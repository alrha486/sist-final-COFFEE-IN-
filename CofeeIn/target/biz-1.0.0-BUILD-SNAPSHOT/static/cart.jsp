<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
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
	$.ajax({ // 쇼핑카트 list
		url : "cartList", 
		method : "GET",
		success : function(data){
			var result = data.data;
			var str = "";
			if(result.length <= 0){
				//alert("장바구니가 비어있습니다.");
			}else{				
				for(var i=0;i<result.length; i++){					
					str +=  "<tr>";
					str +=  "<td><input type='checkbox' value="+ result[i].cartidx +" name='chk'></td>";
					str += "<td><img style='width:100px' src='static/img/product/" + result[i].productimg + "'></td>";
					str +=  "<td>" + result[i].productname + "</td>";
					str +=  "<td>" + result[i].price1 + "</td>";  
					str += "<td><input type='number' min='1' max='50' id='"+result[i].price1+"'  value='"+result[i].p_count +"' name='"+result[i].cartidx+"'>&nbsp;&nbsp;";
					str += "<button style='height: 30px' class='btn btn-outline-dark' onclick='p_countChange();' id='"+result[i].cartidx+"'>수정</button></td>";			
					str +=  "<td name='cartidx' id='cartidx'>" +result[i].price1*result[i].p_count +"</td>";
				 	str +=  "<tr>";				 	
				}
				
				$("#result").html(str);
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
}); // ready 끝
////////////////////////////////////////////////////////////////////////////////////READY 끝
   $(function(){	   
	   $("#btnShopping").bind('click',function(){ // 쇼핑계속하기
		     location.href="/coffee/productList";
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
	   $("#btnDelete").bind('click',function(){ // 선택상품 삭제
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
										str +=  "<td><input type='checkbox' value="+ result[i].cartidx +" name='chk'></td>";
										str += "<td><img style='width:100px' src='static/img/product/" + result[i].productimg + "'></td>";
										str +=  "<td>" + result[i].productname + "</td>";
										str +=  "<td>" + result[i].price1 + "</td>";  
										str += "<td><input type='number' min='1' max='50' id='"+result[i].price1+"' value='"+result[i].p_count +"' name='"+result[i].cartidx+"'>&nbsp;&nbsp;";
										str += "<button style='height: 30px' class='btn btn-outline-dark' onclick='p_countChange();' id='"+result[i].cartidx+"'>수정</button></td>";			
										str +=  "<td name='cartidx' id='cartidx'>" +result[i].price1*result[i].p_count +"</td>";
									 	str +=  "<tr>";		
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

///////선택상품구매 함수 시작//////
 $("#btnPurchase").bind('click',function(){ // 선택상품 삭제
		   var chk = document.getElementsByName("chk"); // 체크박스객체를 담는다
		   var len = chk.length;    //체크박스의 전체 개수
		   var checkRow = '';      //체크된 체크박스의 value를 담기위한 변수
		   var checkCnt = 0;        //체크된 체크박스의 개수
		   var checkLast = '';      //체크된 체크박스 중 마지막 체크박스의 인덱스를 담기위한 변수
		   var rowid = '';             //체크된 체크박스의 모든 value 값을 담는다
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
						rowid += '' + checkRow + ''; // rowid값(productid) 초기화
					} else { //체크된 체크박스의 개수가 여러 개 일때,
						if (i == checkLast) { //체크된 체크박스 중 마지막 체크박스일 때,
							rowid += checkRow; //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
						} else {
							rowid += checkRow + '&' ; //'value',의 형태 (뒤에 ,(콤마)가 붙게)         			
						}
					}
					cnt++;
					checkRow = ''; //checkRow초기화.
				}
			}
		   if(checkCnt ==0){
			   alert("상품을 체크해주세요");
			   return false;
		   }
///////////////////////////////////선택상품 구매 ajax 시작//////////////////////////////////////////////		   
		   location.href ="product/purchase/"+rowid;
///////////////////////////////////선택상품 구매 ajax 끝//////////////////////////////////////////////			
		});

//////선택상품구매 함수 끝///////

		
	});

function p_countChange(){ // 장바구니 수량 변경
	var cartid = event.srcElement.id; // 장바구니 번호
	var chageCount =$("input[name="+cartid+"]").val(); // 수정할 수량	
	var price = $("input[name="+cartid+"]").attr('id');
	var price1 = price * chageCount;
	$.ajax({
		url : "/coffee/cartDetailUpdate",
		method : "PUT",
		data : JSON.stringify({
			"cartidx" : cartid,
			"p_count" : chageCount,
			"price" : price1
		}),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function (data){
			if(data.code){ // 업데이트 성공하면
				$.ajax({ // 쇼핑카트 list
					url : "/coffee/cartList", 
					method : "GET",
					success : function(data){
						var result = data.data;
						var str = "";
						if(result.length <= 0){
							alert("장바구니가 비어있습니다.");
						}else{
							for(var i=0;i<result.length; i++){
								str +=  "<tr>";
								str +=  "<td><input type='checkbox' value="+ result[i].cartidx +" name='chk'></td>";
								str += "<td><img style='width:100px' src='static/img/product/" + result[i].productimg + "'></td>";
								str +=  "<td>" + result[i].productname + "</td>";
								str +=  "<td id='"+result[i].price1+"'>" + result[i].price1 + "</td>";  
								str +=  "<td><input type='number' min='1' max='50' value='"+result[i].p_count +"' name='"+result[i].cartidx+"'>&nbsp;&nbsp;";
								str +=  "<button style='height: 30px' class='btn btn-outline-dark' onclick='p_countChange();' id='"+result[i].cartidx+"'>수정</button></td>";			
								str +=  "<td name='cartidx' id='cartidx'>" +result[i].price1*result[i].p_count +"</td>";
							 	str +=  "<tr>";		
							}					
							$("#result").html(str);
						} // else문 끝
					},
					error : function(err){
						console.log("Error 발생 : " + err);
					}
				});
			}
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});		
}
</script>
<!-- Title -->
<title>카페-인 | CART</title>

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
         <h2>CART</h2>
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
                             <th style="width:10%">이미지</th>
                             <th style="width:20%">상품명</th>
                             <th style="width:10%">판매가</th>
                             <th style="width:23%">수량</th>
                             <th style="width:10%">소계금액</th>
                           </tr>
                  	</thead>
						
						<tbody id="result">
                  		</tbody>                  	                   
                     </table>                  
            	</form>
               <button style="height: 30px" class="btn btn-outline-dark" id="selectAll">전체선택</button>
               <button style="height: 30px" class="btn btn-outline-dark" id="btnDelete">선택상품삭제</button>
               <button style="position: relative;  height: 30px" class="btn btn-outline-dark" id="btnPurchase">선택상품구매</button>
               <button style="position: relative;  height: 30px" class="btn btn-outline-dark" id="btnShopping"> 쇼핑계속하기</button>                              
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


