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
		url : "/coffee/selectMySaving", // 사용자가 가지고있는 적립금조회
		method : "GET",
		success : function(data){ // 로드될 떄
			var useSaving = opener.document.getElementById('hiddenSaving').value;
			if(useSaving != 0){
				$('#mysaving').html(data - useSaving);
				$('#mysaving').val(data - useSaving);
				$('#resultSaving').html(data - useSaving);
				$('#resultSaving').val(data - useSaving);
				
				$('#savings').attr('max',data - useSaving);
			}else{
			$('#mysaving').html(data);
			$('#mysaving').val(data);
			$('#resultSaving').html(data);
			$('#resultSaving').val(data);
			
			$('#savings').attr('max',data);
			}
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); // ajax 끝
	
	
	
	$('#btnUseAll').bind('click',function(){ // 전체 사용 눌렀을 시
		$.ajax({ 
			url : "/coffee/selectMySaving", // 사용자가 가지고있는 쿠폰조회
			method : "GET",
			success : function(data){
				var useSaving = opener.document.getElementById('hiddenSaving').value;
				var saving = data;							
				$('#savings').val(saving-useSaving);
				$('#saving').val(saving-useSaving);
				$('#resultSaving').html(0);
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); // ajax 끝
	});
	
	$('#btnCancle').bind('click',function(){ // 취소 눌렀을 시
		self.close(); 
	});
	
	$("#savings").bind('keyup mouseup', function () {
		
	    var mysaving = $('#mysaving').val();
		var savingVal = $('#savings').val();
	    $('#resultSaving').html(mysaving-savingVal);	  
	});
	
	$('#btnUse').bind('click',function(){ // 사용 눌렀을  시
		 var mysaving = $('#mysaving').val(); // 내 적립금
		 var savingVal = parseInt($('#savings').val()); // 내가 사용입력한 금액
		 if(mysaving < savingVal){
			 alert("적립금보다 많은 금액은 사용하실 수 없습니다.");
			 $('#savings').val(0);
			 $('#savings').html(0);
			 $('#resultSaving').html(mysaving);
			 return false;
		 }else if(savingVal < 0 ){
			 alert("제대로 입력해주세요.");
			 $('#savings').val(0);
			 $('#savings').html(0);
			 $('#resultSaving').html(mysaving);
			 return false;
		 } // 예외처리 통과시 
		 
		 var alreadySaving = parseInt(opener.document.getElementById('savingsss').value);
		 if(alreadySaving == 0){
			 opener.$('#savingss').val(savingVal);
			 opener.$('#savingsss').val(savingVal);
			 opener.$('#savingss').html(savingVal); // 1000 + 
		 }else if(alreadySaving != 0){
			 var openerSaving = parseInt(opener.document.getElementById('savingss').value);
			 opener.$('#savingss').val(openerSaving +savingVal);
			 opener.$('#savingss').html(openerSaving +savingVal); // 원래있던거 + 이번에 입력한거 
			 opener.$('#savingsss').val(openerSaving + savingVal);
		 }
		
		 var totalPrice = opener.document.getElementById('total').value;
		 opener.document.getElementById('total').value = totalPrice - savingVal;
		 opener.document.getElementById('total').innerHTML = (totalPrice - savingVal);
		 
		 var hidden = parseInt(opener.document.getElementById('hiddenSaving').value);
		 opener.document.getElementById('hiddenSaving').value = hidden + savingVal;
		 self.close();
		 
	});

}); // document.ready 끝

</script>
<style>
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
    font-size: 16px;
}

.totalPrice dl {
    float: left;
    padding-left: 70px;
    display: inline-block;
    color: rgb(51,51,51);
}

.totalPrice dd {
   font-family: "Nanum Gothic", sans-serif;
    font-size: 30px;
    line-height: 32px;
}

.totalPrice .sale {
    margin-left: 95px;
    background: url(static/img/minus.png) no-repeat 0 50%;
    background-size: 40px;
}

.totalPrice .delivery {
    margin-left: 95px;
    background: url(static/img/plus.png) no-repeat 0 50%;
    background-size: 40px;
}
.totalPrice .total {
    margin-left: 95px;
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
</head>

<body>
<br><br>
<section
      style="text-align: center">
      <div class="bradcumbContent">
         <h2>카페 - 인</h2>
         <p>적립금</p>
         
      </div>
   </section>

       <div class="totalPrice">
         
               <dl>
                  <dt>내 적립금</dt>
                  <dd id="mysaving"></dd>
                  
               </dl>
               <dl class="sale">
                  <dt>사용할 적립금</dt>
                  <dd id="saving"><input type="number" id="savings" style="width: 5em" max="3000" min="0" value='0'><br>
                  
               </dl>

               <dl class="total">
                  <dt>사용 후 금액</dt>
                  <dd id="resultSaving">0</dd>
               </dl>
         
      </div>
      <br><br><br>
   <div style="text-align: center;">
   		 <input type="button" class="btn oneMusic-btn"  id="btnUseAll" value="전체사용하기">
         <input type="button" class="btn oneMusic-btn"  id="btnUse" value="확인">
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


