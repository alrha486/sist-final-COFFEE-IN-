package com.example.vo;

public class orderdetailVO {
	private int orderidx; // 주문 일련번호 
	private int orderid; // 주문 번호
	private int productid; //상품번호
	private int pcount; // 상품수량
	private int price; // 금액
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
	private int totalprice; // 할인가를 적용안한 총 가격
	private String selldate; // 구매일자 
	private String productimg; // 상품이미지 
	private String productname; // 상품명 
	private int coupon_discount; // 쿠폰 할인가
	private int saving_discount; // 적립금 할인가
	private int realtotalprice; // 원래금액(할인가적용x)
	
	
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

	public String getSelldate() {
		return selldate;
	}

	public void setSelldate(String selldate) {
		this.selldate = selldate;
	}

	public String getProductimg() {
		return productimg;
	}

	public void setProductimg(String productimg) {
		this.productimg = productimg;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	
	public orderdetailVO() {
		
	}
	
	//DB입력 생성자
	public orderdetailVO(int orderid, int productid, int pcount, int price) {
		this.orderid = orderid;
		this.productid = productid;
		this.pcount = pcount;
		this.price = price;
	}
	
	public orderdetailVO(int orderidx, int orderid, int productid, int pcount, int price) {
		this.orderidx = orderidx;
		this.orderid = orderid;
		this.productid = productid;
		this.pcount = pcount;
		this.price = price;
	}
	public int getOrderidx() {
		return orderidx;
	}
	public void setOrderidx(int orderidx) {
		this.orderidx = orderidx;
	}
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getProductid() {
		return productid;
	}
	public void setProductid(int productid) {
		this.productid = productid;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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

	public int getRealtotalprice() {
		return realtotalprice;
	}

	public void setRealtotalprice(int realtotalprice) {
		this.realtotalprice = realtotalprice;
	}


	
	
}
