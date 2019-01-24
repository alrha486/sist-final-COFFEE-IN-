<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="data" value="${data}" />
<!DOCTYPE html>
<html >

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>One Music - Modern Music HTML5 Template</title>

    <!-- Favicon -->
    <link rel="icon" href="static/img/core-img/favicon.ico">

    <!-- Stylesheet -->
   <script src="//code.jquery.com/jquery-1.12.4.js"></script>
  <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="static/css/bootstrap.css">
<link rel="stylesheet" href="static/style.css">
<link rel="stylesheet" href="static/css/custom.css">
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"  rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean" rel="stylesheet">

<script>
$(document).ready(function(){
  // document.getElementById('btnCart').addEventListener("click",cartAdd);
   document.getElementById('btnPurchase').addEventListener("click",purchase);
   document.getElementById('btnList').addEventListener("click",GoList);

});


function purchase(){ // 구매버튼
   var userid = '${sessionScope.userid}';
   if(userid == ''){ // 세션이 없다면
      alert("로그인 후 이용해주세요.");
      location.href="/coffee/login";
   }else{ // 세션이있다면
      var productInfo = "" + $("#productid").val() + "&"  +  $("#count").val() + "&" + $("#price").val() + "";
      location.href = "/coffee/product/purchase1/"+productInfo
   } 
}

function GoList(){ // 구매버튼
   location.href="/coffee/productList";
}

function cartAdd(){ // 장바구니 추가 ajax
var userid = '${sessionScope.userid}';
   if(userid == ''){
      alert("로그인 후 이용해주세요.");
      location.href="/coffee/login";
   }else{
      $.ajax({ // IF문 조건 다 거치면 회원가입 처리 AJAX 실행
         url : "/coffee/addCart", //회원가입 ajax
         dataType : "json",
         method : "POST",
         contentType : 'application/json; charset=UTF-8',
         data : JSON.stringify({
            "productid" : $("#productid").val(),
            "p_count" : $("#count").val(),
            "price1" : $("#price").val()
         }),
         success : function(data){
            if(data == 1) { // 성공시 true를 반환
               alert("장바구니에 추가되었습니다.");
            } else if(data == 0){
               alert("장바구니에 이미 존재하는 상품입니다.");
            } else {
               alert("입력실패");
            }
         },
         error : function(err){
            console.log("Error 발생 : " + err);
         }
      });
   } 
}

</script>
</head>
<body style="background-color:#fffdf4">

	<%	
		String id = null;
		String pname = null;
		
		String userid = String.valueOf(session.getAttribute("userid"));
		 if(session.getAttribute("userid") == null){
		} else if(session.getAttribute("userid") != null){
			
			
		id = String.valueOf(request.getAttribute("productid"));
		pname = id + "a";
		//pname = String.valueOf(request.getAttribute("pname"));
		Cookie cookie = new Cookie(userid + "%" + pname, id);    
		cookie.setMaxAge(24*60*60);
		cookie.setPath("/");
		response.addCookie(cookie);
		}	
	%>

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
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/main.jpg);">
        <div class="bradcumbContent" style="background-color:#fffdf4">
            <p>CAFE-IN</p>
            <h2>PRODUCT</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Events Area Start ##### -->
    <!-- home > shop > coffee > beans -->
    <!--LOCATION-->
      
   
        <section class="events-area section-padding-100">
        <div class="container">
           
                  
                     <h6>HOME > SHOP > COFFEE > BEANS<h6>
                  
            
            
         <hr color="black"/>
            
         <table class="table" style="text-align:center;" >
      <tr>
         <td rowspan=6 style="width:300px;height:300px" ><img src="static/img/product/${product.productname}.jpg" width=400 height=400/></td>
         <th style="width:150px;font-size:1.5em;vertical-align: middle;">상품 이름</th> <th style="width:200px;vertical-align: middle;font-size:1.3em;">${product.productname}</th>
      </tr>
      <tr>
         <th style="width:150px;font-size:1.5em;vertical-align: middle;">상품 정보</th> <th style="width:200px;vertical-align: middle;font-size:1.3em;"> ${product.productex}</th>
      </tr>
      <tr>
         <th style="width:150px;font-size:1.5em;vertical-align: middle;">가격 정보</th> <th style="width:200px;vertical-align: middle;font-size:1.3em;">${product.price}</th>
      </tr>
      <tr>
         <th style="width:150px;font-size:1.5em;vertical-align: middle;">   수량   </th> <th style="width:200px;vertical-align: middle;font-size:1.3em;"><input type="number" id="count" name="count" value="1" min="1" max="20"/></th>
      </tr>
      <tr>
         <th colspan=3 style="vertical-align: bottom;">
	         <button id="btnCart" type="button" style="min-width: 180px;" class="btn btn-outline-dark btn-lg" onclick="cartAdd();">장바구니에 추가하기</button>
	         <button id="btnPurchase" type="button" style="min-width: 180px;" class="btn btn-outline-dark btn-lg">구매하기 </button>
	         <button id="btnList" type="button" style="min-width: 180px;" class="btn btn-outline-dark btn-lg" >상품목록으로</button>
         </th>

      </tr>
   </table> 
         <input type="hidden" value="${product.price}" id="price" />
         <input type="hidden" value="${product.productid}" id="productid" />
   
   <br><br><br><br>
   <!-- 여기까지 -->
   
   <!-- 고객 상품평 -->
   <br><br>
   <h3>고객 상품평</h3>
   
   <%-- <%@include file="reviewTable.jsp" %> --%>
   <jsp:include page="reviewTable.jsp" flush="true">
   		<jsp:param name="productid" value="${product.productid}"/>
   </jsp:include>
   <br><br>
 
     
          
        </div>
    </section>   

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
      <div class="container">
        <div class="footerc">
           <nav id="footercon">
               <a class="#" href="#">개인정보처리방침</a> |
               <a href="#" class="mbn">영상정보처리기기 운영관리 방침</a> |
               <a href="#">홈페이지 이용약관</a> |
               <a href="#" class="mbn">위치정보 이용약관</a> |
               <a href="#" class="mbn">CAFE-IN 이용약관</a> |
               <a href="#" class="last">윤리경영 핫라인</a><br>
               
               
               
               <a class="btned_link" href="/footer/etc/coming_route.do">찾아오시는 길</a>
               <a class="btned_link" href="/footer/partnership/new_partner.do">신규입점제의</a>
               <a class="btned_link" href="/footer/etc/sitemap.do">사이트 맵</a><br>

         
               <ul class="copy_menu">
                  <li>사업자등록번호 000-00-00001</li>
                  <li>(주)CAFE-IN 코리아</li>
                  <li>TEL : 02) 1234-5678</li>
                  <li>개인정보 책임자 : 정준오</li>
               </ul>
               <span class="en">ⓒ 2019 Cafe-In Coffee Company. All Rights Reserved.</span>
            </nav>
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
    <!-- 버튼 동작에 필요한 함수들 -->
</body>

</html>