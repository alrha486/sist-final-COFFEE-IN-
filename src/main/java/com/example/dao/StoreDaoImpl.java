package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("storeDao")
public class StoreDaoImpl implements StoreDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void readStore(Map map) {
		this.sqlSession.selectList("storeAnySearch", map);
	}

	@Override
	public void readAllStore(Map map) {
		this.sqlSession.selectList("storeAllSearch", map);
	}

	@Override
	public void readShopname(Map map) {
		this.sqlSession.selectList("shopnameSearch", map);
	}

}
