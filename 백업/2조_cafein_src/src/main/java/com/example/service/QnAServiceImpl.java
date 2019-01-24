package com.example.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.QnADao;
import com.example.vo.QnAVO;

@Service("qnaService")
public class QnAServiceImpl implements QnAService{
	@Autowired
	QnADao qnaDao;
	
	@Override
	public void insertQnA(QnAVO qna) {
		this.qnaDao.create(qna);
	}

	@Override
	public void selectQnA(Map map) {
		this.qnaDao.read(map);
	}

	@Override
	public void select(Map map) {
		this.qnaDao.readAll(map);
	}

	@Override
	public void updateQnA(QnAVO qna) {
		this.qnaDao.update(qna);
	}

	@Override
	public void deleteQnA(int qna_idx) {
		this.qnaDao.delete(qna_idx);
		
	}

	@Override
	public void answerQnA(QnAVO qna) {
		this.qnaDao.answer(qna);
	}

	@Override
	public void updateCount(int qna_idx) {
		this.qnaDao.updateCount(qna_idx);
	}

	@Override
	public void getPageCount(Map map) {
		this.qnaDao.getPageCount(map);
	}

	

	

}
