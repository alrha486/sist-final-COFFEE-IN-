package com.example.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.vo.MessageVO;


public class EchoHandler extends TextWebSocketHandler{



    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

    
    /**클라이언트 연결 이후에 실행되는 메소드 */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	Map<String,Object> map = session.getAttributes();
    	String userid = (String)map.get("userid");
    	sessionList.add(session);
    	
    	
    }
    

    /** 클라이언트가 웹소켓서버로 메시지를 전송했을 때 실행되는 메소드   **/
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	Map<String,Object> map = session.getAttributes();
    	String userid = (String)map.get("userid");
        for(WebSocketSession sess : sessionList){ // 모든 사용자에게
        	
            sess.sendMessage(new TextMessage(message.getPayload()+ "&" + userid ));
            
        }
    }

    /** 클라이언트가 연결을 끊었을 때 실행되는 메소드 */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
       sessionList.remove(session);
    }
    
    public void sending(String userid, String text) throws IOException{
    		TextMessage message =null;
    		for(WebSocketSession sess : sessionList){ // 모든 사용자에게
        	
            sess.sendMessage(new TextMessage(text+ "&" + userid ));
            
        }
    }
    
    public Map sending1() throws Exception {    	
    	
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", sessionList);
		return data;
    }
}
