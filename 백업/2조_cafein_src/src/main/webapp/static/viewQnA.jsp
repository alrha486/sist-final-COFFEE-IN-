<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="qna" value="${qna}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 템플릿 부분(헷갈리지 말자....) -->
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!--  css  -->
<link rel="stylesheet" href="static/style.css" />
<link rel="stylesheet" href="static/css/bootstrap.css" />
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">

<script src="static/js/jquery.min.js"></script>
<script src="static/js/header.js"></script>

<!-- 여기까지~ -->

<title>문의사항-게시글 보기</title>


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
    
   <table class="table">
   	<tbody id="v1">
   	</tbody>
      
   </table>
   
   <table class="table">
    <tr>
         <td colspan="2" style="text-align: right;">
            <button id="list" type="button" class="btn">목록으로</button>
            <button id="update" type="button" class="btn">수정하기</button>
            <button id="delete" type="button" class="btn">삭제하기</button>
            <button id="reply" type="button" class="btn">답변하기</button>
         </td>
      </tr>
   
   </table>
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
$(function() {
	qna_idx =  parseInt(location.search.substring(1).split("=")[1]);
	//console.log(qna_idx);

	$.ajax({
		url: "/coffee/viewQnA/" + qna_idx,
		method:"GET",
		dataType:"json",
		success:function(data){
			var str="";
			var data = data.data;
			console.log(data);			
			str = " <tr>" +
		      		"<th>" + data.title + "</th>"+
		      	   "<th>No."+data.qna_idx + "</th>" +
		    	  "</tr>" +
		   
		      "<tr>" +
		         "<td>작성날짜&nbsp;&nbsp;&nbsp;"+data.writedate + "</td>" +
		         "<td>조회수&nbsp;&nbsp;&nbsp;" + data.readnum + "</td>" +
		      "</tr>" +
		      "<tr>" +
		         "<td colspan='2'>" +
		           data.contents +
		         "</td>" +
		      "</tr>" ; 
		      
			  $("#v1").html(str);
		}
	}); 
	
	$("#list").bind("click", function() {
		history.back();
	});

	$("#delete").bind("click", function() {
		$.ajax({
			url : "/coffee/viewQnA/" + qna_idx,
			method : "DELETE",
			success : function(data) {
				if (data.code) {
					alert("Delete Success");
					location.href = "/coffee/goQnA";
				}
			},
			error : function(err) {
				console.log("Error 발생 : " + err);
			}
		});
	});
	
	$("#update").bind("click", function() {
		location.href = "update.jsp?qna_idx="+qna_idx;
	});
	
	$("#reply").click(function() {
		//location.href = "../answer/" + qna_idx;
		location.href = "re.jsp?qna_idx="+qna_idx;
	});
		
});
</script>
</body>
</html>
