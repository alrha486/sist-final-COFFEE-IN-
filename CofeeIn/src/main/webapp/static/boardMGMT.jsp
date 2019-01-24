<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>

	<link rel="stylesheet" href="static/css/custom.css" />
    <script src="static/resources/vendor/jquery/jquery.min.js"></script>

    <script src="static/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <script src="static/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <script src="static/resources/vendor/raphael/raphael.min.js"></script>
    <script src="static/resources/vendor/morrisjs/morris.min.js"></script>
    <script src="static/resources/data/morris-data.js"></script>

    <script src="static/resources/dist/js/sb-admin-2.js"></script>
    
<script>
var page = null;
$(document).ready(function(){
	//모두보기
	$("#searchAll").bind("click", function(){
		$.ajax({
			url : "/coffee/adminlist/1",
			dataType : "json",
			method : "GET",
			success : function(data){
				display(data);
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	});
	
	//검색
	$("#search").bind("click", function(){
		var select = $('#select').val();
		var text= $('#keyword').val();
		$.ajax({			
			url : '/coffee/adminlist/'+select+'/' +text+'/1',
			dataType : "json",
			method : "GET",				
			success : function(data){   
				display(data);
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	});
	
});

function goPage(pge){ //page 이동
	page = pge;
	$.ajax({
		url : "/coffee/adminlist/" + pge,
		dataType : "json",
		method : "GET",
		success : function(result){
			display(result);
		}
	});
}

function display(result){
	var startPage = result.startPage;
	var totalPage = result.totalPage;
	var pageSize = result.pageSize;
	page = result.page;
	var data = result.data;
	var count = data.length;
	$("#count").text(count);
	var str = null;
	var recnt=0;
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
			var reply="";
				//만약 data[i].grp 도는 와중에 값이 같은 게 있는 애는 답변/ 아니면 미답변
				for(var j = 0 ; j<count ; j++){
					if(i!=j && data[i].grp == data[j].grp){
						reply="";
						break;
					}else if(data[i].grp != data[j].grp){
						reply="미답변";
						if(j==count-1){
							console.log(recnt);
							recnt++;
						}		
					}
				} 
		
			if(lev==0){
				str += "<tr>";
		 		str += "<td>" + qna.qna_idx + "</td><td><a id='"+data[i].qna_idx +"' onclick='reply()'>" + data[i]["title"] +
		 		"</td><td>"+reply+"</td>"	+ "<td>" + data[i]["userid"] + "</td><td>" + data[i]["writedate"] +"</td>";		 
		  		str += "</tr>";
			} else{
			str+=null;
			}
		
		}
	}
	$("#length").text(recnt);
	$("#result").html(str);
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
	
}

//답변화면으로(팝업)
function reply(){
	var qna_idx = window.event.target.id;
	console.log(qna_idx);
	var evt = window.event;
	var x = evt.screenX;
	var y = evt.screenY;
	window.open("admin_re/" +qna_idx , "_blank", 
			"left=" + x +", top=" + y + ", width=500,height=500");
}

</script>

<body>
<div>
				<div class="col-lg-12">
                    <h3 class="page-header" id="#">게시판 관리</h3>
                </div>
	<table class="table table-striped" >
            <tbody class="a">
               <tr >
                  <th class="text-center" >통합검색</th>
                  <th class="text-right">
                        <select class="form-control" name="select" id="select" style="width: 150px;float:left; margin-right:20px;">
                           <option value="1">전체</option>
                           <option value="1">제목</option>
                           <option value="2">작성자</option>
                        </select>
                     <div class="col-xs-2 "><input type="text" name="keyword" id="keyword" class="form-control"></div>
                     <button  class="btn btn-default " type="button" id="search">검색</button>
                     <button  class="btn btn-default" type="button" id="searchAll">모두보기</button>
                  </th>
               </tr>
            </tbody>
         </table> <!-- 검색바 테이블 -->
         
         <div class="col-md-12"  style="text-align: right; padding-left: 0px; padding-right: 0px; margin-bottom: 15px;">
            <span style="margin-bottom: 5px; font-size: 1.3em;">미답변 문의 수 : <span id="length"></span>개
            </span>
         </div>
         
	<table class="table table-striped" style="text-align: center;">
            <colgroup>
               <col style="width: 10%;">
               <col style="width: 30%;">
               <col style="width: 20%;">
               <col style="width: 20%;">
                <col style="width: 20%;">
               
            </colgroup>
            <thead class="a">
               <tr > 
                  <th style="text-align: center;">번호</th>
                  <th style="text-align: center;">제목</th>
                  <th style="text-align: center;"></th>
                  <th style="text-align: center;">작성자</th>
                  <th style="text-align: center;">작성일</th>
               </tr>
            </thead>
            <tbody id="result"  style="text-align: center;">
               
            </tbody>
         </table>
         
         <div id="paging"></div>
         
         </div>
   
   <%@include file="includes/footer.jsp"%>
</body>

</html>
