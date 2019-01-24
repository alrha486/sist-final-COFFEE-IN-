package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.CouponService;
import com.example.service.MemberService;
import com.example.service.MessageService;
import com.example.vo.MemberVO;
import com.example.vo.cartDetailVO;

@Controller
public class MemberController {	
	@Autowired
	MemberService memberService;
 	@Autowired
 	MessageService messageService;
 	@Autowired
 	CouponService couponService;
	
	@RequestMapping(value = "/login",method=RequestMethod.GET)
	public String login() { // / login.jsp로 이동
		return "login";
	}
	
	@RequestMapping(value = "/logout",method=RequestMethod.GET)
	@ResponseBody
	public int logout(HttpSession session) { // / login.jsp로 이동
		session.invalidate();
		return 1; // 메인페이지로
	}
	
	@RequestMapping(value = "/join",method=RequestMethod.GET)
	public String join() { //  join.jsp
		return "join";
	}
	
	@RequestMapping(value = "/cart",method=RequestMethod.GET)
	public String cart() { //  join.jsp
		return "cart";
	}
	
	@RequestMapping(value = "/cartCheck",method=RequestMethod.GET)
	@ResponseBody
	public int cartCheck(HttpSession session) {// 세션 있는지 없는지 체크
		int sessionCheck = -1;
		if(session.getAttribute("userid") == null) {
			sessionCheck = 1; // 세션 없으면
		}else if(session.getAttribute("userid") != null){
			sessionCheck = 2; // 세션 있으면
		}
		
		return sessionCheck;
	}
	
	@RequestMapping(value = "/cancel",method=RequestMethod.GET)
	@ResponseBody
	public int cancel(HttpSession session) { // 회원가입 중 취소
		session.removeAttribute("userid");
		session.removeAttribute("username"); // 세션 지우고 
		return 1; // 메인페이지로
	}
	
	@RequestMapping(value = "/idCheck/{userid}", method=RequestMethod.POST)
	@ResponseBody
    public int idcheck(@PathVariable String userid) { // ID중복체크를 처리하는 Ajax 
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", userid);
		this.memberService.checkID(map);

		List<MemberVO> list = (List<MemberVO>)map.get("result");

		return list.size();	
    }
	
	@RequestMapping(value = "/nickCheck/{usernickname}", method=RequestMethod.POST)
	@ResponseBody
    public int nickcheck(@PathVariable String usernickname) {  // 닉네임 중복체크를 처리하는 Ajax 
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("usernickname", usernickname);
		this.memberService.checkNickname(map);

		List<MemberVO> list = (List<MemberVO>)map.get("result");

		return list.size();	
    }
	
	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	@ResponseBody
	public Map JoinMember(@RequestBody MemberVO member,HttpSession session) { // 일반 회원가입을 처리하는 AJAX
		Map<String, Object> result = new HashMap<String, Object>();
		
		this.memberService.insertMember(member);
 		result.put("code", Boolean.TRUE); // 회원가입 성공시 true return
 		String userid = member.getUserid(); 		
 		this.memberService.insertNewMemberCoupon(userid); // 신규회원 쿠폰발급
 		
 		Map<String, Object> map7 = new HashMap<String,Object>();
 		map7.put("m_receiver", userid); // DB입력시에 수신자id 보내기 
 		String contents = "회원가입을 축하드립니다. 신규고객님을 위한 쿠폰이 지급되었으니 확인바랍니다.";
 		map7.put("m_contents", contents); // 
 		this.messageService.insertCouponMessage(map7); // 쿠폰 insert
 		
 		Map<String,Object> map1 = new HashMap<String,Object>();
 		map1.put("userid", userid);
 		this.couponService.insertBasicSaving(map1);// 적립금 0원으로 초기화
 		
		return result;
	}
	
	@RequestMapping(value = "/joinKakao",method=RequestMethod.POST)
	@ResponseBody
	public String JoinKakao(@RequestBody MemberVO member, HttpSession session) { // 카카오 회원가입을 처리하는 AJAX
 		session.setAttribute("userid",member.getUserid());
 		session.setAttribute("username",member.getUsername());
		return "/join";
	}
	
	@RequestMapping(value="/callback", method=RequestMethod.GET)
	public String callback() { // 기본 실행. index.jsp
		return "callback";
	} 	
	
	@RequestMapping(value = "/loginMember", method = RequestMethod.POST)
	@ResponseBody
	public int loginMember(@RequestBody MemberVO member,HttpSession session) { // 일반 로그인
		int a = -1;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", member.getUserid());
		this.memberService.loginMember(map);
	
		List<MemberVO> list = (List<MemberVO>)map.get("result");
		if(list.isEmpty()) {
			a = -1;
		}else if(member.getPasswd().equals(list.get(0).getPasswd())) {
			a = 1; // 로그인 성공
			session.setAttribute("userid", member.getUserid());
	
		}else if(!member.getPasswd().equals(list.get(0).getPasswd())){
			a = 2; // 비밀번호 불일치
		}
		
		
		
		return a;	
	}

	
	@RequestMapping(value = "/kakaoCheck", method = RequestMethod.POST)
	@ResponseBody
	public int kakaoCheck(@RequestBody MemberVO member,HttpSession session) { // 카카오 ID DB에 저장되어있는지조회
		int a = -1;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userid", member.getUserid());
		this.memberService.loginMember(map);
	
		List<MemberVO> list = (List<MemberVO>)map.get("result");
		if(list.isEmpty()) {
			a = -1; // DB에 ID가 없으면 
		}else if(member.getUserid().equals(list.get(0).getUserid())) { // DB에 일치하는 ID가 있으면
			a = 1; // 로그인 성공
			session.setAttribute("userid", member.getUserid()); // 로그인 성공과 동시에 세션 세팅
		}
		
		return a;	
	}
		
	
	@RequestMapping(value = "/userInfoSelect", method = RequestMethod.GET) // userid로 회원정보 읽어오기
	@ResponseBody
	public Map cartList(HttpSession session) { 
		Map<String, Object> map = new HashMap<String, Object>();
		String userid = (String) session.getAttribute("userid");
		map.put("userid", userid); 
		this.memberService.userInfoSelect(map); 
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("result");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}
	
/*	
	@RequestMapping(value="/mypage/userInfoUpdate",method=RequestMethod.PUT) 
	@ResponseBody
	public Map update(@RequestBody MemberVO member) { // 회원정보수정
		this.memberService.updateMember(member);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
*/	
/*	@RequestMapping(value="/mypage/userRemove",method=RequestMethod.DELETE) 
	@ResponseBody
	public Map delete(HttpSession session) { // 회원 삭제 
		String userid = (String) session.getAttribute("userid");
		//this.memberService.deleteMember(userid);
		session.removeAttribute("userid"); // 회원정보 삭제 시 세션삭제 
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}*/
	
	@RequestMapping(value = "/selectUserInfo/{username}/{userid}", method = RequestMethod.GET) // userid로 회원정보 읽어오기
	@ResponseBody
	public Map selectUserInfo(@PathVariable String username, @PathVariable String userid) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("userid", userid);
		this.memberService.selectUserInfo(map); 
		
		List<MemberVO> list = (List<MemberVO>)map.get("result");
		Map<String, Object> map1 = new HashMap<String,Object>();
		map1.put("data", list);
		return map1; 
	}
	
	@RequestMapping(value = "/selectUserInfo1/{username}/{tel}", method = RequestMethod.GET) // userid로 회원정보 읽어오기
	@ResponseBody
	public Map selectUserInfo1(@PathVariable String username, @PathVariable String tel) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("tel", tel);
		this.memberService.selectUserInfo1(map); 
		
		List<MemberVO> list = (List<MemberVO>)map.get("result");
		Map<String, Object> map1 = new HashMap<String,Object>();
		map1.put("data", list);
		return map1; 
	}
	
	
	@RequestMapping(value="/memberListSelect", method=RequestMethod.POST)
	@ResponseBody
	public Map userList() {
		Map<String, Object> map= new HashMap<String, Object>();
		this.couponService.select_memberListAll(map);
		List<MemberVO> list = (List<MemberVO>)map.get("results");
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", Boolean.TRUE);
		map1.put("data", list);
		return map1;
	}
	
	
	//////////////////////////은서꺼////////////////////////////////////////
	//전체 리스트 출력
		@RequestMapping(value="memberList/{sort}/{page}", method=RequestMethod.GET)
		@ResponseBody
		public Map memberList(@PathVariable String sort, @PathVariable int page) {
			Map<String, Object> countMap = new HashMap<String, Object>();
			this.memberService.getPageCount(countMap);
			int count = (Integer)countMap.get("result");
			int pageSize = 20;
			int startPage = 1;
			int totalPage = (count % pageSize == 0) ? count / pageSize : count/pageSize+1;
			if(totalPage < page)
				page = totalPage;
			int start = (page - 1) * pageSize + 1; // 11
			int end = start + pageSize - 1; // 20
			
			Map<String, Object> results = new HashMap<String, Object>();
			results.put("start", start);
			results.put("end", end);
			
			//소트하는 부분
			if(sort.equals("1")) {
				this.memberService.selectAllMember_tp(results);	
			} else if(sort.equals('2')) {
				this.memberService.selectAllMember_reg(results);
			} else {
				this.memberService.selectAllMember(results);
			}
			
			List<MemberVO> list = (List<MemberVO>) results.get("results");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", Boolean.TRUE);
			map.put("startPage", startPage);
			map.put("totalPage", totalPage);
			map.put("pageSize", pageSize);
			map.put("page", page);
			map.put("data", list);
			return map;
		}
		
		

		@RequestMapping(value="/memberSelect/{select}/{text}/{page}", method=RequestMethod.GET)
		@ResponseBody
		public Map memberSelect(@PathVariable String select, @PathVariable String text, @PathVariable int page) {
			Map<String, Object> countMap = new HashMap<String, Object>();
			this.memberService.getPageCount(countMap);
			int count = (Integer)countMap.get("result");
			int pageSize = 20;
			int startPage = 1;
			int totalPage = (count % pageSize == 0) ? count / pageSize : count/pageSize+1;
			if(totalPage < page)
				page = totalPage;
			int start = (page - 1) * pageSize + 1; // 11
			int end = start + pageSize - 1; // 20
			
			Map<String, Object> results = new HashMap<String, Object>();
			
			if(select.equals('1')) {
				this.memberService.selectAllMember(results);
				List<MemberVO> list = (List<MemberVO>) results.get("results");
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("code", Boolean.TRUE);
				map.put("data", list);			
				return map;
			}else{
				results.put("p_select", select);
				String text1 = "%" + text +"%";
				results.put("p_text", text1);
				this.memberService.memberSelectAjax(results);
				
				List<MemberVO> list = (List<MemberVO>) results.get("results");
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("code", Boolean.TRUE);
				
				map.put("startPage", startPage);
				map.put("totalPage", totalPage);
				map.put("pageSize", pageSize);
				map.put("page", page);
				
				map.put("data", list);
				return map;
			}
			
		} 

		
		//회원 삭제
		@RequestMapping(value = "/deleteMember/{userid}", method = RequestMethod.DELETE)
		@ResponseBody
		public Map delete(@PathVariable String userid) {
			this.memberService.deleteMember(userid);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", "success");
			return map;
		}

		
		
		@RequestMapping(value = "/UserSelectAll", method = RequestMethod.GET) // userid로 회원정보 읽어오기
		@ResponseBody
		public Map UserSelectAll() { 
			Map<String, Object> map = new HashMap<String, Object>();
			this.memberService.UserSelectAll(map); 
			
			List<MemberVO> list = (List<MemberVO>)map.get("results");
			Map<String, Object> map1 = new HashMap<String,Object>();
			map1.put("data", list);
			return map1; 
		}
		
}



