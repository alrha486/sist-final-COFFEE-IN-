<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 템플릿 부분(헷갈리지 말자....) -->
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 여기까지~ -->

<title>Insert title here</title>

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
		<h1>고객문의 게시판</h1>
		<br><br>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id="records"></tbody>
		</table>
		<button type="button" class="btn pull-right" id="btnWrite">글쓰기</button>
		
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
	$(function() {
		$.ajax({
			url:"qna",
			type:"json",
			method:"GET",
			success:function(data){
				var str="";
				var data = data.data;
				for(var i = 0; i < data.length ; i++){
					str += "<tr>";
					  str += "<td>" + data[i]["qna_idx"] + "</td><td> <a href='/coffee/viewQnA/" + data[i]["qna_idx"] +
						"'>" + data[i]["title"]+"</td>"
					  		+ "<td>" + data[i]["user_idx"] + "</td><td>" + data[i]["writedate"] +"</td>"
					  		+  "<td>" + data[i].readnum + "</td>";		 
					  str += "</tr>";
				}
				
				$("#records").html(str);
			}
		});
		$("#btnWrite").bind("click", function(){
			location.href = "write";
		});
	})
</script>
	    
</body>
</html>
