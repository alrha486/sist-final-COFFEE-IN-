package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.RevVO;

@Repository("revDao")
public class RevDAOImpl implements RevDAO {

	@Autowired
	SqlSession sqlSession;
	
	//리뷰 게시판 상품평 등록
	@Override
	public void create(RevVO revVo) {
		this.sqlSession.insert("Review.revInsert", revVo);
	}
	//리뷰 게시판 전체 목록
	@Override
	public void read(Map map) {
		this.sqlSession.selectList("Review.revSelect", map);
	}
	//리뷰 게시판 리뷰 정보 불러오기
	@Override
	public void readOne(Map map) {
		this.sqlSession.selectOne("Review.revSelectOne", map);
	}
	//리뷰 게시판 리뷰 수정
	@Override
	public void update(RevVO revVo) {
		this.sqlSession.update("Review.revUpdate", revVo);
	}
	//리뷰 게시판 리뷰 삭제
	@Override
	public void delete(int rev_idx) {
		this.sqlSession.delete("Review.revDelete", rev_idx);
	}
	//리뷰 게시판 상품별 리뷰 카운트
	@Override
	public void getReviewCount(Map map) {
		this.sqlSession.selectOne("Review.selectReviewCountSP", map);
	}
}
