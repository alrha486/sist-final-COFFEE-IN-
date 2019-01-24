function playChatBot(realText){
	
if(realText.includes("상품 추천")){ // 상품 추천 물어봤을 떄
		 $.ajax({ // 최근 상품 조회하는 ajax
				url : "/coffee/SearchRecentlyProduct",
				method : "GET",
				success : function(data){
					var result = data.data;
					var productname = result[0].productname;
					Painting("최근에 나온 신제품 입니다!<a href='javascript:void(0);' onclick='closeAndGo();' id='"+ result[0].productid +"'><img width='100px' height='100px' src='static/img/product/"+ result[0].productimg+"'><br>"+result[0].productname +">>바로가기</a>");
					
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
		 });
	}else if(realText.includes("가장 많이 팔린 상품")){ // 인기상품 물어봤을 떄
		// 인기상품 조회하는 ajax 사용
		 $.ajax({ // 채팅방 입장 시 m_read(읽음여부) 1에서 0으로 업데이트
				url : "/coffee/SearchManyPopularityProduct",
				method : "GET",
				success : function(data){
					var result = data.data;
					var productname = result[0].productname;
					Painting("제일 인기가 좋은 상품입니다!<a href='javascript:void(0);' onclick='closeAndGo();' id='"+ result[0].productid +"'><img width='100px' height='100px' src='static/img/product/"+ result[0].productimg+"'><br>"+result[0].productname +">>바로가기</a>");
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			}); // 제일 많이 팔린 상품
	}
	
};
function closeAndGo(){
	self.close();
	opener.location.href = '/coffee/view/' + event.srcElement.id;
	
}
function Painting(text){ // 그려주는(출력) 함수
	var ocontainer = document.getElementById("jstalktheme_test"); //채팅 방 전체 div
	var ocontainer_msg = ocontainer.getElementsByClassName("msg")[0]; // 메시지부분 div			
	var onewmsg = document.createElement("div"); // 새로운 div만들기 (왼쪽)
	var onewblank = document.createElement("div"); // 새로운 div만들기 (오른쪽)
	
	var d = new Date(); // 현재시간
	var ampm = (d.getHours()>12 ?  "PM" : "AM");
	var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
	var m = d.getMinutes();	
	var time = ampm+" "+h+":"+m; // 현재시간
	
	onewmsg.className="othertalk"; // 왼쪽 div  생성(관리자임)
	onewmsg.innerHTML = 
		"<div class=\"profile_image\" style=\"background: url(static/img/profile_image.png) no-repeat;width:40px;height;40px\">\n"+
	"</div>\n"+
	"<div class=\"box\">\n"+
	"<div class=\"profile_name\">\n"+
	"관리자"+"\n"+
	"</div>\n"+
	"<div class=\"a\">\n"+
	"</div>\n"+
	"<div class=\"b\">\n"+
	text +"\n"+
	"</div>\n" +
	"<div class=\"time\">\n"+
	time+"\n"+
	"</div>\n"+
	"</div>\n";
	
	
	onewmsg.innerHTML +=
	    "<div class=\"clear\">\n"+
	    "</div>";
		
		onewblank.className="blank";
		
		ocontainer_msg.appendChild(onewmsg);
		ocontainer_msg.appendChild(onewblank);
		
		ocontainer_msg.scrollTop = ocontainer_msg.scrollHeight;
		
		 $.ajax({ // IF문 조건 다 거치면 회원가입 처리 AJAX 실행
				url : "/coffee/AuToinsertAdminMessage", // 유저의 메시지 DB에 insert
				dataType : "json",
				method : "POST",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"m_contents" : text		
				}),
				success : function(data){
					document.getElementById("textarea").innerHTML = "";
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
		
		
		
		
}