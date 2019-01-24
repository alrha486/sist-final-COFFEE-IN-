package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.service.CouponService;
import com.example.vo.CouponVO;
import com.example.vo.MemberVO;
import com.example.vo.SavingVO;
import com.example.vo.cartDetailVO;
import com.example.vo.userCouponVO;
@Controller
public class CouponController {
	@Autowired
	CouponService couponService;
	
	@RequestMapping(value = "/selectUserCoupon", method = RequestMethod.GET)
	@ResponseBody
	public Map selectUserCoupon(HttpSession session) { // 장바구니 전체조회
		Map<String, Object> map = new HashMap<String, Object>();
		String userid = (String) session.getAttribute("userid");
		map.put("userid", userid); // 유저 아이디로 장바구니에 있는 상품 전체 가져오기
		this.couponService.selectUserCoupon(map); // 장바구니 전체조회
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("result");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}
	
	
	
	@RequestMapping(value="/coupon", method=RequestMethod.GET)
	public String coupon() { // 쿠폰창 실행 
		return "coupon";
	} 	
	
	@RequestMapping(value="/savings", method=RequestMethod.GET)
	public String Savings() { // 적립금 창 실행
		return "savings";
	} 	
	
	@RequestMapping(value = "/selectMySaving", method = RequestMethod.GET)
	@ResponseBody
	public int selectMySaving(HttpSession session) { // 장바구니 전체조회
		Map<String, Object> map = new HashMap<String, Object>();
		String userid = (String) session.getAttribute("userid");
		map.put("userid", userid); // 유저 아이디
		this.couponService.selectMySaving(map); // // 유저가 가지고 있는 적립금 조회
		
		List<SavingVO> list = (List<SavingVO>)map.get("results");
		
		return list.get(0).getSaving(); // 유저가 가지고 있는 적립금 
	}
	
	@RequestMapping(value = "/selectCoupon/{couponNum}", method = RequestMethod.GET)
	@ResponseBody
	public Map selectCouponOne(HttpSession session,@PathVariable int couponNum) { // 장바구니 전체조회
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("couponNum", couponNum);
		
		this.couponService.selectCouponOne(map); // // 유저가 가지고 있는 적립금 조회
		
		List<CouponVO> list = (List<CouponVO>)map.get("result");
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("data", list);
		
		return map1;//
	}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//관리자 페이지 쿠폰관리 페이지
/*		@RequestMapping(value="/admin/coupon", method=RequestMethod.GET)
		public String admin_coupon() { 
			return "coupon_management";
		}*/
		//관리자 페이지 쿠폰등록 페이지
		@RequestMapping(value="/admin/couponInsert", method=RequestMethod.GET)
		public String coupon_insert() { 
			return "couponInsert";
		}
		//관리자 페이지 쿠폰수정 페이지
		@RequestMapping(value = "/couponModify/{couponNum}", method = RequestMethod.GET)
		public String modify(Model model, @PathVariable String couponNum) {
			model.addAttribute("couponNum", couponNum);
			System.out.println(couponNum);
			return "couponModify";
		}
		//관리자 페이지 쿠폰발급 페이지
		@RequestMapping(value = "/couponIssue/{couponNum}", method = RequestMethod.GET)
		public String issue(Model model, @PathVariable int couponNum) {
			model.addAttribute("couponNum", couponNum);
			return "couponIssue";
		}
		//관리자 페이지 쿠폰 전체 회원 목록
		@RequestMapping(value="/admin/memberList", method=RequestMethod.POST)
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
		
		//검색결과 출력-회원명
		@RequestMapping(value="/memberSelect/{userid}", method=RequestMethod.POST)
		@ResponseBody
		public Map userSearch(@PathVariable String userid) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userid", userid);
			this.couponService.memberSelectAjax(map);
			List<MemberVO> list = (List<MemberVO>)map.get("results");
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("code", Boolean.TRUE);
			map1.put("data", list);
			return map1;
		} 
		
		//관리자 페이지 쿠폰 전체 목록
		@RequestMapping(value="/admin/couponList/{page}", method=RequestMethod.POST)
		@ResponseBody
		public Map couponList(@PathVariable int page) {
			Map<String, Object> map= new HashMap<String, Object>();
			this.couponService.getCouponCount(map);
			int totalCount = (Integer) map.get("result");
			int pageSize = 10;
			int startPage = 1;
			int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
			// 1페이지 -> 1+10-1=10 // 2페이지 -> 11+10-1=20
			int start = (page - 1) * pageSize + 1;
			int end = start + pageSize - 1;
			map.put("start", start);
			map.put("end", end);
			this.couponService.select_couponListAll(map);
			List<CouponVO> list = (List<CouponVO>)map.get("results");
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("code", Boolean.TRUE);
			map1.put("totalCount", totalCount);
			map1.put("startPage", startPage);
			map1.put("totalPage", totalPage);
			map1.put("page", page);
			map1.put("data", list);
			System.out.println(list.size());
			return map1;
		} 
		
		//관리자 페이지 쿠폰 등록
		@RequestMapping(value="/coupon/insert", method=RequestMethod.POST)
		@ResponseBody
		public Map create(MultipartHttpServletRequest request) {
			CouponVO couponVo = new CouponVO();
			couponVo.setC_name(request.getParameter("c_name"));
			couponVo.setC_content(request.getParameter("c_content"));
			couponVo.setC_discount(Integer.parseInt(request.getParameter("c_discount")));
			couponVo.setC_condition(Integer.parseInt(request.getParameter("c_condition")));
			
			Map<String, Object> result = new HashMap<String, Object>();
			this.couponService.insertCoupon(couponVo);
			result.put("code", Boolean.TRUE);
			return result;
		}
		//관리자 페이지 쿠폰 발급
		@RequestMapping(value="/coupon/issue/{couponNum}/{userid}", method=RequestMethod.POST)
		@ResponseBody
		public Map coupon_issue(@PathVariable int couponNum, @PathVariable String userid) {
			userCouponVO userCouponVo = new userCouponVO();
			userCouponVo.setUserid(userid);
			userCouponVo.setCouponNum(couponNum);
			System.out.println(userCouponVo);
			
			Map<String, Object> result = new HashMap<String, Object>();
			this.couponService.issueCoupon(userCouponVo);
			result.put("code", Boolean.TRUE);
			return result;
		}
		//관리자 페이지 쿠폰 삭제
		@RequestMapping(value = "/admin/couponDelete/{couponNum}", method = RequestMethod.DELETE)
		@ResponseBody
		public Map couponDelete(@PathVariable int couponNum) {
			this.couponService.deleteCoupon(couponNum);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", "success");
			return map;
		}
		
		// 관리자 페이지 쿠폰 수정페이지 정보 받아오기
		@RequestMapping(value="/infoCoupon/{couponNum}", method = RequestMethod.GET)
		@ResponseBody
		public Map readCoupon(@PathVariable int couponNum) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("couponNum", couponNum);
			this.couponService.infoCoupon(map);
			List<CouponVO> list = (List<CouponVO>)map.get("result");
			CouponVO couponVo = list.get(0);
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("code", "success");
			map1.put("data", couponVo);
			System.out.println(couponVo.getC_name());
			return map1;
		} 
		
		
		//관리자 페이지 쿠폰 수정
		@RequestMapping(value="/modifyCoupon/{couponNum}", method = RequestMethod.PUT)
		@ResponseBody
		public Map modifyCoupon(@PathVariable int couponNum ,@RequestBody CouponVO couponVo) {
			couponVo.setCouponNum(couponNum);
			this.couponService.modifyCoupon(couponVo);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", Boolean.TRUE);
			return map;
		}
	
	
	
}
