<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
   href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean"
   rel="stylesheet">
   
	<link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    <link rel="stylesheet" href="static/css/liststyle.css">
	<link rel="stylesheet" href="static/css/fdw-demo.css">
    <link rel="stylesheet" href="static/css/mypage.css">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
    
<script src="static/js/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
   
}
</style>

<script>
$(function(){

	$("#btnInsert").click(function(){
		qzipcode = $("#qzipcode").val();
		qaddress1 = $("#qaddress1").val();
		qaddress2 = $("#qaddress2").val();
		userid = $("#userid").val();
		
		$.ajax({
			url : "/coffee/delivery_info/insert/" + userid,
			method : "POST",
			data : JSON.stringify({
				"userid" : $("#userid").val(),
				"qaddressname" : $("#qaddressname").val(),
				"qzipcode" : $("#qzipcode").val(),
				"qaddress1" : $("#qaddress1").val(),
				"qaddress2" : $("#qaddress2").val(),
			}),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data){
				if(data == 1){
					alert("배송지를 추가하였습니다.");
					opener.parent.location.reload();
					window.close();
				}else{
					alert("추가 실패하였습니다.");
				}
			},
			error : function(err){
				console.log("Error");
			}
			
		}); // ajax END..
	});  // btnInsert END...
	
	
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
           	 document.getElementById('qzipcode').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('qaddress1').value = fullRoadAddr;
               document.getElementById('qaddress2').value = "";

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
     
     $("#btnCancel").click(function(){
    	 self.close();
     });
	
}); // load END..
</script>

<title>배송지 등록</title>
</head>
<body   style="padding: 5%">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a>배송지 등록</a></li>
  </ol>
</nav>

<!-- <form method="post" action="productInsert_ok.jsp"  enctype="multipart/form-data"> -->
<form id="myform" accept-charset="UTF-8">
<div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width:100%; margin: auto;">
  <h2 class="menu_sub_title" style="text-align: center;margin-bottom:50px;">배송지 등록</h2>
        <table class="table" style="margin: auto; padding: 50%">
	         <tbody>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 배송지 명</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:200px;" type="text" id="qaddressname" name="qaddressname" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px">우편번호<button type="button" id="zipSearch" class="btn btn-info">우편번호검색</button></th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:200px;"  type="text" id="qzipcode" name="qzipcode" readonly="readonly"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px">주소</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:300px;" type="text" id="qaddress1" name="qaddress1" readonly="readonly"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px">상세주소</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:300px;" type="text" id="qaddress2" name="qaddress2" required="required"></td>
	            <td><input type="hidden" id="userid" name="userid" value="${sessionScope.userid}" /></td>	              
	         </tr>
	      </tbody>
      </table><br>      
      <div style="text-align:center;">
         <input class="btn btn-default" type="button" id="btnInsert" value="배송지 등록">
         <input class="btn btn-default" type="button" id="btnCancel" value="취소" />
      </div> 
      </div>

   </div> 
</form>

</body>
</html>