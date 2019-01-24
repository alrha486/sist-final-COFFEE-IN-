<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap"%>
<%@ page import="java.util.List, com.example.vo.ProductVO, java.util.Vector"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="product" value="${data}" />

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

<!-- Stylesheet -->
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
<link rel="stylesheet" href="static/css/searchproduct.css">
<script src="static/js/jquery.min.js"></script>
<script src="static/js/header.js"></script>
<script src="static/js/searchproduct.js"></script>


<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
}

.result {
   text-align: center;
}

.search_product {
   margin: 5%;
   height: 600px;
}

.search_area {
   overflow: hidden;
   padding: 0 0 10px 0;
   border-bottom: 1px solid rgb(247, 247, 247);
   margin: 0 0 30px;
}

.search_product .product_box {
   overflow: hidden;
   margin: 0 0 25px;
   min-height: 100px;
}

ul {
   display: block;
   list-style-type: disc;
   margin-block-start: 1em;
   margin-block-end: 1em;
   margin-inline-start: 0px;
   margin-inline-end: 0px;
   padding-inline-start: 40px;
   text-align: center;
}

.product_list ul li {
   width: 33.3%;
   display: inline-block;
}

.product_list ul li {
   position: relative;
   top: 0;
   left: 0;
   width: 300px;
   float: left;
   margin-bottom: 10px;
}

.product_list ul li a {
   display: block;
   overflow: hidden;
}

a {
   text-decoration: none;
}

.product_list ul li .photo {
   margin-bottom: 25px;
   width: 300px;
   overflow: hidden;
}

div, dl, dt, dd, ul, li, ol, p {
   padding: 0;
   margin: 0;
}

user agent stylesheet
p {
   display: block;
   margin-block-start: 1em;
   margin-block-end: 1em;
   margin-inline-start: 0px;
   margin-inline-end: 0px;
}

@media screen and (max-width: 1199px) and (min-width: 768px)
   .product_list ul li .txt_box {
   width : 96%;
   height : 130px;
   padding : 02%;
   text-align : center;
}

.product_list ul li .txt_box .name {
   display: block;
   max-height: 44px;
   overflow: hidden;
   margin-bottom: 10px;
   font-family: 'Archer-Semibold', 'NanumBarunGothic';
   font-weight: 700;
   font-size: 18px;
   color: rgb(51, 51, 51);
   text-align: center;
}

@media screen and (max-width: 1199px) and (min-width: 768px)
   .product_list ul li .txt_box {
   width:96%;
   height : 130px;
   padding : 02%;
   text-align : center;
}

.product_list ul li .txt_box .num {
   display: block;
   margin-bottom: 10px;
   font-family: 'Arial', 'NanumBarunGothic';
   font-size: 13px;
   color: rgb(51, 51, 51);
   text-align: center;
}

.product_list ul li .txt_box .price {
   display: block;
   font-family: 'NanumBarunGothic';
   font-size: 15px;
   color: rgb(207, 102, 26);
   text-align: center;
}

@media screen and (max-width: 1199px) and (min-width: 768px)
   .product_list ul li .txt_box {
   width : 96%;
   height : 130px;
   padding : 02%;
   text-align : center;
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


   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay"
      style="background-image: url(static/img/bg-img/breadcumb3.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>SEARCH RESULT</h2>
      </div>
   </section>
   <!-- ##### Breadcumb Area End ##### -->

   <div class="search_product">
      <div class="search_area">
         <div class="txt_area">
            <p id="count" style="float: left;margin-right: 20px">${fn:length(data)}건이 검색되었습니다   </p>
            <p ><input type="text" style="width:200px;height:23px"name="innerSearch" id="innerSearch" placeholder="상품명을 입력하세요"></p>
         </div>
      </div>
         <c:if test="${empty product}">
            <p style="text-align: center;" id="resultcount">검색 결과가 없습니다</p>
         </c:if>

            <div class="product_box product_list" id="listarea">
               <ul id="result">
                  <c:if test="${!empty product}">
                     <c:forEach items="${data }" var="item" step="1">
                        
                        <li>
                              <p class="photo"><img src="static/img/product/${item.productname }.jpg" width="150px" height="200px"></p>
                              <p class="txt_box">
                                 <span class="name">${item.productname }</span> 
                                 <span class="num">${item.productex }</span>
                                 <span class="price">${item.price }</span>
                              </p>
                        </li>
                        
                     </c:forEach>
                  </c:if>
               </ul>
            </div>
   		</div>


   <div>
      <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
      <br /> <br />
   </div>
   <!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />
   <!-- ##### Footer Area Start ##### -->


   <!-- ##### All Javascript Script ##### -->
   <!-- jQuery-2.2.4 js -->
   <script src="static/js/jquery/jquery-2.2.4.min.js"></script>
   <!-- Popper js -->
   <script src="static/js/bootstrap/popper.min.js"></script>
   <!-- Bootstrap js -->
   <script src="static/js/bootstrap/bootstrap.min.js"></script>
   <!-- All Plugins js -->
   <script src="static/js/plugins/plugins.js"></script>
   <!-- Active js -->
   <script src="static/js/active.js"></script>
</body>

</html>