package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.service.QnAService;
import com.example.vo.QnAVO;

@Controller
public class QnAController {
	@Autowired
	QnAService qnaService;
	
	@RequestMapping(value ="/goQnA", method = RequestMethod.GET)
	public String goQnA() {
		return "qna_list";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "qna_write"; // 실제 위치는 webapp/static/write.jsp
	}
	
	
	//전체 리스트 출력
	@RequestMapping(value = "qna/{page}", method = RequestMethod.GET)
	@ResponseBody
	public Map list(@PathVariable int page) {		
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.qnaService.getPageCount(countMap);
		int count = (Integer)countMap.get("result");
		int pageSize = 15;
		int startPage = 1;
		int totalPage = (count % pageSize == 0) ? count / pageSize : count/pageSize+1;
		if(totalPage < page)
			page = totalPage;
		//int pageCount = 10;
		
		int start = (page - 1) * pageSize + 1; // 11
		int end = start + pageSize - 1; // 20

		//int startPage = ((page - 1) * pageCount / pageCount) + 1; // 2
		//int endPage = startPage + pageCount - 1; // 11

		//if (endPage > totalPage)
		//	endPage = totalPage;
		
		Map<String, Object> results = new HashMap<String, Object>(); // 전체 레코드
		results.put("start", start);
		results.put("end", end);
		this.qnaService.select(results);
		List<QnAVO> list = (List<QnAVO>) results.get("results");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		map.put("startPage", startPage);
		//map.put("endPage", endPage);
		map.put("totalPage", totalPage);
		map.put("pageSize", pageSize);
		map.put("page", page);
		map.put("data", list);
		return map;
	}
	
	//게시물 내용
	@RequestMapping(value="/viewQnA/{qna_idx}", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView read(@PathVariable int qna_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qna_idx", qna_idx);
		this.qnaService.selectQnA(map);
		this.qnaService.updateCount(qna_idx);
		
		List<QnAVO> list = (List<QnAVO>)map.get("result");
		QnAVO qna = list.get(0);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", qna);
		mav.setViewName("qna_viewQnA");
		
		return mav;
	}
	
	
	//새 게시물 삽입
	@RequestMapping(value = "/write", method =  RequestMethod.POST)
	@ResponseBody
	public Map insert(@RequestBody QnAVO qna) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String title = qna.getTitle();
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		title = title.replace("'", "''");
		qna.setTitle(title);
		
		String contents = qna.getContents();
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("'", "''");
		contents = contents.replace("\r\n", "<br />");
		qna.setContents(contents);
			
		this.qnaService.insertQnA(qna);
		result.put("code", "success");
		result.put("data", qna);
		return result;
	}
	
	//삭제
	@RequestMapping(value = "/viewQnA/{qna_idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable int qna_idx) {
		this.qnaService.deleteQnA(qna_idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "success");
		return map;
	}
	
	//수정용 페이지
	@RequestMapping(value="update/{qna_idx}", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView update(@PathVariable int qna_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qna_idx", qna_idx);
		this.qnaService.selectQnA(map);
		List<QnAVO> list = (List<QnAVO>)map.get("result");
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list.get(0));
		mav.setViewName("qna_update");
		return mav;
	}
	
	
	//수정
	@RequestMapping(value="/updatePage/{qna_idx}", method = RequestMethod.PUT)
	@ResponseBody
	public Map update(@PathVariable int qna_idx, @RequestBody QnAVO qna) {
		qna.setQna_idx(qna_idx);
		this.qnaService.updateQnA(qna);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	//답변용 페이지
	@RequestMapping(value="re/{qna_idx}", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView answer(@PathVariable int qna_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qna_idx", qna_idx);
		this.qnaService.selectQnA(map);
		List<QnAVO> list = (List<QnAVO>)map.get("result");
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list.get(0));
		//System.out.println(list.get(0));
		mav.setViewName("qna_re");
		return mav;
	}
	
	//답변 입력하기
	@RequestMapping(value="/reply", method = RequestMethod.POST)
	@ResponseBody
	public Map answer(@RequestBody QnAVO qna) {
		qna.setLev(qna.getLev()+1);
		qna.setStep(qna.getStep() +1);
		this.qnaService.answerQnA(qna);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		System.out.println(qna.getLev());
		return result;
	} 
	
	//비밀글여부 판독
	@RequestMapping(value="/qnaSearch/{qna_idx}", method=RequestMethod.GET)
	@ResponseBody
	public Map qnaSearch(@PathVariable int qna_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qna_idx", qna_idx);
		this.qnaService.selectQnA(map);
		
		List<QnAVO> list = (List<QnAVO>)map.get("result");
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data",list);
		
		
		return result;
	}
}
