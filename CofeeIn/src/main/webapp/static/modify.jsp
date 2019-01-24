<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="test" value="${test}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
var test = '${test}';
var array = new Array();
array = test.split('&');
console.log(array[0]);
console.log(array[1]);
	
	$(function() {
		$(".dropdown-menu li a").click(function() {
			var selText = $(this).text();
			var imgSource = $(this).find('img').attr('src');
			var img = '<img src="' + imgSource + '" height=25 width=120/>';
			$(this).parents('.btn-group').find(
					'.dropdown-toggle').html(
					img + ' ' + selText);
		});

		$('#score li').on('click', function() {
			// 버튼에 선택된 항목 텍스트 넣기 
			$('#rev_score').val($(this).val());
			// 선택된 항목 값(value) 얻기
			$("#rev_score1").val($(this).val());
		});

		//입력된 값을 받아옴 
		$.ajax({
			url : "/coffee/reviewInfo/" + array[1],
			method : "GET",
			dataType : "json",
			success : function(data) {
				var data = data.data;
					$("#rev_title").val(data.rev_title);
					$("#rev_score").val(data.rev_score);
					$("#rev_score1").val(data.rev_score);
					$("#rev_contents").text(data.rev_contents);

			},
			error : function(err) {
				console.log("error 발생 " + err);
			}
		});
		//목록으로
		$("#btnBack").bind("click", function() {
			location.replace = history.go(-1);
		});
		//수정버튼
		$("#btnUpdate").click(function() {
				$.ajax({
					url : "/coffee/reviewInfo/" + array[1],
					method : "GET",
					dataType : "json",
					success : function(data){
						var result = data.data;						
						$.ajax({
							url : "/coffee/update/" + array[1],
							method : "PUT",
							dataType : "json",
							contentType : 'application/json; charset=UTF-8',
							data : JSON.stringify({
								"rev_title" : $("#rev_title").val(),
								"rev_score" : $("#rev_score1").val(),
								"rev_contents" : $("#rev_contents").val()
							}),
							success : function(data) {
								alert("수정이 완료되었습니다.");
								location.replace("/coffee/view/"+array[0]);
							},
							error : function(err) {
								console.log("Error 발생 : " + err);
							}
						});
						
						
					},
					error : function(err){
					}
				});
 
		}); //btnUpdate끝
	});
	//삭제버튼
</script>

</head>
<body>
	<jsp:include page="header.jsp" />
	
	<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/main.jpg);">
        <div class="bradcumbContent">
            <p>REVIEW</p>
            <h2>MODIFY</h2>
        </div>
    </section>
	
	<%-- <input type="hidden" id="rev_idx" value="${rev_idx}"/>
	<input type="hidden" id="productid" value="${productid}"/> --%>
	<input type="hidden" id="test" value="${test}" />
	<div class="newsletter-area mb-100">
		<form id="myform">
			<!-- 드롭박스 값을 직접 못 가져와서 여기서 값을 가져가는 것. -->
			<input type="hidden" name="rev_score" value="${rev_score }" id="rev_score1" />
			<div class="newsletter-form">
			<ul style="list-style-type: none; margin: 10px 0px">
				<li>제목	<input type="text" id="rev_title" value='' size="100" />
				</li>
				<li>별점 주기
					<div class="btn-group" style="margin: 10px;">
						<a class="btn dropdown-toggle" data-toggle="dropdown" href="#"
							id="rev_score"><img src="static/img/star0.JPG" height=25
							width=120><!-- <span class="caret"></span> --></a>
						<ul class="dropdown-menu" id="score">
							<li value="0"><a href="javascript:void(0);"> <img
									src="static/img/star0.JPG" height=25 width=120></a></li>
							<li value="1"><a href="javascript:void(0);"> <img
									src="static/img/star1.JPG" height=25 width=120></a></li>
							<li value="2"><a href="javascript:void(0);"> <img
									src="static/img/star2.JPG" height=25 width=120></a></li>
							<li value="3"><a href="javascript:void(0);"> <img
									src="static/img/star3.JPG" height=25 width=120></a></li>
							<li value="4"><a href="javascript:void(0);"> <img
									src="static/img/star4.JPG" height=25 width=120></a></li>
							<li value="5"><a href="javascript:void(0);"> <img
									src="static/img/star5.JPG" height=25 width=120></a></li>
						</ul>
					</div>
				</li>			
				<li>내용<br>
					<textarea name="rev_contents" class="noresize" rows="10"
						 id="rev_contents"></textarea></li>
			</ul>
		</div>
		<div style="text-align:center; margin-top:50px;">
			<input type="button" class="btn oneMusic-btn" id="btnUpdate" value="수정하기">
			<input type="button" class="btn oneMusic-btn" id="btnBack" value="목록으로">
		</div>
		</form>
	</div>
</body>
</html>

