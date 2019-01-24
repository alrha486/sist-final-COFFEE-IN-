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

import com.example.service.MyService;
import com.example.service.ProductService;
import com.example.service.QaddressService;
import com.example.vo.MyVO;
import com.example.vo.ProductVO;
import com.example.vo.QaddressVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MyController {
	@Autowired
	MyService myService;
	@Autowired
	QaddressService qaddressService;
	@Autowired
	ProductService productService;
	
/*	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String goAbout() {
		
		return "about";
	}
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String goMypage() {
		
		return "mypage";
	}*/
	
	/*@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		List<MemberVO> list = this.memberService.readAll();
		model.addAttribute("userlist", list);
		return "list";    // /WEB-INF/views/list.jsp
	}*/
	
	@RequestMapping(value = "/info_view/{userid}", method = RequestMethod.GET)
	public String info_view(@PathVariable String userid, Model model) {		//회원정보보기
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		this.myService.read(map);
		
		List<MyVO> list = (List<MyVO>)map.get("myresult");
		
		model.addAttribute("member", list.get(0));
		
		return "info_view";
	}
	
	@RequestMapping(value = "/updateinfo", method = RequestMethod.PUT)  // 회원정보 수정..
	@ResponseBody
	public Map Updateinfo(@RequestBody MyVO my) { 
		Map<String, Object> result = new HashMap<String, Object>();
		
		this.myService.MyUpdate(my);
 		result.put("code", Boolean.TRUE); 
		return result;
	}
	
	@RequestMapping(value = "/deleteinfo/{userid}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map Deleteinfo(@PathVariable String userid, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		
		this.myService.deleteinfo(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		session.removeAttribute("userid");
		return result;
	}
	
	@RequestMapping(value = "/delivery_info/{userid}", method = RequestMethod.POST)
	public String deliveryinfo(@PathVariable String userid, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>(); // 기본 배송지정보 불러오기 위한 map
		Map<String, Object> maptwo = new HashMap<String, Object>(); // 추가 배송지정보 불러오기 위한 map
		map.put("userid", userid);
		maptwo.put("userid", userid);
		this.myService.read(map);
		this.qaddressService.addressselect(maptwo);
		
		
		List<MyVO> list = (List<MyVO>)map.get("myresult");
		List<QaddressVO> listtwo = (List<QaddressVO>)maptwo.get("qaddressresult");
		
		model.addAttribute("member", list.get(0));
		model.addAttribute("qaddress", listtwo);
		return "delivery_info";
	}
	
	@RequestMapping(value = "/addressInsert", method = RequestMethod.GET)
	public String goinsertaddress() {
		
		return "address";
	}
	
	
	@RequestMapping(value = "/delivery_info/insert/{userid}", method = RequestMethod.POST)
	@ResponseBody
	public int deliveryinsert(@PathVariable String userid, @RequestBody QaddressVO qaddress) {
		this.qaddressService.addressinsert(qaddress);
		return 1;
	}
	
	@RequestMapping(value = "/address/delete/{addressnamekey}", method = RequestMethod.DELETE)
	@ResponseBody
	public int deliverydelete(@PathVariable String addressnamekey) {
		this.qaddressService.addressdelete(addressnamekey);
		
		return 1;
	}
	
	@RequestMapping(value = "/todayview/{userid}", method = RequestMethod.POST)
	public String goTodayView() {

		return "todayview";
	}
	
	@RequestMapping(value = "/todayviewset", method = RequestMethod.GET)
	public String goTodayViewset() {

		return "todayviewset";
	}
	
	@RequestMapping(value = "/todayview/product/{productid}", method = RequestMethod.POST)
	@ResponseBody
	public Map todaylist(@PathVariable int productid) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productid", productid);
		this.productService.selectToday(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<ProductVO> todaylist = (List<ProductVO>)map.get("todayresult");
		result.put("data", todaylist.get(0));
		result.put("code", Boolean.TRUE);
		
		return result;
	}

	   @RequestMapping(value="/mypage/coupon", method=RequestMethod.GET)
	   public String mypage_coupon() { // 쿠폰창 실행 
	      return "mypage_coupon";
	   }
	
	

}



