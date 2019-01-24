package com.example.vo;

import java.util.Date;

public class QnAVO {
	private int qna_idx, c_lock, readnum, grp, lev, step;
	private String title, contents;
	private String writedate;
	private String userid; 
	
	public QnAVO() {}
	
	public QnAVO(int qna_idx, String userid, int c_lock, int readnum, int grp, int lev, int step, String title,
			String contents, String writedate) {
		super();
		this.qna_idx = qna_idx;
		this.userid = userid;
		this.c_lock = c_lock;
		this.readnum = readnum;
		this.grp = grp;
		this.lev = lev;
		this.step = step;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
	}
	public int getQna_idx() {
		return qna_idx;
	}
	public void setQna_idx(int qna_idx) {
		this.qna_idx = qna_idx;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getC_lock() {
		return c_lock;
	}
	public void setC_lock(int c_lock) {
		this.c_lock = c_lock;
	}
	public int getReadnum() {
		return readnum;
	}
	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	
	
	
}
