<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="productid" value="${productid}" />
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
.mb-100 {
    margin-bottom: 0px;
}
</style>


<script type="text/javascript">
	var productid = '${productid}';
	//console.log(productid);
	
	$(function() {
		$.ajax({
			url : "/coffee/infoProduct/" + productid,
			method : "GET",
			dataType : "json",
			success : function(data) {
				var data = data.data;
					$("#kind_idx").val(data.kind_idx);
					$("#productname").val(data.productname);
					$("#price").val(data.price);
					$("#stock").val(data.stock);
					$("#images").val(data.productname);
					$("#images").attr('src',"static/img/product/"+data.productname+".jpg");
					$("#productex").val(data.productex);
			},
			error : function(err) {
				console.log("error 발생 " + err);
			}
		});
		
		$("#btnModify").click(function(){
				$.ajax({
					url : "/coffee/infoProduct/" + productid,
					method : "GET",
					dataType : "json",
					success : function(data){
						var result = data.data;					
						$.ajax({
							url : "/coffee/modifyProduct/" + productid,
							method : "PUT",
							dataType : "json",
							contentType : 'application/json; charset=UTF-8',
							data : JSON.stringify({
								"kind_idx" : $("#kind_idx").val(),
								"productname" : $("#productname").val(),
								"price" : $("#price").val(),
								"stock" : $("#stock").val(),
								"productimg" : $("#images").val(),
								"productex" : $("#productex").val()
							}),
							success : function(data) {
								alert("상품 정보가 수정되었습니다.");
								opener.parent.location.reload();
								window.close();
							},
							error : function(err) {
								console.log("Error 발생 : " + err);
							}
						});
					},
					error : function(err){
					}
				});
		});
		
		$("#btnCancle").click(function(){
			window.close();
		});
	}); 
</script>

<title>상품 수정 페이지</title>
</head>
<body   style="padding: 5%">
<form id="myform">
<div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width:100%; margin: auto;">
  <h2 class="menu_sub_title" style="text-align: center;margin-bottom:50px;">상품수정</h2>
        <table class="table" style="margin: auto; padding: 50%">
	         <tbody>
	         <tr>
	            <th class="align-middle" style="height: 50px">상품종류</th>
	            <td class="align-middle">
	               <select class="form-control input-sm"  name="kind_idx" id="kind_idx" style="width:100%;display:inline-block;">
	                  <option value="1">Beans(Coffee)</option>
	                  <option value="2">Bottle Coffee(Coffee)</option>
	                  <option value="3">Drip Bag(Coffee)</option>
	                  <option value="4">Cake(Foods)</option>
	                  <option value="5">Bakery(Foods)</option>
	                  <option value="6">Sandwich(Foods)</option>
	                  <option value="7">Mug(Goods)</option>
	                  <option value="8">Tumbler(Goods)</option>
	                  <option value="9">Accessory(Goods)</option>
	               </select>
	            </td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 상품명</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:100%;" type="text" name="productname" id="productname" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 판매가</th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:100%;"  type="number" name="price" id="price" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 재고수량</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:100%;" type="number" name="stock" id="stock" required="required"></td>
	         </tr>	         
	         <tr>
	            <th class="align-middle">상품 이미지</th>
	            <td class="align-middle"><input class="form-control input-sm" type="image" id="images" required="required" style='width:150px;height:150px;' ></td>
	         </tr>	 
	         <tr>
	            <th class="align-middle"> 상품설명</th>
	            <td class="align-middle">
	               <textarea class="form-control" rows="5" name="productex" id="productex" style="width: 100%; height: 100px" required="required" ></textarea>
	            </td>
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