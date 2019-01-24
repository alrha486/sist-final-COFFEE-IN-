<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="qna"  value="${data}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 템플릿 부분(헷갈리지 말자....) -->
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 여기까지~ -->

<title>문의사항-답변하기</title>

<!--  css  -->

    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/header.js"></script>


</head>

</head>
<body>
	<!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="lds-ellipsis">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>

    <!-- ##### Header Area Start ##### -->
	<jsp:include page="header.jsp" />
    <!-- ##### Header Area End ##### -->
    
    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/hotchoco.jpg);">
        <div class="bradcumbContent">
            <p>CAFE-IN</p>
            <h2>고객센터</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    

	 <!-- ##### Events Area Start ##### -->

	<section class="events-area section-padding-100">
     	<div class="container">
     	
     	<div style='width:900px;margin:auto;'>
     		<h4>게시판 글 답변하기</h4>
     		<br/>
			<form>
				<ul style="list-style-type: none;margin:10px 10px;">
					<li><input type="text" name="title" id="title" class="form-control" placeholder="제목"/></li>
			
					<li style="margin-top:5px;"><textarea name="contents"  id="contents" rows="10" cols="300" class="form-control" placeholder="내용">문의사항에 대한 답글입니다.</textarea></li>
					<li style="margin-top:5px;text-align:center;"><button type="button" id="reply">답변하기</button>&nbsp;&nbsp;&nbsp;
						 <button type="reset">다시하기</button></li>
				</ul>
			</form>
			
		</div>
		</div>
	</section>
	
	    <!-- ##### Events Area End ##### -->

<!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />    
    <!-- ##### Footer Area End ##### -->
    
    <script src="../static/js/jquery-2.2.4.min.js"></script>
    <script src="../static/js/plugins.js"></script>
    <script src="../static/js/active.js"></script>
    <script src="../static/js/popper.min.js"></script>
    <script src="../static/js/bootstrap.min.js"></script>
    
    <script>
	$(function(){
		$("#title").val("${qna.title}");
		$("#contents").val("문의사항에 대한 답변입니다.");
		
		$("#reply").bind("click", function(){
			$.ajax({
				url : "../reply", 
				dataType : "json",
				method : "POST",
				data : JSON.stringify({
					"title" : $("#title").val(),
					"contents" : $("#contents").val(),
					"c_lock" : ${qna.c_lock},
					"userid" : "${sessionScope.userid}",
					"grp" : ${qna.grp},
					"lev" : ${qna.lev},
					"step" : ${qna.step} 
				}),
				contentType : "application/json; charset=utf-8",
				success : function(data){		
					alert("리플이 등록되었습니다.");
					location.href = "/coffee/goQnA";	
				}, 
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
		});
		
	});

</script> 
    
</body>
</html>



<!--  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 답변</title>

<link rel="stylesheet" href="../static/css/bootstrap.min.css" type="text/css" />

<script src="../static/js/jquery.min.js"></script>

<script>
	$(function(){
		$("#title").val("${qna.title}");
		$("#contents").val("문의사항에 대한 답변입니다.");
		
		$("#reply").bind("click", function(){
			$.ajax({
				url : "../reply", 
				dataType : "json",
				method : "POST",
				data : JSON.stringify({
					"title" : $("#title").val(),
					"contents" : $("#contents").val(),
					"c_lock" : ${qna.c_lock},
					"userid" : "운영자",
					"grp" : ${qna.grp},
					"lev" : ${qna.lev},
					"step" : ${qna.step} 
				}),
				contentType : "application/json; charset=utf-8",
				success : function(data){		
					alert("Answer Insert Success");
					location.href = "/Cafe-In_Board";	
				}, 
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
		});
		
	});

</script> 





</head>
<body>
	<h1>게시판 글 답변하기</h1>
	<form>
		<ul>
			<li>Title : <input type="text" name="title" size="50"  id="title"/></li>
			
			<li>Contents : <textarea name="contents"  id="contents" rows="5" cols="50">문의사항에 대한 답글입니다.</textarea></li>
			<li><button type="button" id="reply">답변하기</button>&nbsp;&nbsp;&nbsp;
					<button type="reset">다시하기</button></li>
		</ul>
	</form>
</body>
</html>
-->