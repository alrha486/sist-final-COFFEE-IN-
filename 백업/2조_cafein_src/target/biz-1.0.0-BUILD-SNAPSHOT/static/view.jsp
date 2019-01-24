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
    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
<script src="static/js/jquery.min.js"></script>
<script>
$(document).ready(function(){
	document.getElementById('btnCart').addEventListener("click",cartAdd);
	document.getElementById('btnPurchase').addEventListener("click",purchase);
	document.getElementById('btnList').addEventListener("click",GoList);
});
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
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/hotchoco.jpg);">
        <div class="bradcumbContent">
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
            
         <table class="table">
      <tr>
         <td rowspan=5><img src="static/img/product/${data.productname}.jpg" width=400 height=400/></td>
         <th>상품 이름</th> <th>${data.productname}</th>
      </tr>
      <tr>
         <th>상품 정보</th> <th>${data.productex}</th>
      </tr>
      <tr>
         <th>가격 정보</th> <th>${data.price}</th>
      </tr>
      <tr>
         <th>   수량   </th><th><input type="number" id="count" name="count" value="1" min="1" max="20"/></th>
      </tr>
      <tr>
         <th><button id="btnCart" type="button" class="btn btn-lg">장바구니에 추가하기</button></th>
         <th><button id="btnPurchase" type="button" class="btn btn-lg">구매하기 </button></th>
      </tr>
   </table> 
   		<input type="hidden" value="${data.price}" id="price" />
   		<input type="hidden" value="${data.productid}" id="productid" />
   <table class="table">
      <tr>
         <td>
            <button id="btnList" type="button" class="btn pull-right">상품목록으로</button>
         </td>
      </tr>
   </table>
   
   <!-- 여기까지 -->
   
   <!-- 고객 상품평 -->
   <br><br>
   <h3>고객 상품평</h3>
   
   
   <table class="table mytable">

  <tr>
    <td>번호</td>
    <td>제목</td>
    <td>작성자</td>
    <td>날짜</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
     <td>1</td>
    <td>배송에 문제가 있습니다</td>
    <td>ㅇㅇㅇㅇㅇ</td>
    <td>2017.12.7</td>
    <td><a class="showmore">리뷰 내용 더보기</a></td>
  <tr class="detail">
    <td colspan="3">
      <div>
        <table class="table">
          <tr>
          <td>
           배송좀 제대로 해 주세요<br>
           물건이 너무 늦게 왔네요...
           </td>
          </tr>
        </table>       
      </div>
    </td>
  </tr>
  
  <tr>
     <td>2</td>
    <td>너무 맛있어요~</td>
    <td>작성자맨</td>
    <td>2017.12.13</td>
    <td><a class="showmore">리뷰 내용 더보기</a></td>
  <tr class="detail">
    <td colspan="3">
      <div>
        <table class="table">
          <tr>
          <td>
           또 주문했네요 다음에도 잘 부탁드립니다!<br>
           </td>
          </tr>
        </table>       
      </div>
    </td>
  </tr>
  
</table>
<button type="button" class="btn pull-right" id="btnWrite">리뷰 쓰기</button>
     
          
        </div>
    </section>   
       
    <!-- ##### Events Area End ##### -->
    
    

  

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="#"><img src="static/img/core-img/logo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
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
    <script src="static/js/jquery/jquery-2.2.4.min.js"></script>
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