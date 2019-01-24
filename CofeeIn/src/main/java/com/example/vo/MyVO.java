package com.example.vo;

public class MyVO {
	
	private String userid;
	private String passwd;
	private String username;
	private String usernickname;
	private String email;
	private String tel;
	private String regdate;
	private String zipcode;
	
	private String address1;
	private String address2;
	private int d_ID;
	private int productID;
	private int orderID;
	
	private String selldate;
	private String payid;
	private String o_state;
	private int delivery;
	private int totalprice;
	

	private int price;
	
	public MyVO() {}
	
	
	//회원정보수정
	
	
	
	public MyVO(String userid, String passwd, String email, String tel) {
		this.userid = userid;
		this.passwd = passwd;
		this.email = email;
		this.tel = tel;
	}
	

	public MyVO(String userid, String passwd, String username, String usernickname, String email, String tel,
			String zipcode, String address1, String address2) {
		this.userid = userid;
		this.passwd = passwd;
		this.username = username;
		this.usernickname = usernickname;
		this.email = email;
		this.tel = tel;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegDate(String regdate) {
		this.regdate = regdate;
	}


	//배송지관리
	public MyVO(int d_ID, String userid, String zipcode, String address1, String address2) {
		this.d_ID = d_ID;
		this.userid = userid;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
	}

	//주문내역
	public MyVO(int productID, int orderID, String selldate, String payid, String o_state, int delivery,
			int totalprice, int price) {
		this.productID = productID;
		this.orderID = orderID;
		this.selldate = selldate;
		this.payid = payid;
		this.o_state = o_state;
		this.delivery = delivery;
		this.totalprice = totalprice;
		this.price = price;
	}


	public String getSelldate() {
		return selldate;
	}



	public void setSelldate(String selldate) {
		this.selldate = selldate;
	}



	public String getPayid() {
		return payid;
	}



	public void setPayid(String payid) {
		this.payid = payid;
	}



	public String getO_state() {
		return o_state;
	}



	public void setO_state(String o_state) {
		this.o_state = o_state;
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



	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getD_ID() {
		return d_ID;
	}

	public void setD_ID(int d_ID) {
		this.d_ID = d_ID;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
	
	
}
