package com.example.service;

import java.util.List;
import java.util.Map;

import com.example.vo.MyVO;

public interface MyService {
	void read(Map map);
	/*List<MyVO> info_read();*/
/*	int update(MyVO memberVo);
	int updateDelivery(MyVO memberVo);
	int delete(String userid);*/

	void MyUpdate(MyVO my);
	void deleteinfo(Map map);
}
