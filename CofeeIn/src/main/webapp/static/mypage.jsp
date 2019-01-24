<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap"%>
<%@ page import="java.util.List, com.example.vo.ProductVO, java.util.Vector"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>카페-인 | 상품 검색</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/favicon.ico">


<link rel="stylesheet" href="static/style.css">
<link rel="stylesheet" href="static/css/bootstrap.css">
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">
<link rel="stylesheet" href="static/css/liststyle.css"> 
<link rel="stylesheet" href="static/css/fdw-demo.css"> 
<link rel="stylesheet" href="static/css/mypage.css">  

<script src="static/js/jquery.min.js"></script>
<script src="static/js/header.js"></script>
<script src="static/js/searchproduct.js"></script>

<script>

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
</script>
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


   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/mainimg14.png);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>SEARCH RESULT</h2>
      </div>
      </section>
      
   <input type="hidden" id="suserid" value="${sessionScope.userid }" >
   <input type="hidden" id="susername" value="${sessionScope.username }" >
         
   <section class="middlesection">
   
   <div class="wrap">
	   	
	    <div class="header">
	    </div>
	    
	    <div class="middlediv">
	        <form id="fmPop">
	        
	        </form>
	        <div class="content">
				<div class="numberlist">
				</div>

	        </div>
	    
	        <div class="aside">
	        
						<button type="button" class="btn btn-default btn-lg btn-block" onclick="location.href='/coffee/info_view/${sessionScope.userid}'">개인정보수정</button><br/>
						<button type="button" class="btn btn-default btn-lg btn-block" onclick="goDelivery();">배송지 추가/관리</button><br/>
						<button type="button" class="btn btn-default btn-lg btn-block" onclick="goTodayview();">오늘 본 상품</button><br/>
						<button type="button" class="btn btn-default btn-lg btn-block" onclick="location.href='/coffee/mypage/coupon'">쿠폰/적립금 조회</button><br/>
						<button type="button" class="btn btn-default btn-lg btn-block" onclick="location.href='/coffee/mypage/orderState'">주문/배송 조회</button><br/>
	        	
	        </div>

	    </div>
	    
	    <div class="footer">
	    </div>
	    
	</div>
   </section>
  

   <!-- ##### Breadcumb Area End ##### -->

   <!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />
   <!-- ##### Footer Area Start ##### -->


   <!-- ##### All Javascript Script ##### -->
   <!-- jQuery-2.2.4 js -->
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