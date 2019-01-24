<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<c:set var="list" value="${list}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>Cafe-In</title>
<!-- Favicon -->
<link rel="icon" href="static/img/core-img/favicon.ico">

<link rel="stylesheet" href="static/style.css" />
<link rel="stylesheet" href="static/css/bootstrap.css" />
<link rel="stylesheet" href="static/css/custom.css" />
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">

<script src="static/js/jquery.min.js"></script>
<script src="static/js/header.js"></script>

</head>
<body>

	<jsp:include page="header.jsp" />
	
	<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/main.jpg);">
        <div class="bradcumbContent">
            <p>MyPage</p>
            <h1 id="pageMenu">마이페이지</h1>
        </div>
    </section>
    
    <div class="body">
    	<ul style="position:relative; text-align:left; float:left; margin:50px 100px 0 150px;">
    		<li>
    			<ul style="margin-bottom:50px;">
		    		<li style="margin-bottom:20px;"><a href="#" id="coffeeAll" style="font-size:33px;">마이페이지</a></li>
		    		<li><a href="/coffee/mypage/userInfo" id="userInfo" style="color:#5f5f5f; font-size:22px;">개인정보수정</a></li>
		    		<li><a href="#" id="userInfo" style="color:#5f5f5f; font-size:22px;">배송지관리</a></li>
		    		<li><a href="#" id="deliveryState" style="color:#5f5f5f; font-size:22px;">오늘 본 상품</a></li>
		    		<li><a href="#" id="deliveryState" style="color:#5f5f5f; font-size:22px;">쿠폰</a></li>
		    		<li><a href="/coffee/mypage/orderState" id="orderState" style="color:#5f5f5f; font-size:22px;">주문조회</a></li>
		    		<li><a href="/coffee/mypage/deliveryState" id="deliveryState" style="color:#5f5f5f; font-size:22px;">배송조회</a></li>
	    		</ul>
    		</li>
    	</ul>
	</div>
	
	
	<!-- jQuery-2.2.4 js -->
    <script src="static/js/jquery.min.js"></script>
    <!-- Popper js -->
    <script src="static/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="static/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="static/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="static/js/active.js"></script>
    
    
	<!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />
    <!-- ##### Footer Area End ##### -->
</body>
</html>