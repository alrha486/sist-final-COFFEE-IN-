package com.example.dao;

import java.util.Map;

import com.example.vo.RevVO;

public interface RevDAO {
	//리뷰 게시판 상품평 등록
	void create(RevVO revVo);
	//리뷰 게시판 전체 목록
	void read(Map map);
	//리뷰 게시판 리뷰 정보 불러오기
	void readOne(Map map);
	//리뷰 게시판 리뷰 수정
	void update(RevVO revVo);
	//리뷰 게시판 리뷰 삭제
	void delete(int rev_idx);
	//리뷰 게시판 상품별 리뷰 카운트
	void getReviewCount(Map map);
}
