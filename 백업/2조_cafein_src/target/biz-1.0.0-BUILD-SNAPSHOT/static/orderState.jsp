<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="static/js/jquery.min.js"></script>
<script>
$(document).ready(function(){	
	$.ajax({ // 주문 이력 LIST 조회하는 AJAX
		url : "/coffee/mypage/orderStates", 
		method : "GET",
		success : function(data){
			var result = data.data;			
			var str = "";
			//var equal_count = 0;
			//var notEqual_count = 0;
			var o_state;
			if(result.length <= 0){ // 주문 이력이 없다면 
				str +=  "<tr><td>주문 내역이 없습니다.</td></tr>";
			}else{ // 주문 이력이 있다면				
				for(var i=0;i<result.length; i++){
				//alert(result[i].orderid);
					if(i==0){ // i 가 0일때는 		
						if(result[i].o_state == 1){ result[i].o_state = '배송준비중'; }
					
						str +=  "<tr>";
						str +=  "<td><input type='checkbox' value="+ result[i].orderid +" name='chk'></td>";
						str +=  "<td>"+ result[i].selldate + "(" +result[i].orderid + ")";
						str +=  "<input type='button'  id='"+result[i].orderid +"' value='구매상세보기' onclick='return orderview("+result[i].orderid +")'></td>";
						str +=  "<td><img style='width:100px' src='static/img/product/" + result[i].productimg + "'>";
						str +=  result[i].productname + "<span id='"+ result[i].orderid+"'></span></td>";
						str +=  "<td>" + result[i].totalprice + "</td>"; // 실 결제 가격 
						str +=  "<td>" + result[i].o_state + "<input type='button' value='배송조회'></td>";
						str +=  "</tr>";
					}
					
					else if(i !=0){ // i가 0이 아닐 때
						
						if(result[i-1].orderid == result[i].orderid){// 같은 주문번호면 표시하지 않음
							//equal_count++;
						}else{ // 주문번호가 다르면 표시
							if(result[i].o_state == 1){ result[i].o_state = '배송준비중'; }
							//$('#equal').html("  외 "+equal_count + "개"); // 찍어주고
							//equal_count = 0;  // 0으로 초기화
								
							str +=  "<tr>";
							str +=  "<td><input type='checkbox' value="+ result[i].orderid +" name='chk'></td>";
							str +=  "<td>"+ result[i].selldate + "(" +result[i].orderid + ")";
							str +=  "<input type='button'  id='"+result[i].orderid +"' value='구매상세보기' onclick='return orderview("+result[i].orderid +")'></td>";
							str +=  "<td><img style='width:100px' src='static/img/product/" + result[i].productimg + "'>";
							str +=  result[i].productname + "<span id='"+ result[i].orderid+"'></span></td>";
							str +=  "<td>" + result[i].totalprice + "</td>";
							str +=  "<td>" + result[i].o_state + "<input type='button' value='배송조회'></td>";  							
						 	str +=  "</tr>";
						}
					} 		 														
				}//for문 끝				
				$("#result").html(str);	
//				$('#equal').html("  외 "+equal_count + "개");


			} // else문 끝
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); 

	document.getElementById('logoutBtn').onclick = function(){ // 로그아웃버튼
		$.ajax({ 
			url : "logout", //회원가입 ajax
			method : "GET",
			success : function(data){
				if(data == 1) { // 성공시 1를 반환
					location.href = "/coffee/";
				} else{
					alert("로그아웃 실패");
				}
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	}	
	
}); 
////////////////////////////////////////////////////////////////////////////////////READY 끝
function orderview(orderid){ // 구매상세 눌렀을 떄 
	 window.open("/coffee/mypage/orderView/" + orderid, "Coupon", "width=1350, height=800,top=100, left=350, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
}
   $(function(){	   		
	   $("#btnMypage").bind('click',function(){ // 쇼핑계속하기
		     location.href="/coffee/mypage";
		});

	   var check = false; // 전체선택을 위한 전역변수
	   $("#selectAll").bind('click',function(){ // 전체선택   
			var chk = document.getElementsByName("chk");
			if (check == false) {
				check = true;
				for (var i = 0; i < chk.length; i++) {
					chk[i].checked = true; //모두 체크
				}
			} else {
				check = false;
				for (var i = 0; i < chk.length; i++) {
					chk[i].checked = false; //모두 해제
				}
			}
		});	   
//////////////////////////////////////////////////////////////////////////////////////////
	   $("#btnDelete").bind('click',function(){ // 선택주문 삭제
		   var chk = document.getElementsByName("chk"); // 체크박스객체를 담는다
		   var len = chk.length;    //체크박스의 전체 개수
		   var checkRow = '';      //체크된 체크박스의 value를 담기위한 변수
		   var checkCnt = 0;        //체크된 체크박스의 개수
		   var checkLast = '';      //체크된 체크박스 중 마지막 체크박스의 인덱스를 담기위한 변수
		   var rowid = 0;             //체크된 체크박스의 모든 value 값을 담는다
		   var cnt = 0;
		   
		   for(var i=0; i<len; i++){
			   if(chk[i].checked == true){
			   checkCnt++;        //체크된 체크박스의 개수
			   checkLast = i;     //체크된 체크박스의 인덱스
			   }
		   } 
		   for(var i=0; i<len; i++){

			if (chk[i].checked == true) { //체크가 되어있는 값 구분
					checkRow = chk[i].value;
					if (checkCnt == 1) { //체크된 체크박스의 개수가 한 개 일때,
						rowid = checkRow; // rowid값(productid) 초기화
					} else { //체크된 체크박스의 개수가 여러 개 일때,
						if (i == checkLast) { //체크된 체크박스 중 마지막 체크박스일 때,
							rowid = checkRow ; //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
						} else {
							rowid = checkRow ; //'value',의 형태 (뒤에 ,(콤마)가 붙게)         			
						}
					}
					cnt++;
					checkRow = ''; //checkRow초기화.
					
			$.ajax({ // 반복문 거치면서 ajax실행
				url : "DeleteCart/"+rowid, //장바구니 삭제ajax
				method : "DELETE",				
				success : function(data){
					if(data.code){
////////////////////////////////////////////////////List 불러오는 ajax////////////////////////////////						
						$.ajax({ // 쇼핑카트 list
							url : "cartList", 
							method : "GET",
							success : function(data){
								var result = data.data;
								var str = "";
								if(result.length <= 0){
									alert("장바구니가 비어있습니다.");
								}else{
									for(var i=0;i<result.length; i++){
										str +=  "<tr>";
										str +=  "<td><input type='checkbox' value="+ result[i].orderid +" name='chk'></td>";
										str +=  "<td>"+ result[i].selldate + "(" +result[i].orderid + ")";
										str +=  "<input type='button' value='구매상세보기'></td>";
										str +=  "<td><img style='width:100px' src='static/img/product/" + result[i].productimg + "'>";
										str +=  result[i].productname + "외 몇개</td>";
										str +=  "<td>" + result[i].price + "</td>";
										str +=  "<td>" + result[i].o_state + "</td>";  							
									 	str +=  "</tr>";		
									}
								
									$("#result").html(str);
								} // else문 끝
							},
							error : function(err){
								console.log("Error 발생 : " + err);
							}
						});
/////////////////////////////////////////////////다시 불러오는 ajax끝////////////////////////////////////////////////////////////						
					}
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
				}
			}
		});
///////////////////////////선택상품삭제 끝///////////////////////////////////////////////////////////

	});
</script>		  
		  
<!-- Title -->
<title>카페-인 | OrderState</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

<!-- Stylesheet -->
<link rel="stylesheet" href="static/style.css">

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
   <header class="header-area">
      <!-- Navbar Area -->
      <div class="oneMusic-main-menu">
         <div class="classy-nav-container breakpoint-off">
            <div class="container">
               <!-- Menu -->
               <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                  <!-- Nav brand -->
                  <a href="/coffee/" class="nav-brand"><img src="static/img/core-img/logo2.png" alt=""></a>

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
                           <li><a href="/coffee/">Home</a></li>
                           <li><a href="#">About</a></li>
                           <li><a href="/coffee/productList">Shop</a>
                              <ul class="dropdown">
                                 <li><a href="#">Coffee</a>
                                    <ul class="dropdown">
                                       <li><a href="#">Beans</a></li>
                                       <li><a href="#">Bottle coffee</a></li>
                                       <li><a href="#">Drip bag</a></li>
                                    </ul></li>
                                 <li><a href="index.html">Foods</a>
                                    <ul class="dropdown">
                                       <li><a href="#">Cake</a></li>
                                       <li><a href="#">Bakery</a></li>
                                       <li><a href="#">Sandwich</a></li>
                                    </ul></li>
                                 <li><a href="index.html">Goods</a>
                                    <ul class="dropdown">
                                       <li><a href="#">Mug/Tumbler</a></li>
                                       <li><a href="#">Coffee goods</a></li>
                                       <li><a href="#">Accessory</a></li>
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

                        <div class="login-register-cart-button d-flex align-items-center">
                           <div class="login-register-btn mr-50">
                              <a id="logoutBtn">Logout</a>
                           </div>
                           <div class="login-register-btn mr-50">
                              <a href="login.html" id="loginBtn">Mypage</a>
                           </div>
                           <div class="login-register-btn mr-50">
                              <a href="#" id="searchBtn"><img src="//image.istarbucks.co.kr/common/img/common/icon_magnifier_white.png"></a>
                           </div>

                           <!-- Cart Button -->
                           <div class="cart-btn">
                              <a href="/coffee/cart" id="cartBtn">
                                 <p>
                                    <span class="icon-shopping-cart"></span> <span
                                       class="quantity">1</span>
                                 </p>
                              </a>
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
   <!-- ##### Header Area End ##### -->

   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay"
      style="background-image: url(static/img/bg-img/aaa.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>주문조회</h2>
      </div>
   </section>
   <!-- ##### Breadcumb Area End ##### -->



   <!--장바구니 페이지  Start -->


   <section class="contact-area section-padding-100-0">
      <div class="container">
                  <div style="padding-top:50px" >

                 <form action="cart" id="myform">    
                     <table class="table table-hover" style="text-align:center">
                     <thead>
                        <tr>                       
                             <th style="width:5%">선택</th>
                             <th style="width:10%">주문일(주문번호)</th> <!-- 주문 일 ( 주문번호 ) + 구매상세보기(버튼)-->
                             <th style="width:50%">상품/수량</th> <!-- 상품사진 + 상품명 + 수량  외 몇개-->
                             <th style="width:10%">결제금액</th> <!--  totalPrice -->
                             <th style="width:10%">상태</th> <!-- 주문상태 + 배송조회버튼 -->                             
                           </tr>
                  	</thead>
						
						<tbody id="result">
                  		</tbody>                  	                   
                     </table>                  
            	</form>
               <button style="height: 30px" class="btn btn-outline-dark" id="selectAll">전체선택</button>
               <button style="height: 30px" class="btn btn-outline-dark" id="btnDelete">선택주문취소</button>
               <button style="position: relative;  height: 30px" class="btn btn-outline-dark" id="btnMypage">뒤로가기</button>                              
</section>
   
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


