<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="couponnum" value="${couponNum}" />
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
<link rel="stylesheet" href="static/css/bootstrap.css">
<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
}
.mb-100 {
    margin-bottom: 0px;
}
</style>


<script type="text/javascript">
	var couponnum = '${couponnum}';
	$(function() {
		$.ajax({
			url : "/coffee/infoCoupon/" + couponnum,
			method : "GET",
			dataType : "json",
			success : function(data) {
				var data = data.data;
				
				$("#c_name").val(data.c_name);
				$("#c_content").val(data.c_content);
				$("#c_discount").val(data.c_discount);
				$("#c_condition").val(data.c_condition);
			},
			error : function(err) {
				console.log("error 발생 " + err);
			}
		});
		
		$("#btnModify").click(function(){			
			$.ajax({
				url : "/coffee/modifyCoupon/" + couponnum,
				method : "PUT",
				dataType : "json",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"c_name" : $("#c_name").val(),
					"c_content" : $("#c_content").val(),
					"c_discount" : $("#c_discount").val(),
					"c_condition" : $("#c_condition").val()
				}),
				success : function(data) {
					alert("쿠폰정보가 수정되었습니다.");
					opener.parent.location.reload();
					self.close();
				},
				error : function(err) {
					console.log("Error 발생 : " + err);
				}
			});
 
		});
		
		$("#btnCancle").click(function(){
			self.close();
		});
	}); 
</script>

<title>쿠폰 수정 페이지</title>
</head>
<body   style="padding: 5%">
<form id="myform">
<div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width:100%; margin: auto;">
  <h2 class="menu_sub_title" style="text-align: center;margin-bottom:50px;">쿠폰수정</h2>
        <table class="table" style="margin: auto; padding: 50%">
	         <tbody>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 쿠폰이름</th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:100%;"  type="text" id="c_name" name="c_name" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 쿠폰내용</th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:100%;"  type="text" id="c_content" name="c_content" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 할인금액</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:100%;" type="number" id="c_discount" name="c_discount" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 쿠폰사용가능금액</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:100%;" type="number" id="c_condition" name="c_condition" required="required"></td></td>
	         </tr>
	      </tbody>
      </table>
      <div style="text-align:center;">
      	<input class="btn btn-default" type="button" id="btnModify" value="수정">
      	<input class="btn btn-default" type="button" id="btnCancle" value="취소" />
      </div>
      </div>
   </div> 
</form>

</body>
</html>