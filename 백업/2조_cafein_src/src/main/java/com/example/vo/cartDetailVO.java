package com.example.vo;

public class cartDetailVO {
	private String cartidx; // 장바구니 일련번호
	private String cartid; // 장바구니 번호
	private int productid; // 상품 id
	private int p_count; // 상품 개수
	private int price; // 합산 가격 
	private int validation; // 존재 상태

	private String productname; // 상품명
	private String productimg; // 상품이미지 mapper 에서 사용할 임시변수 
	private int price1; // 상품 단가
	private String userid;
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getProductimg() {
		return productimg;
	}

	public void setProductimg(String productimg) {
		this.productimg = productimg;
	}

	public cartDetailVO() {
		
	}
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCartidx() {
		return cartidx;
	}
	public void setCartidx(String cartidx) {
		this.cartidx = cartidx;
	}
	public String getCartid() {
		return cartid;
	}
	public void setCartid(String cartid) {
		this.cartid = cartid;
	}
	public int getProductid() {
		return productid;
	}
	public void setProductid(int productid) {
		this.productid = productid;
	}
	public int getP_count() {
		return p_count;
	}
	public void setP_count(int p_count) {
		this.p_count = p_count;
	}

	public int getValidation() {
		return validation;
	}

	public void setValidation(int validation) {
		this.validation = validation;
	}

	public int getPrice1() {
		return price1;
	}

	public void setPrice1(int price1) {
		this.price1 = price1;
	}
	
	
}
