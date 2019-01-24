package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CouponVO;
import com.example.vo.userCouponVO;

@Repository("couponDao")
public class CouponDAOImpl implements CouponDAO{
	@Autowired
	SqlSession sqlSession;

	@Override
	public void selectUserCoupon(Map map) {
		this.sqlSession.selectList("Coupon.select_userCoupon",map);
	}

	@Override
	public void updateUserCoupon(Map map) {
		this.sqlSession.update("Coupon.updateUserCoupon",map);
	}

	@Override
	public void selectMySaving(Map map) {
		this.sqlSession.selectList("Coupon.selectMySaving",map);
	}

	@Override
	public void updateUserSaving(Map map) {
		this.sqlSession.update("Coupon.updateUserSaving",map);
	}

	@Override
	public void insertBasicSaving(Map map) {
		this.sqlSession.insert("Coupon.insertBasicSaving",map);
	}

	@Override
	public void afterPurchaseUpdate(Map map) {
		this.sqlSession.update("Coupon.afterPurchaseUpdate",map);
	}

	@Override
	public void selectCouponOne(Map map) {
		this.sqlSession.selectList("Coupon.selectCouponOne", map);
	}
////////////////////////////////////////////////////
	//관리자 쿠폰 발급 페이지 회원 전체 리스트
		@Override
		public void select_memberListAll(Map map) {
			this.sqlSession.selectList("Member.select_memberListAll",map);
		}
		//관리자 쿠폰 페이지 쿠폰 전체 리스트
		@Override
		public void select_couponListAll(Map map) {
			this.sqlSession.selectList("Coupon.select_couponListAll",map);
		}
		//관리자 페이지 쿠폰 발급
		@Override
		public void issueCoupon(userCouponVO userCouponVo) {
			this.sqlSession.insert("Coupon.issueCoupon", userCouponVo);
		}
		//관리자 페이지 쿠폰 등록
		@Override
		public void insertCoupon(CouponVO couponVo) {
			this.sqlSession.insert("Coupon.insertCoupon", couponVo);
		}
		//관리자 페이지 쿠폰 삭제
		@Override
		public void deleteCoupon(int couponnum) {
			this.sqlSession.delete("Coupon.deleteCoupon", couponnum);
		}
		//관리자 쿠폰 수정 페이지 쿠폰 정보 불러오기
		@Override
		public void infoCoupon(Map map) {
			this.sqlSession.selectOne("Coupon.infoCoupon", map);
		}
		//관리자 페이지 쿠폰 수정
		@Override
		public void modifyCoupon(CouponVO couponVo) {
			this.sqlSession.update("Coupon.modifyCoupon", couponVo);
		}
		//관리자 쿠폰 페이지 쿠폰 카운트
		@Override
		public void getCouponCount(Map map) {
			this.sqlSession.selectOne("Coupon.selectCouponCountSP", map);
		}
		//관리자 쿠폰 발급 페이지 회원 조건 검색
		@Override
		public void memberSelectAjax(Map map) {
			this.sqlSession.selectList("Member.memberSelectAjax", map);
		}

}

