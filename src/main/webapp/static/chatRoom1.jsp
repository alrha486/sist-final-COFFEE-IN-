<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="message_sender" value="${m_sender}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오톡 채팅방 구현</title>
<style>
.jstalktheme
{
	background-color: #9bbad8;
	padding: 4px 4px 0px 4px;
}

.jstalktheme .clear
{
	clear: both;
}

.jstalktheme .blank
{
	clear: both;
	height: 4px;
}

.jstalktheme .msg
{
	height: calc(100% - 72px);
	overflow-y: scroll;
	
	font-size: 12px;
}

.jstalktheme .msg .time
{
	font-size: 10px;
}

.jstalktheme .msg .mytalk
{
	float: right;
	width: 100%;
}

.jstalktheme .msg .mytalk .time
{
	float: right;
	bottom: 0;
}

.jstalktheme .msg .mytalk .a
{
	float: right;
	position: relative;
	min-height: 24px;
	max-width: calc(100% - 64px);
	left: 2px;
	background-color: #ffec42;
	border-radius: 3px;
	z-index: 2;
	padding: 0px 4px 0px 4px;
	word-break: break-all;
}

.jstalktheme .msg .mytalk .b
{
	float: right;
	position: relative;
	width: 8px;
	height: 22px;
	background: url(static/img/chat_balloon_yellow.right.png) no-repeat;
	z-index: 1;
}

.jstalktheme .msg .othertalk
{
	float: left;
	width: 100%;
}

.jstalktheme .msg .othertalk .profile_image
{
	float: left;
	width: 40px;
	height: 40px;
	border-radius: 14px; 
}

.jstalktheme .msg .othertalk .box
{
	float: left;
	width: calc(100% - 48px);
}

.jstalktheme .msg .othertalk .box .profile_name
{
	font-size: 12px;
}

.jstalktheme .msg .othertalk .box .a
{
	float: left;
	position: relative;
	width: 8px;
	height: 22px;
	background: url(static/img/chat_balloon_white.left.png) no-repeat;
	z-index: 1;
}

.jstalktheme .msg .othertalk .box .b
{
	float: left;
	position: relative;
	min-height: 24px;
	max-width: calc(100% - 64px);
	left: -2px;
	background-color: #ffffff;
	border-radius: 3px;
	z-index: 2;
	padding: 0px 4px 0px 4px;
	word-break: break-all;
}

.jstalktheme .msg .othertalk .box .time
{
	float: left;
}

.jstalktheme .sendmsg
{
	
}

.jstalktheme .sendmsg .textarea
{
	float: left;
	width: calc(100% - 68px);
	height: 64px;
	border-radius: 8px 0px 0px 8px;
	margin: 0px 0px 0px 0px;
	padding: 2px 2px 2px 2px;
	resize: none;
}

.jstalktheme .sendmsg .button
{
	float: right;
	width: 62px;
	height: 68px;
	background-color: #ffec42;
	border-radius: 0px 8px 8px 0px;
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	text-align: center;
	display: table;
	cursor: pointer;
}

.jstalktheme .sendmsg .button p
{
  display: table-cell;
  vertical-align: middle;
}
</style>
<!-- -----------------------------------------------------script 시작------------------------------------------- -->
<script type="text/javascript" src="<c:url value="static/js/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="static/js/sockjs-0.3.4.js"/>"></script>
<script type="text/javascript">

$(document).ready(function() {
	var m_sender = '${message_sender}';
	
	
//	$.ajax  채팅룸 입장하면 메시지 읽음(m_read 을 1에서 0) 으로 업데이트 ajax작성 
	 $.ajax({ // 채팅방 입장 시 m_read(읽음여부) 1에서 0으로 업데이트
			url : "/coffee/MessageReadUpdateAdmin/" + m_sender,
			method : "PUT",
			success : function(data){					
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); // 메시지 m_read(읽음여부) ajax 끝
	
	
	
	
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/chattingRoom/" + m_sender,
		method : "GET",
		success : function(data){			
			var result = data.data;			
/////////////////////////////////////////////////////////////////////////////////
			for(var i=0; i<result.length; i++){ // 메시지 개수만큼 돌면서 

				var realText = result[i].m_contents; 
				var realUserid = result[i].m_receiver; // 수신자(자기 자신) // alrha486
				var sender = result[i].m_sender;
				var realTime = result[i].m_date; // 보낸 시간 20190115-19:30
				var array = new Array(); 
				array[0] = realTime.substring(7,9); // 시간
				array[1] = realTime.substring(10,12); // 분
			   	var ocontainer = document.getElementById("jstalktheme_test"); //채팅 방 전체 div
				var ocontainer_msg = ocontainer.getElementsByClassName("msg")[0]; // 메시지부분 div
				var onewmsg = document.createElement("div"); // 새로운 div만들기 (왼쪽)
				var onewblank = document.createElement("div"); // 새로운 div만들기 (오른쪽)
				
				
				//var name = result[i].m_sender; // 상대방
				
				var d = new Date(); // 현재시간
				
				var ampm = (array[0]>12 ?  "PM" : "AM");
				var h = (array[0]>12 ? array[0]-12 : array[0]);
				var m = array[1];	
				var time = ampm+" "+h+":"+m; // 현재시간
				
				if(sender != "wlsdnd123") // session검사해서 userid가 관리자면 왼쪽에 말풍선 생성
				{
					onewmsg.className="othertalk"; // 왼쪽 div  생성(관리자임)
					onewmsg.innerHTML = 
						"<div class=\"profile_image\" style=\"background: url(static/img/profile_image.png) no-repeat;width:35px;height;35px\">\n"+
					"</div>\n"+
					"<div class=\"box\">\n"+
					"<div class=\"profile_name\">\n"+
					sender+"\n"+
					"</div>\n"+
					"<div class=\"a\">\n"+
					"</div>\n"+
					"<div class=\"b\">\n"+
					realText+"\n"+
					"</div>\n" +
					"<div class=\"time\">\n"+
					time+"\n"+
					"</div>\n"+
					"</div>\n";
				}else{ // 자기자신 
					onewmsg.className="mytalk";
					onewmsg.innerHTML = 
					"<div class=\"b\">\n"+
					"</div>\n"+
					"<div class=\"a\">\n"+
					realText+"\n"+
					"</div>\n"+
					"<div class=\"time\">\n"+
					time+"\n"+
					"</div>\n" +
					"";
				}
				
				onewmsg.innerHTML +=
			    "<div class=\"clear\">\n"+
			    "</div>";
				
				onewblank.className="blank";
				
				ocontainer_msg.appendChild(onewmsg);
				ocontainer_msg.appendChild(onewblank);
				
				ocontainer_msg.scrollTop = ocontainer_msg.scrollHeight;
} // for문 끝
/////////////////////////////////////////////////////////////////////////////////
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});
});








	var sock; //웸소켓을 지정한 url(EchoHandler)로 연결한다.
	sock = new SockJS("<c:url value="/echo"/>");  
	//    /echo/ =  EchoHandler클래스 호출  >> HechoHandler 생성자로 객체생성

//데이터가 나한테 전달되읐을 때 자동으로 실행되는 function
sock.onmessage = onMessage;

//데이터를 끊고싶을때 실행하는 메소드
sock.onclose = onClose;

/*소켓으로 보내겠다.  */
function sendMessage() {   
	var text = document.getElementById("textarea"); // textarea의 값 
	var text1 = text.value.replace("\n","<br />\n"); // 입력받은 text
	if(text1==""){
		alert("텍스트를 입력해주세요.");
		return false;
	}
    sock.send(text1); // EchoHandler로 입력 text를 보냄
    
    var messageReceiver = '${message_sender}';
 	
    $.ajax({ // 관리자 채팅 DB에 입력하는 ajax 
		url : "/coffee/insertAdminMessage", 
		dataType : "json",
		method : "POST",
		contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({
			"m_receiver" :  messageReceiver,
			"m_contents" : text1
		}),
		success : function(data){
			document.getElementById("textarea").innerHTML = "";
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});
}



//evt 파라미터는 웹소켓을 보내준 데이터다.(자동으로 들어옴)
function onMessage(evt) { // 메시지 받으면 
	 var text = evt.data; // 입력한 text
	    
	    var array = new Array();
		array = text.split('&');
		var realText = array[0];
		var realUserid = array[1]; //alrha486
		
	   	var ocontainer = document.getElementById("jstalktheme_test"); //채팅 방 전체 div
		var ocontainer_msg = ocontainer.getElementsByClassName("msg")[0]; // 메시지부분 div
		
		var onewmsg = document.createElement("div"); // 새로운 div만들기 (왼쪽)
		var onewblank = document.createElement("div"); // 새로운 div만들기 (오른쪽)
		
		var name = '관리자'; // 상대방
		
		var d = new Date(); // 현재시간
		var ampm = (d.getHours()>12 ?  "PM" : "AM");
		var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
		var m = d.getMinutes();	
		var time = ampm+" "+h+":"+m; // 현재시간
		
	
	if(realUserid != "wlsdnd123") // session검사해서 userid가 관리자면 왼쪽에 말풍선 생성
	{
		onewmsg.className="othertalk"; // 왼쪽 div  생성(관리자임)
		onewmsg.innerHTML = 
			"<div class=\"profile_image\" style=\"background: url(static/img/profile_image.png) no-repeat;width:35px;height;35px\">\n"+
		"</div>\n"+
		"<div class=\"box\">\n"+
		"<div class=\"profile_name\">\n"+
		realUserid+"\n"+
		"</div>\n"+
		"<div class=\"a\">\n"+
		"</div>\n"+
		"<div class=\"b\">\n"+
		realText+"\n"+
		"</div>\n" +
		"<div class=\"time\">\n"+
		time+"\n"+
		"</div>\n"+
		"</div>\n";
	}else{ // 자기자신 
		onewmsg.className="mytalk";
		onewmsg.innerHTML = 
		"<div class=\"b\">\n"+
		"</div>\n"+
		"<div class=\"a\">\n"+
		realText+"\n"+
		"</div>\n"+
		"<div class=\"time\">\n"+
		time+"\n"+
		"</div>\n" +
		"";
	}
	
	onewmsg.innerHTML +=
    "<div class=\"clear\">\n"+
    "</div>";
	
	onewblank.className="blank";
	
	ocontainer_msg.appendChild(onewmsg);
	ocontainer_msg.appendChild(onewblank);
	
	ocontainer_msg.scrollTop = ocontainer_msg.scrollHeight;
     
}
function onClose(evt) { // 연결 끊김 
    $("#data").append("연결 끊김");
}



</script>
</head>

<body>
<div class="jstalktheme" id="jstalktheme_test" style="width: 320px; height: 480px;"> <!-- 전체 div -->
<div class="msg"> <!-- 채팅방 부분 div -->
</div>

<div class="sendmsg">
    <textarea class="textarea" id="textarea" onkeypress="if(event.keyCode==13){ sendMessage(); this.value=''; return false; }else if(event.keyCode==10){ this.value+='\n'; }"></textarea>
    <div class="button" onclick="sendMessage()">
 	   <p>전송</p>
    </div>
    <div class="clear">
    </div>
</div>

</div>
</body>
</html>
