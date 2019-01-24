package com.example.dao;

import java.util.Map;

import com.example.vo.orderbasicVO;

public interface OrderDAO {
	void insertOrderBasic(orderbasicVO orderbasic);
	void selectOrderid(Map map);
	void insertOrderDetail(Map map);
	void orderInfoSelect(Map map);
	void orderIdsSize(Map map);
	void orderDetailSelect(Map map);
	void updateProductNum(Map map);
	void SearchOrderCount(Map map);
	void SearchOrderCount1(Map map);
	void SearchOrderCount2(Map map);
	void orderStateModify(int orderid);
	void orderStateModify1(int orderid);
}
