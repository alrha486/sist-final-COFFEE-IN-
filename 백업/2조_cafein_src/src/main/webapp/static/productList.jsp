<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<link rel="stylesheet" href="static/style.css">
<link rel="stylesheet" href="static/css/bootstrap.css">
<link rel="stylesheet" href="static/css/custom.css" />
<link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"  rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean" rel="stylesheet">
    
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <script src="//code.jquery.com/jquery-1.12.4.js"></script>
  <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
   var page = null;
   $(document).ready(function() {
	   
	      $.ajax({
	          url : "/coffee/productLists/COFFEE/1",
	          dataType : "json",
	          method : "GET",
	          success : function(data) {
	  		       display(data);

	          }
	       });
	      
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
         method : "GET",
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
         method : "GET",
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
         method : "GET",
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
         method : "GET",
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
            str += "<a href='/coffee/view/"+ productid + "'>";
            str += "<div class='scale'><img src='static/img/product/"+productname+".jpg'></div>";
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
<!-- Title -->
<title>카페-인 | CART</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

<!-- Stylesheet -->

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
      <!-- Navbar Area -->
   <!-- ##### Header Area End ##### -->




   <!--장바구니 페이지  Start -->


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
   
   <!-- ##### Contact Area End ##### -->


   <div class="col-12 col-lg-3" align="right">
      <div class="contact-content mb-100">
         <!-- Contact Social Info -->
         <div class="contact-social-info mt-50">
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Pinterest"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Dribbble"><i class="fa fa-dribbble" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Behance"><i class="fa fa-behance" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Linkedin"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
         </div>

      </div>
   </div>
   </section>
   <!-- ##### Contact Area End ##### -->

   <!-- ##### Footer Area Start ##### -->
   <footer class="footer-area">
      <div class="container">
         <div class="row d-flex flex-wrap align-items-center">
            <div class="col-12 col-md-6">
               <a href="index.html"><img src="static/img/core-img/logo3.png" alt="" width="20%"></a>
               <p class="copywrite-text">
                  <a href="#">
                     <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                     Copyright &copy;<script>
                        document.write(new Date().getFullYear());
                     </script>
                     All rights reserved | This template is made with <i
                     class="fa fa-heart-o" aria-hidden="true"></i> by <a
                     href="https://colorlib.com" target="_blank">Colorlib</a> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
               </p>
            </div>

            <div class="col-12 col-md-6">
               <div class="footer-nav">
                  <ul>
                     <li><a href="#">Home</a></li>
                     <li><a href="#">Albums</a></li>
                     <li><a href="#">Events</a></li>
                     <li><a href="#">News</a></li>
                     <li><a href="#">Contact</a></li>
                  </ul>
               </div>
            </div>
         </div>
      </div>
   </footer>
   <!-- ##### Footer Area Start ##### -->

   <!-- ##### All Javascript Script ##### -->
   <!-- jQuery-2.2.4 js -->
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


