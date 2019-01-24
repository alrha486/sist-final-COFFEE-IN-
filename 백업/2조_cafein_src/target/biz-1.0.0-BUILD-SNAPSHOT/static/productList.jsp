<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="type" value="${type}" />   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>Cafe-In</title>
<!-- Favicon -->
<link rel="icon" href="../static/img/core-img/favicon.ico">

<link rel="stylesheet" href="static/css/bootstrap.min.css"
   type="text/css" />
<link rel="stylesheet" href="../static/css/style.css" type="text/css" />
<link rel="stylesheet" href="../static/css/custom.css" type="text/css" />
<script src="../static/js/jquery/jquery.min.js"></script>
<script>
   var page = null;
   $(document).ready(function() {
      var type=$("#type").val();
      
      //시작 페이지
      if(type=="COFFEE"){
         $("#shopmenu").text('Coffee');
         goAjaxType(type);
      } else if(type=="FOODS"){
         $("#shopmenu").text('Foods');
         goAjaxType(type);
      } else if(type=="GOODS"){
         $("#shopmenu").text('Goods');
         goAjaxType(type);
      } else if(type=="Beans"){
         $("#shopmenu").text('Coffee');
         var number=1;
         goAjax(number);
      } else if(type=="Bottle"){
         $("#shopmenu").text('Coffee');
         var number=2;
         goAjax(number);
      } else if(type=="Drip"){
         $("#shopmenu").text('Coffee');
         var number=3;
         goAjax(number);
      } else if(type=="Cake"){
         $("#shopmenu").text('Foods');
         goAjax(4);
      } else if(type=="Bakery"){
         $("#shopmenu").text('Foods');
         goAjax(5);
      } else if(type=="Sandwich"){
         $("#shopmenu").text('Foods');
         goAjax(6);
      } else if(type=="Mug"){
         $("#shopmenu").text('Goods');
         goAjax(7);
      } else if(type=="Tumbler"){
         $("#shopmenu").text('Goods');
         goAjax(8);
      } else if(type=="Accessory"){
         $("#shopmenu").text('Goods');
         goAjax(9);
      } 

      //메뉴 클릭 시 상품 목록
      $("#Coffee").on("click", function() {
         $("#shopmenu").text('Coffee');
         var p_type = 'COFFEE';
         var url="/coffee/productList/"+p_type;
         history.replaceState(null, null, url);
         goAjaxType(p_type);
      });
      $("#Foods").on("click", function() {
         $("#shopmenu").text('Foods');
         var p_type = 'FOODS';
         var url="/coffee/productList/"+p_type;
         history.replaceState(null, null, url);
         goAjaxType(p_type);
      });
      $("#Goods").on("click", function() {
         $("#shopmenu").text('Goods');
         var p_type = 'GOODS';
         var url="/coffee/productList/"+p_type;
         history.replaceState(null, null, url);
         goAjaxType(p_type);
      });

      $("#coffeeAll").on("click", function() {
         $("#shopmenu").text('Coffee');
         var p_type = 'COFFEE';
         var url="/coffee/productList/"+p_type;
         history.replaceState(null, null, url);
         goAjaxType(p_type);
      });
      $("#beans, #beans1").on("click", function() {
         $("#shopmenu").text('Coffee');
         var url="/coffee/productList/Beans";
         history.replaceState(null, null, url);
         var number = 1;
         goAjax(number);
      });
      $("#bottle, #bottle1").on("click", function() {
         $("#shopmenu").text('Coffee');
         var url="/coffee/productList/Bottle";
         history.replaceState(null, null, url);
         var number = 2;
         goAjax(number);
      });
      $("#drip, #drip1").on("click", function() {
         $("#shopmenu").text('Coffee');
         var url="/coffee/productList/Drip";
         history.replaceState(null, null, url);
         var number = 3;
         goAjax(number);
      });

      $("#foodsAll").on("click", function() {
         $("#shopmenu").text('Foods');
         var p_type = 'FOODS';
         var url="/coffee/productList/"+p_type;
         history.replaceState(null, null, url);
         goAjaxType(p_type);
      });
      $("#cake, #cake1").on("click", function() {
         $("#shopmenu").text('Foods');
         var url="/coffee/productList/Cake";
         history.replaceState(null, null, url);
         var number = 4;
         goAjax(number);
      });

      $("#bakery, #bakery1").on("click", function() {
         $("#shopmenu").text('Foods');
         var url="/coffee/productList/Bakery";
         history.replaceState(null, null, url);
         var number = 5;
         goAjax(number);
      });
      $("#sandwich, #sandwich1").on("click", function() {
         $("#shopmenu").text('Foods');
         var url="/coffee/productList/Sandwich";
         history.replaceState(null, null, url);
         var number = 6;
         goAjax(number);
      });

      $("#goodsAll").on("click", function() {
         $("#shopmenu").text('Goods');
         var p_type = 'GOODS';
         var url="/coffee/productList/"+p_type;
         history.replaceState(null, null, url);
         goAjaxType(p_type);
      });
      $("#mug, #mug1").on("click", function() {
         $("#shopmenu").text('Goods');
         var url="/coffee/productList/Mug";
         history.replaceState(null, null, url);
         var number = 7;
         goAjax(number);
      });
      $("#tumbler, #tumbler1").on("click", function() {
         $("#shopmenu").text('Goods');
         var url="/coffee/productList/Tumbler";
         history.replaceState(null, null, url);
         var number = 8;
         goAjax(number);
      });
      $("#accessory, #accessory1").on("click", function() {
         $("#shopmenu").text('Goods');
         var url="/coffee/productList/Accessory";
         history.replaceState(null, null, url);
         var number = 9;
         goAjax(number);
      });
      

      $("#selectSort").click(function(){
         var value=$("#selectSort option:selected").val();
         console.log(value);
      });
      
   });

   //상품 대분류 목록 출력
   function goAjaxType(p_type) {
      $.ajax({
         url : "/coffee/productLists/" + p_type + "/1",
         dataType : "json",
         method : "POST",
         success : function(data) {
            display(data);
         },
         error : function(err) {
            console.log("Error 발생 : " + err);
         }
      });
   }

   //상품 소분류 목록 출력
   function goAjax(number) {
      $.ajax({
         url : "/coffee/productList/" + number+"/1",
         dataType : "json",
         method : "POST",
         success : function(data) {
            display(data);
         },
         error : function(err) {
            console.log("Error 발생 : " + err);
         }
      });
   }

   //page 이동(대분류)
   function goPageType(type, page) { 
      var type="COFFEE";
      $.ajax({
         url : "/coffee/productLists/"+type+"/"+page,
         dataType : "json",
         method : "POST",
         success : function(data) {
            display(data);
         }
      });
   }
   //page 이동(소분류)
   function goPageKind(kind, page) {
      $.ajax({
         url : "/coffee/productList/"+kind+"/"+page,
         dataType : "json",
         method : "POST",
         success : function(data) {
            display(data);
         }
      });
   }
   
   //상품 목록 출력
   function display(data) {
      var startPage = data.startPage;
      var totalPage = data.totalPage;
      var pageSize = data.pageSize;
      var page = data.page;
      var type = data.type;
      var kind = data.kind;
      var data = data.data;
      var count = data.length;
      var str = null;
      if (count == 0) {
         str = "<h1>상품을 준비중입니다</h1>";
      } else if (count > 0) {
         str = "";
         for (var i = 0; i < count; i++) {
            var product = data[i];
            var productid = product.productid;
            var kind_idx=product.kind_idx;
            var productname = product.productname;
            var productimg = product.productimg;
            var productex = product.productex;
            var price = product.price

            str += "<div class='col-12 col-sm-4 col-md-3 col-lg-2 single-album-item'>";
            str += "<a href='/coffee/view/"+ productid +"'>";
            str += "<div class='scale'><img src='static/img/coffee/"+productname+".jpg'></div>";
            str += "<div class='album-info'>";
            str += "<h5>" + productname + "</h5>";
            str += "<p style='text-algin:left !important'>" + productex + "</p>";
            str += "<h5>￦" + price + "</h5>";
            
            str += "</div></a></div>";
         }
      }
      $("#records").html(str);

      // 대분류 페이징
      if(kind==0){
         // 이전페이지 이동
         if (page == 1) { //현재 페이지가 1페이지
            pageStr = "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&lt;</a></li>";
         } else if (page != 1) {
            pageStr = "<li class='page-item'><a class='page-link' href='javascript:goPageType(\""
                  + type + "\"," + (page - 1) + ")'>&lt;</a></li>";
         }
         // 페이지 번호 (1~끝까지)
         for (var k = 1; k <= totalPage; k++) {
            if (page == k)
               pageStr += "<li class='page-item active'><a class='page-link' href='javascript:goPageType(\""
                     + type + "\"," + k + ")'>" + k + "</a></li>";
            else
               pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPageType(\""
                     + type + "\"," + k + ")'>" + k + "</a></li>";
         }
         // 다음페이지 이동
         if (page == totalPage) {
            // 마지막 페이지에서 다음 페이지 누를 시
            pageStr += "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&gt;</a></li>";
         } else if (page != totalPage) { // 다음 페이지가 있으면
            pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPageType(\""
                  + type + "\"," + (page + 1) + ")'>&gt;</a></li>";
         }
   
         $("#paging").html(pageStr);
      }
      else{ // 소분류 페이징
         // 이전페이지 이동
         if (page == 1) { //현재 페이지가 1페이지
            pageStr = "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&lt;</a></li>";
         } else if (page != 1) {
            pageStr = "<li class='page-item'><a class='page-link' href='javascript:goPageKind("
                  + kind + "," + (page - 1) + ")'>&lt;</a></li>";
         }
         // 페이지 번호 (1~끝까지)
         for (var k = 1; k <= totalPage; k++) {
            if (page == k)
               pageStr += "<li class='page-item active'><a class='page-link' href='javascript:goPageKind("
                     + kind + "," + k + ")'>" + k + "</a></li>";
            else
               pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPageKind("
                     + kind + "," + k + ")'>" + k + "</a></li>";
         }
         // 다음페이지 이동
         if (page == totalPage) {
            // 마지막 페이지에서 다음 페이지 누를 시
            pageStr += "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&gt;</a></li>";
         } else if (page != totalPage) { // 다음 페이지가 있으면
            pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPageKind("
                  + kind + "," + (page + 1) + ")'>&gt;</a></li>";
         }
   
         $("#paging").html(pageStr);
      }
      
   }
</script>
</head>
<body>
   <input type="hidden" id="type" value="${type}"/>
   
   <%-- <%@include file="header.jsp" %> --%>
   <header class="header-area">
      <!-- Navbar Area -->
      <div class="oneMusic-main-menu">
         <div class="classy-nav-container breakpoint-off">
            <div class="container">
               <!-- Menu -->
               <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                  <!-- Nav brand -->
                  <a href="/coffee/productList/COFFEE" class="nav-brand"><img
                     src="../static/img/core-img/logo1.png" alt=""></a>

                  <!-- Navbar Toggler -->
                  <div class="classy-navbar-toggler">
                     <span class="navbarToggler"><span></span><span></span><span></span></span>
                  </div>

                  <!-- Menu -->
                  <div class="classy-menu">

                     <!-- Close Button -->
                     <div class="classycloseIcon">
                        <div class="cross-wrap">
                           <span class="top"></span><span class="bottom"></span>
                        </div>
                     </div>

                     <!-- Nav Start -->
                     <div class="classynav">
                        <ul>
                           <li><a href="index.html">Home</a></li>
                           <li><a href="#">About</a></li>
                           <!-- <li><a href="albums-store.html">Albums</a></li> -->
                           <li><a href="#">Shop</a>
                              <ul class="dropdown">
                                 <li><a href="#" id="Coffee">Coffee</a>
                                    <ul class="dropdown">
                                       <li><a href="#" id="beans1">Beans</a></li>
                                       <li><a href="#" id="bottle1">Bottle coffee</a></li>
                                       <li><a href="#" id="drip1">Drip bag</a></li>
                                    </ul></li>
                                 <li><a href="#" id="Foods">Foods</a>
                                    <ul class="dropdown">
                                       <li><a href="#" id="cake1">Cake</a></li>
                                       <li><a href="#" id="bakery1">Bakery</a></li>
                                       <li><a href="#" id="sandwich1">Sandwich</a></li>
                                    </ul></li>
                                 <li><a href="#" id="Goods">Goods</a>
                                    <ul class="dropdown">
                                       <li><a href="#" id="mug1">Mug/Tumbler</a></li>
                                       <li><a href="#" id="tumbler1">Coffee goods</a></li>
                                       <li><a href="#" id="accessory1">Accessory</a></li>
                                    </ul></li>
                              </ul>
                           <li><a href="event.html">Contact</a>
                              <ul class="dropdown">
                                 <li><a href="#">Notice</a></li>
                                 <li><a href="#">QnA</a></li>
                              </ul></li>

                           <li><a href="#">Store</a></li>
                        </ul>


                        <!-- Login/Register & Cart Button -->

                        <div
                           class="login-register-cart-button d-flex align-items-center">
                           <!-- Login/Register -->
                           <div class="login-register-btn mr-50">
                              <a href="login.html" id="loginBtn">Login</a>
                           </div>
                           <div class="login-register-btn mr-50">
                              <a href="login.html" id="loginBtn">Mypage</a>
                           </div>
                           <div class="login-register-btn mr-50">
                              <a href="#" id="searchBtn"><img
                                 src="//image.istarbucks.co.kr/common/img/common/icon_magnifier_white.png"></a>

                           </div>


                           <!-- Cart Button -->
                           <div class="cart-btn">
                              <p>
                                 <span class="icon-shopping-cart"></span> <span
                                    class="quantity">1</span>
                              </p>
                           </div>

                        </div>
                     </div>
                     <!-- Nav End -->

                  </div>
               </nav>
            </div>
         </div>
      </div>
   </header>

   <section class="breadcumb-area bg-img bg-overlay"
      style="background-image: url(static/img/main.jpg);">
      <div class="bradcumbContent">
         <p>Shop</p>
         <h1 id="shopmenu">Coffee</h1>
      </div>
   </section>

   <div class="body">
      <ul
         style="height:100%; text-align: left; float: left; margin: 50px 100px 0 150px;">
         <li>
            <ul style="margin-bottom: 70px;">
               <li style="margin-bottom: 20px;"><a href="#" id="coffeeAll"
                  style="font-size: 33px;">Coffee</a></li>
               <li><a href="#" id="beans"
                  style="color: #5f5f5f; font-size: 22px;">Beans</a></li>
               <li><a href="#" id="bottle"
                  style="color: #5f5f5f; font-size: 22px;">Bottle Coffee</a></li>
               <li><a href="#" id="drip"
                  style="color: #5f5f5f; font-size: 22px;">Drip Bag</a></li>
            </ul>
         </li>
         <li>
            <ul
               style="margin-bottom: 70px; padding-top: 70px; border-top: 1px solid #c9c9c9;">
               <li style="margin-bottom: 20px;"><a href="#" id="foodsAll"
                  style="font-size: 33px;">Foods</a></li>
               <li><a href="#" id="cake"
                  style="color: #5f5f5f; font-size: 22px;">Cake</a></li>
               <li><a href="#" id="bakery"
                  style="color: #5f5f5f; font-size: 22px;">Bakery</a></li>
               <li><a href="#" id="sandwich"
                  style="color: #5f5f5f; font-size: 22px;">Sandwich</a></li>
            </ul>
         </li>
         <li>
            <ul
                style="margin-bottom: 70px; padding-top: 70px; border-top: 1px solid #c9c9c9;">
               <li style="margin-bottom: 20px;"><a href="#" id="goodsAll"
                  style="font-size: 33px;">Goods</a></li>
               <li><a href="#" id="mug"
                  style="color: #5f5f5f; font-size: 22px;">Mug</a></li>
               <li><a href="#" id="tumbler"
                  style="color: #5f5f5f; font-size: 22px;">Tumbler</a></li>
               <li><a href="#" id="accessory"
                  style="color: #5f5f5f; font-size: 22px;">Accessory</a></li>
            </ul>
         </li>
      </ul>
      
      <!-- 신메뉴/이벤트 -->
      <div id="demo" class="carousel slide" data-ride="carousel">
         <!-- Indicators -->
         <ul class="carousel-indicators">
           <li data-target="#demo" data-slide-to="0" class="active"></li>
           <li data-target="#demo" data-slide-to="1"></li>
           <li data-target="#demo" data-slide-to="2"></li>
         </ul>
         
         <!-- The slideshow -->
         <div class="carousel-inner">
           <div class="carousel-item active">
             <img src="static/img/main.jpg" style="width:100%; height:300px;">
           </div>
           <div class="carousel-item">
             <img src="static/img/main.jpg" style="width:100%; height:300px;">
           </div>
           <div class="carousel-item">
             <img src="static/img/main.jpg" style="width:100%; height:300px;">
           </div>
         </div>
         
         <!-- Left and right controls -->
         <a class="carousel-control-prev" href="#demo" data-slide="prev">
           <span class="carousel-control-prev-icon"></span>
         </a>
         <a class="carousel-control-next" href="#demo" data-slide="next">
           <span class="carousel-control-next-icon"></span>
         </a>
         
         <hr>      
      </div>
      
      <br><br>

      <select name="selectSort" id="selectSort" style="float:right; margin-right:200px;">      
           <option value=1 selected="selected">최신순</option>
           <option value=2 >인기순</option>
           <option value=3 >낮은가격순</option>
           <option value=4 >높은가격순</option>
      </select>

      <div>
      <div id="records" class='row oneMusic-albums'
         style="margin-top: 50px;">
      </div>

      <div class="container2">
         <ul class="pagination" id="paging" style="text-align:center;"></ul>
      </div>
      </div>
   </div>
   <!-- ##### Footer Area Start ##### -->
   <footer class="footer-area">
      <div class="container">
         <div class="footerc">
            <nav id="footercon">
               <a class="#" href="#">개인정보처리방침</a> | <a href="#" class="mbn">영상정보처리기기
                  운영관리 방침</a> | <a href="#">홈페이지 이용약관</a> | <a href="#" class="mbn">위치정보
                  이용약관</a> | <a href="#" class="mbn">CAFE-IN 이용약관</a> | <a href="#"
                  class="last">윤리경영 핫라인</a><br> <a class="btned_link"
                  href="/footer/etc/coming_route.do">찾아오시는 길</a> <a
                  class="btned_link" href="/footer/partnership/new_partner.do">신규입점제의</a>
               <a class="btned_link" href="/footer/etc/sitemap.do">사이트 맵</a><br>


               <ul class="copy_menu">
                  <li>사업자등록번호 000-00-00001</li>
                  <li>(주)CAFE-IN 코리아</li>
                  <li>TEL : 02) 1234-5678</li>
                  <li>개인정보 책임자 : 정준오</li>
               </ul>
               <span class="en">ⓒ 2019 Cafe-In Coffee Company. All Rights
                  Reserved.</span>
            </nav>
         </div>
      </div>
   </footer>
   <!-- ##### Footer Area End ##### -->

   <!-- jQuery-2.2.4 js -->
   <script src="../static/js/jquery/jquery-2.2.4.min.js"></script>
   <!-- Popper js -->
   <script src="../static/js/bootstrap/popper.min.js"></script>
   <!-- Bootstrap js -->
   <script src="../static/js/bootstrap/bootstrap.min.js"></script>
   <!-- All Plugins js -->
   <script src="../static/js/plugins/plugins.js"></script>
   <!-- Active js -->
   <script src="../static/js/active.js"></script>
</body>
</html>