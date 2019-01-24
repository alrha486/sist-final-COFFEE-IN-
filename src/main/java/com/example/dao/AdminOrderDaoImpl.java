package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("adminOrderDao")
public class AdminOrderDaoImpl implements AdminOrderDao{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void adminOrder_select(Map map) {
		this.sqlSession.selectList("OrderProduct.admin_order_select", map);
	}

	@Override
	public void adminOrder_selectall(Map map) {
		this.sqlSession.selectList("admin_order_select_all", map);
	}

	@Override
	public void adminOrder_selectany(Map map) {
		this.sqlSession.selectList("OrderProduct.admin_order_select_any", map);
	}


	@Override
	public void adminOrder_select_any_price(Map map) {
		this.sqlSession.selectList("adminOrder_select_any_price", map);
	}

	@Override
	public void adminOrder_select_any_selldate(Map map) {
		this.sqlSession.selectList("adminOrder_select_any_selldate", map);
	}

	@Override
	public void adminOrder_select_any_orderid(Map map) {
		this.sqlSession.selectList("adminOrder_select_any_orderid", map);
	}

}
