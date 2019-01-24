<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 답변</title>

<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">
    
<script src="static/js/jquery.min.js"></script>
<script src="static/js/header.js"></script>
<script src="static/js/plugins.js"></script>
<script src="static/js/active.js"></script>
<script src="static/js/popper.min.js"></script>
<script src="static/js/bootstrap.js"></script>

<script>
	var qna_idx = null;
	$(function(){
	qna_idx =  parseInt(location.search.substring(1).split("=")[1]);
		$.ajax({
			url: "../answer/" + qna_idx,
			method:"GET",
			dataType:"json",
			success : function(data){
				var data = data.data;
				$("#title").val("RE:"+data.title);
				$("#c_lock").val(data.c_lock);
				var value = data.c_lock.toString();
				//console.log(qna_idx);
				$('input[name="c_lock"]').val([value]);
				$("#contents").val(data.contents);
			}
		});
	})

</script>

</head>
<body>
	<h1>게시판 글 답변하기</h1>
	<form>
		<input type="hidden" name="p_idx" value="${param.idx}" />
		<input type="hidden" name="p_grp" value="${grp}" />
		<input type="hidden" name="p_lev" value="${lev}" />
		<input type="hidden" name="p_step" value="${step}" />
		<ul>
			<li>Title : <input type="text" name="title" size="50" 
			        id="title"/></li>
			
			<li>Contents : <textarea name="contents" rows="5" cols="50">답글입니다.</textarea></li>
			<li><button type="submit">답변하기</button>&nbsp;&nbsp;&nbsp;
					<button type="reset">다시하기</button></li>
		</ul>
	</form>
</body>
</html>