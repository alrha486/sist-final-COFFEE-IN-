package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.OrderDAO;
import com.example.vo.orderbasicVO;

@Service("orderService")
public class OrderServiceImpl implements OrderService{
	@Autowired
	OrderDAO orderDao;

	@Override
	public void insertOrderBasic(orderbasicVO orderbasic) {
		this.orderDao.insertOrderBasic(orderbasic);
	}

	@Override
	public void selectOrderid(Map map) {
		this.orderDao.selectOrderid(map);
	}

	@Override
	public void insertOrderDetail(Map map) {
		this.orderDao.insertOrderDetail(map);
	}

	@Override
	public void orderInfoSelect(Map map) {
		this.orderDao.orderInfoSelect(map);		
	}

	@Override
	public void orderIdsSize(Map map) {
		this.orderDao.orderIdsSize(map);
	}

	@Override
	public void orderDetailSelect(Map map) {
		this.orderDao.orderDetailSelect(map);
	}

	@Override
	public void updateProductNum(Map map) {
		this.orderDao.updateProductNum(map);
	}

	@Override
	public void SearchOrderCount(Map map) {
		this.orderDao.SearchOrderCount(map);
	}

	@Override
	public void SearchOrderCount1(Map map) {
		this.orderDao.SearchOrderCount1(map);
	}

	@Override
	public void SearchOrderCount2(Map map) {
		this.orderDao.SearchOrderCount2(map);
	}

	@Override
	public void orderStateModify(int orderid) {
		this.orderDao.orderStateModify(orderid);
	}
	
	@Override
	public void orderStateModify1(int orderid) {
		this.orderDao.orderStateModify1(orderid);
	}
	

}
