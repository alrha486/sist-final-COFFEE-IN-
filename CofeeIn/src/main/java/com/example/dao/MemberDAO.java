package com.example.dao;

import java.util.Map;

import com.example.vo.MemberVO;

public interface MemberDAO {
	void checkID(Map map);
	void checkNickname(Map map);
	void insertMember(MemberVO member);
	void insertKakao(MemberVO member);
	void loginMember(Map map);
	void insertNewMemberCoupon(String userid);
	void userInfoSelect(Map map);
	void updateMember(MemberVO member);
	void selectUserInfo(Map map);
	void updateUserInfo(Map map);
	void selectUserInfo1(Map map);
	
	
	void deleteMember(String userid);
    void memberSelectAjax(Map map);
	void getPageCount(Map map);
	void selectAllMember(Map map);
	void selectAllMember_tp(Map map);
	void selectAllMember_reg(Map map);
	
	void UserSelectAll(Map map);
	
	void selectChatUserList(Map map);
}
