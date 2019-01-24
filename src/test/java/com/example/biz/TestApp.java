package com.example.biz;

import static org.junit.Assert.assertNotNull;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class TestApp {
	private SqlSession sqlSession;
	
	
	@Test
	public void test() {
		ApplicationContext ctx = new FileSystemXmlApplicationContext("/src/main/webapp/WEB-INF/spring/applicationContext.xml");
		this.sqlSession = ctx.getBean("sqlSession",SqlSession.class);
		assertNotNull(this.sqlSession);
	}

}
