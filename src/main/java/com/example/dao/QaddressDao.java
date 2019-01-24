package com.example.dao;

import java.util.Map;

import com.example.vo.QaddressVO;

public interface QaddressDao {
	
	void addressinsert(QaddressVO qaddress);
	void addressselect(Map map);
	void addressdelete(String addressnamekey);
}
