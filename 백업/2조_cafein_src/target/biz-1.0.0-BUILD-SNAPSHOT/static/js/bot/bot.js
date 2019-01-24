function playChatBot(realText){
	if(realText.includes("안녕")){
		Painting("안녕하세요 좋은 하루 되세요^^");
	}
	else if(realText.includes("반가워")){
		Painting("네 저도 반갑습니다.^^");
	}
	else if(realText.includes("종모형")){
		Painting("종모형.......너무 잘생겼어요");
	}
	else if(realText.includes("이정현")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("병신")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("ㅄ")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("ㅂㅅ")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("개새끼")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("ㅗ")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("엿")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("개새")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("새끼")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("꺼져")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}	
	else if(realText.includes("죽을래")){
		Painting("살려주세요");
	}
	else if(realText.includes("시발")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}	
	else if(realText.includes("뭐해?")){
		Painting("니생각 ㅎㅎ");
	}	
	else if(realText.includes("개놈")){
		Painting("바른 말 고운 말을 사용해 주세요.");
	}
	else if(realText.includes("어쩌라고")){
		Painting("저한테 왜 그러세요...");
	}
	/////////////////욕끝///////////////////////////
	else if(realText.includes("오늘 뭐먹지?")){
		Painting("날이 추우니 따듯한 면 종류를 추천해드릴게요");
	}
	else if(realText.includes("아파")){
		Painting("병원 다녀오셨어요?");
	}
	else if(realText.includes("추워")){
		Painting("날이 너무 춥죠 따뜻하게 입고 다니세요.");
	}
	else if(realText.includes("춥다")){
		Painting("날이 너무 춥죠 따뜻하게 입고 다니세요.");
	}
	else if(realText.includes("ㅎ")){
		Painting("ㅎㅎ");
	}
	else if(realText.includes("ㅋ")){
		Painting("ㅋㅋ");
	}
	else if(realText.includes("더워")){
		Painting("이 날씨가요?");
	}
	else if(realText.includes("아프다")){
		Painting("병원 다녀오셨어요?");
	}
	else if(realText.includes("사랑해")){
		Painting("네 저도 사랑합니다 고객님♥");
	}
	else if(realText.includes("뭐하니")){
		Painting("니 생각 ㅎㅎ");
	}
	else if(realText.includes("컴퓨터 학원 추천좀")){
		Painting("컴퓨터학원은 역시 쌍용강북 교육센터가 최고죠");
	}
	else if(realText.includes("컴퓨터 학원")){
		Painting("컴퓨터학원은 역시 쌍용강북 교육센터가 최고죠");
	}
	else if(realText.includes("쌍용")){
		Painting("쌍용교육센터 짱");
	}
	else if(realText.includes("학원")){
		Painting("쌍용교육센터 짱");
	}
	else if(realText.includes("컴퓨터")){
		Painting("쌍용교육센터 짱");
	}
	else if(realText.includes("사랑")){
		Painting("사랑해");
	}
	else if(realText.includes("따라해봐")){
		Painting(realText);
	}
	else if(realText.includes("야")){
		Painting("네??");
	}
	else if(realText.includes("?")){
		Painting("??");
	}
	else if(realText.includes("즐")){
		Painting("바른 말 고운 말을 사용해주세요");
	}
	else if(realText.includes("너")){
		Painting("부르셨어요?");
	}else if(realText.includes("학원 추천좀")){
		Painting("컴퓨터학원은 역시 쌍용강북 교육센터가 최고죠");
	}
	else if(realText.includes("현재시간")){
		var d = new Date(); // 현재시간
		var ampm = (d.getHours()>12 ?  "PM" : "AM");
		var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
		var m = d.getMinutes();	
		var time = ampm+" "+h+":"+m; // 현재시간
		Painting("네 고객님 현재시간은 " + time + "입니다.");
	}
	else if(realText.includes("현재 시간")){
		var d = new Date(); // 현재시간
		var ampm = (d.getHours()>12 ?  "PM" : "AM");
		var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
		var m = d.getMinutes();	
		var time = ampm+" "+h+":"+m; // 현재시간
		Painting("네 고객님 현재시간은 " + time + "입니다.");
	}
	else if(realText.includes("시간")){
		var d = new Date(); // 현재시간
		var ampm = (d.getHours()>12 ?  "PM" : "AM");
		var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
		var m = d.getMinutes();	
		var time = ampm+" "+h+":"+m; // 현재시간
		Painting("네 고객님 현재시간은 " + time + "입니다.");
	}
	else if(realText.includes("상품 추천")){ // 상품 추천 물어봤을 떄
		//alert("상품추천");
		// 최근 상품 조회하는 ajax
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
	}
	else if(realText.includes("가장 많이 팔린 상품")){ // 인기상품 물어봤을 떄
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
	else if(realText.includes("가장 많이 팔린 상품")){ // 인기상품 물어봤을 떄
		// 인기상품 조회하는 ajax 사용
		 $.ajax({
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

	else{
		Painting("잘 모르겠어요...");
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