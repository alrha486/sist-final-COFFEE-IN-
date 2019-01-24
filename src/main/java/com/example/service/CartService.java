package com.example.service;

import java.util.Map;

import com.example.vo.cartDetailVO;

public interface CartService {
	void selectAll(Map map); // 카트 목록 전체 조회
	void deleteCart(int idx);
	void selectCartOne(Map map);
	void addCart(String userid);
	void selectCartid(Map map);
	void addCartDetail(Map map);
	void selectCartDetailOne(Map map);
	void updateCartDetail(cartDetailVO cart);
}
