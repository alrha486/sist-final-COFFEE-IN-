package com.example.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.WebSocketSession;

import com.example.service.MemberService;
import com.example.service.MessageService;
import com.example.util.EchoHandler;
import com.example.vo.MemberVO;
import com.example.vo.MessageVO;

@Controller
public class MessageController {
	private static final WebSocketSession WebSocketSession = null;
	@Autowired
	MessageService messageService;
	@Autowired
	MemberService memberService;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private EchoHandler echo;
	
	HttpSession session2;

	@RequestMapping(value = "/chatSearch", method = RequestMethod.GET)
	@ResponseBody
	public Map chatSearch(HttpSession session) { // 메시지 전체조회(일반회원)
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");
		map.put("m_receiver",userid); // 수신자id
		messageService.selectMessageAll(map);
		
		List<MessageVO> list = (List<MessageVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data; // 메시지 정보가 들어있는 list return 
	}
	
	
	@RequestMapping(value = "/chattingRoom/{m_sender}", method = RequestMethod.GET)
	@ResponseBody
	public Map chatSearch1(HttpSession session,@PathVariable String m_sender) { // 메시지 전체조회
		Map<String,Object> map = new HashMap<String,Object>();
		//String userid = (String)session.getAttribute("userid");
		map.put("m_sender",m_sender); // 발신자id
		messageService.selectMessageAllAdmin(map);
		List<MessageVO> list = (List<MessageVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		return data; // 메시지 정보가 들어있는 list return 
	}
	
	@RequestMapping(value = "/chatRoom1/{m_sender}", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView chatSearchAdmin(HttpSession session,@PathVariable String m_sender) { // 관리자 메시지 페이지로 이동
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chatRoom1");
		mav.addObject("m_sender",m_sender);
		return mav;  
	}
	
	
	
	
	@RequestMapping(value = "/receiverList", method = RequestMethod.GET)
	@ResponseBody
	public Map receiverList(HttpSession session) throws Exception { // 관리자 입장에서 누구누구한테 메시지가 왔는지
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");
		map.put("m_receiver",userid); // 발신자id
		messageService.selectReceiverList(map);
		
		List<MessageVO> list = (List<MessageVO>)map.get("results");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", list);
		/////////////////////////웹소켓////////////////////////////////////

		return data; // 메시지 정보가 들어있는 list return 
	}
	
	
	@RequestMapping(value = "/insertUserMessage", method = RequestMethod.POST)
	@ResponseBody
	public void insertUserMessage(@RequestBody MessageVO message,HttpSession session) { // 유저가 보낸 메시지 DB에 insert
		String m_sender = (String)session.getAttribute("userid");
		message.setM_sender(m_sender);
		this.messageService.insertUserMessage(message); // message 변수에는 m_sender와 m_contents가 담겨있음 	
	}
	
	
	
	
	@RequestMapping(value = "/insertAdminMessage", method = RequestMethod.POST)
	@ResponseBody
	public void insertAdminMessage(@RequestBody MessageVO message,HttpSession session) { // 관리자가 보낸 메시지 DB에 insert
		String m_sender = (String)session.getAttribute("userid");
		message.setM_sender(m_sender);
		this.messageService.insertAdminMessage(message); // 

	}
	
	
	@RequestMapping(value = "/AuToinsertAdminMessage", method = RequestMethod.POST)
	@ResponseBody
	public void AuToinsertAdminMessage(@RequestBody MessageVO message,HttpSession session) { // 유저가 보낸 메시지 DB에 insert
		//Map<String, Object> result = new HashMap<String, Object>();
		String m_receiver = (String)session.getAttribute("userid");
		message.setM_receiver(m_receiver);
		this.messageService.AuToinsertAdminMessage(message); // message 변수에는 m_sender와 m_contents가 담겨있음 

	}
	
	
	@RequestMapping(value = "/MessageEaSearch", method = RequestMethod.GET)
	@ResponseBody
	public int MessageEaSearch(HttpSession session) { // 메시지 전체조회
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");
		map.put("m_receiver", userid); // 수신자d
		messageService.selectUserUnReadMessage(map); // 안읽은 메시지 개수 
		List<MessageVO> list = (List<MessageVO>)map.get("results");
		
		return list.size(); // 메시지 정보가 들어있는 list return 
	}
	
	@RequestMapping(value = "/MessageReadUpdate", method = RequestMethod.PUT)
	@ResponseBody
	public void MessageReadUpdate(HttpSession session) { // 메시지 전체조회
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");
		map.put("m_receiver", userid); // 수신자d
		messageService.MessageReadUpdate(map); // 안읽은 메시지 개수 
	}
	
	@RequestMapping(value = "/MessageReadUpdateAdmin/{m_sender}", method = RequestMethod.PUT)
	@ResponseBody
	public void MessageReadUpdateAdmin(HttpSession session,@PathVariable String m_sender) { // 메시지 전체조회
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");
		map.put("m_sender", m_sender); // 발신자(회원)
		map.put("m_receiver", userid); //  수신자(관리자)
		messageService.MessageReadUpdateAdmin(map); // 안읽은 메시지 개수 
	}
	
	@RequestMapping(value = "/sendNewPasswordMessage", method = RequestMethod.GET)
	@ResponseBody
	public int sendNewPasswordMessage(HttpSession session,MemberVO member) {
		int result = -1;
		String randomPW = getRandomPassword();
		String setfrom = "alrha486@gmail.com";         
	    String tomail  = member.getEmail(); // 구매자의 이메일 
	    String title   = "<Coffee-In>비밀번호 찾기";      
	    String content = member.getUsername()  + " 님! 새로운 비밀번호를 보내드립니다. 로그인 후 마이페이지에서 변경하시길 권장드립니다. 새로운 비밀번호 >>  " + randomPW ;
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom); 
	      messageHelper.setTo(tomail);     
	      messageHelper.setSubject(title); 
	      messageHelper.setText(content);  
	     
	      mailSender.send(message);
	      
	      //이제 여기에 유저 PW 업데이트해주기
	      String userid = member.getUserid();
	      Map<String,Object> map = new HashMap<String,Object>();
	      map.put("userid", userid);
	      map.put("passwd", randomPW);
	      memberService.updateUserInfo(map);
	      
	      result = 1;
	    } catch(Exception e){
	      System.out.println(e);
	    }	
	    
	    return result;
	}
	
	
	
	@RequestMapping(value = "/selectMreadCount/{m_sender}", method = RequestMethod.GET)
	@ResponseBody
	public int selectMreadCount(@PathVariable String m_sender) { // 메시지 전체조회
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("m_sender", m_sender);
		//System.out.println(m_sender);
		messageService.selectMreadCount(map); // 안읽은 메시지 개수 
		List<MessageVO> list = (List<MessageVO>)map.get("results");

		//System.out.println(list.size());
		return list.get(0).getM_read(); // 메시지 정보가 들어있는 list return 
	}
	
	
	
	public String getRandomPassword(){ // 새로운 비밀번호 생성하는 메시지(난수)
        char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};

        StringBuffer sb = new StringBuffer();
        Random rn = new Random();
        for( int i = 0 ; i < 9 ; i++ ){
            sb.append( charaters[ rn.nextInt( charaters.length ) ] );
        }
        return sb.toString();
    }
	
	

}

