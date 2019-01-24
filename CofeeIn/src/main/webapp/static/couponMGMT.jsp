<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>


 <style>
		.a {
		   font-family: "Nanum Gothic", sans-serif;
		   text-align: center;
		}
</style>
  
        <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header" id="result1">쿠폰관리</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading" id ="result2">
                             <%@include file="coupon_management.jsp"%>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        
                          </div>
                        <!-- /.panel-body -->
                        </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
        <%@include file="includes/footer.jsp"%>

<script>
	$(document).ready(function(){
		var page=1;
		$.ajax({
			  url:"/coffee/admin/couponList/"+page,
			  type:"json",
			  method:"POST",
			  success : function(data) {
				  couponList(data);
			  },
			  error : function(err) {
					console.log("error 발생 : " + err);
			  }
		});
		
		$("#btnDelete").on("click", function() {
			var values=document.getElementsByName("check");
			for(var i=0; i<values.length; i++){
				if(values[i].checked){				
					$.ajax({
						url : "/coffee/admin/couponDelete/"+values[i].value,
						method : "DELETE",
						success : function(data) { // 삭제 성공하면							
						},
						error : function(err) {
							console.log("Error 발생 : " + err);
						}
					});
				}
			}
			alert("쿠폰이 삭제되었습니다.");
			location.replace("/coffee/couponMGMT");
		});
		
		$("#btnModify").on("click", function() {
			var length=0;
			var values=document.getElementsByName("check");
			for(var i=0; i<values.length; i++){
				if(values[i].checked){
					length+=1;
				}
			}
			if(length>1){
				alert("수정은 한 개만 선택 후 가능합니다.");
			} else if(length==1){
				for(var i=0; i<values.length; i++){
					if(values[i].checked){
						var value=values[i].value;
						var windowW=700;
						var windowH=600;
						var left = Math.ceil((window.screen.width - windowW)/2);
				        var top = Math.ceil((window.screen.height - windowH)/2);
				/*		$.ajax({
							url : "/coffee/couponModify/"+value,
							method : "GET",
							success : function(data) {
							},
							error : function(err) {
								console.log("Error 발생 : " + err);
							}
						});*/
				window.open("/coffee/couponModify/"+value, "쿠폰 수정 페이지", "width="+windowW+" height="+windowH+" top="+top+", left="+left+", toolbar=no, menubar=no, scrollbars=no, resizable=yes");
					}
				}
			}
		});
		
		$("#btnInsert").on("click", function() {
			location.href="/coffee/admin/couponInsert";
		});
		
		$("#btnIssue").on("click", function() {
			var length=0;
			var values=document.getElementsByName("check");
			for(var i=0; i<values.length; i++){
				if(values[i].checked){
					length+=1;
				}
			}
			if(length==0){
				alert("발급할 쿠폰을 선택해주세요.");
			}
			else if(length>1){
				alert("쿠폰 발급은 한 개만 선택 후 가능합니다.");
			} else if(length==1){
				for(var i=0; i<values.length; i++){
					if(values[i].checked){
						var value=values[i].value;
						var windowW=1600;
						var windowH=800;
						var left = Math.ceil((window.screen.width - windowW)/2);
				        var top = Math.ceil((window.screen.height - windowH)/2);
				        window.open("/coffee/couponIssue/"+value, "쿠폰 발급 페이지", "width="+windowW+" height="+windowH+" top="+top+", left="+left+", toolbar=no, menubar=no, scrollbars=no, resizable=yes");
					}
				}
			}
		});
		
	});
	
	function couponList(data){
		var str="";
		var totalCount = data.totalCount;
		var startPage = data.startPage;
		var totalPage = data.totalPage;
		var page = data.page;
		var data = data.data;
		$('#length').text(totalCount);
		
		for(var i = 0; i<data.length ; i++){		  
		  str += "<tr style='text-align:center;'>";
		  str += "<td style='vertical-align:middle;'><input type='checkbox' name='check' value='"+data[i].couponNum+"'></td>";
		  str += "<td style='vertical-align:middle;'>" + data[i].couponNum+ "</td>";
		  str += "<td style='vertical-align:middle;'>" + data[i].c_name +"</td>";
		  str += "<td style='vertical-align:middle;'>" + data[i].c_content +"</td>";
		  str += "<td style='vertical-align:middle;'>" + data[i].c_discount + "</td>";
		  str +=	 "<td style='vertical-align:middle;'>" + data[i].c_dead + "</td>";
		  str += "<td style='vertical-align:middle;'>" + data[i].c_condition + "</td>";
		  str += "</tr>";		 
		}
		
		$("#result").html(str);
		
		if (page == 1) { //현재 페이지가 1페이지
			pageStr = "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&lt;</a></li>";
		} else if (page != 1) {
			pageStr = "<li class='page-item'><a class='page-link' href='javascript:goPage("+ (page - 1) + ")'>&lt;</a></li>";
		}
		// 페이지 번호 (1~끝까지)
		for (var k = 1; k <= totalPage; k++) {
			if (page == k)
				pageStr += "<li class='page-item active'><a class='page-link' href='javascript:goPage(" + k + ")'>" + k + "</a></li>";
			else
				pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage("+ k + ")'>" + k + "</a></li>";
		}
		// 다음페이지 이동
		if (page == totalPage) {
			// 마지막 페이지에서 다음 페이지 누를 시
			pageStr += "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&gt;</a></li>";
		} else if (page != totalPage) { // 다음 페이지가 있으면
			pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage("+ (page + 1) + ")'>&gt;</a></li>";
		}

		$("#paging").html(pageStr);
	}
	
	function goPage(page) { 
		$.ajax({
			url : "/coffee/admin/couponList/"+page,
			dataType : "json",
			method : "POST",
			success : function(data) {
				couponList(data);
			}
		});
	}
</script>    
 <script src="static/js/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean"
   rel="stylesheet">
<link  href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean"
   rel="stylesheet">
	
	<link rel="stylesheet" href="static/css/custom.css" type="text/css" />

    <script src="static/resources/vendor/jquery/jquery.min.js"></script>
    <script src="static/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="static/resources/vendor/metisMenu/metisMenu.min.js"></script>
    <script src="static/resources/vendor/raphael/raphael.min.js"></script>
    <script src="static/resources/vendor/morrisjs/morris.min.js"></script>
    <script src="static/resources/data/morris-data.js"></script>
    <script src="static/resources/dist/js/sb-admin-2.js"></script>

<body>
</body>

</html>
