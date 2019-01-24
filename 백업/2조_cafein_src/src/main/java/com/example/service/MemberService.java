package com.example.service;

import java.util.Map;

import com.example.vo.MemberVO;

public interface MemberService {
	void checkID(Map map); // ID중복체크
	void checkNickname(Map map);  // 닉네임 중복체크
	void insertMember(MemberVO member); // 일반회원가입
	void insertKakao(MemberVO member);
	void loginMember(Map map);
	void insertNewMemberCoupon(String userid);
	void userInfoSelect(Map map);
	void updateMember(MemberVO member);
	void selectUserInfo(Map map);
	void updateUserInfo(Map map);
	void selectUserInfo1(Map map);
	
	
	void memberSelectAjax(Map map);
	void getPageCount(Map map);
	void selectAllMember(Map map);
	void selectAllMember_tp(Map map);
	void selectAllMember_reg(Map map);
	void deleteMember(String userid);
	void UserSelectAll(Map map);
}
