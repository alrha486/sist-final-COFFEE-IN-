package com.example.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.cartDetailVO;

@Repository("CartDao")
public class CartDAOImpl implements CartDAO{
	@Autowired
	SqlSession sqlSession;

	@Override
	public void selectAll(Map map) {
		this.sqlSession.selectList("Cart.select_cartDetail",map);
		
	}

	@Override
	public void deleteCart(int idx) {
		this.sqlSession.delete("Cart.delete_cartDetail",idx);
	}

	@Override
	public void selectCartOne(Map map) {
		this.sqlSession.selectOne("Cart.select_cartDetailOne",map);
	}

	@Override
	public void addCart(String userid) { // cartBasic insert
		this.sqlSession.insert("Cart.insertCartBasic",userid);
	}

	@Override
	public void selectCartid(Map map) { // cartid 추출 
		this.sqlSession.selectOne("Cart.select_cartId",map);
	}

	@Override
	public void addCartDetail(Map map) { // cartDetail insert
		this.sqlSession.insert("Cart.insertCartDetail",map);
	}

	@Override
	public void selectCartDetailOne(Map map) {
		this.sqlSession.selectOne("Cart.selectCartDetailOne",map);	
	}

	@Override
	public void updateCartDetail(cartDetailVO cart) {
		this.sqlSession.update("Cart.updateCartDetail",cart);
	}

}

