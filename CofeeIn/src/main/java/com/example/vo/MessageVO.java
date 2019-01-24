package com.example.vo;

public class MessageVO {
	private int m_idx; // 일련번호
	private String m_sender; // 송신자
	private String m_receiver; // 수신자
	private String m_contents; // 메시지내용
	private String m_date; // 메시지보낸 일자
	
	
	private String username; // 유저네임 (FK)
	private int m_read;
	
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getM_sender() {
		return m_sender;
	}
	public void setM_sender(String m_sender) {
		this.m_sender = m_sender;
	}
	public String getM_receiver() {
		return m_receiver;
	}
	public void setM_receiver(String m_receiver) {
		this.m_receiver = m_receiver;
	}
	public String getM_contents() {
		return m_contents;
	}
	public void setM_contents(String m_contents) {
		this.m_contents = m_contents;
	}
	public String getM_date() {
		return m_date;
	}
	public void setM_date(String m_date) {
		this.m_date = m_date;
	}
	
	public MessageVO() {
		
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getM_read() {
		return m_read;
	}
	public void setM_read(int m_read) {
		this.m_read = m_read;
	}
}
