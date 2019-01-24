package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.StoreService;
import com.example.vo.StoreVO;

@Controller
public class StoreController {
	@Autowired
	StoreService storeService;
	
	@RequestMapping(value = "/store", method = RequestMethod.GET)
	public String goStore() {
		
		return "store";
	}
	
	@RequestMapping(value = "/store/searchmap/", method = RequestMethod.POST)
	public String goMap() {
		
		return "searchmap";
	}
	
	@RequestMapping(value = "/store/search", method = RequestMethod.POST)
	@ResponseBody
	public Map Allsearchstore() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		this.storeService.readAll(map);
		
		List<StoreVO> list = (List<StoreVO>)map.get("storeAllResult");
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("data", list);
		result.put("code", Boolean.TRUE);
		
		return result;
	}
	
	@RequestMapping(value = "/store/anysearch/{searchname}", method = RequestMethod.GET)
	@ResponseBody
	public Map Anysearchstore(@PathVariable String searchname) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("DB에들어갈 검색 값은 = " + searchname);
		map.put("address", searchname);
		this.storeService.readany(map);
		
		List<StoreVO> list = (List<StoreVO>)map.get("storeAnyResult");
		
		System.out.println("검색하여 불러온 리스트에 사이즈는 ? = " + list.size());
		
		Map<String, Object> anylist = new HashMap<String, Object>();
		anylist.put("data", list);
		anylist.put("code", Boolean.TRUE);
		return anylist;
	}
	
	@RequestMapping(value = "/store/shopsearch/{shopname}", method = RequestMethod.GET)
	@ResponseBody
	public Map shopnameSearch(@PathVariable String shopname) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("shopname =" + shopname);
		map.put("shopname", shopname);
		this.storeService.readShopname(map);
		
		List<StoreVO> list = (List<StoreVO>)map.get("shopnameResult");
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("data", list);
		result.put("code", Boolean.TRUE);
		
		return result;
	}
}
