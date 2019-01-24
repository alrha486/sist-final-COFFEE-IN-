package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.QaddressDao;
import com.example.vo.QaddressVO;

@Service("qaddressService")
public class QaddressServiceImpl implements QaddressService{
	@Autowired
	QaddressDao qaddressDao;
	
	@Override
	public void addressinsert(QaddressVO qaddress) {
		this.qaddressDao.addressinsert(qaddress);
	}

	@Override
	public void addressselect(Map map) {
		this.qaddressDao.addressselect(map);
	}

	@Override
	public void addressdelete(String addressnamekey) {
		this.qaddressDao.addressdelete(addressnamekey);
	}
	
}
