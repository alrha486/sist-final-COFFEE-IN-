package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.vo.MyVO;

public interface MyDao {
	void read(Map map);
/*	int update(MyVO myVo);
	int updateDelivery(MyVO myVo);
	int delete(String userid);
	List<MyVO> info_read();*/

	void update(MyVO my);
	void deleteinfo(Map map);
}
