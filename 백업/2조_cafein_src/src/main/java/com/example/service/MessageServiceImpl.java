package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.MessageDAO;
import com.example.vo.MessageVO;

@Service("messageService")
public class MessageServiceImpl implements MessageService{
	@Autowired
	MessageDAO messageDao;

	@Override
	public void insertCouponMessage(Map map) {
		this.messageDao.insertCouponMessage(map);
	}

	@Override
	public void selectMessageAll(Map map) {
		this.messageDao.selectMessageAll(map);
	}

	@Override
	public void insertOrderMessage(Map map) {
		this.messageDao.insertOrderMessage(map);
	}

	@Override
	public void selectMessageAllAdmin(Map map) {
		this.messageDao.selectMessageAllAdmin(map);
	}

	@Override
	public void selectReceiverList(Map map) {
		this.messageDao.selectReceiverList(map);
	}

	@Override
	public void insertUserMessage(MessageVO message) {
		this.messageDao.insertUserMessage(message);
	}

	@Override
	public void insertAdminMessage(MessageVO message) {
		this.messageDao.insertAdminMessage(message);
	}

	@Override
	public void AuToinsertAdminMessage(MessageVO message) {
		this.messageDao.AuToinsertAdminMessage(message);
	}

	@Override
	public void selectUserUnReadMessage(Map map) {
		this.messageDao.selectUserUnReadMessage(map);
	}

	@Override
	public void MessageReadUpdate(Map map) {
		this.messageDao.MessageReadUpdate(map);
	}

	@Override
	public void MessageReadUpdateAdmin(Map map) {
		this.messageDao.MessageReadUpdateAdmin(map);	
	}

	@Override
	public void insertOrderStateChange(Map map) {
		this.messageDao.insertOrderStateChange(map);
	}

	@Override
	public void insertOrderStateChange1(Map map) {
		this.messageDao.insertOrderStateChange1(map);
	}

	@Override
	public void selectMreadCount(Map map) {
		this.messageDao.selectMreadCount(map);
	}

	

}
