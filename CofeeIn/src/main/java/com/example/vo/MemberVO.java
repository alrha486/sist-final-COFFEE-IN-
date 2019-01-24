package com.example.vo;

import java.util.Date;

public class MemberVO {
	private int idx;
	private String username;
	private String usernickname;

	private String userid;
	private String passwd;
	private String email;
	private String tel;

	private String regdate;
	private String zipcode;
	private String address1;
	private String address2;
	
	public MemberVO() { 
	}// 디폴트생성자		
	
	public MemberVO(String userid, String passwd) { 
		this.username = username;
		this.passwd = passwd;
	}// 필수입력 생성자 --> 이거뭐지 ?필요없을듯
	
	public MemberVO(String username,String usernickname ,String userid, String passwd, String email, String tel, String regdate) { 
		this.username = username;
		this.usernickname = usernickname;
		this.userid = userid;
		this.passwd = passwd;
		this.email = email;
		this.tel = tel;
		this.regdate = regdate;
	}// 필수입력 생성자 --> 이거뭐지 ?필요없을듯
	
	public MemberVO(String userid, String username, String usernickname, String email,String tel) { 
		this.userid = userid;
		this.username = username;
		this.usernickname = usernickname;
		this.email = email;
		this.tel = tel;
	}//카카오톡,네이버 간편 회원가입 전용 생성자


	public MemberVO(String username, String userid, String usernickname,String passwd, String email, 
			String tel,String zipcode,	String address1, String address2) {
		this.username = username;
		this.usernickname = usernickname;
		this.userid = userid;
		this.passwd = passwd;
		this.email = email;
		this.tel = tel;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
	} // 다 집어넣는 생성자

	
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getRegdate() {
		return regdate;
	}
	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsernickname() {
		return usernickname;
	}

	public void setUsernickname(String usernickname) {
		this.usernickname = usernickname;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
	
}
