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
$(document).ready(function(){
	var page=1;
	$.ajax({
	  url:"/coffee/productListSS/"+page,
	  type:"json",
	  method:"GET",
	  success : function(data) {
		  searchAll(data);
	  },
	  error : function(err) {
			console.log("error 발생 : " + err);
	  }
    });
	
	$("#searchAll").click(function() { // 전체 검색 클릭
		var page=1;
		$.ajax({
		  url:"/coffee/productListSS/"+page,
		  type:"json",
		  method:"GET",
		  success : function(data) {
			  searchAll(data);
		  },
		  error : function(err) {
				console.log("error 발생 : " + err);
		  }
	  });
	});
	
	$("#search").bind("click", function(){
		var p_type = $('#producttype').val();
		var p_name= $('#productname').val();
		var page=1;
		
		if(p_name==""){
			alert("검색할 상품의 이름을 입력해주세요");
		} else if(p_type==0){
			alert("검색할 상품의 종류를 선택해주세요");
		} else if(p_name!="" && p_type!=0){
			$.ajax({			
				url : "/coffee/productSelectSS/"+p_type+"/"+p_name+"/"+page,
				dataType : "json",
				method : "GET",				
				success : function(data){ 
					search(data);
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
		}
	});
	
	$("#btnDelete").on("click", function() { // 선택상품삭제
		var values=document.getElementsByName("check");
		for(var i=0; i<values.length; i++){
			if(values[i].checked){				
				$.ajax({
					url : "/coffee/productDelete/"+values[i].value,
					method : "DELETE",
					success : function(data) {
						
					},
					error : function(err) {
						console.log("Error 발생 : " + err);
					}
				});			
			}
		}
		alert("선택하신 상품이 삭제되었습니다.");
		window.location.reload();
	});
	
	$("#btnModify").on("click", function() { // 선택상품 수정
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
					var windowH=760;
					var left = Math.ceil((window.screen.width - windowW)/2);
			        var top = Math.ceil((window.screen.height - windowH)/2);
			        window.open("/coffee/modifyProductOne/"+value, "상품 수정 페이지", "width="+windowW+" height="+windowH+" top="+top+", left="+left+", toolbar=no, menubar=no, scrollbars=no, resizable=yes");
				}
			}
		}
	});
	
});

function goPage(page) { 
	$.ajax({
		url : "/coffee/productListSS/"+page,
		dataType : "json",
		method : "GET",
		success : function(data) {
			searchAll(data);
		}
	});
}
function goPage2(p_type, p_name, page) {
	$.ajax({
		url : "/coffee/productSelectSS/"+p_type+"/"+p_name+"/"+page,
		dataType : "json",
		method : "GET",
		success : function(data) {
			search(data);
		}
	});
}

function searchAll(data){
	var str="";
	var totalCount = data.totalCount;
	var pageSize = data.pageSize;
	var startPage = data.startPage;
	var totalPage = data.totalPage;
	var page = data.page;
	var data = data.data;
	$('#length').text(totalCount);
	
	for(var i = 0; i<data.length ; i++){
		  //상품 이미지

		  //상품 종류
		  var kind_idx=data[i].kind_idx;
		  var kind="";
		  if(kind_idx==1){kind="Beans(Coffee)";} else if(kind_idx==2){kind="Bottle Coffee(Coffee)"}
		  	else if(kind_idx==3){kind="Drip Bag(Coffee)"} else if(kind_idx==4){kind="Cake(Foods)"}
			else if(kind_idx==5){kind="Bakery(Foods)"} else if(kind_idx==6){kind="Sandwich(Foods)"}
			else if(kind_idx==7){kind="Mug(Goods)"} else if(kind_idx==8){kind="Tumbler(Goods)"}
			else if(kind_idx==9){kind="Accessory(Goods)"}
		  
		  str += "<tr style='text-align:center;'>";
		  str += "<td style='vertical-align:middle;'><input type='checkbox' name='check' value='"+data[i].productid+"'></td>";
		  str += "<td style='vertical-align:middle;'>" + data[i]["productid"] + "</td>";
		  str += "<td style='vertical-align:middle;'><img src='static/img/product/" + data[i]["productname"] +".jpg' style='width:100px; height:100px;'></a></td>";
		  str += "<td style='vertical-align:middle;'>" + data[i]["productname"] +"</td><td style='vertical-align:middle;'>" + kind + "</td>";
		  str +=	 "<td style='vertical-align:middle;'>" + data[i].price + "</td><td style='vertical-align:middle;'>" + data[i].sell_count + "</td>";
		  str +=	 "<td style='vertical-align:middle;'>" + data[i].stock + "</td>";
		  str += "</tr>";		 
	}
	
	$("#result").html(str);

	/* var count = data.length; */
	
	if (page == 1) { //현재 페이지가 1페이지
		pageStr = "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&lt;</a></li>";
	} else if (page != 1) {
		pageStr = "<li class='page-item'><a class='page-link' href='javascript:goPage(" + (page - 1) + ")'>&lt;</a></li>";
	}
	// 페이지 번호 (1~끝까지)
	for (var k = 1; k <= totalPage; k++) {
		if (page == k)
			pageStr += "<li class='page-item active'><a class='page-link' href='javascript:goPage(" + k + ")'>" + k + "</a></li>";
		else
			pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage(" + k + ")'>" + k + "</a></li>";
	}
	// 다음페이지 이동
	if (page == totalPage) {
		// 마지막 페이지에서 다음 페이지 누를 시
		pageStr += "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&gt;</a></li>";
	} else if (page != totalPage) { // 다음 페이지가 있으면
		pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage(" + (page + 1) + ")'>&gt;</a></li>";
	}

	$("#paging").html(pageStr);
}

function search(data){
	var p_type = $('#producttype').val();
	var p_name= $('#productname').val();
	var str="";
	var totalCount = data.totalCount;
	var pageSize = data.pageSize;
	var startPage = data.startPage;
	var totalPage = data.totalPage;
	var page = data.page;
	var data = data.data;
	$('#length').text(totalCount);
	
	for(var i = 0; i<data.length ; i++){
		
		  //상품 종류
		  var kind_idx=data[i].kind_idx;
		  var kind="";
		  if(kind_idx==1){kind="Beans(Coffee)";} else if(kind_idx==2){kind="Bottle Coffee(Coffee)"}
		  	else if(kind_idx==3){kind="Drip Bag(Coffee)"} else if(kind_idx==4){kind="Cake(Foods)"}
			else if(kind_idx==5){kind="Bakery(Foods)"} else if(kind_idx==6){kind="Sandwich(Foods)"}
			else if(kind_idx==7){kind="Mug(Goods)"} else if(kind_idx==8){kind="Tumbler(Goods)"}
			else if(kind_idx==9){kind="Accessory(Goods)"}
		  
		  str += "<tr style='text-align:center;'>";
		  str += "<td style='vertical-align:middle;'><input type='checkbox' name='check' value='"+data[i].productid+"'></td>";
		  str += "<td style='vertical-align:middle;'>" + data[i]["productid"] + "</td>";
		  str += "<td style='vertical-align:middle;'><img src='static/img/product/" + data[i]["productname"] +".jpg' style='width:100px; height:100px;'></a></td>";
		  str += "<td style='vertical-align:middle;'>" + data[i]["productname"] +"</td><td style='vertical-align:middle;'>" + kind + "</td>";
		  str +=	 "<td style='vertical-align:middle;'>" + data[i].price + "</td><td style='vertical-align:middle;'>" + data[i].sell_count + "</td>";
		  str +=	 "<td style='vertical-align:middle;'>" + data[i].stock + "</td>";
		  str += "</tr>";		 
	}
	
	$("#result").html(str);

	/* var count = data.length; */
	
	if (page == 1) { //현재 페이지가 1페이지
		pageStr = "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&lt;</a></li>";
	} else if (page != 1) {
		pageStr = "<li class='page-item'><a class='page-link' href='javascript:goPage2("+ p_type + ",\"" + p_name + "\"," + (page - 1) + ")'>&lt;</a></li>";
	}
	// 페이지 번호 (1~끝까지)
	for (var k = 1; k <= totalPage; k++) {
		if (page == k)
			pageStr += "<li class='page-item active'><a class='page-link' href='javascript:goPage2("+ p_type + ",\"" + p_name + "\"," + k + ")'>" + k + "</a></li>";
		else
			pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage2("+ p_type + ",\"" + p_name + "\"," + k + ")'>" + k + "</a></li>";
	}
	// 다음페이지 이동
	if (page == totalPage) {
		// 마지막 페이지에서 다음 페이지 누를 시
		pageStr += "<li class='page-item'><a class='page-link' href='javascript:void(0)'>&gt;</a></li>";
	} else if (page != totalPage) { // 다음 페이지가 있으면
		pageStr += "<li class='page-item'><a class='page-link' href='javascript:goPage2("+ p_type +"," + ",\"" + p_name + "\"," + (page + 1) + ")'>&gt;</a></li>";
	}

	$("#paging").html(pageStr);
}
</script>

<body>

      			<div class="col-lg-12">
                    <h3 class="page-header" id="result1">상품관리</h3>
                </div>
   <br/><br/>
	<a href="/coffee/admin/productInsert" class="badge badge-danger">상품 등록</a>

   <br>
   <br>

   <div>
      <div>
         <table class="table table-striped">
            <tbody class="a">
               <tr>
                  <th class="align-middle"  style="text-align: center;width:130px">상품명</th>
                  <td style="width:300px">
                     <input  class="form-control input-sm" type="text" name="productname" id="productname" style="width:250px" value="">
                  </td>
                  <th class="align-middle"  style="text-align: center;width:130px">구분</th>
                  <td  style="width:450px">
                     <select  class="form-control input-sm" name="producttype" id="producttype" style="width:200px;float: left; margin-right:40px ">
                        <option value="0">--상품 구분 선택--</option>
                       	<option value="1">Beans(Coffee)</option>
						<option value="2">Bottle Coffee(Coffee)</option>
						<option value="3">Drip Bag(Coffee)</option>
						<option value="4">Cake(Foods)</option>
						<option value="5">Bakery(Foods)</option>
						<option value="6">Sandwich(Foods)</option>
						<option value="7">Mug(Goods)</option>
						<option value="8">Tumbler(Goods)</option>
						<option value="9">Accessory(Goods)</option>
                     </select>
                     <!-- <select class="form-control input-sm"  name="select" id="select" style="width:150px">
                        <option value="0">--노출 여부 선택--</option>
                        <option value="1">노출</option>
                        <option value="2">미노출</option>
                     </select> -->
                  </td>
                  <th style="width:300px">
                     <button  class='btn btn-primary'  type="button" id="search">검색</button>
                     <button  class='btn btn-warning'  type="button" id="searchAll">전체검색</button>
                  </th>
               </tr>
            </tbody>
         </table><br><br> <!--  검색창 테이블 -->

            <div style="text-align: right;padding-left: 0px; padding-right: 0px; margin-bottom: 15px;">
                  <span style="margin-bottom: 5px; font-size: 1.3em;">검색 된 상품 수 : <span id="length" id="count">0</span>개</span>
            <span style="padding-right: 0px; margin-bottom: 5px; margin-bottom: 15px; margin-left: 20px;">
                  <button type="button" class='btn btn-success' id="btnModify">선택상품 수정</button>
                  <button type="button" class='btn btn-danger' id="btnDelete">선택상품 삭제</button>
            </span>
            </div>
            
            <table class="table table-striped">
               <thead class="a">
                  <tr>
                  	 <th style="text-align: center;width:5%"></th>
                     <th style="text-align: center;width:5%">상품번호</th>
                     <th style="text-align: center;width:10%">이미지</th>
                     <th style="text-align: center;width:30%">상품명</th>
                     <th style="text-align: center;width:15%">상품종류</th>
                     <th style="text-align: center;width:10%">가격</th>
                     <th style="text-align: center;width:10%">판매량</th>
                     <th style="text-align: center;width:10%">재고량</th>
                  </tr>
               </thead>
               <tbody id="result">
                  
               </tbody>
            </table>
      </div>
      <div class="container2">
	     <ul class="pagination" id="paging" style="text-align:center;"></ul>
	  </div>
   </div>
   
   <%@include file="includes/footer.jsp"%>
</body>

</html>
