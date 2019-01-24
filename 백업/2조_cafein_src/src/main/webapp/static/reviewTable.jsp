<!-- 처음에 보이는 화면. 게시판 리스트 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8"/>
<title>상품리뷰</title>

<script>
<%
	String productid=request.getParameter("productid");
%>
$(function() {
	var product_id=$("#productid").val();
	var page=1;
	//리스트에 글 내용 표시
  $.ajax({
	  url:"/coffee/reviews/"+product_id+"/"+page,
	  type:"json",
	  method:"POST",
	  success : function(data) {
		  display(data);
	  },
	  error : function(err) {
			console.log("error 발생 : " + err);
		}
  });
  
	//리뷰 작성하기 버튼 클릭
  $("#btnWrite").bind("click", function(){
	  if("${sessionScope.userid}" == ""){
		  alert("로그인 후 이용해주세요.");
		  return false;
	  }
	  location.href = "/coffee/write/"+product_id;
  });
});

	function goPage(product_id, page) { 
		$.ajax({
			url : "/coffee/reviews/"+product_id+"/"+page,
			dataType : "json",
			method : "POST",
			success : function(data) {
				display(data);
			}
		});
	}

	function display(data){
	  var product_id=$("#productid").val();
	  var str="";
	  var totalCount = data.totalCount;
	  var pageSize = data.pageSize;
	  var startPage = data.startPage;
	  var totalPage = data.totalPage;
	  var page = data.page;
	  var data = data.data;
	  
	  for(var i = 0; i<data.length ; i++){
		  var starimg="";
		  
		  if(data[i]["rev_score"] == 0){
			  starimg += "<img src='static/img/star0.JPG' width=120 height=25/>";
		  } else if(data[i]["rev_score"]==1){
			  starimg += "<img src='static/img/star1.JPG' width=120 height=25/>";
		  } else if(data[i]["rev_score"]==2){
			  starimg += "<img src='static/img/star2.JPG' width=120 height=25/>";
		  } else if(data[i]["rev_score"]==3){
			  starimg += "<img src='static/img/star3.JPG' width=120 height=25/>";
		  } else if(data[i]["rev_score"]==4){
			  starimg += "<img src='static/img/star4.JPG' width=120 height=25/>";
		  } else if(data[i]["rev_score"]==5){
			  starimg += "<img src='static/img/star5.JPG' width=120 height=25/>";
		  }
		  
		  str += "<tr>";
		  str += "<td>" + data[i]["rev_idx"] + "</td><td>" + data[i]["rev_title"]+"</td>"
		  		+ "<td>" + starimg + "</td><td>" + data[i]["userid"] +"</td>"
		  		+  "<td>" + data[i].rev_writedate + "</td><td><a class='showmore'>리뷰 내용 더보기</a></td>";		 
		  str += "</tr>";
		  str += "<tr class='detail'>";
		  str += "  <td colspan='6'>";
		  str += "    <div>";
		  str += "    <table class='table'>";
		  str+= "       <tr style='text-align:center; margin-left:auto; margin-right:auto;'><img src='static/img/product/"+ data[i].productname+ ".jpg' width='150' height='150'/></tr><br>";

		  str+= "       <tr>" +data[i].rev_contents + "</tr><br>";
		  if(data[i]["userid"] == "${sessionScope.userid}"){  
		  str+="<tr style='width:100%;float:right;'>";
		  //str+="<a href='/coffee/modify/" + product_id+"&" + data[i].rev_idx + " '>수정하기</a>";
		 str+="	<input type='button' style='float:right;' class='btn btn-outline-dark btn-lg' value='수정하기' onclick='rev_update();' id='"+data[i].rev_idx+"'>";
		  str+="	<input type='button' style='float:right;' class='btn btn-outline-dark btn-lg' value='삭제하기' onclick='rev_delete();' id='"+data[i].rev_idx+"'></tr>";
		  //str+="<a onclick='rev_delete()' id='"+data[i].rev_idx+"'>삭제하기</a></tr>"; 		  
		  }
		  else if(data[i]["userid"] != "${sessionScope.userid}"){
		  }
		  str+= "     </table>";
		  str+= "   </div>";
		  str+="  </td>";
		  str+="</tr>";
		 
	  }		  
	  $("#result").html(str);
	  
	  if (page == 1) { //현재 페이지가 1페이지
			pageStr = "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&lt;</a></li>";
		} else if (page != 1) {
			pageStr = "<li class='page-item'><a class='page-link' href='javascript:goPage(\"" + product_id + "\"," + (page - 1) + ")'>&lt;</a></li>";
		}
		// 페이지 번호 (1~끝까지)
		for (var k = 1; k <= totalPage; k++) {
			if (page == k)
				pageStr += "<li class='page-item active'><a class='page-link' href='javascript:goPage(\"" + product_id + "\"," + k + ")'>" + k + "</a></li>";
			else
				pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage(\"" + product_id + "\"," + k + ")'>" + k + "</a></li>";
		}
		// 다음페이지 이동
		if (page == totalPage) {
			// 마지막 페이지에서 다음 페이지 누를 시
			pageStr += "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&gt;</a></li>";
		} else if (page != totalPage) { // 다음 페이지가 있으면
			pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage(\"" + product_id + "\"," + (page + 1) + ")'>&gt;</a></li>";
		}

		$("#paging").html(pageStr);
	  
	  //리뷰 내용 더보기 클릭
	  $('a.showmore').click(function(e) {
		    e.preventDefault();
		    var targetrow = $(this).closest('tr').next('.detail');
		    targetrow.show().find('div').slideToggle('slow', function(){
			      if (!$(this).is(':visible')) {
			        targetrow.hide();
			      }
	   		 });
	   });
	}
	
	   function rev_delete() { // 자신의 리뷰 삭제
	   	$.ajax({
		         url : "/coffee/delete/" +event.srcElement.id,
		         method : "DELETE",
		         success : function(data) {
		            alert("해당 리뷰가 삭제되었습니다.");		           
		            window.location.reload(); // 페이지 새로고침
		         },
		         error : function(err) {
		            console.log("Error 발생 : " + err);
		         }
		      });
		   }
	   
	   function rev_update() { // 자신의 리뷰 삭제
		   var product_id=$("#productid").val();
		   var test=  product_id + '&' +event.srcElement.id ;
   	   
			location.href='/coffee/modify/' + test; 
			   }
</script>
<style type="text/css">
tr.detail {
  display: none;
  width: 100%;
}
tr.detail div {
  display: none;
}
.showmore:hover {
  cursor: pointer;
}
</style>
</head>
<body>
	<table class="table">
 		<thead>
 			<tr>
 				<th>번호</th><th>제목</th><th>별점</th>
 				<th>작성자</th><th>날짜</th><th>&nbsp;</th>
 		</thead>
 		<tbody id="result">
 			
 		</tbody>
 	</table>
 	<div>
		<ul class="pagination" id="paging" style="text-align:center;"></ul>
	</div>
 	<input type="button" style="float:right;min-width: 180px;" class="btn btn-outline-dark btn-lg" id="btnWrite" value="리뷰작성">
</body>
</html>