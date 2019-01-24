<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>카페-인 | Coupon</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

<!-- Stylesheet -->
<link rel="stylesheet" href="static/style.css">

<script src="static/js/jquery.min.js"></script>
<script>
$(document).ready(function(){	

	$.ajax({ 
		url : "selectUserCoupon", // 사용자가 가지고있는 쿠폰조회
		method : "GET",
		success : function(data){
			var result = data.data;
			var str = "";
			if(result.length == 0){ // 유저가 가지고 있는 쿠폰이 아무것도 없을 떄
		           str +="<div class='single-event-area mb-30'>";
		           str +="<div class='event-text'>";
		           str +="<h4>사용가능한 쿠폰이 없습니다.</h4>";  
		           str +="</div>";
		           str +="</div>";
			}else{			
				var useCouponNum = opener.document.getElementById('hiddenCoupon').value;
	 			for(var i=0; i<result.length; i++){ 
	 				if(useCouponNum == result[i].couponNum){ // 이미 사용누르고 다시 들어왔을 때 
	 				}else{
			           str +="<div class='single-event-area mb-30'>";
			           str +="<div class='event-text'>";
			           str +="<h4>" + result[i].c_name +"</h4>";
			           str +="<div class='event-meta-data'>";
			           str +="<a  class='event-place id='discount'>"+result[i].c_discount + "</a>";
			           str +="<a class='event-date'>" + result[i].c_dead + "</a><br/>";
			           str +="</div>";
			           str +="<div class='event-meta-data'>";
			           str +="<a class='event-date'>"+ result[i].c_content + "</a>";
			           str +="</div>";
			           str +="<a class='btn see-more-btn' name = '"+result[i].c_discount+"'  id='"+result[i].couponNum+"' onclick='useCoupon();'>사용하기</a>";
			           str +="</div>";
			           str +="</div>";
	 				}
			 	 } 
			}
			$('#result').html(str);
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); // ajax 끝
	
	
	$('#btnCancle').bind('click',function(){ // 취소 눌렀을 시 
		self.close(); 
	});
	
	
}); // document.ready 끝
function useCoupon(){ // 쿠폰 사용 눌렀을 때
	var couponNum = event.srcElement.id; // 선택한쿠폰 번호
	$.ajax({ 
		url : "/coffee/selectCoupon/" + couponNum, // 사용자가 가지고있는 쿠폰조회
		method : "GET",
		success : function(data){
			var result = data.data;
			var condition = opener.$('#sum').val(); // 상품 전체가격
			if(result[0].c_condition > condition){ // 쿠폰 조건 위반
				alert(result[0].c_condition + "원 이상 구매 시 사용가능 한 쿠폰입니다.");
				return false;
			}else{ // 쿠폰 조건 위반x
				
				var couponNum = result[0].couponNum; // 쿠폰번호
				var discount = result[0].c_discount; // 할인 금액
				
				opener.document.getElementById('couponss').innerHTML = discount; // 초기화
				opener.document.getElementById('couponss').value = discount; // 초기화
				
				var a = 0; //전역변수
				/////////////////////////////////////////////////////////////////////////////////////////////
					$.ajax({ 
						url : "selectUserCoupon", // 사용자가 가지고있는 쿠폰조회
						method : "GET",
					    async:false,
						success : function(data){
							var result = data.data;
							var useCouponNum = opener.document.getElementById('hiddenCoupon').value;
							for(var i=0;i<result.length; i++){
								if(useCouponNum == result[i].couponNum){
								a = result[i].c_discount;
								}
							}
						},
						error : function(err){
							console.log("Error 발생 : " + err);
						}
					}); // ajax 끝
				/////////////////////////////////////////////////////////////////////////////////////////////
				//alert(a);

						var totalPrice = opener.document.getElementById('total').value; // 주문페이지의 total 값 				
						opener.document.getElementById('total').value = totalPrice - discount + a;
						opener.document.getElementById('total').innerHTML = (totalPrice - discount + a);

				
				opener.document.getElementById('couponNum').value = couponNum;
				opener.document.getElementById('hiddenCoupon').value = couponNum;
				self.close(); // 쿠폰창 닫고
			}
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); // ajax 끝 */

}

</script>
</head>

<body>
<br>
      <!-- ##### Breadcumb Area Start ##### -->
   <section
      style="text-align: center">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>COUPON</h2>
         <h6>< 쿠폰은 하나만 사용 가능합니다. ></h6>
      </div>
   </section>
    <section class="events-area section-padding-100">  
        <div class="container">     
            <div class="row">
            <p style="margin: auto;">
               
            </p>
            
                <!-- 쿠폰 각각 -->
                <div class="col-12 col-md-6 col-lg-4" id ="result"> <!-- ajax로 여기에 쿠폰이 들어옴 -->
                </div>

                 </div>
                 </div>
</section>
   <div style="text-align: center;">
         <input type="button" class="btn oneMusic-btn"  id="btnCancle" value="닫기">
   </div>


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


