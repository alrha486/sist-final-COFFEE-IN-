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

<title>Insert title here</title>

<!--  css  -->
    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
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
            <h2>Q&A</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    
     <!-- ##### Events Area Start ##### -->

		<section class="events-area section-padding-100">
        <div class="container">
		<h4>고객문의 게시판</h4>
		<br>
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
		<button type="button" class="btn btn-danger pull-right" id="btnWrite">글쓰기</button>
		<input type="hidden" id="userid" value="${sessionScope.userid}">
		<div id="paging"></div>
		</div>
    </section>

	    <!-- ##### Events Area End ##### -->
	    
	<!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />  
    <!-- ##### Footer Area End ##### -->
    
    <script src="static/js/jquery-2.2.4.min.js"></script>
    <script src="static/js/plugins.js"></script>
    <script src="static/js/active.js"></script>
    <script src="static/js/popper.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    
<script>
var page = null;
$(document).ready(function(){
	

	
	
	
	
////////////////////////////////////	
	$.ajax({
		url : "qna/1",
		dataType : "json",
		method : "GET",
		success : function(data){
			display(data);
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});
	
	$("#btnWrite").bind("click", function(){
		if($('#userid').val() != "" ){
			location.href = "write";
		}else if($('#userid').val() == "" ){
			alert("로그인 후 이용해 주세요.");
		}
	})	;
	
});

function goPage(pge){ //page 이동
	page = pge;
	$.ajax({
		url : "qna/" + pge,
		dataType : "json",
		method : "GET",
		success : function(result){
			display(result);
		}
	});
}

function display(result){
	console.log("${sessionScope.userid}");
	var startPage = result.startPage;
	//var endPage = result.endPage;
	var totalPage = result.totalPage;
	var pageSize = result.pageSize;
	page = result.page;  //current Page
	var data = result.data;
	var count = data.length;
	$("#count").text(count);
	var str = null;
	if(count == 0) {
		str = "<tr>";
		str += "<td colspan='5' align='center'>";
		str += "글이 없습니다.</td>";
		str += "</tr>";
	}else if(count > 0){
	for(var i = 0 ; i < count ; i++){
		var qna = data[i];	
		var lev = qna.lev;
		var lock = qna.c_lock;
		var reply = "";
		var lockimg="";
		var qna_idx = "";
		if(lev > 0) {
			for(var j = 0 ; j < lev ; j++){
				reply +="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			reply+="<img src='static/img/re.png' style='width:18px;height:18px'/>&nbsp;";
			qna_idx="";
		}else{
			reimg = "";
			qna_idx = data[i]["qna_idx"]
		}
		
		if(lock==0){
			lockimg += "<img src='static/img/rock.png' style='width:17px;height:17px'/>";
		}else{
			lockimg="";
		}
		str += "<tr>";
		// view/글번호
		 str += "<td>" + qna_idx + "</td><td>" + reply +"<a id='"+data[i].qna_idx +"' onclick='block()'>" + data[i]["title"] +"&nbsp;"+lockimg+"</td>"
		  		+ "<td>" + data[i]["userid"] + "</td><td>" + data[i]["writedate"] +"</td>"
		  		+  "<td>" + data[i].readnum + "</td>";		 
		  str += "</tr>";
		
		}
	}
	$("#records").html(str);
	$("#paging").empty();
	$("#paging").attr("style", "text-align:center");
	
	var pageStr = null;
	
	//1페이지일때.
	if(page == 1) {
		pageStr = "&lt;&lt;&nbsp;&nbsp;";
		pageStr += "&lt;&nbsp;&nbsp;";
	}else if(page != 1) {
		pageStr = "<a href='javascript:goPage(1)'>&lt;&lt;</a>&nbsp;&nbsp;";
		pageStr += "<a href='javascript:goPage(" + (startPage - pageSize) +
		")'>&lt;</a>&nbsp;&nbsp;";
	}
	
	//페이지 번호...
	for(var k = startPage ; k <= totalPage ; k++){
		if(page == k) pageStr += "<span style='color:red;font-weight:bold'>" +
		k + "</span>&nbsp;&nbsp;&nbsp;";
		else pageStr += "<a href='javascript:goPage(" + k + ")'>" + k +
		"</a>&nbsp;&nbsp;&nbsp;";
	}
	
	//다음으로 이동
	if(page == totalPage) {
		pageStr += "&gt;</a>&nbsp;&nbsp;";
		pageStr += "&gt;&gt;";
		//pageStr += "<img src='static/img/arrow2.png' style='width:17px;height:17px'/>"
	}else if(page != totalPage){
		pageStr += "<a href='javascript:goPage(" + (startPage + pageSize) +
		")'>&gt;</a>&nbsp;&nbsp;";
		pageStr += "<a href='javascript:goPage(" + totalPage +
		")'>&gt;&gt;</a>";
	}
	
	$("#paging").html(pageStr);
	
} // display 끝
function block(){
	var qna_idx = window.event.target.id;
	var userid = '${sessionScope.userid}';
	$.ajax({
		url : "qnaSearch/" + qna_idx,
		dataType : "json",
		method : "GET",
		success : function(result){
			var data = result.data;
			if(data[0].c_lock==0){
				if(data[0].userid == userid || userid == 'wlsdnd123'){
					location.href= '/coffee/viewQnA/'+qna_idx;
				}else{
					alert("비밀글입니다.");	
				}
			} else {
				location.href= '/coffee/viewQnA/'+qna_idx;
			}
			
		}

	});
}
</script>
	    
</body>
</html>
