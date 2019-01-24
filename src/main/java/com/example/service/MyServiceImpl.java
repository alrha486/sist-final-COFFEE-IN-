package com.example.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.MyDao;
import com.example.vo.MyVO;

@Service("myService")
public class MyServiceImpl implements MyService {
	@Autowired
	MyDao myDao;
	


/*	@Override
	public int update(MyVO myVo) {
		return this.myDao.update(myVo);
	}

	@Override
	public int delete(String userid) {
		return this.myDao.delete(userid);
	}

	@Override
	public int updateDelivery(MyVO myVo) {
		return this.myDao.updateDelivery(myVo);
	}

	@Override
	public List<MyVO> info_read() {
		return this.myDao.info_read();
	}*/

	@Override
	public void read(Map map) {
		this.myDao.read(map);
	}



	@Override
	public void MyUpdate(MyVO my) {
		this.myDao.update(my);
	}



	@Override
	public void deleteinfo(Map map) {
		this.myDao.deleteinfo(map);
	}


}
