package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("cityDao")
public class CityDaoImpl implements CityDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void readGugun(Map map) {
		this.sqlSession.selectList("CityListAll", map);
	}

}
