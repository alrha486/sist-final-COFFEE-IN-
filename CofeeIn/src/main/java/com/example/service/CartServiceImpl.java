package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CartDAO;
import com.example.vo.cartDetailVO;

@Service("cartService")
public class CartServiceImpl implements CartService{
	@Autowired
	CartDAO cartDao;
	
	@Override
	public void selectAll(Map map) {
		this.cartDao.selectAll(map);
	}

	@Override
	public void deleteCart(int idx) {
		this.cartDao.deleteCart(idx);
	}

	@Override
	public void selectCartOne(Map map) {
		this.cartDao.selectCartOne(map);
		
	}

	@Override
	public void addCart(String userid) {
		this.cartDao.addCart(userid);		
	}

	@Override
	public void selectCartid(Map map) {
		this.cartDao.selectCartid(map);
	}

	@Override
	public void addCartDetail(Map map) {
		this.cartDao.addCartDetail(map);
	}

	@Override
	public void selectCartDetailOne(Map map) {
		this.cartDao.selectCartDetailOne(map);
	}

	@Override
	public void updateCartDetail(cartDetailVO cart) {
		this.cartDao.updateCartDetail(cart);
	}

}
