<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>
    <!-- jQuery -->
    <script src="static/resources/vendor/jquery/jquery.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="static/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="static/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="static/resources/vendor/raphael/raphael.min.js"></script>
    <script src="static/resources/vendor/morrisjs/morris.min.js"></script>
    <script src="static/resources/data/morris-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="static/resources/dist/js/sb-admin-2.js"></script>
<style>
.a {
   font-family: "Nanum Gothic", sans-serif;
   text-align: center;
}
</style>

<script>

	$(function(){
		
		$.ajax({
			url : "/coffee/admin/order",             // 상품이름 받아오기..
			method : "get",
			data : "json",
			error : function(){
				console.log("상품 이름을 받아오는데 실패했습니다.");
			},
			success : function(data){
				console.log("상품 이름을 받아오는데 성공했습니다.");
    			
				if( data.rows.length > 0 ){

    				var options = '<option value="">--선택--</option>';

    				for (var i = 0; i < data.rows.length; i++)
    				{
    					options += '<option value="' + data.rows[i].productid + '">' + data.rows[i].productname + '</option>';
    				}

    				$("#orderPname").html(options);
    				//$("#orderPname").val(orderPnameValue).attr("selected","selected");
     				//$("#gugun option[value=").attr("selected","selected");

    			}else{

    				var options = '<option value="">--선택--</option>';

    				alert($("#orderPname").html());
    				$("#orderPname").html(options);
    				$('#orderPname option:first').attr('selected', 'selected');

    			}
    		}
		}); // ajax END..
		
		/* $("#datepicker1, #datepicker2").datepicker();   // 날짜 선택 .. */
	
		   document.getElementById("today").addEventListener('click', today); // 오늘 
		   document.getElementById("week").addEventListener('click', week); // 일주일 전
	       document.getElementById("month").addEventListener('click', month); // 한달전 
		
		
		
	});  // load END ...
	


	  function allselect(){ // 전체 검색 ..
		  
		  $.ajax({ 
			  url : "/coffee/admin/order/allselect",
			  method : "get",
			  data : "json",
			  error : function(){
				console.log("전체 검색 오류");  
			  },
			  success : function(data){
				  console.log("전체 검색 성공");
				  var data = data.data;
				  var orderlist = "";
				  if(data.length > 0){
					  for(var i = 0 ; i < data.length ; i++){
						  
						  switch(data[i].o_state){
						  case "1" : data[i].o_state = "주문확인"; break;
						  case "2" : data[i].o_state = "배송중"; break;
						  case "3" : data[i].o_state = "배송완료"; break;
						  }
						  
						  
						  switch(data[i].payid){
						  case "1" : data[i].payid = "신용카드"; break;
						  case "2" : data[i].payid = "무통장입금"; break;
						  case "3" : data[i].payid = "휴대폰소액결제"; break;
						  case "4" : data[i].payid = "카카오페이"; break;
						  }
						  
						  orderlist += "<tr>";
						  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].orderid + "</td>";
						  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].selldate + "</td>";
						  orderlist += "<td style='width: 30%;text-align:center;'>" + data[i].productname + "</td>";	
						  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].pcount + "</td>";
						  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].price + "</td>";
						  orderlist += "<td style='width: 12%;text-align:center;'>" + data[i].payid + "</td>";
						  orderlist += "<td style='width: 12%;text-align:center;'>" + data[i].username + "</td>";													  
						  orderlist += "<td style='width: 20%;text-align:center;'>" + data[i].o_state;
						  if(data[i].o_state == "주문확인"){
								 orderlist += "&nbsp;&nbsp;&nbsp;<button id='"+data[i].orderid +"' name='"+data[i].o_state+"&" +data[i].userid + "' type='button' class='btn btn-warning btn-sm' onclick='orderStateChange();'>배송시작처리</button></td>";
							 }else if(data[i].o_state == "배송중"){
								 orderlist += "&nbsp;&nbsp;&nbsp;<button id='"+data[i].orderid +"' name='"+data[i].o_state+"&" +data[i].userid + "' type='button' class='btn btn-danger btn-sm' onclick='orderStateChange();'>배송완료처리</button></td>";
							 }else{
								 orderlist += "&nbsp;&nbsp;&nbsp;<button id='"+data[i].orderid +"' name='"+data[i].o_state+"&" +data[i].userid + "' type='button' class='btn btn-success btn-sm'>배송완료</button></td>";
							 }
						  
						  
						  orderlist += "</tr>";
						  
					  }
				  } 
				  $("#length").text(data.length);
				  $("#orderResult").html(orderlist);
			  } // success END...
			  
		  }); // ajax END...
	  }

//  -------------------------------------------------------------------------------------------

///////////////////////  선택 검색 ///////////////////////////

function testanyselect(){
	   var productname = $("#orderPname option:selected").text();
	   var datepicker1 = $("#datepicker1").val();
	   var datepicker2 = $("#datepicker2").val();
	   var deliveryStep = $("#deliveryStep option:selected").val();
	   /* var orderlist = $("#orderlist option:selected").text(); */
	   var orderlist = $("#orderlist option:selected").val();
	   var payid = $("#payid option:selected").val();	

	   
	   if(datepicker1 == ""){
		   datepicker1 = "2000-01-01";
	   }
	   if(datepicker2 == ""){
		   datepicker2 = "2020-01-01";
	   }
	   
	   console.log(productname);
	   console.log(deliveryStep);
	   console.log(orderlist);
	   console.log(datepicker1);
	   console.log(datepicker2);
	   console.log(payid);
	   
		   $.ajax({
			   url : "/coffee/admin/order/testanyselect/" + productname + "/" + datepicker1 + "/" + datepicker2 + "/" + deliveryStep + "/" + orderlist + "/" + payid + "/",
			   method : "get",
			   contentType : 'application/json; charset=UTF-8',
			   data : "json",
			   error : function(){
				   console.log("선택 검색 에러");
			   },
			   success : function(data){
				   console.log("선택 검색 성공");
				   
					  var data = data.data;
					  var orderlist = "";
					  if(data.length > 0){
						  for(var i = 0 ; i < data.length ; i++){
							  
							  switch(data[i].o_state){
							  case "1" : data[i].o_state = "주문확인"; break;
							  case "2" : data[i].o_state = "배송중"; break;
							  case "3" : data[i].o_state = "배송완료"; break;
							  }
							  
							  switch(data[i].payid){
							  case "1" : data[i].payid = "신용카드"; break;
							  case "2" : data[i].payid = "무통장입금"; break;
							  case "3" : data[i].payid = "휴대폰소액결제"; break;
							  case "4" : data[i].payid = "카카오페이"; break;
							  }
							  orderlist += "<tr>";
							  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].orderid + "</td>";
							  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].selldate + "</td>";
							  orderlist += "<td style='width: 30%;text-align:center;'>" + data[i].productname + "</td>";	
							  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].pcount + "</td>";
							  orderlist += "<td style='width: 10%;text-align:center;'>" + data[i].price + "</td>";
							  orderlist += "<td style='width: 12%;text-align:center;'>" + data[i].payid + "</td>";
							  orderlist += "<td style='width: 12%;text-align:center;'>" + data[i].username + "</td>";													  
							  orderlist += "<td style='width: 20%;text-align:center;'>" + data[i].o_state;
								 if(data[i].o_state == "주문확인"){
									 orderlist += "&nbsp;&nbsp;&nbsp;<button id='"+data[i].orderid +"' name='"+data[i].o_state+"&" +data[i].userid + "' type='button' class='btn btn-warning btn-sm' onclick='orderStateChange();'>배송시작처리</button></td>";
								 }else if(data[i].o_state == "배송중"){
									 orderlist += "&nbsp;&nbsp;&nbsp;<button id='"+data[i].orderid +"' name='"+data[i].o_state+"&" +data[i].userid + "' type='button' class='btn btn-danger btn-sm' onclick='orderStateChange();'>배송완료처리</button></td>";
								 }else{
									 orderlist += "&nbsp;&nbsp;&nbsp;<button id='"+data[i].orderid +"' name='"+data[i].o_state+"&" +data[i].userid + "' type='button' class='btn btn-success btn-sm'>배송완료</button></td>";
								 }
						  }
					  } 
					  $("#length").text(data.length);
					  $("#orderResult").html(orderlist);
			   }
			   
		   });  // ajax END...
}

	function today() {
	    var today1 = new Date();
	    var dd1 = today1.getDate() -1;
	    var mm1 = today1.getMonth() + 1; //January is 0!
	    var yyyy1 = today1.getFullYear();
	    today1 = yyyy1 + '-' + mm1 + '-' + dd1;
	    
	    var today = new Date();
	    var dd = today.getDate() +1;
	    var mm = today.getMonth() + 1; //January is 0!
	    var yyyy = today.getFullYear();
	
	    today = yyyy + '-' + mm + '-' + dd;
	    document.getElementById("datepicker1").value = today1;
	    document.getElementById("datepicker2").value = today;
	 }
	 function week() {
	    var today = new Date();
	    var dd = today.getDate();
	    var mm = today.getMonth() + 1; //January is 0!
	    var yyyy = today.getFullYear();
	    today = yyyy + '-' + mm + '-' + dd;
	    document.getElementById("datepicker2").value = today;
	
	    today = today.split("-");
	    var beforeDate = new Date();
	    beforeDate.setFullYear(today[0], today[1] - 1, today[2] - 7);
	    var y = beforeDate.getFullYear();
	    var m = beforeDate.getMonth() + 1;
	    var d = beforeDate.getDate();
	    if (m < 10) {
	       m = "0" + m;
	    }
	    if (d < 10) {
	       d = "0" + d;
	    }
	
	    beforeDate = y + "-" + m + "-" + d;
	    document.getElementById("datepicker1").value = beforeDate;
	 }
	 function month() {
	    var today = new Date();
	    var dd = today.getDate();
	    var mm = today.getMonth() + 1; //January is 0!
	    var yyyy = today.getFullYear();
	    today = yyyy + '-' + mm + '-' + dd;
	
	    var today1 = new Date();
	    var dd1 = today1.getDate();
	    var mm1 = today1.getMonth(); //January is 0!
	    if (mm1 == 0)
	       mm1 = 12;
	    var yyyy1 = "";
	    if(mm == 1){
	    	yyyy1 = today1.getFullYear() -1;
	    } else {
	    	yyyy1 = today1.getFullYear();	    	
	    }
	    
	    today1 = yyyy1 + '-' + mm1 + '-' + dd1;
	
	    document.getElementById("datepicker2").value = today;
	    document.getElementById("datepicker1").value = today1;
	
	 }

	 function orderStateChange(){ // 배송 시작 처리 
		 var orderid = window.event.target.id;		
	     var o_state = window.event.target.name;
	     var array = new Array();
	     array = o_state.split("&");
	     
	     var userid = '${sessionScope.userid}';
	     if(array[0] == "주문확인"){
	    	 $.ajax({
					url : "/coffee/orderStateModify/" + orderid + "/" + array[1],
							method : "PUT",
							dataType : "json",
							contentType : 'application/json; charset=UTF-8',
							success : function(data) {
								alert("상품 배송을 시작했습니다.");
								location.replace("/coffee/admin");
							},
							error : function(err) {
								console.log("Error 발생 : " + err);
							}
			}); 
	     }else if(array[0] == "배송중"){ // 배송중
	    	 $.ajax({
					url : "/coffee/orderStateModify1/" + orderid + "/" + array[1],
							method : "PUT",
							dataType : "json",
							contentType : 'application/json; charset=UTF-8',
							success : function(data) {
								alert("배송처리가 완료되었습니다.");
								location.replace("/coffee/admin");
							},
							error : function(err) {
								console.log("Error 발생 : " + err);
							}
			}); 
	     } 
			
	 }
</script>
<body>
      			<div class="col-lg-12">
                    <h3 class="page-header">주문관리</h3>
                </div>
   <br />
   <br />

      <table class="table table-hover">
         <colgroup>
            <col style="width: 10%;">
            <col style="width: 30%;">
            <col style="width: 10%;">
            <col style="width: 30%;">
            <col style="width: 10%;">
         </colgroup>
         <tbody class="a">
            <tr>
               <!--  첫번째 줄  기간,상품명-->
               <th style="vertical-align: middle;">기간</th>
               <td colspan="6"><input class="form-control input-sm"
                  type="text" name="datepicker1" style="width: 250px; float: left;"
                  id="datepicker1" value="" data-date="2018-12-04"
                  data-date-format="yyyy-mm-dd"> ~ <input
                  class="form-control input-sm" type="text" name="datepicker2"
                  style="width: 250px; float: right;" id="datepicker2" value=""
                  data-date="2018-12-11" data-date-format="yyyy-mm-dd"></td>
               <td colspan="2">
                  <button type="button" id="today" class="btn btn-secondary btn-sm">오늘</button>
                  <button type="button" id="week" class="btn btn-secondary btn-sm">일주일</button>
                  <button type="button" id="month" class="btn btn-secondary btn-sm">한달</button>
               </td>
            </tr>
            <tr>
               <th style="vertical-align: middle;">상품명</th>
               <td style="vertical-align: middle;" colspan="4">
               <select class="form-control" id="orderPname" name="orderPname" style="width: 250px;"></select>
                  </td>


               <th style="vertical-align: middle;">결제방식</th>
               <td style="vertical-align: middle;" colspan="4"><select
                  class="form-control input-sm" name="payid" id="payid"
                  style="width: 250px;">
                     <option value="0">--선택--</option>
                     <option value="1">신용카드</option>
                     <option value="2">무통장입금</option>
                     <option value="3">휴대폰소액결제</option>
                     <option value="4">카카오페이</option>
               </select></td>
            </tr>
            <tr>
               <th style="vertical-align: middle;">정렬</th>
               <td style="vertical-align: middle;" colspan="4"><select
                  class="form-control input-sm" name="orderlist" id="orderlist"
                  style="width: 250px;">
                     <option value="0">--선택--</option>
                     <option value="1">주문일</option>
                     <option value="2">주문번호</option>
                     <option value="3">가격</option>
               </select></td>

               <th style="vertical-align: middle;">주문상태</th>
               <td style="vertical-align: middle;" colspan="4"><select
                  class="form-control input-sm" name="deliveryStep" id="deliveryStep"
                  style="width: 250px;">
                     <option value="0">--선택--</option>
                     <option value="1">주문확인</option>
                     <option value="2">배송중</option>
                     <option value="3">배송완료</option>
               </select></td>
            </tr>
         </tbody>
      </table>
      <div style="float: right;margin-right: 50px">
         <button id="btnSearch" type="button" class='btn btn-primary' onclick="testanyselect();">
            검 색</button>
         <button id="btnSearchAll" type="button"
           class='btn btn-warning' onclick="allselect();">전 체 검 색</button>
      </div>
      <br>
      <br>
      <br>
      <hr>
      <br>
      <br>
      <br>
   <form method="post" role="form" class="form-horizontal"
      name="regi_form" id="regi_form">

      <div style="text-align: right; margin-bottom: 8px; padding-left: 0px;">
         <span style="font-size: 1.3em; padding-left: 0px;">총 주문건수 : <strong
            class="text-danger"><span id="length"></span></strong>개
            <button class="btn btn-danger btn-sm" type="button" id="ChkSms"
               style="margin-left: 20px; cursor: pointer;">선택 SMS발송</button>
            <button class="btn btn-primary btn-sm" type="button"
               onclick="CheckGroup(2);return false;">선택주문취소</button>
            <button class="btn btn-success btn-sm" type="button"
               onclick="xlsdown();return false;">엑셀저장</button> <!--button class="btn btn-primary btn-sm" type="button" onclick="sendCashReceipt();return false;">선택 현금영수증 발행</button-->


            <select class="form-control input-sm" name="status_update"
            id="status_update"
            style="margin-left: 30px; width: 190px; display: inline-block;">
               <option value="">-- 주문상태 선택변경 --</option>
               <option value="0">미결제</option>
               <option value="1">미입금</option>
               <option value="2">신규주문</option>
               <option value="3">배송준비</option>
               <option value="4">배송중</option>
               <option value="5">배송완료</option>
               <option value="6">배송예약</option>
               <option value="7">취소접수</option>
               <option value="8">취소완료</option>
               <option value="9">반품중</option>
               <option value="10">반품완료</option>
               <option value="11">교환중</option>
               <option value="12">교환완료</option>
         </select>
            <button class="btn btn-info btn-sm" type="button"
               onclick="CheckGroup(4);return false;">선택변경하기</button>

         </span>
      </div>
      <table class="table table-striped">

         <thead class="a">
            <tr>
               <!-- 출력 table header -->
               <th style="text-align: center;">주문번호</th> <!--1  -->
               <th style="text-align: center;">주문일</th> <!--  -->
               <th style="text-align: center;">상품정보</th> <!--  -->
               <th style="text-align: center;">수량</th> <!--  -->
               <th style="text-align: center;">결제금액</th> <!--  -->
               <th style="text-align: center;">결제방식</th> <!--  -->
               <th style="text-align: center;">주문인</th> <!--  -->
               <th style="text-align: center;">주문상태</th> <!--  -->

            </tr>
         </thead>
         <tbody id="orderResult">
         </tbody>
      </table>
   </form>
   <!-- </div> -->



<%@include file="includes/footer.jsp"%>
</body>

</html>
