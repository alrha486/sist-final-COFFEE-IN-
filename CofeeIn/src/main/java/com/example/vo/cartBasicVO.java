package com.example.vo;

public class cartBasicVO {
	private int cartid;
	private String userid;
	private int cartstate;
	
	public cartBasicVO() {
		
	}
	public cartBasicVO(String userid) {
		this.userid = userid;
	}
	
	public cartBasicVO(int cartid, String userid, int cartstate) {
		this.cartid = cartid;
		this.userid = userid;
		this.cartstate = cartstate;
	}
	public int getCartid() {
		return cartid;
	}
	public void setCartid(int cartid) {
		this.cartid = cartid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getCartstate() {
		return cartstate;
	}
	public void setCartstate(int cartstate) {
		this.cartstate = cartstate;
	}
	
	
}
