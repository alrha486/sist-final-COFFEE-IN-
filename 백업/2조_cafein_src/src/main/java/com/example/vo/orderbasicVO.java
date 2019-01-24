package com.example.vo;

import java.util.Date;

public class orderbasicVO {
	private int orderid; //주문번호
	private String userid; // 회원id
	private String username; // 수신자이름
	private String tel ; //수신자 휴대폰
	private String zipcode; // 우편번호
	private String address1;  //주소1
	private String address2 ; // 주소2
	private String message;  // 배송 메시지
	private int payid ; // 결제수단
	private int o_state; // 주문상태
	private int couponNum; // 쿠폰번호 
	private int delivery; // 배송비
	private int totalprice; // 결제금액 // 할인가적용
	private int coupon_discount; // 쿠폰 할인가
	private int saving_discount; // 적립금 할인가
	private int realtotalprice; // 원래금액(할인가적용x)
	
	private Date date1;
	private Date date2;
	

	public Date getDate1() {
		return date1;
	}
	public void setDate1(Date date1) {
		this.date1 = date1;
	}
	public Date getDate2() {
		return date2;
	}
	public void setDate2(Date date2) {
		this.date2 = date2;
	}
	public int getCoupon_discount() {
		return coupon_discount;
	}
	public void setCoupon_discount(int coupon_discount) {
		this.coupon_discount = coupon_discount;
	}
	public int getSaving_discount() {
		return saving_discount;
	}
	public void setSaving_discount(int saving_discount) {
		this.saving_discount = saving_discount;
	}
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getPayid() {
		return payid;
	}
	public void setPayid(int payid) {
		this.payid = payid;
	}
	public int getO_state() {
		return o_state;
	}
	public void setO_state(int o_state) {
		this.o_state = o_state;
	}
	public int getCouponNum() {
		return couponNum;
	}
	public void setCouponNum(int couponNum) {
		this.couponNum = couponNum;
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public int getRealtotalprice() {
		return realtotalprice;
	}
	public void setRealtotalprice(int realTotalprice) {
		this.realtotalprice = realTotalprice;
	}
	
	
	
	}
