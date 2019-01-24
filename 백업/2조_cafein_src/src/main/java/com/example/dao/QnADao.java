package com.example.dao;

import java.util.Map;

import com.example.vo.QnAVO;

public interface QnADao {
	void create(QnAVO qna);
	void read(Map map);
	void readAll(Map map);
	void update(QnAVO qna);
	void delete(int qna_idx);
	void answer(QnAVO qna);
	void updateCount(int qna_idx);
	void getPageCount(Map map);
}
