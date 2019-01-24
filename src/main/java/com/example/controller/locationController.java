package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class locationController {

	@RequestMapping(value = "/about",method=RequestMethod.GET)
	public String about() { // about.jsp로 이동
		return "about";
	}
	
	@RequestMapping(value = "/mypage",method=RequestMethod.GET)
	public String mypage() { // mypage.jsp로 이동
		return "mypage";
	}
	
	@RequestMapping(value = "/mypage/userInfo",method=RequestMethod.GET)
	public String userInfo() { // userInfo.jsp로 이동
		return "userInfo";
	}
	
	@RequestMapping(value = "/mypage/orderState",method=RequestMethod.GET)
	public String orderState() { // order_state.jsp로 이동
		return "orderState";
	}
	
	@RequestMapping(value = "/mypage/deliveryState",method=RequestMethod.GET)
	public String deliveryState() { // deliveryState.jsp로 이동
		return "deliveryState";
	}
	
	@RequestMapping(value = "/chatRoom",method=RequestMethod.GET)
	public String chatRoom() { // chatRoom.jsp로 이동
		return "chatRoom";
	}
	
	@RequestMapping(value = "/chatRoom1",method=RequestMethod.GET)
	public String chatRoom1() { // chatRoom.jsp로 이동
		return "chatRoom1";
	}
	
	@RequestMapping(value = "/admin",method=RequestMethod.GET)
	public String adminPage() { // adminPage.jsp로 이동
		return "admin";
	}
	
	@RequestMapping(value = "/chatList",method=RequestMethod.GET)
	public String chatList() { // chatList.jsp로 이동
		return "chatList1";
	}

	@RequestMapping(value = "/idSearch",method=RequestMethod.GET)
	public String idSearch() { 
		return "idSearch";
	}
	
	@RequestMapping(value = "/pwSearch",method=RequestMethod.GET)
	public String pwSearch() { 
		return "pwSearch";
	}
	
	@RequestMapping(value = "/IDSearch1",method=RequestMethod.GET)
	public String IDSearch1() {
		return "IDSearch1";
	}
	
	@RequestMapping(value = "/admin/revenue",method=RequestMethod.GET)
	public String revenue() { // 상품 매출페이지
		return "revenue";
	}

	@RequestMapping(value = "/admin/revenue1",method=RequestMethod.GET)
	public String revenue1() { // 주문 매출페이지
		return "revenue1";
	}
	
	@RequestMapping(value = "/admin/revenue2",method=RequestMethod.GET)
	public String revenue2() { // 매출 페이지
		return "revenue2";
	}
	
	@RequestMapping(value = "/productMGMT",method=RequestMethod.GET)
	public String productMGMT() { // 매출 페이지
		return "productMGMT";
	}
	
	@RequestMapping(value = "/couponMGMT",method=RequestMethod.GET)
	public String couponMGMT() { //
		return "couponMGMT";
	}
	
	@RequestMapping(value = "/memberMGMT",method=RequestMethod.GET)
	public String memberMGMT() { // 매출 페이지
		return "memberMGMT";
	}
	
	@RequestMapping(value = "/boardMGMT",method=RequestMethod.GET)
	public String boardMGMT() { // 매출 페이지
		return "boardMGMT";
	}
	
}
