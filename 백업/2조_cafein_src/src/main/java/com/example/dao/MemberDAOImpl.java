package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.MemberVO;

@Repository("memberDao")
public class MemberDAOImpl implements MemberDAO{
	@Autowired
	SqlSession sqlSession;
		
	@Override
	public void checkID(Map map) { // ID 중복체크
		this.sqlSession.selectOne("Member.checkid",map);
				
	}

	@Override
	public void checkNickname(Map map) {
		this.sqlSession.selectOne("Member.checkNick",map);
		
	}

	@Override
	public void insertMember(MemberVO member) {
		this.sqlSession.insert("Member.insertMember",member);
		
	}

	@Override
	public void insertKakao(MemberVO member) {
		this.sqlSession.insert("Member.insertKakao",member);
		
	}

	@Override
	public void loginMember(Map map) {
		this.sqlSession.selectOne("Member.loginMember", map);
	}

	@Override
	public void insertNewMemberCoupon(String userid) {
		this.sqlSession.insert("Member.insertNewMemberCoupon",userid);
	}

	@Override
	public void userInfoSelect(Map map) {
		this.sqlSession.selectOne("Member.userInfoSelect",map);
	}

	@Override
	public void updateMember(MemberVO member) {
		this.sqlSession.update("Member.member_update",member);
	}


	@Override
	public void selectUserInfo(Map map) {
		this.sqlSession.selectOne("Member.selectUserInfo", map);
	}

	@Override
	public void updateUserInfo(Map map) {
		this.sqlSession.update("Member.updateUserInfo",map);
	}

	@Override
	public void selectUserInfo1(Map map) {
		this.sqlSession.selectOne("Member.selectUserInfo1",map);
	}
	
	@Override
	public void deleteMember(String userid) {
		this.sqlSession.delete("Member.member_delete",userid);
	}

	@Override
	public void selectAllMember(Map map) {
		this.sqlSession.selectList("Member.selectAllMember", map);
	}

	@Override
	public void selectAllMember_tp(Map map) {
		this.sqlSession.selectList("Member.selectAllMember_tp", map);
	}

	@Override
	public void selectAllMember_reg(Map map) {
		this.sqlSession.selectList("Member.selectAllMember_reg", map);
	}

	@Override
	public void memberSelectAjax(Map map) {
		this.sqlSession.selectList("Member.memberSelectAjax",map);
	}



	@Override
	public void getPageCount(Map map) {
		this.sqlSession.selectList("Member.memberPageCount", map);
	}

	@Override
	public void UserSelectAll(Map map) {
		this.sqlSession.selectList("Member.UserSelectAll",map);
	}
	
}

