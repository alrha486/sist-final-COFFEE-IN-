package com.example.dao;

import java.util.Map;

import com.example.vo.ProductVO;

public interface ProductDAO {
	void selectAll(Map map);
	void selectProductOne(Map map);
	///////////////////////////////////////
	void readAny(Map map);
	void readNew(Map map);
	void SearchManyPopularityProduct(Map map);
	void SearchRecentlyProduct(Map map);
	void selectProductGrape1(Map map);
	void selectProductGrape2(Map map);
	//////////////////////////////////////////
	//상품 소분류 목록
	void selectOneKind(Map map);
	//상품 대분류 목록
	void selectOneKinds(Map map);
	//상품 정보 불러오기
	void selectProduct(Map map);
	//상품 전체 목록
	void select_productListAll(Map map);
	
	//상품 전체 카운트
	void getTotalCount(Map map);
	//상품 대분류 카운트
	void getTypeCount(Map map);
	//상품 소분류 카운트
	void getKindCount(Map map);
	
	
	
	//관리자 페이지 상품 등록
	void insertProduct(ProductVO productVo);
	//관리자 페이지 상품 삭제
	void deleteProduct(int productid);
	//관리자 상품 수정 페이지 상품 정보 불러오기
	void infoProduct(Map map);
	//관리자 상품 수정 페이지 상품 수정
	void modifyProduct(ProductVO productVo);
	//관리자 페이지 상품 조건 검색
	void productSelectAjax(Map map);
	//관리자 상품 조건 검색 카운트
	void getSearchCount(Map map);
	
	
	void selectToday(Map map);
	
	void nameAll(Map map);
}
