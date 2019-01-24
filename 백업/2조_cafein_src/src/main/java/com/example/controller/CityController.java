package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.CityService;
import com.example.vo.CityVO;

@Controller
public class CityController {
	@Autowired
	CityService cityService;
	
	@RequestMapping(value ="/store/{sido}", method = RequestMethod.POST)
	@ResponseBody
	public Map listgugn(@PathVariable String sido) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sido", sido);
		this.cityService.readGugun(map);
		
		List<CityVO> list = (List<CityVO>)map.get("cityresult");
		Map<String, Object> gugunlist = new HashMap<String, Object>();
		
		gugunlist.put("rows", list);
		gugunlist.put("code", Boolean.TRUE);
		
		return gugunlist;
	}
}
