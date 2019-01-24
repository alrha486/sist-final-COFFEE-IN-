package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.QaddressVO;

@Repository("qaddressDao")
public class QaddressDaoImpl implements QaddressDao{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void addressinsert(QaddressVO qaddress) {  // 기본배송지 외 배송지 추가 
		this.sqlSession.insert("qaddressinsert", qaddress);
	}

	@Override
	public void addressselect(Map map) {
		this.sqlSession.selectList("qaddressselect", map);
	}

	@Override
	public void addressdelete(String qaddressname) {
		this.sqlSession.delete("qaddressdelete", qaddressname);
	}

}
