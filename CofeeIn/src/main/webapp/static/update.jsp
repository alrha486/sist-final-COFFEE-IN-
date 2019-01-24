<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<!-- 템플릿 부분(헷갈리지 말자....) -->
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!--  css  -->


<link rel="stylesheet" href="style.css" />
<link rel="stylesheet" href="css/bootstrap.css" />
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
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(img/bg-img/hotchoco.jpg);">
        <div class="bradcumbContent">
            <p>CAFE-IN</p>
            <h2>고객센터</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    
    <!-- ##### Events Area Start ##### -->

<section class="events-area section-padding-100">
    <div class="container">

      <h1>문의사항 수정</h1>
	<form id="myform">
		<ul style="list-style-type: none;margin:10px 0px">
			<li>제목 : <input type="text" name="title" id="title"/></li>
			<li>비밀글 선택 <input type="radio" name="c_lock" id="c_lock" value="1">비공개
								 <input type="radio" name="c_lock" id="c_lock" value="0">공개</li>
			<li><textarea id="contents" name="contents" rows="5" cols="50"></textarea></li>
			<li><button type="button" id="update">작성하기</button>&nbsp;&nbsp;&nbsp;
					<button type="reset">다시하기</button>
					<button type="button" id="back">돌아가기</button></li>
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
var qna_idx = null;
$(function(){
	qna_idx =  parseInt(location.search.substring(1).split("=")[1]);
	//기존 값을 받아옴
	$.ajax({
		url: "../viewQnA/" + qna_idx,
		method:"GET",
		dataType:"json",
		success : function(data){
			var data = data.data;
			$("#title").val(data.title);
			$("#c_lock").val(data.c_lock);
			var value = data.c_lock.toString();
			//console.log(qna_idx);
			$('input[name="c_lock"]').val([value]);
			$("#contents").val(data.contents);
		}
	});
	
	//수정버튼
	$("#update").bind("click", function(){
		$.ajax({
			url:"../viewQnA/" + qna_idx,
			method : "PUT",
			dataType : "json",
			contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify({
				"title":$("#title").val(),
				"contents":$("#contents").val(),
				"c_lock":parseInt($("#c_lock").val())
			}),
			success : function(data){
				location.href = "/coffee/goQnA";
				alert("Update Success");
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	});
	
	//다시 돌아가기
	$("#back").bind("click", function() {
		history.back();
	});
});
</script>
</body>
</html>
