package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.CartService;
import com.example.vo.cartDetailVO;
@Controller
public class CartController {
	@Autowired
	CartService cartService;
	
	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	@ResponseBody
	public Map cartList(HttpSession session) { // 장바구니 전체조회
		Map<String, Object> map = new HashMap<String, Object>();
		String userid = (String) session.getAttribute("userid");
		map.put("userid", userid); // 유저 아이디로 장바구니에 있는 상품 전체 가져오기
		this.cartService.selectAll(map); // 장바구니 전체조회
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}

	@RequestMapping(value="/DeleteCart/{idx}",method=RequestMethod.DELETE) // 선택상품 삭제
	@ResponseBody
	public Map delete(@PathVariable int idx) { // 선택상품 삭제
		this.cartService.deleteCart(idx);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/cartSearch/{cartidx}", method = RequestMethod.GET) // 카트 ID로 하나의 카트한줄 조회
	@ResponseBody
	public Map cartList(HttpSession session,@PathVariable String cartidx) { // 장바구니 전체조회
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartidx", cartidx); // 카트 아이디로 장바구니에 있는 상품 전체 가져오기
		this.cartService.selectCartOne(map); // 장바구니 전체조회
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("code", Boolean.TRUE);
		data.put("data", list);
		return data;
	}

	
	@RequestMapping(value = "/addCart", method = RequestMethod.POST)
	@ResponseBody
	public int addCart(@RequestBody cartDetailVO cart,HttpSession session) { // 장바구니 추가
	      int flag = -1;  // 리턴할 변수(기본 -1)
	//////////////////////////////////////////////////////////////////////////////////////////
	      Map<String, Object> map1 = new HashMap<String, Object>();
	      String userid1 = (String)session.getAttribute("userid");
	      map1.put("userid", userid1); // 여기까진 이상x 
	      this.cartService.selectCartid(map1); // userid로 cartBasic의 cartid값 받아오기
	      List<cartDetailVO> list1 = (List<cartDetailVO>)map1.get("results");
	      if(list1.size() == 0) { // 유저의 장바구니가 비어있으면 
	///////////////////유저 장바구니가 비어있으면 basic detail 둘다 추가/////////////////////////////
	         Map<String, Object> map = new HashMap<String, Object>();
	         String userid = (String)session.getAttribute("userid");
	         this.cartService.addCart(userid); //1.  cartBasic 테이블 insert
	         map.put("userid", userid); // 여기까진 이상x 
	         this.cartService.selectCartid(map); // userid로 cartBasic의 cartid값 받아오기
	         List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
	         
	         String cartid = list.get(0).getCartid(); // 2. cartid 추출 
	         
	         Map<String, Object> map2 = new HashMap<String, Object>(); // cartDetail insert를 위한 map 생성
	         map2.put("cartid", cartid);
	         map2.put("productid", cart.getProductid());
	         map2.put("p_count", cart.getP_count());
	         int price = cart.getP_count() * cart.getPrice1();
	         map2.put("price", price);
	         this.cartService.addCartDetail(map2);//3. cartDetail insert
	         flag = 1;
	      }else{ // 비어있지 않다면 장바구니가 있다면 상품 있는지 비교 
	            Map<String, Object> map8 = new HashMap<String, Object>();
	            String userid7 = (String)session.getAttribute("userid");
	            map8.put("userid", userid7); // 여기까진 이상x 
	            this.cartService.selectCartid(map8); // userid로 cartBasic의 cartid값 받아오기
	            List<cartDetailVO> list7 = (List<cartDetailVO>)map8.get("results");
	            String cartid7 = list7.get(0).getCartid();
	/////////////장바구니번호가 중복되면 안되므로 userid가 갖고있는 cartid로 insert해야함////////////////////////////////   
	            // userid로 조회한 cartid 가 비어있지않다면 (장바구니가 있다면) cartbasic insert 생략
   
	            Map<String, Object> map = new HashMap<String, Object>();
	            map.put("cartid", cartid7);
	            map.put("productid", cart.getProductid());
	            this.cartService.selectCartDetailOne(map);
	            List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
	            
	            if(list.size() ==1) { // 장바구니에 해당 상품이 존재한다면
	            	flag = 0;
	            }else { // 장바구니에 해당 상품이 존재하지 않는다면
	            	Map<String, Object> map2 = new HashMap<String, Object>(); // cartDetail insert를 위한 map 생성
		               map2.put("cartid", cartid7);
		               map2.put("productid", cart.getProductid());
		               map2.put("p_count", cart.getP_count());
		               int price = cart.getP_count() * cart.getPrice1();
		               map2.put("price", price);
		               this.cartService.addCartDetail(map2);//3. cartDetail insert
		               flag = 1;
	            }              
	         }
	      
	      return flag;	
	}
	
	
	@RequestMapping(value = "/productInfoSelect/{cartidx}", method = RequestMethod.GET) // 카트 ID로 하나의 카트한줄 조회
	@ResponseBody
	public Map productInfoSelect(@PathVariable String cartidx) { // 장바구니 전체조회
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartidx", cartidx); // 유저 아이디로 장바구니에 있는 상품 전체 가져오기
		this.cartService.selectCartOne(map); // 장바구니 전체조회
		List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data;
	}
	
	   @RequestMapping(value = "/cartEaSearch", method = RequestMethod.GET)
	   @ResponseBody
	   public int cartEaSearch(HttpSession session) { // 유저id별로 장바구니에 몇개 들어가있는지
	      Map<String, Object> map = new HashMap<String, Object>();
	      String userid = (String) session.getAttribute("userid");
	      map.put("userid", userid); // 유저 아이디로 장바구니에 있는 상품 전체 가져오기
	      this.cartService.selectAll(map); // 장바구니 전체조회
	      List<cartDetailVO> list = (List<cartDetailVO>)map.get("results");
	      
	   //   Map<String, Object> data = new HashMap<String, Object>();
	      //data.put("code", Boolean.TRUE);
	      //data.put("data", list);
	      return list.size();
	   }
	   
	   
		@RequestMapping(value="/cartDetailUpdate",method=RequestMethod.PUT)
		@ResponseBody // 장바구니 수량 변경
		public Map cartDtailUpdate(@RequestBody cartDetailVO cart) {
			this.cartService.updateCartDetail(cart);
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("code", Boolean.TRUE);
			return map;
		}
}
