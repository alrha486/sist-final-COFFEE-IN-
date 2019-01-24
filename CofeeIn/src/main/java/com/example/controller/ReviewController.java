package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.service.FileUploadService;
import com.example.service.RevService;
import com.example.vo.RevVO;
import com.sun.istack.internal.logging.Logger;

@Controller
public class ReviewController {
	private static Logger logger = Logger.getLogger(ReviewController.class);
	
	@Autowired
	RevService revService;
	
	@Autowired
	FileUploadService fileUploadService;
	
	@Resource(name = "uploadPath")
	private String uploadPath;  //File upload 경로
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "reviewTable";
	}  */

	//상품평 작성페이지 이동
	@RequestMapping(value = "/write/{productid}", method = RequestMethod.GET)
	public String write(Model model, @PathVariable int productid) {
		model.addAttribute("productid", productid);
		return "write";
	}
	//상품평 수정페이지 이동
	@RequestMapping(value = "/modify/{test}", method = RequestMethod.GET)
	public String modify(Model model, @PathVariable String test) {
		System.out.println(test);
		model.addAttribute("test", test);
		return "modify";
	}
	
	//전체 리스트
	/*@RequestMapping(value="/reviews", method=RequestMethod.GET)
	@ResponseBody
	public Map list() {
		Map<String, Object> map= new HashMap<String, Object>();
		this.revService.selectReview(map);
		List<RevVO> list = (List<RevVO>)map.get("results");
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", "success");
		map1.put("data", list);
		return map1;
	}*/
	
	//상품별 리뷰 출력
	@RequestMapping(value="/reviews/{productid}/{page}", method=RequestMethod.POST)
	@ResponseBody
	public Map list(@PathVariable int productid, @PathVariable int page) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("productid", productid);
		this.revService.getReviewCount(map);
		int totalCount = (Integer) map.get("result");
		int pageSize = 10;
		int startPage = 1;
		int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
		// 1페이지 -> 1+10-1=10 // 2페이지 -> 11+10-1=20
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		map.put("start", start);
		map.put("end", end);
		
		this.revService.selectReview(map);
		List<RevVO> list = (List<RevVO>)map.get("results");
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", "success");
		map1.put("totalCount", totalCount);
		map1.put("pageSize", pageSize);
		map1.put("startPage", startPage);
		map1.put("totalPage", totalPage);
		map1.put("page", page);
		map1.put("data", list);
		return map1;
	}
	
	//리뷰 작성
	@RequestMapping(value="/write/{productid}", method=RequestMethod.POST)
	//@RequestMapping(value="/revwrite", method=RequestMethod.POST)
	@ResponseBody
	public Map create(MultipartHttpServletRequest request, @PathVariable int productid) {
		RevVO rev = new RevVO();
		rev.setProductid(productid);
		rev.setRev_title(request.getParameter("rev_title"));
		rev.setRev_score(Integer.parseInt(request.getParameter("rev_score")));
		rev.setRev_contents(request.getParameter("rev_contents"));
		rev.setUserid(request.getParameter("userid"));
		System.out.println(request.getParameter("userid"));
		//이미지 파일 올리는 부분. 
		//MultipartFile mFile = request.getFile("productimage");
		//String uri = this.fileUploadService.restore(mFile, uploadPath);
		//System.out.println(uploadPath);

		
		//uri에는 바뀐 파일 이름이 저장됨.
		//rev.setRev_file(uri);
		
		Map<String, Object> result = new HashMap<String, Object>();
		this.revService.insertReview(rev);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
	/////////////////////////////
	
	//파일 uri 변경
	@RequestMapping(value="/imageUpload", method=RequestMethod.POST)
	@ResponseBody
	public String create(MultipartHttpServletRequest request) {	
		MultipartFile mFile = request.getFile("productimage");
		//String uri = this.fileUploadService.restore(mFile, uploadPath);
		String uri = this.fileUploadService.restore1(mFile, uploadPath);
		
		return uri;
	}
	
	//리뷰 정보 출력
	@RequestMapping(value="/reviewInfo/{rev_idx}", method = RequestMethod.GET )
	@ResponseBody
	public Map read(@PathVariable int rev_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rev_idx", rev_idx);
		this.revService.selectOneReview(map);
		List<RevVO> list = (List<RevVO>)map.get("result");
		RevVO revVo = list.get(0);
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", "success");
		map1.put("data", revVo);
		return map1;
	} 
	
	// 리뷰 삭제
	@RequestMapping(value = "/delete/{rev_idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable int rev_idx) {
		this.revService.deleteReview(rev_idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "success");
		return map;
	}
	
	//리뷰 수정
	@RequestMapping(value="/update/{rev_idx}", method = RequestMethod.PUT)
	@ResponseBody
	public Map update(@PathVariable int rev_idx ,@RequestBody RevVO revVo) {
		revVo.setRev_idx(rev_idx);
		this.revService.updateReview(revVo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
}
