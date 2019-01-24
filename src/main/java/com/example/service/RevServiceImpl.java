package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.RevDAO;
import com.example.vo.RevVO;

@Service("revService")
public class RevServiceImpl implements RevService {
	@Autowired
	RevDAO revDao;

	//리뷰 게시판 리뷰 등록
	@Override
	public void insertReview(RevVO revVo) {
		this.revDao.create(revVo);
	}
	//리뷰 게시판 상품별 리뷰 전체목록
	@Override
	public void selectReview(Map map) {
		this.revDao.read(map);
	}
	//리뷰 게시판 리뷰 정보 불러오기
	@Override
	public void selectOneReview(Map map) {
		this.revDao.readOne(map);
	}
	//리뷰 게시판 리뷰 수정
	@Override
	public void updateReview(RevVO revVo) {
		this.revDao.update(revVo);
	}
	//리뷰 게시판 리뷰 삭제
	@Override
	public void deleteReview(int rev_idx) {
		this.revDao.delete(rev_idx);
	}
	//리뷰 게시판 상품별 리뷰 카운트
	@Override
	public void getReviewCount(Map map) {
		this.revDao.getReviewCount(map);
	}
}
