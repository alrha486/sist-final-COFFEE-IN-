package com.example.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.AdminOrderService;
import com.example.vo.AdminOrderVO;
import com.example.vo.ProductVO;

@Controller
public class AdminOrderController {
	@Autowired
	AdminOrderService adminOrderService;
	
	@RequestMapping(value = "/admin/order", method = RequestMethod.GET)
	@ResponseBody
	public Map AdminOrderSelect() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		this.adminOrderService.adminOrder_select(map);
		Map<String, Object> pnameResult = new HashMap<String, Object>();
		List<ProductVO> list = (List<ProductVO>)map.get("admin_order_select_result");
		
		pnameResult.put("rows", list);
		pnameResult.put("code", Boolean.TRUE);
		
		return pnameResult;
	}
	
	@RequestMapping(value = "/admin/order/allselect", method = RequestMethod.GET)
	@ResponseBody
	public Map AdminOrderSelectAll() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		this.adminOrderService.adminOrder_selectall(map);
		Map<String, Object> allResult = new HashMap<String, Object>();
		List<AdminOrderVO> list = (List<AdminOrderVO>)map.get("admin_order_select_all_result");
		
		allResult.put("data", list);
		allResult.put("code", Boolean.TRUE);
		
		return allResult;
	}
	
	
	

	
	@RequestMapping(value = "/admin/order/testanyselect/{productname}/{datepicker1}/{datepicker2}/{deliveryStep}/{orderlist}/{payid}/", method = RequestMethod.GET)
	@ResponseBody
	public Map testanyselect(@PathVariable String productname, @PathVariable String datepicker1, @PathVariable String datepicker2,
			@PathVariable String deliveryStep, @PathVariable String orderlist, @PathVariable String payid) {
		String s_productname = productname;
		String s_datepicker1 = datepicker1;
		String s_datepicker2 = datepicker2;
		String s_deliveryStep = deliveryStep;
		String s_orderlist = orderlist;
		String s_payid = payid;
		
		if(productname.equals("--선택--")) {
			s_productname = "";
		}
		
		switch(Integer.parseInt(deliveryStep)){
	       case 0 :  s_deliveryStep = "1"; break;
	       case 1 :  s_deliveryStep = "1"; break;
	       case 2 :  s_deliveryStep = "2"; break;
	       case 3 :  s_deliveryStep = "3"; break;
	       case 4 :  s_deliveryStep = "4"; break;
	       case 5 :  s_deliveryStep = "5"; break;
	    }
		
		if(s_payid.equals("0")) {
			s_payid = "";
		}
		
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("productname", s_productname);
		map.put("datepicker1", s_datepicker1);
		map.put("datepicker2", s_datepicker2);
		map.put("deliveryStep", s_deliveryStep);
		map.put("payid", s_payid);
		
		switch(Integer.parseInt(orderlist)) {
		case 0 : this.adminOrderService.adminOrder_select_any_price(map); break;
		case 1 : this.adminOrderService.adminOrder_select_any_selldate(map); break;
		case 2 : this.adminOrderService.adminOrder_select_any_orderid(map); break;
		case 3 : this.adminOrderService.adminOrder_select_any_price(map); break;
		}
		
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		List<AdminOrderVO> list = (List<AdminOrderVO>)map.get("admin_order_select_any_result");

		
		result.put("data", list);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
}
