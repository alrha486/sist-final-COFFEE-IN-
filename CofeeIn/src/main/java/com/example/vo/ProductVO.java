package com.example.vo;

public class ProductVO {
	private int productid; // 상품 일련번호
	private int kind_idx; // 상품 타입 
	private String productname; // 상품 이름
	private String productimg; // 상품 이미지
	private String productex; // 상품 설명
	private int price; // 상품 가격 
	private int sell_count; // 판매수량
	private String registerdate;	
	
	private int pcount;
	private String p_type;
	private String p_productkind;
	private String selldate;
	
	private int stock; // 재고량
	
	
	public String getP_type() {
		return p_type;
	}

	public void setP_type(String p_type) {
		this.p_type = p_type;
	}

	public String getP_productkind() {
		return p_productkind;
	}

	public void setP_productkind(String p_productkind) {
		this.p_productkind = p_productkind;
	}

	public int getPcount() {
		return pcount;
	}

	public void setPcount(int pcount) {
		this.pcount = pcount;
	}

	public ProductVO() {
		
	}// 디폴트 생성자
	
	public int getProductid() {
		return productid;
	}
	public void setProductid(int productid) {
		this.productid = productid;
	}
	public int getKind_idx() {
		return kind_idx;
	}
	public void setKind_idx(int kind_idx) {
		this.kind_idx = kind_idx;
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
	public String getProductex() {
		return productex;
	}
	public void setProductex(String productex) {
		this.productex = productex;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSell_count() {
		return sell_count;
	}
	public void setSell_count(int s_count) {
		this.sell_count = s_count;
	}

	public String getRegisterdate() {
		return registerdate;
	}

	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}

	public String getSelldate() {
		return selldate;
	}

	public void setSelldate(String selldate) {
		this.selldate = selldate;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}
	
	//private int total; // 매출액 (관리자페이지에서 상품판매순위)


	
}
