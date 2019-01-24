package com.example.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class SessionListener implements HttpSessionListener{
	@Autowired
	SqlSession sqlSession;

	public SessionListener() {
		
	}
	
	int todayCount =0;
	
	@Override
	public void sessionCreated(HttpSessionEvent se) { // 세션이 생성되었을 때
		if(this.todayCount == 0) { // 첫 방문자면 insert
			//this.sqlSession.insert("Member.insertSession");
			this.todayCount++;
		}else { // 두번쨰 방문자부터는 update
			//this.sqlSession.update("Member.updateSession",todayCount);
			this.todayCount++;
		}
	}

	 
	 
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
	}

}
