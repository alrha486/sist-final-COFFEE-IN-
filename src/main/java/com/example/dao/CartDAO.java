package com.example.dao;

import java.util.Map;

import com.example.vo.cartDetailVO;

public interface CartDAO {
	void selectAll(Map map);
	void deleteCart(int idx);
	void selectCartOne(Map map);
	void addCart(String userid);
	void selectCartid(Map map);
	void addCartDetail(Map map);
	void selectCartDetailOne(Map map);
	void updateCartDetail(cartDetailVO cart);
}
