<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${not(empty param.p_idx) }">
	<c:set var="p_idx" value="${param.p_idx }" />

	
		${dc.delete(p_idx); ''}
		<script>
			self.close();
			opener.location.href = "list.jsp";
		</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/plugins.js"></script>
    <script src="static/js/active.js"></script>
    <script src="static/js/popper.min.js"></script>
    <script src="static/js/bootstrap.js"></script>

<title>Insert title here</title>
<script>
		$(function(){
			$("#cancle").click(function(evt){
				self.close();
				history.back();
			});
		});
	</script>
</head>
<body>
	<h5>정말 삭제하시겠습니까?</h5>
	<form method="post" action="delete.jsp">
		<input type="hidden" name="p_idx" value="${param.idx}" />
		<!-- <input type="submit" value="삭제하기"> -->
		<input type="submit" value="삭제하기">
		<button id="cancle" type="button">취소</button>
	</form>
</body>
</html>