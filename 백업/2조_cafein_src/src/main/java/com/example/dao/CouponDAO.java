package com.example.dao;

import java.util.Map;

import com.example.vo.CouponVO;
import com.example.vo.userCouponVO;

public interface CouponDAO {
	void selectUserCoupon(Map map);
	void updateUserCoupon(Map map);
	void selectMySaving(Map map);
	void updateUserSaving(Map map);
	void insertBasicSaving(Map map);
	void afterPurchaseUpdate(Map map);
	void selectCouponOne(Map map);
///////////////////////////////////////////////
	//관리자 쿠폰 발급 페이지 회원 전체 검색 
	void select_memberListAll(Map map);
	//관리자 쿠폰 페이지 쿠폰 전체 검색
	void select_couponListAll(Map map);
	//관리자 쿠폰 페이지 쿠폰 발급
	void issueCoupon(userCouponVO userCouponVo);
	//관리자 쿠폰 페이지 쿠폰 등록
	void insertCoupon(CouponVO couponVo);
	//관리자 쿠폰 페이지 쿠폰 삭제
	void deleteCoupon(int couponnum);
	//관리자 쿠폰 수정페이지 쿠폰 정보 불러오기
	void infoCoupon(Map map);
	//관리자 쿠폰 페이지 쿠폰 수정
	void modifyCoupon(CouponVO couponVo);
	//관리자 쿠폰 페이지 쿠폰 카운트
	void getCouponCount(Map map);
	//관리자 쿠폰 발급 페이지 회원 조건 검색
	void memberSelectAjax(Map map);
}
