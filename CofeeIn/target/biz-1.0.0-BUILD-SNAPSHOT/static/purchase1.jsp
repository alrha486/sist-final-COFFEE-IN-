<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="productInfo" value="${productInfo}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Cafe-In</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/favicon.ico">
<link rel="stylesheet" href="static/style.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"  rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean" rel="stylesheet">

<link rel="stylesheet" href="static/style.css">
<link rel="stylesheet" href="static/css/bootstrap.css">

<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
}
.choose {
   font-family: "Nanum Gothic", sans-serif;

}

.totalPrice{
 bordercolor:"#D5D5D5";
     overflow: hidden;
    padding: 40px 100px 40px 40px;
    border: 6px solid rgb(232,232,232);
        padding: 30px 0px 30px 10px;
}

dl {font-family: "Nanum Gothic", sans-serif;
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}

.totalPrice dt {
    margin-bottom: 5px;
    font-family: "Nanum Gothic", sans-serif;
    font-size: 15px;
}

.totalPrice dl {
    float: left;
    padding-left: 55px;
    display: inline-block;
    color: rgb(51,51,51);
}

.totalPrice dd {
   font-family: "Nanum Gothic", sans-serif;
    font-size: 30px;
    line-height: 32px;
}

.totalPrice .couponss {
    margin-left: 55px;
    background: url(static/img/minus.png) no-repeat 0 50%;
    background-size: 40px;
}

.totalPrice .savingss {
    margin-left: 55px;
    background: url(static/img/minus.png) no-repeat 0 50%;
    background-size: 40px;
}

.totalPrice .delivery {
    margin-left: 55px;
    background: url(static/img/plus.png) no-repeat 0 50%;
    background-size: 40px;
}
.totalPrice .total {
    margin-left: 55px;
    background: url(static/img/equal.png) no-repeat 0 50%;
    background-size: 40px;
}


.totalPrice .total dd {
    font-family: "Nanum Gothic", sans-serif;
    color: rgb(207,102,26);
}

p.d {
   font-family: 'Nanum Gothic', sans-serif;
   font-family: 'Noto Serif KR', serif;
   font-family: 'East Sea Dokdo', cursive;
   font-family: 'Black Han Sans', sans-serif;
   font-family: 'Do Hyeon', sans-serif;
   font-size: 30px;
}
p.d2 {
   font-family: 'Nanum Gothic', sans-serif;
   font-family: 'Noto Serif KR', serif;
   font-family: 'East Sea Dokdo', cursive;
   font-family: 'Black Han Sans', sans-serif;
   font-family: 'Do Hyeon', sans-serif;
   font-size: 20px;
}

</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="static/js/jquery.min.js"></script>
<script>
$(document).ready(function(){ 
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/userInfoSelect", // 세션으로 유저 정보 가져오기
		method : "GET",
		success : function(data){			
			var result = data.data;			
			$('#txtName').val(result[0].username);
			$('#txtTel').val(result[0].tel);
			$('#txtEmail').val(result[0].email);
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});
/////////////////////페이지 로드될 때 회원 정보 알 수 있게하는 ajax	
	
	
	var productInfo = '${productInfo}';
	var array = new Array();
	array = productInfo.split('&');
	var str = "";
	var totalPrice =0; // 합계
    		$.ajax({  // 길이만큼 반복하면 ajax
    			url : "/coffee/productInfoSelect1/" +array[0],
    			method : "GET",
    			success : function(data){			
    				var result = data.data;
    				str += "<tr>";
    				str += "<td>" + result[0].productname + "</td>" ;
    				str += "<td><img width='100px' src='static/img/product/"+result[0].productimg+"'></td>";
    				str += "<td>" + array[1] + "</td>";  // 상품 수량
    				str += "<td>" + array[2] + "</td>"; // 상품 가격
    				str += "<td>" + array[1] * array[2] + "</td>"; // 수량 x 가격
    				str += "</tr>";
    				$('#result1').html(str); // body에 뿌려주기
    				
    				totalPrice = array[1] * array[2]; // 수량 x 가격 (장바구니결제x, 직접구매(상품 1개))
    				
    				if(totalPrice >= 30000){ // 총금액이 3만원 이상이면 배송비면제
    					$('#delivery').html(0);
    					$('#delivery').val(0);
    					$('#sum').html(totalPrice);
    					$('#sum').val(totalPrice);
    					$('#total').html(totalPrice);
    					$('#total').val(totalPrice);
    					
    					$('#savingss').val(0);
    					$('#couponss').val(0);
    				}else{ // 총금액이 3만원 미만일 시 배송비 3천원 추가
    					$('#delivery').html(3000);
    					$('#delivery').val(3000);
    					$('#sum').html(totalPrice);
    					$('#sum').val(totalPrice);
    					$('#total').html(totalPrice + 3000);
    					$('#total').val(totalPrice + 3000);
    					$('#savingss').val(0);
    					$('#couponss').val(0);
    				}
    				
    				//alert($('#sum').val());
    			},
    			error : function(err){
    				console.log("Error 발생 : " + err);
    			}
    		});

	
	
	
	
    		$('#viewCoupon').bind('click',function(){ // 쿠폰보기 버튼 클릭
    			 window.open("/coffee/coupon", "Coupon", "width=800, height=800 top=100, left=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  		 
    		})
    		
    		$('#viewSavings').bind('click',function(){ // 적립금 보기 버튼 클릭
    			 window.open("/coffee/savings", "Savings", "width=1000, height=500 top=180, left=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  		 
    		})
    		
    		$('#cancelCoupon').bind('click',function(){ // 쿠폰사용취소
    			
    
    			  $('#couponss').html(0); // 초기화
    			  $('#couponss').val(0); // 초기화
    			  $('#couponNum').val(0); // 초기화
    			  $('#hiddenCoupon').val(0); // 초기화
    			  var sum = parseInt($('#sum').val());
    			  var saving = parseInt($('#savingss').val()); // 요놈이 문제
    			  var delivery = parseInt($('#delivery').val());
    			  
    			  var totalPrice = sum - saving + delivery;  			  
    			  $('#total').html(totalPrice);
    			  $('#total').val(totalPrice);  			  
    		})
    		
    		$('#cancelSaving').bind('click',function(){ // 적립금 사용 취소 
    			  $('#savingss').val(0);
    			  $('#savingss').html(0);
    			  $('#savingsss').val(0);
    			  $('#hiddenSaving').val(0);
    			  var sum = parseInt($('#sum').val());
    			  var coupon = parseInt($('#couponss').val());
    			  var delivery = parseInt($('#delivery').val());
    			  
    			  var totalPrice = sum - coupon + delivery;  			  
    			  $('#total').html(totalPrice);
    			  $('#total').val(totalPrice);
    		})
	
	
	
}); // document.ready 끝.

$(function(){
$('#zipSearch').click(function(){ // 다음 주소 api 사용
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('address1').value = fullRoadAddr;
            document.getElementById('address2').value = "";

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;


            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;

            }
        }
    }).open();
});
});

window.addEventListener('load', setup); // 윈도우가 로딩되면 setup 함수 실행

function setup(){
	document.getElementById("checkbox").addEventListener('change', mychange);// 쿠폰보기 버튼 이벤트추가
	document.getElementById("btnPayment").addEventListener('click', payment);// 쿠폰보기 버튼 이벤트추가
}	

	
function payment(){ //결제버튼 눌렀을 때
	if($('#username').val() == ""){
		alert("수신자 이름을 입력해주세요.");
		return false;
	}else if($('#tel').val() == ""){
		alert("전화번호를 입력해주세요.");
		return false;
	}else if($('#zipcode').val() == ""){
		alert("주소를 입력해주세요.");
		return false;
	}else if($('#address2').val() == ""){
		alert("상세 주소를 입력해주세요.");
		return false;
	}
	var checkval = $("input:radio[name='radio']:checked").val();
	if(checkval != 1 && checkval != 2 && checkval != 3 && checkval != 4){
		alert("결제수단을 선택해주세요.");
		return false;
	}

	
	var discount_price = $('#discount').val();
	
	 	$.ajax({ // 결제 
			url : "/coffee/payment", //구매 ajax
			dataType : "json",
			method : "POST",
			contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify({								
				"userid" : $("#userid").val(),
				"username" : $("#username").val(),
				"tel" : $("#tel").val(),
				"zipcode" : $("#zipcode").val(),
				"address1" : $("#address1").val(),
				"address2" : $("#address2").val(),
				"message" : $("#message").val(),
				"payid" : checkval,
				"couponNum" : $("#couponNum").val(),
				"delivery" : $("#delivery").val(),
				"totalprice" : $("#total").val(),
				"coupon_discount" : $('#couponss').val(),
				"saving_discount" : $('#savingss').val(),
				"realtotalprice" : $('#sum').val()
			}),
			success : function(data){ // orderbasic의 orderid 가 넘어옴
				var orderid = data;
				var data1 = '${productInfo}'; // a&b&c&d
				//상품ID/갯수/가격
				var array = new Array();
				array = data1.split('&');
				var productid = array[0];
				var count = array[1];
				var price = array[2];
				
					$.ajax({  // 길이만큼 반복하면 ajax
						url : "/coffee/orderDetailInsertOne/"+ orderid + "/" + productid + "/" + count + "/" + price , //회원가입 ajax
						method : "POST",
						success : function(data){							
						},
						error : function(err){
							console.log("Error 발생 : " + err);
						}
					}); // 서브ajax끝
				//} 
				// 반복문이 끝나면 주문이 완료되었다는 알림무
						$.ajax({  // 구매 완료 메일 보내는 ajax
								url : "/coffee/orderMail/" + orderid + "/" + $("#total").val(),
								method : "POST",
								success : function(data){	
									if(data == 1){
									alert("주문이완료되었습니다.");
									location.href="/coffee/";
									}
								},
								error : function(err){
									console.log("Error 발생 : " + err);
								}
							}); // 서브ajax끝
					},error : function(err){
							console.log("Error 발생 : " + err);
						}
				});// success문 끝
}

function mychange(){ // 체크박스의 checked 옵션이 바뀔떄마다 
		
	$.ajax({  // 길이만큼 반복하면 ajax
		url : "/coffee/userInfoSelect", // 세션으로 유저 정보 가져오기
		method : "GET",
		success : function(data){			
			var result = data.data;			
			if($("#checkbox").is(":checked")){ //<사용자정보와 같다>체크하면
		 	    document.getElementById("username").value = result[0].username;
			 	document.getElementById("tel").value = result[0].tel;
			 	document.getElementById("zipcode").value = result[0].zipcode;
			 	document.getElementById("address1").value = result[0].address1;
			 	document.getElementById("address2").value = result[0].address2;
			 
		    }else{ // 체크풀면
		 	    document.getElementById("username").value = "";
			 	document.getElementById("tel").value = "";
			 	document.getElementById("zipcode").value = "";
			 	document.getElementById("address1").value = "";
			 	document.getElementById("address2").value = "";
		    }
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});
	
	 
}
function selectChange(){
	var value = event.srcElement.value;
	$('#message').val(value);
	if(value == ""){
		$("#message").removeAttr("readonly");
		$("#message").focus();
	}
}

function Cancel(){
	history.back();
}
</script>
</head>
<body>

   <!-- ##### Header Area Start ##### -->
   <jsp:include page="header.jsp" />
   <!-- ##### Header Area End ##### -->

   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay"
      style="background-image: url(img/bg-img/purchase.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>ORDER</h2>
      </div>
   </section>
   <!-- ##### Breadcumb Area End ##### -->

   <div class="container"
      style="border: 1px solid #ced4da; margin-top: 50px; margin-bottom: 30px;padding: 30px" >
      <!--  <h4 style="margin-top:20px;">1. 주문상품 결제금액</h2> -->

      <p class="d">주문 상품 결제 금액</p>
      <table class="table table-hover" id="opener">
         <!-- 주문자 정보 입력 table -->
         <thead class="a">
            <tr>
               <th>상품명</th>
               <th>상품이미지</th>
               <th>주문수량</th>
               <th>상품금액</th>
               <th>총 결제 금액</th>
            </tr>
         </thead>
         <tbody id="result1">
         </tbody>
      </table>

      <br>
      <hr>


      <p class="d">주문 정보</p>
      <hr>
      <div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width:100%; margin: auto;">
            <div class="newsletter-form">
               <input type="text" id="txtName" readonly="readonly" value="이름">
               <input type="text" id="txtTel" readonly="readonly" value="전화번호">
               <input type="email" id="txtEmail" readonly="readonly" value="이메일">
            </div>
         </div>
      </div>

      <p class="d" style="float:left; margin-right:20px;">배송 정보</p>
      <p class="d2"> <input type="checkbox" id="checkbox">주문자와 정보 동일</p>
      <hr>

      <div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width: 100%; margin: auto;">
            <div class="section-heading text-left mb-50">
               <p>Membership Registration</p>
               <p>* 필수 항목</p>
            </div>
            <div class="newsletter-form">
               <input type="text" name="username" id="username" required="required" placeholder="ID">
               <input type="text" name="tel" id="tel" required="required" placeholder="Phone Number">
               <button type="button" id="zipSearch" class="btn btn-outline-dark btn-sm">우편번호검색</button>
               <input type="text" name="zipcode" id="zipcode" readonly="readonly" size="5" placeholder="Zipcode">
               <input type="text" name="address1" id="address1" readonly="readonly" size="50" placeholder="Address">
               <input type="text" name="address2" id="address2" required="required" placeholder="상세주소를 입력해주세요">
                    배송 메시지<br>
				<select name='select' onchange="selectChange();">
				  <option value='' selected >-- 선택 --</option>
				  <option value='문앞에 놔주세요.'>문앞에 놔주세요.</option>
				  <option value='경비실에 놔주세요.'>경비실에 놔주세요.</option>
				  <option value='도착 전 전화주세요.'>도착 전 전화주세요.</option>
				  <option value=''>직접 입력</option>
				</select>
               <input type="text" name="message" id="message" required="required" placeholder="배송시 참고할 사항이 있으면 입력해주세요">
            </div>
         </div>
      </div>

      <p class="d">결제 예정 금액
         <button type="button" id="viewCoupon" class="btn btn-outline-dark btn-sm">쿠폰 조회</button>
         <button type="button" id="viewSavings" class="btn btn-outline-dark btn-sm">적립금 조회</button>
      </p>
     <hr>
       
      
      
      
	<div class="totalPrice">     
               <dl>
                  <dt>상품 합계 가격</dt>
                  <dd id="sum"></dd>                  
               </dl>
               
               <dl class="couponss">
                  <dt>쿠폰 할인금액</dt>
                  <dd id="couponss">0<br>  
                  <dt> <button type="button" id="cancelCoupon" class="btn btn-outline-dark btn-sm">쿠폰 사용 취소</button></dt>             
               </dl>
               
               <dl class="savingss">
                  <dt>적립금 사용금액</dt>
                  <dd id="savingss">0<br>
                  <dt> <button type="button" id="cancelSaving" class="btn btn-outline-dark btn-sm">적립금 사용 취소</button></dt>               
               </dl>
               
               <dl class="delivery">
                  <dt>배송비</dt>
                  <dd id="delivery">0</dd>                  
               </dl>
               
               <dl class="total">
                  <dt>최종 결제 금액</dt>
                  <dd id="total"></dd>
               </dl>         
	</div>
      
      
      
      
      <br/><br/><br/>
      <p class="d">결제 수단</p>
      <hr>
      <br/>
      <div class="choose" >
         <input type="radio" name="radio" value="1" style="margin-left:10px;">신용카드 
         <input type="radio" name="radio" value="2"style="margin-left:10px;">무통장입금(가상계좌) 
         <input type="radio" name="radio" value="3"style="margin-left:10px;">휴대폰소액결제 
         <input type="radio" name="radio" value="4"style="margin-left:10px;">카카오페이 
         
         <input type="hidden" id="userid" value="${sessionScope.userid}" />
         <input type="hidden" id="couponNum" value="0"/>
         <input type="hidden" id="discount_price" value="0" />
         
         <input type="hidden" id="hiddenCoupon" value="0" /> 
         <input type="hidden" id="hiddenSaving" value="0" />
         <input type="hidden" id="savingsss" value="0" />
      </div>
      <br/><br/><br/><br/>
      <div style="text-align: center;">
      <input type="button" class="btn oneMusic-btn" value="취소" onclick="Cancel();">
      <input type="button" class="btn oneMusic-btn" id ="btnPayment" value="결제">
      </div>
   </div>

</body>

</html>