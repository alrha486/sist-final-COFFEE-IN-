<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
	$(document).ready(function() {
		$(".fileDrop").on("drop", function(event){
			formData = new FormData();
			event.preventDefault();
			
			var files = event.originalEvent.dataTransfer.files;
			for(var i = 0 ; i < files.length ; i++){
				var file = files[i];
				console.log(file);
				formData.append("file", file);
			}
		});
		
		$("#btnInsert").bind("click", function(){
		  var formData = new FormData($("#myform")[0]);
		  $.ajax({
			  url:"/coffee/admin/productInsert",
			  type : "json",
			  method : "POST",
			  processData : false,
			  contentType : false,
			  data : formData,
			  success :function(data){
				  alert(data.code);
				  location.href="/coffee/productMGMT";
			  },
			  error : function(err){
				  console.log("error 발생 : " + err);
			  }
		  });	  
		});
		
		$("#btnCancel").bind("click", function(){
			location.href="/coffee/productMGMT";
		});
	}); 

	function getRealPath(obj){
	    var fileValue = $("#productimage").val().split("\\");
	    var fileName = fileValue[fileValue.length-1]; // 파일명
	    
	    var formData = new FormData($("#myform")[0]);
	    
		  $.ajax({
			  url:"/product/imageUpload",
			  type : "json",
			  method : "POST",
			  processData : false,
			  contentType : false,
			  data : formData,
			  success :function(data){
				  $('#images').attr("src","static/img/"+fileName); // 이건 야매로.... 실제경로 받아올 시 fakepath뜨기때문에
			  },
			  error : function(err){
				  console.log("error 발생 : " + err);
			  }
		  });
	}
</script>

<title>상품 등록 페이지</title>
</head>
<body   style="padding: 5%">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/product/manager/product">상품 관리</a></li>
    <li class="breadcrumb-item active" aria-current="page">상품 등록</li>
  </ol>
</nav>

<!-- <form method="post" action="productInsert_ok.jsp"  enctype="multipart/form-data"> -->
<form id="myform" accept-charset="UTF-8">
<div class="col-12 col-lg-12">
         <div class="newsletter-area mb-100" style="width:100%; margin: auto;">
  <h2 class="menu_sub_title" style="text-align: center;margin-bottom:50px;">상품등록</h2>
        <table class="table" style="margin: auto; padding: 50%">
	         <tbody>
	         <tr>
	            <th class="align-middle" style="height: 50px">상품종류</th>
	            <td class="align-middle">
	               <select class="form-control input-sm"  name="kind_idx" id="kind_idx" style="width:25%;display:inline-block;">
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
	            <td class="align-middle"><input class="form-control input-sm"  style="width:25%;" type="text" name="productname" id="productname" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 판매가</th>
	            <td class="align-middle"><input class="form-control input-sm" style="width:25%;"  type="number" name="price" id="price" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 재고수량</th>
	            <td class="align-middle"><input class="form-control input-sm"  style="width:25%;" type="number" name="stock" id="stock" required="required"></td>
	         </tr>
	         <tr>
	            <th class="align-middle" style="height: 50px"> 상품대표이미지</th>
	            <td class="align-middle">
	               <input type="file" name="productimage" id="productimage" accept=".gif, .jpg, .png"  onchange="javascript:getRealPath(this);"
	               required="required">
	               <img id="images" name="images" width="200px" height="200px">
	            </td>
	         </tr>
	         <tr>
	            <th class="align-middle"> 상품설명</th>
	            <td class="align-middle">
	               <textarea class="form-control" rows="3" name="productex" id="productex" style="width: 100%; height: 100px" required="required" ></textarea>
	            </td>
	         </tr>
	      </tbody>
      </table>
      <div style="text-align:center;">
         <input class="btn btn-default" type="button" id="btnInsert" value="상품등록">
         <input class="btn btn-default" type="button" id="btnCancel" value="취소" />
      </div>  
      </div>
   </div> 
</form>

</body>
</html>