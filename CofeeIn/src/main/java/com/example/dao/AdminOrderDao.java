package com.example.dao;

import java.util.Map;

public interface AdminOrderDao {
	
	void adminOrder_select(Map map);
	void adminOrder_selectall(Map map);
	void adminOrder_selectany(Map map);
	void adminOrder_select_any_price(Map map);
	void adminOrder_select_any_selldate(Map map);
	void adminOrder_select_any_orderid(Map map);
}
