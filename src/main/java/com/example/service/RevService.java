package com.example.service;

import java.util.Map;

import com.example.vo.RevVO;

public interface RevService {
	//리뷰 게시판 리뷰 등록
	void insertReview(RevVO revVo);
	//리뷰 게시판 상품별 리뷰 전체목록
	void selectReview(Map map);
	//리뷰 게시판 리뷰 정보 불러오기
	void selectOneReview(Map map);
	//리뷰 게시판 리뷰 수정
	void updateReview(RevVO revVo);
	//리뷰 게시판 리뷰 삭제
	void deleteReview(int rev_idx);
	//리뷰 게시판 상품별 리뷰 카운트
	void getReviewCount(Map map);
}
