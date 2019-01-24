<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="orderid7" value="${orderid}" /> <!-- cartdetail 정보가 들어있는 list -->

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
	var orderid = ${orderid7};
		$.ajax({  // 길이만큼 반복하면 ajax
			url : "/coffee/mypage/orderViews/" +orderid,
			method : "GET",
			success : function(data){			
				var result = data.data;
				var str = "";
				for(var i=0; i<result.length; i++){ // 넘어온 상품 수만큼 돌면서 호출
					str += "<tr>";
    				str += "<td>" + result[i].productname + "</td>";
    				str += "<td><img width='100px' src='static/img/product/"+result[i].productimg+"'></td>";
    				str += "<td>" + result[i].pcount + "</td>"; // 수량
    				str += "<td>" + result[i].price/result[i].pcount + "</td>"; // 단가
    				str += "<td>" + result[i].price + "</td>"; // 결제금액
    				str += "</tr>";
				}
				$('#result1').html(str);
				
				var totalPrice7 = result[0].totalprice + result[0].coupon_discount + result[0].saving_discount - result[0].delivery;
				var totalPrice8 =  result[0].totalprice - result[0].coupon_discount - result[0].saving_discount + result[0].delivery;
					$('#delivery').html(result[0].delivery + "원");
					$('#delivery').val(result[0].delivery);
					$('#sum').html(result[0].realtotalprice+ "원");
					$('#sum').val(result[0].realtotalprice);
					$('#couponss').html(result[0].coupon_discount+ "원");
					$('#couponss').val(result[0].coupon_discount);
					$('#savingss').html(result[0].saving_discount+ "원");
					$('#savingss').val(result[0].saving_discount);
					$('#total').html(result[0].totalprice+ "원");
					$('#total').val(result[0].totalprice);
				
				$('#name').val(result[0].username);
				$('#tel').val(result[0].tel);
				var text1 = "";
				var zipcode = result[0].zipcode;
				var totalAddress = text1.concat(zipcode,"-    ", result[0].address1, "  ",  result[0].address2);

				$('#address').val(totalAddress);
				$('#message').val(result[0].message);
				var payid = result[0].payid;

				if(payid ==1){
					$('#payid').val("신용카드");
				}else if(payid ==2){
					$('#payid').val("무통장입금");
				}else if(payid ==3){
					$('#payid').val("휴대폰소액결제");
				}else if(payid ==4){
					$('#payid').val("카카오페이");
				} 
				
				
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	 
});

window.addEventListener('load', setup); // 윈도우가 로딩되면 setup 함수 실행

function setup(){
	document.getElementById("btnGoList").addEventListener('click', btnGoList);// 쿠폰보기 버튼 이벤트추가
}		
function btnGoList(){ //결제버튼 눌렀을 때
	location.href= self.close();		
}

</script>
</head>
<body>
   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay"
      style="background-image: url(img/bg-img/purchase.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>주문 상세 조회</h2>
      </div>
   </section>
   <!-- ##### Breadcumb Area End ##### -->

   <div class="container"
      style="border: 1px solid #ced4da; margin-top: 50px; margin-bottom: 30px;padding: 30px" >
      <!--  <h4 style="margin-top:20px;">1. 주문상품 결제금액</h2> -->

      <p class="d">주문 상세 조회</p>
      <table class="table table-hover" id="opener">
         <!-- 주문자 정보 입력 table -->
         <thead class="a">
            <tr>
               <th>상품명</th>
               <th>상품이미지</th>
               <th>주문수량</th>
               <th>상품단가</th>
               <th>합계</th>
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
               받는 사람<input type="text" id="name" readonly="readonly" >
               휴대폰<input type="text" id="tel" readonly="readonly">            
               주소<input type="text" id="address" readonly="readonly">
               배송 메시지<input type="text" id="message" readonly="readonly"> 
               결제 수단<input type="text" id="payid" readonly="readonly"> 
            </div>
         </div>
      </div>
      
      <p class="d" style="float:left; margin-right:10px;">결제 금액</p>
	<hr>
	  <div class="col-12 col-lg-12">
      <div class="totalPrice">
         
               <dl>
                  <dt>상품합계</dt>
                  <dd id="sum"></dd>
                  
               </dl>
               
               <dl class="couponss">
                  <dt>쿠폰 할인금액</dt>
                  <dd id="couponss">0<br>               
               </dl>
               
               <dl class="savingss">
                  <dt>적립금 사용금액</dt>
                  <dd id="savingss">0<br>               
               </dl>
               
               <dl class="delivery">
                  <dt>배송비</dt>
                  <dd id="delivery"></dd>
                  
               </dl>
               <dl class="total">
                  <dt>총 결제 금액</dt>
                  <dd id="total"></dd>
               </dl>
         
      </div>
      <div style="text-align: center;">
      <input type="button" class="btn oneMusic-btn" value="목록으로" id="btnGoList">
      </div>
	</div>
   </div>
</body>

</html>