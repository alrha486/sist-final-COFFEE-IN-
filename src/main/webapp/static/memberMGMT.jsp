<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="memSearch"  value="${data}" />

<%@include file="includes/header.jsp"%>     
    <script src="static/resources/vendor/jquery/jquery.min.js"></script>
    <script src="static/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="static/resources/vendor/metisMenu/metisMenu.min.js"></script>
    <script src="static/resources/vendor/raphael/raphael.min.js"></script>
    <script src="static/resources/vendor/morrisjs/morris.min.js"></script>
    <script src="static/resources/data/morris-data.js"></script>
    <script src="static/resources/dist/js/sb-admin-2.js"></script>
<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
   
}
</style>
<script>
	var page = null;
	$(document).ready(function(){		
		
		$("#searchAll").bind("click", function(){ //모두 보기(주문 내역 모두 조회)
			var sort = $('#sort').val();
			console.log( $('#sort').val());
			$.ajax({			
				url : "/coffee/memberList/" + sort+"/1",
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
		
		//검색. 
		$("#search").bind("click", function(){
			var select = $('#select').val();
			var text= $('#keyword').val();
			$.ajax({			
				url : '/coffee/memberSelect/'+select+'/' +text+'/1',
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
		
		//삭제
		$("#memDelete").bind("click", function(){
			var checkboxValues = [];
		    $("input[name='check']:checked").each(function(i) {
		        checkboxValues.push($(this).val());
		    });
			for(var i=0 ; i < checkboxValues.length ; i++){
				var userid = checkboxValues[i];
				$.ajax({
					url:"/coffee/deleteMember/" + userid,
					method : "DELETE",
					success : function(data) {
						alert("선택하신 회원이 삭제되었습니다.");
						location.reload(true);
					},
					error : function(err) {
						console.log("Error 발생 : " + err);
					}
				}); 
			}	
		});
		
		//정렬
		$("#sort").bind("change",function(){
			var sort = $('#sort').val();
			$.ajax({			
				url : "memberList/"+sort+"/1",
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
	
	//출력 부분
	function display(data){
		var str=null;
		var startPage = data.startPage;
		var totalPage = data.totalPage;
		var pageSize = data.pageSize;
		page = data.page;  //current Page
		var data = data.data;
		$("#length").text(data.length);
		for(var i=0 ; i<data.length ; i++){
			str += "<tr >" +
			"<td><input type='checkbox' id ='check' name='check' value='"+data[i].userid +" '></td>" +
            "<td style='text-align: center;'>"+ data[i].userid +"</td>" +
            "<td style='text-align: center;'>"+ data[i].username +"</td>" +
            "<td style='text-align: center;'>"+ data[i].usernickname +"</td>" +
            "<td style='text-align: center;'>"+ data[i].tel +"</td>" +
            "<td style='text-align: center;'>"+ data[i].email +"</td>" +
            "<td style='text-align: center;'>"+ data[i].zipcode +"</td>" +
            "<td style='text-align: center;'>"+ data[i].address1 +"</td>" +
            "<td style='text-align: center;'>"+ data[i].regdate +"</td>" +
         "</tr>";	
		}
		$("#result").html(str);
		$("#paging").empty();
		$("#paging").attr("style", "text-align:center");
		
		var pageStr = null;
		
		//페이징 부분
		//1페이지일때.
		if(page == 1) {
			pageStr = "&lt;&lt;&nbsp;&nbsp;";
			pageStr += "&lt;&nbsp;&nbsp;";
		}else if(page != 1) {
			pageStr = "<a href='javascript:goPage(1)'>&lt;&lt;</a>&nbsp;&nbsp;";
			pageStr += "<a href='javascript:goPage(" + (startPage) +
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
		}else if(page != totalPage){
			pageStr += "<a href='javascript:goPage(" + (startPage + pageSize) +
			")'>&gt;</a>&nbsp;&nbsp;";
			pageStr += "<a href='javascript:goPage(" + totalPage +
			")'>&gt;&gt;</a>";
		}
		
		$("#paging").html(pageStr);
	}
	
	function goPage(pge){ //page 이동
		var sort = $('#sort').val();
		page = pge;
		$.ajax({
			url : "memberList/"+sort+"/" + pge,
			dataType : "json",
			method : "GET",
			success : function(data){
				display(data);
			}
		});
	}
</script>

<body>
      			<div class="col-lg-12">
                    <h3 class="page-header">회원관리</h3>
                </div>
   <br/><br/>
   <div >
         <table class="table table-striped" >
            <tbody class="a">
               <tr >
                  <th class="text-center" >통합검색</th>
                  <th class="text-right">
                        <select class="form-control" name="select" id="select" style="width: 150px;float:left; margin-right:20px;">
                           <option value="1">전체</option>
                           <option value="1">회원명</option>
                           <option value="2">휴대폰번호</option>
                           <option value="3">아이디</option>
                        </select>
                     <div class="col-xs-2 "><input type="text" name="keyword" id="keyword" class="form-control"></div>
                     <button  class="btn btn-warning " type="button" id="search">검색</button>
                     <button  class="btn btn-danger" type="button" id="searchAll">모두보기</button>
                  </th>
               </tr>
            </tbody>
         </table> <!-- 검색바 테이블 -->
         
         <br/><br/>
         <div class="col-md-12"
            style="text-align: right; padding-left: 0px; padding-right: 0px; margin-bottom: 15px;">
            <select class="form-control" name="sort" id="sort" style="width: 150px;float:left; margin-right:20px;">
                    <option value="0">정렬</option>
                    <option value="1">총구매금액 순</option>
                    <option value="2">가입일자 순</option>
            </select>
            <span style="margin-bottom: 5px; font-size: 1.3em;">총 회원수 : <span id="length"></span>명
            </span> <span style="margin-bottom: 5px; margin-left: 20px;">
               <button type="button"  class='btn btn-primary'  id="memDelete">선택회원 삭제</button>
            </span>
         </div>
         <table class="table table-striped" style="text-align: center;">
            <colgroup>
               <col style="width: 2%;">
               <col style="width: 8%;">
               <col style="width: 8%;">
               <col style="width: 10%;">
               <col style="width: 12%;">
               <col style="width: 12%;">
               <col style="width: 5%;">
               <col style="width: 20%;">
               <col style="width: 10%;">
               
            </colgroup>
            <thead class="a">
               <tr >
                  <th style="text-align: center;">#</th>
                  <th style="text-align: center;">아이디</th>
                  <th style="text-align: center;">회원명</th>
                  <th style="text-align: center;">닉네임</th>
                  <th style="text-align: center;">휴대폰번호</th>
                  <th style="text-align: center;">이메일주소</th>
                  <th style="text-align: center;">우편번호</th>
                  <th style="text-align: center;">주소</th>
                  <th style="text-align: center;">회원가입일자</th>
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
