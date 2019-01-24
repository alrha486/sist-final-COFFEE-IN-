package com.example.vo;

public class RevVO {
	private int rev_idx;
	private int productid;
	private String userid;
	private String rev_title;
	private String rev_file;
	private int rev_score;
	private String rev_contents;
	private String rev_writedate;
	
	private String productname;
	
	
	public RevVO() {}
	
	public RevVO(int rev_idx, int productid, String userid, String rev_title, String rev_file, int rev_score,
			String rev_contents, String rev_writedate) {
		this.rev_idx = rev_idx;
		this.productid = productid;
		this.userid = userid;
		this.rev_title = rev_title;
		this.rev_file = rev_file;
		this.rev_score = rev_score;
		this.rev_contents = rev_contents;
		this.rev_writedate = rev_writedate;
	}

	public int getRev_idx() {
		return rev_idx;
	}

	public void setRev_idx(int rev_idx) {
		this.rev_idx = rev_idx;
	}

	public int getProductid() {
		return productid;
	}

	public void setProductid(int productid) {
		this.productid = productid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getRev_title() {
		return rev_title;
	}

	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}

	public String getRev_file() {
		return rev_file;
	}

	public void setRev_file(String rev_file) {
		this.rev_file = rev_file;
	}

	public int getRev_score() {
		return rev_score;
	}

	public void setRev_score(int rev_score) {
		this.rev_score = rev_score;
	}

	public String getRev_contents() {
		return rev_contents;
	}

	public void setRev_contents(String rev_contents) {
		this.rev_contents = rev_contents;
	}

	public String getRev_writedate() {
		return rev_writedate;
	}

	public void setRev_writedate(String rev_writedate) {
		this.rev_writedate = rev_writedate;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}
	
	
	
}
