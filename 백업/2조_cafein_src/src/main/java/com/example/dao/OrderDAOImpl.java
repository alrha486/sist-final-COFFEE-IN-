package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.orderbasicVO;

@Repository("OrderDao")
public class OrderDAOImpl implements OrderDAO{
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insertOrderBasic(orderbasicVO orderbasic) {
		this.sqlSession.insert("Order.orderBasic_insert",orderbasic);
	}

	@Override
	public void selectOrderid(Map map) {
		this.sqlSession.selectOne("Order.selectOrderid",map);
	}

	@Override
	public void insertOrderDetail(Map map) {
		this.sqlSession.insert("Order.insertOrderDetail",map);
	}

	@Override
	public void orderInfoSelect(Map map) {
		this.sqlSession.selectList("Order.orderInfoSelect",map);
	}

	@Override
	public void orderIdsSize(Map map) {
		this.sqlSession.selectOne("Order.orderIdsSize",map);
	}

	@Override
	public void orderDetailSelect(Map map) {
		this.sqlSession.selectList("Order.orderDetailSelect",map);
	}

	@Override
	public void updateProductNum(Map map) {
		this.sqlSession.update("Order.updateProductNum",map);
	}

	@Override
	public void SearchOrderCount(Map map) {
		this.sqlSession.selectList("Order.SearchOrderCount",map);
	}

	@Override
	public void SearchOrderCount1(Map map) {
		this.sqlSession.selectList("Order.SearchOrderCount1",map);
	}

	@Override
	public void SearchOrderCount2(Map map) {
		this.sqlSession.selectList("Order.SearchOrderCount2",map);
	}

	@Override
	public void orderStateModify(int orderid) {
		this.sqlSession.update("Order.orderStateModify",orderid);
	}
	
	@Override
	public void orderStateModify1(int orderid) {
		this.sqlSession.update("Order.orderStateModify1",orderid);
	}
	
}

