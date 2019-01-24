package com.example.service;

import java.util.Map;

import com.example.vo.QnAVO;

public interface QnAService {
	void insertQnA(QnAVO qna);
	void selectQnA(Map map);
	void select(Map map);
	void updateQnA(QnAVO qna);
	void deleteQnA(int qna_idx);
	void answerQnA(QnAVO qna);
	void updateCount(int qna_idx);
	void getPageCount(Map map);
}
