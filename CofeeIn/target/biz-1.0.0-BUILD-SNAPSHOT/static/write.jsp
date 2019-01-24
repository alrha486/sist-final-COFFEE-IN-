<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 템플릿 부분(헷갈리지 말자....) -->
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 여기까지~ -->

<title>문의사항-글쓰기</title>

<!--  css  -->
<link rel="stylesheet" href="static/style.css" />
<link rel="stylesheet" href="static/css/bootstrap.css" />
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">

<script src="static/js/jquery.min.js"></script>
<script src="static/js/header.js"></script>

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
     
	<h1>문의사항 작성</h1>
	
	<form id="boardform" name="boardform">
		<ul style="list-style-type: none;margin:10px 0px">
			<li>제목 : <input type="text" name="title"  id="title"/></li>
			<li>비밀글 선택 <input type="radio" name="c_lock" id="c_lock" value="1">비공개
								 <input type="radio" name="c_lock" id="c_lock" value="0">공개</li>
			<li><textarea name="contents" id="contents" rows="5" cols="50"></textarea></li>
			<li><button type="button" id="btnInsert">작성하기</button>&nbsp;&nbsp;&nbsp;
					<button type="reset">다시하기</button>&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn"  id="btnBack">목록으로</button></li>
		</ul>
	</form>
			
</div>
</section>

	    <!-- ##### Events Area End ##### -->

	<!-- ##### Footer Area Start ##### -->
  	<jsp:include page="footer.jsp" />
    <!-- ##### Footer Area End ##### -->

<script src="static/js/plugins.js"></script>
<script src="static/js/active.js"></script>
<script src="static/js/popper.min.js"></script>
<script src="static/js/bootstrap.js"></script>
<script>
	$(function(){
		//삽입버튼
		$("#btnInsert").bind("click", function(){
			$.ajax({
				url:"write",
				dataType:"json",
				method:"POST",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"title":$("#title").val(),
					"contents":$("#contents").val(),
					"c_lock":parseInt($("#c_lock").val())
				}),
				success : function(data){
					alert("Insert Success");
					location.href = "/coffee/goQnA";
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
		});
		$("#btnBack").bind("click", function(){
			history.back();
		});
	});
</script>

</body>
</html>
