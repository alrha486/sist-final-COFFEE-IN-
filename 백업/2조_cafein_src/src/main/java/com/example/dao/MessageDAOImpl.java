package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.MessageVO;

@Repository("MessageDao")
public class MessageDAOImpl implements MessageDAO{
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insertCouponMessage(Map map) {
		this.sqlSession.insert("Message.insertCouponMessage",map);
	}

	@Override
	public void selectMessageAll(Map map) {
		this.sqlSession.selectList("Message.selectMessageAll",map);
	}

	@Override
	public void insertOrderMessage(Map map) {
		this.sqlSession.insert("Message.insertOrderMessage",map);
	}

	@Override
	public void selectMessageAllAdmin(Map map) {
		this.sqlSession.selectList("Message.selectMessageAllAdmin",map);
	}

	@Override
	public void selectReceiverList(Map map) {
		this.sqlSession.selectList("Message.selectReceiverList",map);
	}

	@Override
	public void insertUserMessage(MessageVO message) {
		this.sqlSession.insert("Message.insertUserMessage",message);
	}

	@Override
	public void insertAdminMessage(MessageVO message) {
		this.sqlSession.insert("Message.insertAdminMessage",message);
	}

	@Override
	public void AuToinsertAdminMessage(MessageVO message) {
		this.sqlSession.insert("Message.AuToinsertAdminMessage",message);
	}

	@Override
	public void selectUserUnReadMessage(Map map) {
		this.sqlSession.selectList("Message.selectUserUnReadMessage",map);
	}

	@Override
	public void MessageReadUpdate(Map map) {
		this.sqlSession.update("Message.MessageReadUpdate",map);
	}

	@Override
	public void MessageReadUpdateAdmin(Map map) {
		this.sqlSession.update("Message.MessageReadUpdateAdmin",map);
	}

	@Override
	public void insertOrderStateChange(Map map) {
		this.sqlSession.insert("Message.insertOrderStateChange",map);
	}
	
	@Override
	public void insertOrderStateChange1(Map map) {
		this.sqlSession.insert("Message.insertOrderStateChange1",map);
	}

	@Override
	public void selectMreadCount(Map map) {
		this.sqlSession.selectList("Message.selectMreadCount",map);
	}
}

