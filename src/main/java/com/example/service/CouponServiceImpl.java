package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CouponDAO;
import com.example.vo.CouponVO;
import com.example.vo.userCouponVO;

@Service("couponService")
public class CouponServiceImpl implements CouponService{
	@Autowired
	CouponDAO couponDao;

	@Override
	public void selectUserCoupon(Map map) { 
		this.couponDao.selectUserCoupon(map);
	}

	@Override
	public void updateUserCoupon(Map map) {
		this.couponDao.updateUserCoupon(map);
	}

	@Override
	public void selectMySaving(Map map) {
		this.couponDao.selectMySaving(map);
	}

	@Override
	public void updateUserSaving(Map map) {
		this.couponDao.updateUserSaving(map);
	}

	@Override
	public void insertBasicSaving(Map map) {
		this.couponDao.insertBasicSaving(map);
	}

	@Override
	public void afterPurchaseUpdate(Map map) {
		this.couponDao.afterPurchaseUpdate(map);
	}

	@Override
	public void selectCouponOne(Map map) {
		this.couponDao.selectCouponOne(map);
	}
///////////////////////////////////////////////////////////
	//관리자 쿠폰 페이지 회원 전체 목록
		@Override
		public void select_memberListAll(Map map) {
			couponDao.select_memberListAll(map);
		}
		//관리자 쿠폰 페이지 쿠폰 전체 목록
		@Override
		public void select_couponListAll(Map map) {
			couponDao.select_couponListAll(map);
		}
		//관리자 쿠폰 발급 페이지 쿠폰 발급
		@Override
		public void issueCoupon(userCouponVO userCouponVo) {
			this.couponDao.issueCoupon(userCouponVo);
		}
		//관리자 쿠폰 페이지 쿠폰 등록
		@Override
		public void insertCoupon(CouponVO couponVo) {
			this.couponDao.insertCoupon(couponVo);
		}
		//관리자 쿠폰 페이지 쿠폰 삭제
		@Override
		public void deleteCoupon(int couponnum) {
			this.couponDao.deleteCoupon(couponnum);
		}
		//관리자 쿠폰 수정 페이지 쿠폰 정보 불러오기
		@Override
		public void infoCoupon(Map map) {
			this.couponDao.infoCoupon(map);
		}
		//관리자 쿠폰 수정 페이지 쿠폰 수정
		@Override
		public void modifyCoupon(CouponVO couponVo) {
			this.couponDao.modifyCoupon(couponVo);
		}
		//관리자 쿠폰 페이지 쿠폰 전체 카운트
		@Override
		public void getCouponCount(Map map) {
			this.couponDao.getCouponCount(map);
		}
		//관리자 쿠폰 발급 페이지 회원 조건 검색
		@Override
		public void memberSelectAjax(Map map) {
			this.couponDao.memberSelectAjax(map);
		}
}
