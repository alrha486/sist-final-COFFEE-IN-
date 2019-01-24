package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CityDao;

@Service("CityService")
public class CityServiceImpl implements CityService {
	@Autowired
	CityDao cidyDao;

	@Override
	public void readGugun(Map map) {
		this.cidyDao.readGugun(map);
	}
	
}
