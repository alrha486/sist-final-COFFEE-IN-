package com.example.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.service.CartService;
import com.example.service.CouponService;
import com.example.service.MemberService;
import com.example.service.MessageService;
import com.example.service.OrderService;
import com.example.util.EchoHandler;
import com.example.vo.MemberVO;
import com.example.vo.cartDetailVO;
import com.example.vo.orderbasicVO;
import com.example.vo.orderdetailVO;

@Controller
public class OrderController {
	@Autowired
	OrderService orderService;
	@Autowired
	MemberService memberService;
	@Autowired
	CartService cartService;
	@Autowired
	CouponService couponService;
	@Autowired
	MessageService messageService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private EchoHandler echo;
	

	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	@ResponseBody
	public int payment(@RequestBody orderbasicVO orderbasic,HttpSession session) { // orderbasic 테이블 insert
		Map<String, Object> map = new HashMap<String, Object>();
		this.orderService.insertOrderBasic(orderbasic); // orderbasic 테이블 insert
		this.orderService.selectOrderid(map); // 가장최근 orderid 가져오기 
		List<orderdetailVO> list = (List<orderdetailVO>)map.get("results"); 		
 		
		Map<String, Object> map1 = new HashMap<String, Object>();
		String userid = (String)session.getAttribute("userid");
		map1.put("userid", userid);
		map1.put("couponNum", orderbasic.getCouponNum());
		this.couponService.updateUserCoupon(map1);
		// userCoupon의 validity 업데이트
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("userid", userid);
		map2.put("saving", orderbasic.getSaving_discount());
		this.couponService.updateUserSaving(map2);

		return list.get(0).getOrderid(); // 가장최근 orderid return 
	}
	
	@RequestMapping(value = "/orderDetailInsert/{cartidx}/{orderid}", method = RequestMethod.POST) // orderDetail 테이블 insert 
	@ResponseBody // 장바구니에서 구매시 
	public Map orderDetailInsert(HttpSession session,@PathVariable String cartidx,@PathVariable int orderid) { // orderDetail 테이블 insert 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartidx", cartidx); // 카트 아이디로 장바구니에 있는 상품 전체 가져오기
		this.cartService.selectCartOne(map); // 카트id로 장바구니 정보조회
		
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
		int productid = list.get(0).getProductid();
		int pcount = list.get(0).getP_count();
		int price = list.get(0).getPrice();  // orderDetail insert에 필요한 데이터들 추출해서 변수에 저장
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("orderid", orderid);
		map1.put("productid", productid);
		map1.put("pcount", pcount);
		map1.put("price", price);
		this.orderService.insertOrderDetail(map1);
				
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);

		// 재고 -- 셀카운트 ++ 해주는 서비스 추가
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("productid", productid);
		map2.put("pcount", pcount);
		this.orderService.updateProductNum(map2);
		
		return data;
	}
	
	@RequestMapping(value = "/orderDetailInsertOne/{orderid}/{productid}/{count}/{price}", method = RequestMethod.POST) // orderDetail 테이블 insert 
	@ResponseBody
	public Map orderDetailInsertOne(HttpSession session,@PathVariable int orderid,
			@PathVariable int productid, @PathVariable int count, @PathVariable int price) { // orderDetail 테이블 insert
		// 하나의 상품 구매임(장바구니에서 구매X)

		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("orderid", orderid);
		map1.put("productid", productid);
		map1.put("pcount", count);
		map1.put("price", price*count);
		this.orderService.insertOrderDetail(map1);
				
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", data);

		return data;
	}
	

	@RequestMapping(value = "/orderMail/{orderid}/{totalPrice}", method = RequestMethod.POST)
	@ResponseBody
	public int orderMail(HttpSession session, @PathVariable int orderid, @PathVariable int totalPrice) { // 주문 완료 메일을 보내주는 ajax
		int result = -1;
		Map<String, Object> map2 = new HashMap<String, Object>();
		String userid = (String) session.getAttribute("userid");
		map2.put("userid", userid); // 카트 아이디로 장바구니에 있는 상품 전체 가져오기
		this.memberService.userInfoSelect(map2); 

		List<MemberVO> list1 = (List<MemberVO>)map2.get("result");
		String username = list1.get(0).getUsername();
		String userEmail = list1.get(0).getEmail();

	
		   	String setfrom = "alrha486@gmail.com";         
		    String tomail  = userEmail; // 구매자의 이메일 
		    String title   = "구매가 완료되었습니다.";      
		    String content = username  + "님! 구매해주셔서 감사합니다. 또 이용해주십시오. (주)카페인";
		   
		    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom); 
		      messageHelper.setTo(tomail);     
		      messageHelper.setSubject(title); 
		      messageHelper.setText(content);  
		     
		      mailSender.send(message);
		      result = 1;
		    } catch(Exception e){
		      System.out.println(e);
		    }	
 		
		    
           // 주문 감사 메시지 		    
		    Map<String, Object> map7 = new HashMap<String,Object>();
	 		map7.put("m_receiver", userid); // DB입력시에 수신자id 보내기 
	 		String contents = username + "님! 주문해주셔서 감사합니다. 고객님의 주문번호는 ";
	 		int saving = (totalPrice/100); 
	 		contents += orderid +"번. 최종 결제금액은 " + totalPrice + "원, " + saving +"원 적립되었습니다. 좋은하루되세요 ^^" ;
	 		map7.put("m_contents", contents); // 
	 		this.messageService.insertOrderMessage(map7);
	 		
	 		Map<String, Object> map8 = new HashMap<String,Object>();
	 		map8.put("userid", userid);
	 		map8.put("saving",saving);
	 		this.couponService.afterPurchaseUpdate(map8); // 구매 후 적립금 update
	 		// 주문 감사 메시지 

		return result; // 가장최근 orderid return 
	}
	
	@RequestMapping(value = "/mypage/orderStates", method = RequestMethod.GET) // userid로 회원정보 읽어오기
	@ResponseBody
	public Map orderState(HttpSession session) { // 유저의 주문내역 조회
		Map<String, Object> map = new HashMap<String, Object>();
		String userid = (String) session.getAttribute("userid");
		map.put("userid", userid); 
		this.orderService.orderInfoSelect(map);
		
		List<orderdetailVO> list = (List<orderdetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list); 
		return data;
	}
	
	@RequestMapping(value = "/mypage/orderView/{orderid}", method = RequestMethod.GET) 
	@ResponseBody
	public ModelAndView orderView(@PathVariable int orderid) { // 구매 상세 눌렀을 때 
		ModelAndView mav = new ModelAndView();
		mav.setViewName("orderView");
		mav.addObject("orderid", orderid);
		return mav;
	}
	
	
	@RequestMapping(value = "/mypage/orderViews/{orderid}", method = RequestMethod.GET) 
	@ResponseBody
	public Map orderViews(@PathVariable int orderid) { // 구매 상세 눌렀을 때 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderid", orderid);
		this.orderService.orderDetailSelect(map);
		
		List<orderdetailVO> list = (List<orderdetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
	
		return data;
	}
	
	
	@RequestMapping(value = "/SearchOrderCount/{date1}/{date2}", method = RequestMethod.GET) 
	@ResponseBody
	public Map SearchOrderCount(@PathVariable String date1,@PathVariable String date2) { // 구매 상세 눌렀을 때 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("date1", date1);
		map.put("date2", date2);
		this.orderService.SearchOrderCount(map);
		
		List<orderdetailVO> list = (List<orderdetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
	
		return data;
	}
	
	@RequestMapping(value = "/SearchOrderCount1/{time}", method = RequestMethod.GET) 
	@ResponseBody
	public Map SearchOrderCount(@PathVariable String time) { // 구매 상세 눌렀을 때 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("date", time);
		this.orderService.SearchOrderCount1(map);
		
		List<orderdetailVO> list = (List<orderdetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
	
		return data;
	}

	@RequestMapping(value = "/SearchOrderCount2/{time}", method = RequestMethod.GET) 
	@ResponseBody
	public Map SearchOrderCount2(@PathVariable String time) { // 구매 상세 눌렀을 때 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("date", time);
		this.orderService.SearchOrderCount2(map);
		
		List<orderdetailVO> list = (List<orderdetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
	
		return data;
	}
	

	@RequestMapping(value="/orderStateModify/{orderid}/{userid}", method = RequestMethod.PUT)
	@ResponseBody
	public Map orderStateModify(@PathVariable int orderid,@PathVariable String userid, HttpSession session) throws IOException { // 배송상태 변경 (배송준비>>배송중)
	    this.orderService.orderStateModify(orderid);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		
		/////////밑에는 메시지/////////////////////////////////////////
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("userid", userid); // 카트 아이디로 장바구니에 있는 상품 전체 가져오기
		this.memberService.userInfoSelect(map1); 

		List<MemberVO> list1 = (List<MemberVO>)map1.get("result");
		String username = list1.get(0).getUsername();
		String userEmail = list1.get(0).getEmail();	
		
		
		String contents = username +"님께서 주문하신 (주문 번호 : " + orderid + ") 상품이 발송되었습니다";
		Map<String,Object> map2 = new HashMap<String,Object>();
 		map2.put("m_contents", contents);
 		map2.put("m_receiver", userid); 
		this.messageService.insertOrderStateChange(map2); // 메시지 전송
		this.echo.sending(contents, userid);
		/////////////////////밑에는 메일/////////////////////////////////
		String setfrom = "alrha486@gmail.com";         
	    String tomail  = userEmail; // 구매자의 이메일 
	    String title   = "상품이 배송이 시작되었습니다.";      
	    contents += "(주)카페인";
	   
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom); 
	      messageHelper.setTo(tomail);     
	      messageHelper.setSubject(title); 
	      messageHelper.setText(contents);  
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }	
		return map;
	}
	
	@RequestMapping(value="/orderStateModify1/{orderid}/{userid}", method = RequestMethod.PUT)
	@ResponseBody
	public Map orderStateModify1(@PathVariable int orderid,@PathVariable String userid, HttpSession session) throws IOException { // 배송상태 변경 (배송중>>배송완료)
	    this.orderService.orderStateModify1(orderid);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		
		/////////밑에는 메세지////////////////////////////////////////
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("userid", userid); // 카트 아이디로 장바구니에 있는 상품 전체 가져오기
		this.memberService.userInfoSelect(map1); 

		List<MemberVO> list1 = (List<MemberVO>)map1.get("result");
		String username = list1.get(0).getUsername();		
		String userEmail = list1.get(0).getEmail();	
		
		String contents = username +"님께서 주문하신 (주문 번호 : " + orderid + ") 상품이 배송 완료되었습니다.";
		Map<String,Object> map2 = new HashMap<String,Object>();
 		map2.put("m_contents", contents);
 		map2.put("m_receiver", userid); 
		this.messageService.insertOrderStateChange(map2); // 메시지 전송
		this.echo.sending(contents, userid);
		//////////////////밑에는 메일/////////////////////////////////////////
		String setfrom = "alrha486@gmail.com";         
	    String tomail  = userEmail; // 구매자의 이메일 
	    String title   = "상품 배송이 완료되었습니다.";      
	    contents += "(주)카페인";
	   
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom); 
	      messageHelper.setTo(tomail);     
	      messageHelper.setSubject(title); 
	      messageHelper.setText(contents);  
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }	
		return map;
	}
	
	
	@RequestMapping(value = "/deliveryStateCheck",method=RequestMethod.GET)
	public String deliveryStateCheck() { // 배송상태조회
		return "deliveryStateCheck";
	}
	
	@RequestMapping(value = "/deliveryStateCheck1",method=RequestMethod.GET)
	public String deliveryStateCheck1() { // 배송상태조회
		return "deliveryStateCheck1";
	}
}

