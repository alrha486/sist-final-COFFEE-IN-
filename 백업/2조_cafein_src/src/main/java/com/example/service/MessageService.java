package com.example.service;

import java.util.Map;

import com.example.vo.MessageVO;

public interface MessageService {
	void insertCouponMessage(Map map);
	void selectMessageAll(Map map);
	void insertOrderMessage(Map map);
	void selectMessageAllAdmin(Map map);
	void selectReceiverList(Map map);
	void insertUserMessage(MessageVO message);
	void insertAdminMessage(MessageVO message);
	void AuToinsertAdminMessage(MessageVO message);
	void selectUserUnReadMessage(Map map);
	void MessageReadUpdate(Map map);
	void MessageReadUpdateAdmin(Map map);
	void insertOrderStateChange(Map map);
	void insertOrderStateChange1(Map map);
	void selectMreadCount(Map map);
}
