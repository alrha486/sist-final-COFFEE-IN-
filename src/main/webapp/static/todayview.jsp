<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘 본 상품</title>

    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
	<link rel="stylesheet" href="static/css/liststyle.css">
	<link rel="stylesheet" href="static/css/fdw-demo.css">  
	
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/header.js"></script>
    <script src="static/js/jquery.cookie.js"></script>
    
<script>
	$(document).ready(function(){
		
	    var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        count = ca.length;
        
        var todaylists = "";
	
        if(count >= 1){
	        for(var i = 0 ; i < count ; i++){
			var s = i + 1;
			productid = $("#pid" + s + "").val();

			$.ajax({
				url : "/coffee/todayview/product/" + productid,
				method : "post",
				data : "json",
				error : function(err){

				},
				success : function(data){
					
					var data = data.data;				
					todaylists += "<tr>";
					todaylists += "<td rowspan='2' width='10%' height='0' style='vertical-align:middle;'>";
					todaylists += "<div style='height:100%;'><img src='static/img/product/" + data.productname +".jpg' height='50px'></div></td>";
					todaylists += "<td width='80%'><a href='javascript:void(0)'>" + data.productname + "</td>";
					todaylists += "<td width='5%' rowspan='2' style='text-align:center;vertical-align:middle;'><p>" + data.price + "</p></td>";
					todaylists += "<td width='5%' rowspan='2'>";
					todaylists += "<button class='btn btn-primary'>주문</button><br/><br/>";
					todaylists += "<button class='btn btn-success'>담기</button><br/><br/>";
					todaylists += "<button class='btn btn-info' onclick='todaylistdelete(" + data.productid + ");'>삭제</button></td>";
					todaylists += "</tr>";
					todaylists += "<tr>";
					todaylists += "<td>" + data.productex + "</td>";
					todaylists += "</tr>";
					
					if(count == i){
						display(todaylists);
					}
					
				}
			}); // ajax END..
			
 		}  //for END. 
    } else if(count == 1) {
    	alert("오늘 본 상품이 없습니다");
    } // if END.. 
        
	
	});
	
	function display(todaylists){  // 테이블에 리스트 추가
		$("#todaylist").html(todaylists); 
	}
	
	function todaylistdelete(id){
		cookiename = $("#cookiename" + id + "").val();
		deleteCookie(cookiename);

	}
	
	function getCookie(c_name){ // 삭제할 쿠키 value 가져오기 ..
		var i,x,y,ARRcookies=document.cookie.split(";");
			for (i=0;i<ARRcookies.length;i++)
			{
			  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
			  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
			  x=x.replace(/^\s+|\s+$/g,"");
			  	if (x==c_name){
					return unescape(y);
				}
		  	}
		}
	
	 function deleteCookie(cookieName){
		  var expireDate = new Date();
		  
		  //어제 날짜를 쿠키 소멸 날짜로 설정한다.
		  expireDate.setDate( expireDate.getDate() - 1 );
		  document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
		  location.reload();
	 }
	 
		function goDelivery(){
			userid = $("#suserid").val();
			$("#fmPop").attr('action', "/coffee/delivery_info/" + userid);
	    	$("#fmPop").attr('method', 'post');
	    	$("#fmPop").submit();
			
		}
		
		function goTodayview(){
			userid = $("#suserid").val();
			$("#fmPop").attr('action', "/coffee/todayview/" + userid);
			$("#fmPop").attr('method', 'post');
			$("#fmPop").submit();
		}

		function back(){
			location.href="/coffee/mypage";
		}
</script>

<style>
.mid{
	margin: 200px;
}
</style>
</head>
<body>

   <!-- Preloader -->
   <div class="preloader d-flex align-items-center justify-content-center">
      <div class="lds-ellipsis">
         <div></div>
         <div></div>
         <div></div>
         <div></div>
      </div>
   </div>
   


   <!-- ##### Header Area Start ##### -->
   <jsp:include page="header.jsp" />
   <!-- ##### Header Area End ##### -->
<input type="hidden" id="suserid" value="${sessionScope.userid }" >

   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/blog2.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>Today View</h2>
      </div>
      </section>
      
         <section class="middlesection">
   
	        <form id="fmPop">
	        
	        </form>
	        
<div class="mid">
				<%
					String name = "";
					String value = "";
					String cook = request.getHeader("Cookie");
					String userid = String.valueOf(session.getAttribute("userid"));
					
					if(cook != null){
						Cookie[] cookies = request.getCookies();
						
						for(int i = 0 ; i < cookies.length ; i++){
							String cookiename = cookies[i].getName().split("%")[0];
							if(!userid.equals(cookiename)){
							} else if(!cookies[i].getName().equals("JSESSIONID")){
								name = cookies[i].getName();
								value = cookies[i].getValue();
				%>
					<input type="hidden" id="cookiename<%=value %>" value="<%=name %>">
					<input type="hidden" id="pid<%=i %>" value="<%=value %>">
				
				<%
							}
						}
					} %>
					
					
					<table class="table table-bordered">
						<thead>
							<tr class="success">
								<th style="text-align: center;">상품 이미지</th>
								<th>상품 이름</th>
								<th style="text-align: center;">가격</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="todaylist">
						</tbody>
					</table><br>
				<div style="text-align:center;">
	               <input type='button' value='선택 상품 삭제'  class="btn btn-danger" id="btnCancel"/>
	               <input type='button' value='돌아 가기'  class="btn btn-warning" onclick="back();"/>
               </div>
					</div>
					
   </section>
  

   <!-- ##### Breadcumb Area End ##### -->

   <!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />
   <!-- ##### Footer Area Start ##### -->
   
   <script src="static/js/jquery-2.2.4.min.js"></script>
   <!-- Popper js -->
   <script src="static/js/bootstrap/popper.min.js"></script>
   <!-- Bootstrap js -->
   <script src="static/js/bootstrap.min.js"></script>
   <!-- All Plugins js -->
   <script src="static/js/plugins/plugins.js"></script>
   <!-- Active js -->
   <script src="static/js/active.js"></script>
</body>
</html>