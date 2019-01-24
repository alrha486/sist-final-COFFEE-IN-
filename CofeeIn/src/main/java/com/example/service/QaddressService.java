package com.example.service;

import java.util.Map;

import com.example.vo.QaddressVO;

public interface QaddressService {
	void addressinsert(QaddressVO qaddress);
	void addressselect(Map map);
	void addressdelete(String addressnamekey);
}
