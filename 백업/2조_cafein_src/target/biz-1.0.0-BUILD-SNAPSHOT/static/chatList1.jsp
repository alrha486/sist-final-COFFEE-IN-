<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="./css/common.css">
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
  width: 5px;
  height: 5px;
  margin: 0 auto;
  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  border-radius: 50%;
  background: #e51c23;
}
</style>
   <link rel="stylesheet" href="static/style.css">
<script src="static/js/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/receiverList", // 관리자 id로 수신자 이름만 뽑아오는 ajax
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
			str +="     <img src='static/img/profile_image.png' id ='"+result[i].m_sender+"' ondblclick='openChat();'>"; 
			str +="</td>";
			str +="<td class='chat_td'>";
			str +="<div>";
			str +="<div class='name' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
			str += result[i].username +"(" + result[i].m_sender + ")";
			str +="         </div>";
			str +="          <div class='chat_preview' id ='"+result[i].m_sender+"' ondblclick='openChat();'>";
			str +=result[i].m_contents;
			str +="          </div>";
			str +="      </td>";
			str +="      <td class='time_td'>";	
			str +="         <div class='time'>";
			str +="            오후 4:00 ";
			str +="        </div>";
			str +="</div>";
	        str +="         <div class='check'>";
	        str +="            <p> </p>";
	        str +="         </div>";
	        str +="      </td>";
	        str +="    </tr>";
	        str +="</table>";
	       	str +="</li>";
		}else if(i != 0){ // 0이 아니면
			if(result[i-1].m_sender == result[i].m_sender){
			  // 같으면 아무일도 일어나지않음	
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
				str +=result[i].m_contents;
				str +="          </div>";
				str +="      </td>";
				str +="      <td class='time_td'>";	
				str +="         <div class='time'>";
				str +="            오후 4:00 ";
				str +="        </div>";
				str +="</div>";
		        str +="         <div class='check'>";
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
}
</script>
<body>
<div class="chat_list_wrap">
    <div class="header">
        CAFEIN | 채팅
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