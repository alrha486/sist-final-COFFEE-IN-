<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<c:set var="user" value="${member}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    <link rel="stylesheet" href="static/css/liststyle.css">
	<link rel="stylesheet" href="static/css/fdw-demo.css">
    <!-- <link rel="stylesheet" href="static/css/mypage.css"> -->
    
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/header.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script>
	
	//table data
	$(document).ready(function(){
		passwd = "${user.passwd}";
		userid = "${user.userid}";
		$(".username").val("${user.username}");
		$(".usernickname").val("${user.usernickname}");
		$(".email").val("${user.email}");
		$(".tel").val("${user.tel}");
		$(".zipcode").val("${user.zipcode}");
		$(".address1").val("${user.address1}");
		$(".address2").val("${user.address2}");
		
		
	      
		$('#zipSearch').click(function(){ // Daum 주소 API 
	          
	          new daum.Postcode({
	             oncomplete: function(data) {
	                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	  
	                 // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                 var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	                 var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	  
	                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                     extraRoadAddr += data.bname;
	                 }
	                 // 건물명이 있고, 공동주택일 경우 추가한다.
	                 if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                 }
	                 // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                 if(extraRoadAddr !== ''){
	                     extraRoadAddr = ' (' + extraRoadAddr + ')';
	                 }
	                 // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	                 if(fullRoadAddr !== ''){
	                     fullRoadAddr += extraRoadAddr;
	                 }
	  
	                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
	             	 document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	                 document.getElementById('address1').value = fullRoadAddr;
	                 document.getElementById('address2').value = "";
	  
	                 // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                 if(data.autoRoadAddress) {
	                     //예상되는 도로명 주소에 조합형 주소를 추가한다.
	                     var expRoadAddr = data.autoRoadAddress + extraRoadAddr;

	  
	                 } else if(data.autoJibunAddress) {
	                     var expJibunAddr = data.autoJibunAddress;
	  
	                 } 
	             }
	         }).open();
	       }); // 주소 API END ...
		
	 $("#btnUpdate").click(function(){
		 
		if($("#passwd").val() != "${user.passwd}"){
			alert("비밀번호가 일치하지 않습니다.");
		} else if($("#passwd").val() == "${user.passwd}"){
		
			$.ajax({
				url : "/coffee/updateinfo",
				dataType : "json",
				method : "PUT",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"userid" : $("#userid").val(),
					"passwd" : $("#passwd").val(),
					"username" : $("#username").val(),
					"usernickname" : $("#usernickname").val(),
					"email" : $("#email").val(),
					"tel" : $("#tel").val(),
					"zipcode" : $("#zipcode").val(),
					"address1" : $("#address1").val(),
					"address2" : $("#address2").val(),
				}),
				success : function(data){
					if(data.code) { // 성공시 true를 반환
						alert("회원 정보가 수정되었습니다.");
						location.href = "/coffee/mypage";
					} else {
						alert("회원 정보 수정에 실패하였습니다.");
					}
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			
			}); // update ajax END..
		
		}
	 });  // update button END...   
	       
	
	 $("#btnDelete").click(function(){
		 if($("#passwd").val() != "${user.passwd}"){
				alert("비밀번호가 일치하지 않습니다.");
			} else if($("#passwd").val() == "${user.passwd}"){
				

		 $.ajax({
			 url : "/coffee/deleteinfo/" + userid,
			 method : "delete",
			 data : "json",
			 error : function(err){
				 console.log("회원 탈퇴 오류 발생" + err);
			 },
			 success : function(data){
				 if(data.code){
					 alert("탈퇴가 정상적으로 처리되었습니다");
					 location.href = "/coffee/";
					 }
					 
				 }
			  // ajax END..
		 });
	}
		 
	 }); // btnDelete END..
	 
	 $("#btnCancel").click(function(){
		history.back(); 
	 });
	 
	 
});  //load END...
		


		
		
	</script>
	<style>
	.header{
		height: 50px;
		text-align: center;
	}
	
	.header1{
		text-align: center;
	}
	.footer1{
		text-align: center;
	}
	
	.footer2{
		height:70px;
	}
	
	hr{
	margin-left: 300px;
	margin-right: 300px;
	
	}
	
	</style>
</head>
<body>

	<jsp:include page="header.jsp" />
	<input type="hidden" id="suserid" value="${sessionScope.userid }" >
	   <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/aaa.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>MY PAGE</h2>
      </div>
      </section>

	
<section class="middlesection">
   
   <div class="wrap">
	   	
	    <div class="header">
	    </div>
	    
	    <div class="middlediv">
	        
	        <div class="header1">
			    <h1 style="margin:70px 0px 30px 0px;color: green;">${user.username}님의 정보</h1>
			    </div>
			    <hr/>
				<input type="hidden" id="userid" name="userid" value="${user.userid}"/>
				<form class="form-horizontal">
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">이름</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" name="username" id="username" value='${user.username}' readonly="readonly">
				    </div>
				  </div>

				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">닉네임</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" name="usernickname" id="usernickname" value='${user.usernickname}'>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">이메일</label>
				    <div class="col-sm-4">
				      <input type="email" class="form-control" name="email" id="email" value="${user.email}">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">전화번호</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" name="tel" id="tel" value="${user.tel}">
				      
				      <br/>
				      <button type="button" id="zipSearch" class="btn btn-info">우편번호검색</button>

				    </div>
				  </div>
				  
				  
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">우편번호</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" name="zipcode" id="zipcode" value="${user.zipcode}">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">주소</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" name="address1" id="address1" value="${user.address1}">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">상세주소</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" name="address2" id="address2" value="${user.address2}">
				    </div>
				  </div>
				  <br/>
				  
				  <h5 style="text-align: center;">회원정보를 수정 및 탈퇴	하시려면, 비밀번호를 입력하셔야 합니다.</h5><br/>
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-4 control-label">비밀번호 확인</label>
				    <div class="col-sm-4">
				      <input type="password" class="form-control" name="passwd" id="passwd" placeholder="비밀번호를 입력해주세요">
				    </div>
				  </div>				  
				</form>
				<hr/>
					<div class="footer1">
					<input type='submit' value='수정하기' class="btn btn-success" id="btnUpdate" />
					<input type='button' value='회원탈퇴'  class="btn btn-danger" id="btnDelete"/>
					<input type='button' value='돌아가기'  class="btn btn-warning" id="btnCancel"/>
					</div>
	        </div>
		    
	    </div>
<div class="footer2"></div>
	    
   </section>
   
   <jsp:include page="footer.jsp" />
</body>
</html>