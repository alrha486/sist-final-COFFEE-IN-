package com.example.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.QnAVO;

@Repository("qnaDao")
public class QnADaoImpl implements QnADao{
	@Autowired
	SqlSession sqlSession;

	@Override
	public void create(QnAVO qna) {
		this.sqlSession.insert("QnA.insert", qna);
	}

	@Override
	public void read(Map map) {
		this.sqlSession.selectOne("QnA.selectOne", map);
	}

	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("QnA.selectAll", map);
	}

	@Override
	public void update(QnAVO qna) {
		this.sqlSession.update("QnA.update", qna);
	}

	@Override
	public void delete(int qna_idx) {
		this.sqlSession.delete("QnA.delete", qna_idx);
	}

	@Override
	public void answer(QnAVO qna) {
		this.answer_update(qna.getGrp(), qna.getStep());
		this.sqlSession.insert("QnA.replyInsert", qna);
	}
	
	public void answer_update(int grp, int step) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("grp", grp);
		map.put("step", step);
		this.sqlSession.update("QnA.replyUpdate", map);
	}

	@Override
	public void updateCount(int qna_idx) {
		this.sqlSession.update("QnA.updateCount", qna_idx);
	}

	@Override
	public void getPageCount(Map map) {
		this.sqlSession.selectOne("QnA.selectPageCount", map);
	}

	

}
