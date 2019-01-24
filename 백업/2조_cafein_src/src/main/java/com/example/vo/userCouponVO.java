package com.example.vo;

public class userCouponVO {
	private int c_idx; // 일련번호
	private String userid; // 유저id
	private int couponNum; //쿠폰테이블 fk
	private String receive_date; // 발급 날자
	private int validity; // 쿠폰상태(1:있는 상태(기본), 2:쿠폰사용시)
	
	private String c_name; // 쿠폰이름
	private String c_content; //쿠폰 내용
	private int c_discount; // 쿠폰 할인 금액
	private String c_dead; // 쿠폰 마감 일자
	private int c_condition; //쿠폰 사용 조건(최소금액)
	
	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public String getC_content() {
		return c_content;
	}

	public void setC_content(String c_content) {
		this.c_content = c_content;
	}

	public int getC_discount() {
		return c_discount;
	}

	public void setC_discount(int c_discount) {
		this.c_discount = c_discount;
	}

	public String getC_dead() {
		return c_dead;
	}

	public void setC_dead(String c_dead) {
		this.c_dead = c_dead;
	}

	public int getC_condition() {
		return c_condition;
	}

	public void setC_condition(int c_condition) {
		this.c_condition = c_condition;
	}

	public userCouponVO() {
	} // 디폴트 생성자

	public int getC_idx() {
		return c_idx;
	}

	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getCouponNum() {
		return couponNum;
	}

	public void setCouponNum(int couponNum) {
		this.couponNum = couponNum;
	}

	public String getReceive_date() {
		return receive_date;
	}

	public void setReceive_date(String receive_date) {
		this.receive_date = receive_date;
	}

	public int getValidity() {
		return validity;
	}

	public void setValidity(int validity) {
		this.validity = validity;
	}
	

	
}
