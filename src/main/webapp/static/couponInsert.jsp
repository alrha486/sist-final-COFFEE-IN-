<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="static/js/jquery.min.js"></script>

<link
   href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean"
   rel="stylesheet">

<!-- Stylesheet -->
<link rel="stylesheet" href="static/css/style.css">
<link rel="stylesheet" href="static/css/bootstrap.css">
<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
   
}
</style>


<script type="text/javascript">

	$(function() {
		$("#btnInsert").bind("click", function(){
		  var formData = new FormData($("#myform")[0]);
		  $.ajax({
			  url:"/coffee/coupon/insert",
			  type : "json",
			  method : "POST",
			  processData : false,
			  contentType : false,
			  data : formData,
			  success :function(data){
				  alert("쿠폰이 등록되었습니다.");
				  location.href="/coffee/couponMGMT";
			  },
			  error : function(err){
				  console.log("error 발생 : " + err);
			  }
		  });	  
		});
	});
	
	function back(){
		history.back();
	}
</script>

<title>쿠폰 등록 페이지</title>
</head>
<body   style="padding: 5%">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/coffee/admin/product">쿠폰 관리</a></li>
    <li class="breadcrumb-item active" aria-current="page">쿠폰 등록</li>
  </ol>
</nav>

<!-- <form method="post" action="productInsert_ok.jsp"  enctype="multipart/form-data"> -->
<form id="myform">
<div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width:100%; margin: auto;">
  <h2 class="menu_sub_title" style="text-align: center;margin-bottom:50px;">쿠폰등록</h2>
        <table class="table" style="margin: auto; padding: 50%">
	         <tbody>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 쿠폰이름</th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:25%;"  type="text" name="c_name" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 쿠폰내용</th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:25%;"  type="text" name="c_content" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 할인금액</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:25%;" type="number" name="c_discount" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 쿠폰사용가능금액</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:25%;" type="number" name="c_condition" required="required"></td></td>
	         </tr>
	      </tbody>
      </table>
      <div style="text-align:center;">
         <input class="btn btn-default" type="button" id="btnInsert" value="쿠폰등록">
         <input class="btn btn-default" type="button" id="btnCancle" value="취소" onclick="back();"/>
      </div>  
      </div>
   </div> 
</form>
      


</body>
</html>