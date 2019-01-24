package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.StoreDao;

@Service("StoreService")
public class StoreServiceImpl implements StoreService {
	@Autowired
	StoreDao storeDao;
	
	@Override
	public void readany(Map map) {
		this.storeDao.readStore(map);
	}

	@Override
	public void readAll(Map map) {
		this.storeDao.readAllStore(map);
	}

	@Override
	public void readShopname(Map map) {
		this.storeDao.readShopname(map);
	}

}
