package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.MemberDAO;
import com.example.vo.MemberVO;

@Service("memberService")
public class MemberServiceImple implements MemberService{
	@Autowired
	MemberDAO memberDao;
	
	@Override
	public void checkID(Map map) {
		this.memberDao.checkID(map);
	}

	@Override
	public void checkNickname(Map map) {
		this.memberDao.checkNickname(map);
		
	}

	@Override
	public void insertMember(MemberVO member) {
		this.memberDao.insertMember(member);
		
	}

	@Override
	public void insertKakao(MemberVO member) {
		this.memberDao.insertKakao(member);		
	}

	@Override
	public void loginMember(Map map) {
		this.memberDao.loginMember(map);
	}

	@Override
	public void insertNewMemberCoupon(String userid) {
		this.memberDao.insertNewMemberCoupon(userid);
	}

	@Override
	public void userInfoSelect(Map map) {
		this.memberDao.userInfoSelect(map);
	}

	@Override
	public void updateMember(MemberVO member) {
		this.memberDao.updateMember(member);
	}

	@Override
	public void deleteMember(String userid) {
		this.memberDao.deleteMember(userid);
	}

	@Override
	public void selectUserInfo(Map map) {
		this.memberDao.selectUserInfo(map);
	}

	@Override
	public void updateUserInfo(Map map) {
		this.memberDao.updateUserInfo(map);
	}

	@Override
	public void selectUserInfo1(Map map) {
		this.memberDao.selectUserInfo1(map);
	}

	
	@Override
	public void memberSelectAjax(Map map) {
		this.memberDao.memberSelectAjax(map);
	}
	
	@Override
	public void getPageCount(Map map) {
		this.memberDao.getPageCount(map);
	}

	@Override
	public void selectAllMember_tp(Map map) {
		this.memberDao.selectAllMember_tp(map);
	}

	
	@Override
	public void selectAllMember_reg(Map map) {
		this.memberDao.selectAllMember_reg(map);
	}

	@Override
	public void selectAllMember(Map map) {
		this.memberDao.selectAllMember(map);
	}

	@Override
	public void UserSelectAll(Map map) {
		this.memberDao.UserSelectAll(map);	
	}
	
	
}
