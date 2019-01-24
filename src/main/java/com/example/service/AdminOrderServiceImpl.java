package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.AdminOrderDao;

@Service("adminOrderService")
public class AdminOrderServiceImpl implements AdminOrderService{
	@Autowired
	AdminOrderDao adminOrderDao;
	
	@Override
	public void adminOrder_select(Map map) {
		this.adminOrderDao.adminOrder_select(map);
	}

	@Override
	public void adminOrder_selectall(Map map) {
		this.adminOrderDao.adminOrder_selectall(map);
	}

	@Override
	public void adminOrder_selectany(Map map) {
		this.adminOrderDao.adminOrder_selectany(map);
	}


	@Override
	public void adminOrder_select_any_price(Map map) {
		this.adminOrderDao.adminOrder_select_any_price(map);
	}

	@Override
	public void adminOrder_select_any_selldate(Map map) {
		this.adminOrderDao.adminOrder_select_any_selldate(map);
	}

	@Override
	public void adminOrder_select_any_orderid(Map map) {
		this.adminOrderDao.adminOrder_select_any_orderid(map);
	}

}
