<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="productid" value="${productid}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
<script src="static/js/jquery/jquery.min.js"></script>
<script src="static/js/jquery.barrating.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="static/css/bootstrap1.min.css" type="text/css"/>
<link rel="stylesheet" href="static/style.css">

<style>
	.newsletter-area{
		margin-left:auto;
		margin-right:auto;
		width:50%;
	}
	.newsletter-area{
		margin-top:50px;
	}
	textarea{
		width:100%;
	}
</style>
 <script> 
  $(function() {
	  var productid=$("#productid").val();
	  console.log(productid);
	  $(".dropdown-menu li a").click(function () {
		    /* var selText = $(this).text();
		    console.log(selText); */
		    var imgSource = $(this).find('img').attr('src');
		    console.log(imgSource);
		    var img = '<img src="' + imgSource + '" height=25 width=120/>';        
		    console.log(img);
		    /* $(this).parents('.btn-group').find('.dropdown-toggle').html(img + ' ' + selText + ' <span class="caret"></span>'); */
		    $(this).parents('.btn-group').find('.dropdown-toggle').html(img);
		});
	  
	  $('#score li').on('click', function() {
		    // 버튼에 선택된 항목 텍스트 넣기 
		    $('#rev_score').val($(this).val());
		    // 선택된 항목 값(value) 얻기
		    $("#rev_score1").val($(this).val())
	  });
	  
	//삽입 버튼
	  $("#btnInsert").bind("click", function(){
		  var formData = new FormData($("#myform")[0]);
		  $.ajax({
			  //url : "reviews",
			  url:"/coffee/write/"+productid,
			  type : "json",
			  method : "POST",
			  processData : false,
			  contentType : false,
			  data : formData,
			  success :function(data){
				  alert("리뷰가 등록되었습니다.");
				  location.href="/coffee/view/"+productid;
			  },
			  error : function(err){
				  console.log("error 발생 : " + err);
			  }
		  });	  
		 	
	 });
	  
	//목록으로 돌아가기
	  $("#btnBack").bind("click", function(){
			 location.href="/coffee/view/"+productid;
	  });	
  });

</script>

</head>
<body>
<jsp:include page="header.jsp" />

<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/main.jpg);">
	<div class="bradcumbContent">
	    <p>REVIEW</p>
	    <h2>WRITE</h2>
	</div>
 </section>

<input type="hidden" id="productid" value="${productid}"/>

<div class="newsletter-area mb-100">
<form id="myform" name="myform">
	<!-- 드롭박스 값을 직접 못 가져와서 여기서 값을 가져가는 것. -->
	<input type="hidden" name="rev_score" value="0"  id="rev_score1"/>
		<div class="newsletter-form">  
			<ul style="list-style-type: none;margin:10px 0px">
				<li>제목<input type="text"  name="rev_title" id="rev_title" required="required"/></li>
				<li>별점 주기
					<div class="btn-group" style="margin:10px;">                  
		                <a class="btn dropdown-toggle" data-toggle="dropdown" id="rev_score">
		                	<img src="static/img/star0.JPG" height=25 width=120 ></a>
		                <ul class="dropdown-menu" id="score">
		                    <li value=0><a href="javascript:void(0);">
		                       <img src="static/img/star0.JPG" height=25 width=120 ></a>
		                    </li>
		                    <li value=1><a href="javascript:void(0);">
		                        <img src="static/img/star1.JPG" height=25 width=120 ></a>
		                    </li>
		                    <li value="2"><a href="javascript:void(0);">
		                       <img src="static/img/star2.JPG" height=25 width=120 ></a>
		                    </li>
		                    <li value="3"><a href="javascript:void(0);">
		                        <img src="static/img/star3.JPG" height=25 width=120 ></a>
		                    </li>
		                    <li value="4"><a href="javascript:void(0);">
		                        <img src="static/img/star4.JPG" height=25 width=120  ></a>
		                    </li>
		                    <li value="5"><a href="javascript:void(0);">
		                        <img src="static/img/star5.JPG" height=25 width=120 ></a>
		                    </li>
		                </ul>
		            </div>
	            </li>
<!-- <!-- 				<li>파일 첨부<input type="file" name="rev_file" id="rev_file" >
				<input type="file" name="productimage" id="productimage" accept=".gif, .jpg, .png"  onchange="javascript:getRealPath(this);">
	            </li>
				<li><img id="images"></li> -->
				<li>내용<br>
					<textarea name="rev_contents" class="noresize" rows="10" id="rev_contents" required="required"></textarea>
				</li>
	 		</ul>
	 		
  		</div>
  		<div style="text-align:center; margin-top:50px;">
	 		<input type="button" class="btn oneMusic-btn" id="btnInsert" value="작성하기">
			<input type="button" class="btn oneMusic-btn"  id="btnBack" value="목록으로">
 		</div>
 		<input type="hidden" name="userid" value="${sessionScope.userid}" />
	</form>
	</div>
</body>
</html>