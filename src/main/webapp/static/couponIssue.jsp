<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="couponNum" value="${couponNum}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="static/js/jquery.min.js"></script>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"
   rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean"
   rel="stylesheet">

<!-- Stylesheet -->
<!-- <link rel="stylesheet" href="style.css"> -->
<link rel="stylesheet" href="static/css/bootstrap.css">
<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
}
.mb-100 {
    margin-bottom: 0px;
}
</style>

<script type="text/javascript">
	var couponNum = '${couponNum}';
	$(function() {
		var str="";
		$.ajax({
			url : "/coffee/memberListSelect",
			method : "POST",
			dataType : "json",
			success : function(data) {
				var data = data.data;
				$('#length').text(data.length);
				for(var i = 0; i<data.length ; i++){
				  str += "<tr style='text-align:center;'>";
				  str += "<td style='vertical-align:middle;'><input type='checkbox' name='check' value='"+data[i].userid+"'></td>";
				  str += "<td style='vertical-align:middle;'>" + data[i].userid + "</td>";
				  str += "<td style='vertical-align:middle;'>" + data[i].username + "</td>";
				  str += "<td style='vertical-align:middle;'>" + data[i].usernickname +"</td>";
				  str += "<td style='vertical-align:middle;'>" + data[i].email + "</td>";
				  str +=	 "<td style='vertical-align:middle;'>" + data[i].tel + "</td>";
				  str += "<td style='vertical-align:middle;'>" + data[i].regdate + "</td>";
				  str += "</tr>";		 
				}
					
				$("#result").html(str);
			},
			error : function(err) {
				console.log("error 발생 " + err);
			}
		});
		
		$("#searchAll").click(function(){
			var str="";
			$.ajax({
				url : "/coffee/memberListSelect",
				method : "POST",
				dataType : "json",
				success : function(data) {
					var data = data.data;
					$('#length').text(data.length);
					for(var i = 0; i<data.length ; i++){
					  str += "<tr style='text-align:center;'>";
					  str += "<td style='vertical-align:middle;'><input type='checkbox' name='check' value='"+data[i].userid+"'></td>";
					  str += "<td style='vertical-align:middle;'>" + data[i].userid + "</td>";
					  str += "<td style='vertical-align:middle;'>" + data[i].username + "</td>";
					  str += "<td style='vertical-align:middle;'>" + data[i].usernickname +"</td>";
					  str += "<td style='vertical-align:middle;'>" + data[i].email + "</td>";
					  str +=	 "<td style='vertical-align:middle;'>" + data[i].tel + "</td>";
					  str += "<td style='vertical-align:middle;'>" + data[i].regdate + "</td>";
					  str += "</tr>";		 
					}
						
					$("#result").html(str);
				},
				error : function(err) {
					console.log("error 발생 " + err);
				}
			});
		});
		
		$("#search").bind("click", function(){
			var userid= $('#userid').val();
			
			if(userid==""){
				alert("검색할 회원의 아이디를 입력해주세요");
			} else if(userid!=""){
				$.ajax({			
					url : "/coffee/memberSelect/" + userid,
					dataType : "json",
					method : "POST",				
					success : function(data){ 
						search(data);
					},
					error : function(err){
						console.log("Error 발생 : " + err);
					}
				});
			}
		});
		
		$("#btnIssue").click(function(){
			var values=document.getElementsByName("check");
			for(var i=0; i<values.length; i++){
				if(values[i].checked){
					$.ajax({
						url : "/coffee/coupon/issue/"+couponNum+"/"+values[i].value,
						method : "POST",
						success : function(data) {
							
						},
						error : function(err) {
							console.log("Error 발생 : " + err);
						}
					});
					alert("쿠폰 발급을 완료했습니다.");
				}
			}
		});
		
		$("#check-all").click(function(){
	        //클릭되었으면
	        if($("#check-all").prop("checked")){
	            //input태그의 name이 check인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[name=check]").prop("checked",true);
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 check인 태그들을 찾아서 checked옵션을 false로 정의
	            $("input[name=check]").prop("checked",false);
	        }
	    });
	      
	}); 
	
	function search(data){
		var userid= $('#userid').val();
		var str="";
		var data = data.data;
		$('#length').text(data.length);
		
		for(var i = 0; i<data.length ; i++){
			str += "<tr style='text-align:center;'>";
		    str += "<td style='vertical-align:middle;'><input type='checkbox' name='check' value='"+data[i].userid+"'></td>";
		    str += "<td style='vertical-align:middle;'>" + data[i].userid + "</td>";
		    str += "<td style='vertical-align:middle;'>" + data[i].username + "</td>";
		    str += "<td style='vertical-align:middle;'>" + data[i].usernickname +"</td>";
		    str += "<td style='vertical-align:middle;'>" + data[i].email + "</td>";
		    str +=	 "<td style='vertical-align:middle;'>" + data[i].tel + "</td>";
		    str += "<td style='vertical-align:middle;'>" + data[i].regdate + "</td>";
		    str += "</tr>";	 
		}
		
		$("#result").html(str);
	}
</script>

<title>쿠폰 발급 페이지</title>
</head>
<body style="padding: 5%">

<!--  검색창 테이블 -->
<table class="table table-striped">
   <tbody class="a">
      <tr>
         <th class="align-middle"  style="text-align: center;width:130px">회원아이디</th>
         <td style="width:300px">
            <input  class="form-control input-sm" type="text" name="userid" id="userid" style="width:250px" value="">
         </td>
         <th style="width:300px">
            <button class="btn btn-success btn-sm"  type="button" id="search">검색</button>
            <button class="btn btn-warning btn-sm"  type="button" id="searchAll">전체검색</button>
         </th>
      </tr>
   </tbody>
</table><br><br>


<div style="float:left;">
	<button type="button" id="btnIssue" class="btn btn-danger btn-sm" >쿠폰 발급</button>
</div>
<div style="text-align: right;padding-left: 0px; padding-right: 0px; margin-bottom: 15px;">
      <span style="margin-bottom: 5px; font-size: 1.3em;">검색 된 회원 수 : <span id="length" id="count">0</span>명</span>
</div>

<table class="table table-striped">
   <thead class="a">
      <tr>
      	 <th style="text-align: center;width:5%"><input type="checkbox" id="check-all" />전체 선택</th>
         <th style="text-align: center;width:10%">아이디</th>
         <th style="text-align: center;width:10%">이름</th>
         <th style="text-align: center;width:10%">닉네임</th>
         <th style="text-align: center;width:25%">이메일</th>
         <th style="text-align: center;width:15%">전화번호</th>
         <th style="text-align: center;width:15%">가입날짜</th>
      </tr>
   </thead>
   <tbody id="result">
      
   </tbody>
</table>

</body>
</html>