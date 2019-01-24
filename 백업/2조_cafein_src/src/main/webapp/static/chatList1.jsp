<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="static/css/bootstrap.css">
</head>
<style>
* {
  margin: 0;
  padding: 0;
}
body {
  font-size: 11px;
}
.chat_list_wrap {
  list-style: none;
}
.chat_list_wrap .header {
  font-size: 14px;
  padding: 15px 0;
  background: #420100;
  color: white;
  text-align: center;
  font-family: "Josefin Sans", sans-serif;
}
.chat_list_wrap .search {
  background: #eee;
  padding: 5px;
}
.chat_list_wrap .search input[type="text"] {
  width: 100%;
  border-radius: 4px;
  padding: 5px 0;
  border: 0;
  text-align: center;
}
.chat_list_wrap .list {
  padding: 0 16px;
}
.chat_list_wrap .list ul {
  width: 100%;
  list-style: none;
  margin-top: 3px;
}
.chat_list_wrap .list ul li {
  padding-top: 10px;
  padding-bottom: 10px;
  border-bottom: 1px solid #e5e5e5;
}
.chat_list_wrap .list ul li table {
  width: 100%;
}
.chat_list_wrap .list ul li table td.profile_td {
  width: 50px;
  padding-right: 11px;
}
.chat_list_wrap .list ul li table td.profile_td img {
  width: 50px;
  height: auto;
}
.chat_list_wrap .list ul li table td.chat_td .name {
  font-size: 12px;
  font-weight: bold;
}
.chat_list_wrap .list ul li table td.time_td {
  width: 90px;
  text-align: center;
}
.chat_list_wrap .list ul li table td.time_td .time {
  padding-bottom: 4px;
}
.chat_list_wrap .list ul li table td.time_td .check p {
  width: 8px;
  height: 8px;
  margin: 0 auto;
  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  border-radius: 50%;
  background: blue;
}
.chat_list_wrap .list ul li table td.time_td .check1 p {
  width: 8px;
  height: 8px;
  margin: 0 auto;
  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  border-radius: 50%;
  background: red;
}
</style>
<link rel="stylesheet" href="static/style.css">


<script src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value="static/js/sockjs-0.3.4.js"/>"></script>
<script type="text/javascript" src="<c:url value="static/js/bot/bot.js"/>"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/UserSelectAll", // 관리자 id로 수신자 이름만 뽑아오는 ajax
		method : "GET",
		success : function(data){			
			var result = data.data;
			var str = "";
		for(var i=0; i <result.length; i++){
 		if(i == 0){ // 일단 첫번쨰는 그냥 출력
 			str +=" <li>";
 			str +="<table cellpadding='0' cellspacing='0'>";
			str +="<tr>";
			str +="<td class='profile_td'>";
			str +="     <img src='static/img/profile_image.png' id ='"+result[i].userid+"' ondblclick='openChat();'>"; 
			str +="</td>";
			str +="<td class='chat_td'>";
			str +="<div>";
			str +="<div class='name' id ='"+result[i].userid+"' ondblclick='openChat();'>";
			str += result[i].username +"(" + result[i].userid + ")";
			str +="         </div>";
			str +="          <div class='chat_preview' id ='"+result[i].userid+"' ondblclick='openChat();'>";

			str +="          </div>";
			str +="      </td>";
			str +="      <td class='time_td'>";	
			str +="         <div class='time' width='200px'>";

			str +="        </div>";
			str +="</div>";
			if(result[i].userid == 'guswn123'){
		        str +="         <div class='check1'>";
			}else{
				str +="         <div class='check'>";
			}
	        str +="            <p> </p>";
	        str +="         </div>";
	        str +="      </td>";
	        str +="    </tr>";
	        str +="</table>";
	       	str +="</li>";
		}else if(i != 0){ // 0이 아니면
			if(result[i-1].userid == result[i].userid){
			  // 같으면 아무일도 일어나지않음	
			}else{
	 			str +=" <li>";
	 			str +="<table cellpadding='0' cellspacing='0'>";
				str +="<tr>";
				str +="<td class='profile_td'>";
				str +="     <img src='static/img/profile_image.png' id ='"+result[i].userid+"' ondblclick='openChat();'>"; 
				str +="</td>";
				str +="<td class='chat_td'>";
				str +="<div>";
				str +="<div class='name' id ='"+result[i].userid+"' ondblclick='openChat();'>";
				str += result[i].username +"(" + result[i].userid + ")";
				str +="         </div>";
				str +="          <div class='chat_preview' id ='"+result[i].userid+"' ondblclick='openChat();'>";

				str +="          </div>";
				str +="      </td>";
				str +="      <td class='time_td'>";	
				str +="         <div class='time' width='200px'>";

				str +="        </div>";
				str +="</div>";
				if(result[i].userid == 'guswn123'){
			        str +="         <div class='check1'>";
				}else{
					str +="         <div class='check'>";
				}
		        str +="            <p> </p>";
		        str +="         </div>";
		        str +="      </td>";
		        str +="    </tr>";
		        str +="</table>";
		       	str +="</li>";
			}
		}  
	}//for문			
		$('#result').html(str);
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});  
});

function openChat(){
	window.open('/coffee/chatRoom1/'+event.target.id, '채팅방','width=370, height=550 top=270, left=950,toolbar=no, menubar=no, scrollbars=no, resizable=yes');
	$('#btnCount').html(0);
}
//////////////////////////////////
function AllUser(){
	
	var include = function(arr, obj) {
		for(var i = 0, len = arr.length; i < len; i++) {
			if(arr[i] == obj) {
				return true;
			} 
		}
		return false;
	};
	
	var already= -1;
	var array = new Array();
	var count = 1;
	var str = "";
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/receiverList", // 관리자 id로 수신자 이름만 뽑아오는 ajax
		method : "GET",
		async:false,
		success : function(data){			
			var result = data.data;
			
	for(var i=0; i <result.length; i++){

		//alert(result[i].m_read);
		
		
		if(i == 0){ // 일단 첫번쨰는 그냥 출력
 			str +=" <li>";
 			str +="<table cellpadding='0' cellspacing='0'>";
			str +="<tr>";
			str +="<td class='profile_td'>";
			str +="     <img src='static/img/profile_image.png' id ='"+result[i].m_sender+"' ondblclick='openChat();'>"; 
			str +="</td>";
			str +="<td class='chat_td'>";
			str +="<div>";
			str +="<div class='name' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
			str += result[i].username +"(" + result[i].m_sender + ")";
			str +="         </div>";
			str +="          <div class='chat_preview' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
			str +=result[i].m_contents + "&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;"; 
			str +="         </div>";
			str +="      </td>";
			str +="<td class='chat_td'>";
/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////
$.ajax({  // 길이만큼 반복하면 ajax
	url : "/coffee/selectMreadCount/" + result[i].m_sender, // 관리자 id로 수신자 이름만 뽑아오는 ajax
		method : "GET",
		async:false,
		success : function(data){		
			str += "<button type='button' class='btn btn-warning ' id='btnCount'>"+data+"</button>";
		},error : function(err){
			console.log(err);
		}
});		
/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////

			str +="      </td>";
			str +="      <td class='time_td'>";	
			str +="         <div class='time' width='200px'>";
			str += result[i].m_date;
			str +="        </div>";
			str +="</div>";
			if(result[i].m_sender == 'guswn123'){
		        str +="         <div class='check1'>";
			}else{
				str +="         <div class='check'>";
			}
	        str +="            <p> </p>";
	        str +="         </div>";
	        str +="      </td>";
	        str +="    </tr>";
	        str +="</table>";
	       	str +="</li>";
	       	
	       	array[i] = result[i].m_sender;
	       	
		}else if(i != 0){ // 0이 아니면
		
			for(var k=0; k<array.length; k++){
				if(array[k] == result[i].m_sender){
							already = 1; 
					}
				}
			
			if(already == 1){ // 있으면 초기화
					already = -1;
			}else{
				
				

				
	 			str +=" <li>";
	 			str +="<table cellpadding='0' cellspacing='0'>";
				str +="<tr>";
				str +="<td class='profile_td'>";
				str +="     <img src='static/img/profile_image.png' id ='"+result[i].m_sender+"' ondblclick='openChat();'>"; 
				str +="</td>";
				str +="<td class='chat_td'>";
				str +="<div>";
				str +="<div class='name' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
				str += result[i].username +"(" + result[i].m_sender + ")";
				str +="         </div>";
				str +="          <div class='chat_preview' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
				str +=result[i].m_contents + "&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;"; 
				str +="         </div>";
				str +="      </td>";
				str +="<td class='chat_td'>";
	/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/selectMreadCount/" + result[i].m_sender, // 관리자 id로 수신자 이름만 뽑아오는 ajax
			method : "GET",
			async:false,
			success : function(data){		
				str += "<button type='button' class='btn btn-warning ' id='btnCount'>"+data+"</button>";
				//str +=data;
			},error : function(err){
				console.log(err);
			}
	});		
	/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////

				str +="      </td>";
				str +="      <td class='time_td'>";	
				str +="         <div class='time' width='200px'>";
				str += result[i].m_date;
				str +="        </div>";
				str +="</div>";
				if(result[i].m_sender == 'guswn123'){
			        str +="         <div class='check1'>";
				}else{
					str +="         <div class='check'>";
				}
		        str +="            <p> </p>";
		        str +="         </div>";
		        str +="      </td>";
		        str +="    </tr>";
		        str +="</table>";
		       	str +="</li>";
		       	
				array[i] = result[i].m_sender;
			}
		}  
	}//for문			
		$('#result').html(str);
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); 
}

function ConUser(){
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/receiverList", // 관리자 id로 수신자 이름만 뽑아오는 ajax
		method : "GET",
		success : function(data){			
			var result = data.data;
			var str = "";
 			str +=" <li>";
 			str +="<table cellpadding='0' cellspacing='0'>";
			str +="<tr>";
			str +="<td class='profile_td'>";
			str +="     <img src='static/img/profile_image.png' id ='"+"guswn123"+"' ondblclick='openChat();'>"; 
			str +="</td>";
			str +="<td class='chat_td'>";
			str +="<div>";
			str +="<div class='name' id ='"+"guswn123"+"' ondblclick='openChat();'>";
			str += "김현주" +"(" + "guswn123" + ")";
			str +="         </div>";
			str +="          <div class='chat_preview' id ='"+"guswn123"+"' ondblclick='openChat();'>";
			str +="안녕하세요";
			str +="          </div>";
			str +="      </td>";
			str +="      <td class='time_td'>";	
			str +="         <div class='time' width='200px'>";
			str += result[0].m_date;
			str +="        </div>";
			str +="</div>";
	        str +="         <div class='check1'>";
	        str +="            <p> </p>";
	        str +="         </div>";
	        str +="      </td>";
	        str +="    </tr>";
	        str +="</table>";
	       	str +="</li>";  
		$('#result').html(str);
	},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); 
}


function All(){
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/UserSelectAll", // 관리자 id로 수신자 이름만 뽑아오는 ajax
		method : "GET",
		success : function(data){			
			var result = data.data;
			var str = "";
		for(var i=0; i <result.length; i++){
 		if(i == 0){ // 일단 첫번쨰는 그냥 출력
 			str +=" <li>";
 			str +="<table cellpadding='0' cellspacing='0'>";
			str +="<tr>";
			str +="<td class='profile_td'>";
			str +="     <img src='static/img/profile_image.png' id ='"+result[i].userid+"' ondblclick='openChat();'>"; 
			str +="</td>";
			str +="<td class='chat_td'>";
			str +="<div>";
			str +="<div class='name' id ='"+result[i].userid+"' ondblclick='openChat();'>";
			str += result[i].username +"(" + result[i].userid + ")";
			str +="         </div>";
			str +="          <div class='chat_preview' id ='"+result[i].userid+"' ondblclick='openChat();'>";

			str +="          </div>";
			str +="      </td>";
			str +="      <td class='time_td'>";	
			str +="         <div class='time' width='200px'>";

			str +="        </div>";
			str +="</div>";
			if(result[i].userid == 'guswn123'){
		        str +="         <div class='check1'>";
			}else{
				str +="         <div class='check'>";
			}
	        str +="            <p> </p>";
	        str +="         </div>";
	        str +="      </td>";
	        str +="    </tr>";
	        str +="</table>";
	       	str +="</li>";
		}else if(i != 0){ // 0이 아니면
			if(result[i-1].userid == result[i].userid){
			  // 같으면 아무일도 일어나지않음	
			}else{
	 			str +=" <li>";
	 			str +="<table cellpadding='0' cellspacing='0'>";
				str +="<tr>";
				str +="<td class='profile_td'>";
				str +="     <img src='static/img/profile_image.png' id ='"+result[i].userid+"' ondblclick='openChat();'>"; 
				str +="</td>";
				str +="<td class='chat_td'>";
				str +="<div>";
				str +="<div class='name' id ='"+result[i].userid+"' ondblclick='openChat();'>";
				str += result[i].username +"(" + result[i].userid + ")";
				str +="         </div>";
				str +="          <div class='chat_preview' id ='"+result[i].userid+"' ondblclick='openChat();'>";

				str +="          </div>";
				str +="      </td>";
				str +="      <td class='time_td'>";	
				str +="         <div class='time' width='200px'>";

				str +="        </div>";
				str +="</div>";
				if(result[i].userid == 'guswn123'){
			        str +="         <div class='check1'>";
				}else{
					str +="         <div class='check'>";
				}
		        str +="            <p> </p>";
		        str +="         </div>";
		        str +="      </td>";
		        str +="    </tr>";
		        str +="</table>";
		       	str +="</li>";
			}
		}  
	}//for문			
		$('#result').html(str);
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); 
}
///////////////////////////웹소켓 파트///////////////////////////////////////
	var sock; 
	sock = new SockJS("<c:url value="/echo"/>");  
	sock.onmessage = onMessage;
	function onMessage(evt) { // 메시지 받으면 
		
		var include = function(arr, obj) {
			for(var i = 0, len = arr.length; i < len; i++) {
				if(arr[i] == obj) {
					return true;
				} 
			}
			return false;
		};
		
		var already= -1;
		var array = new Array();
		var count = 1;
		var str = "";
		$.ajax({  // 길이만큼 반복하면 ajax
			url : "/coffee/receiverList", // 관리자 id로 수신자 이름만 뽑아오는 ajax
			method : "GET",
			async:false,
			success : function(data){			
				var result = data.data;
				
		for(var i=0; i <result.length; i++){

			//alert(result[i].m_read);
			
			
			if(i == 0){ // 일단 첫번쨰는 그냥 출력
	 			str +=" <li>";
	 			str +="<table cellpadding='0' cellspacing='0'>";
				str +="<tr>";
				str +="<td class='profile_td'>";
				str +="     <img src='static/img/profile_image.png' id ='"+result[i].m_sender+"' ondblclick='openChat();'>"; 
				str +="</td>";
				str +="<td class='chat_td'>";
				str +="<div>";
				str +="<div class='name' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
				str += result[i].username +"(" + result[i].m_sender + ")";
				str +="         </div>";
				str +="          <div class='chat_preview' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
				str +=result[i].m_contents + "&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;"; 
				str +="         </div>";
				str +="      </td>";
				str +="<td class='chat_td'>";
	/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/selectMreadCount/" + result[i].m_sender, // 관리자 id로 수신자 이름만 뽑아오는 ajax
			method : "GET",
			async:false,
			success : function(data){		
				str += "<button type='button' class='btn btn-warning ' id='btnCount'>"+data+"</button>";
			},error : function(err){
				console.log(err);
			}
	});		
	/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////

				str +="      </td>";
				str +="      <td class='time_td'>";	
				str +="         <div class='time' width='200px'>";
				str += result[i].m_date;
				str +="        </div>";
				str +="</div>";
				if(result[i].m_sender == 'guswn123'){
			        str +="         <div class='check1'>";
				}else{
					str +="         <div class='check'>";
				}
		        str +="            <p> </p>";
		        str +="         </div>";
		        str +="      </td>";
		        str +="    </tr>";
		        str +="</table>";
		       	str +="</li>";
		       	
		       	array[i] = result[i].m_sender;
		       	
			}else if(i != 0){ // 0이 아니면
			
				for(var k=0; k<array.length; k++){
					if(array[k] == result[i].m_sender){
								already = 1; 
						}
					}
				
				if(already == 1){ // 있으면 초기화
						already = -1;
				}else{
					
					

					
		 			str +=" <li>";
		 			str +="<table cellpadding='0' cellspacing='0'>";
					str +="<tr>";
					str +="<td class='profile_td'>";
					str +="     <img src='static/img/profile_image.png' id ='"+result[i].m_sender+"' ondblclick='openChat();'>"; 
					str +="</td>";
					str +="<td class='chat_td'>";
					str +="<div>";
					str +="<div class='name' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
					str += result[i].username +"(" + result[i].m_sender + ")";
					str +="         </div>";
					str +="          <div class='chat_preview' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
					str +=result[i].m_contents + "&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;"; 
					str +="         </div>";
					str +="      </td>";
					str +="<td class='chat_td'>";
		/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////
		$.ajax({  // 길이만큼 반복하면 ajax
			url : "/coffee/selectMreadCount/" + result[i].m_sender, // 관리자 id로 수신자 이름만 뽑아오는 ajax
				method : "GET",
				async:false,
				success : function(data){		
					str += "<button type='button' class='btn btn-warning ' id='btnCount'>"+data+"</button>";
					//str +=data;
				},error : function(err){
					console.log(err);
				}
		});		
		/////////////////////////////여기에 메시지 count ajax 추가//////////////////////////////////////////

					str +="      </td>";
					str +="      <td class='time_td'>";	
					str +="         <div class='time' width='200px'>";
					str += result[i].m_date;
					str +="        </div>";
					str +="</div>";
					if(result[i].m_sender == 'guswn123'){
				        str +="         <div class='check1'>";
					}else{
						str +="         <div class='check'>";
					}
			        str +="            <p> </p>";
			        str +="         </div>";
			        str +="      </td>";
			        str +="    </tr>";
			        str +="</table>";
			       	str +="</li>";
			       	
					array[i] = result[i].m_sender;
				}
			}  
		}//for문			
			$('#result').html(str);
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); 
	}
</script>
<body>
<div class="chat_list_wrap">
    <div class="header" style="font-size:1.3em;">
        CAFEIN | 채팅
    </div>
    <div class="header">
        <table style="text-align:center;">
        	<tr>
        	<td width="200px" onclick="All();"><span class="glyphicon glyphicon-th-large" style="color:#FFFFFF;"></span></td>
        	<td width="200px" onclick="AllUser();"><span class="glyphicon glyphicon-envelope" style="color:#FFFFFF;"></span></td>
        	<td width="200px" onclick="ConUser();"><span class="glyphicon glyphicon-user" style="color:#FFFFFF;"></span></td>
        	</tr>
        	<tr>
        	<td width="200px" onclick="All();">전체 유저 목록</td>
        	<td width="200px" onclick="AllUser();">채팅 유저 목록</td>
        	<td width="200px" onclick="ConUser();">접속 중인 유저</td>
        	</tr>
        </table>
    </div>
    <div class="search">
        <input type="text" placeholder="채팅방 이름, 참여자 검색" />
    </div>
    <div class="list">
        <ul id="result">

        </ul>
    </div>
</div>
</body>
</html>