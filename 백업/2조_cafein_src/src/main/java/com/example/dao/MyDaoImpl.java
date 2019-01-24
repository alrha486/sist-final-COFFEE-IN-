package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.MyVO;


@Repository("myDao")
public class MyDaoImpl implements MyDao {
	@Autowired
	SqlSession sqlSession;
	

	@Override
	public void read(Map map) {		// Mypage 회원정보
		this.sqlSession.selectList("myreturn", map);
	}


	@Override
	public void update(MyVO my) { // Mypage - > update 수정하기
		this.sqlSession.update("My.myupdate", my);
	}


	@Override
	public void deleteinfo(Map map) {
		this.sqlSession.delete("My.mydelete", map);
	}

/*	class MyRowMapper implements RowMapper<MyVO>{		//회원정보에서 아이디, 이름, 닉네임, 이메일, 전화번호, 우편번호, 주소 가져옴

		public MyVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MyVO myVo = new MyVO(rs.getString("userid"),
					rs.getString("username"), rs.getString("usernickname"),
					rs.getString("email"), rs.getString("tel"), rs.getString("zipcode"), 
					rs.getString("address1"), rs.getString("address2"));
			return myVo;
		}
	}
	@Override
	public List<MyVO> info_read() {		//주문내역
		String sql = "SELECT orderID, selldate, productID, payid, o_state, delivery, totalprice, price FROM Member ORDER BY userid DESC";
		return this.jdbcTemplate.query(sql, new MyRowMapper());
	}

	@Override
	public int update(MyVO myVo) {		//회원정보수정		수정할때 비밀번호, 이메일, 전화번호 수정가능
		String sql = "UPDATE Member SET passwd = ?, email = ?, tel = ? " +
	                      "WHERE userid = ?";
		return this.jdbcTemplate.update(sql, myVo.getPasswd(),
				myVo.getEmail(), myVo.getTel());
	}
	@Override
	public int updateDelivery(MyVO myVo) {		//배송지수정
		String sql = "UPDATE Member SET zipcode = ?, address1 = ?, address2 = ? " +
	                      "WHERE userid = ?";
		return this.jdbcTemplate.update(sql, myVo.getPasswd(),
				myVo.getZipcode(), myVo.getAddress1(), myVo.getAddress2());
	}

	@Override
	public int delete(String userid) {		//회원탈퇴
		String sql = "DELETE FROM Member WHERE userid = ?";
		return this.jdbcTemplate.update(sql, userid);
	}*/
}




