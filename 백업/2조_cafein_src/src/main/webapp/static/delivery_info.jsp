<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="user" value="${member}" />
<c:set var="qa" value="${qaddress}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>배송지 추가/관리</title>
	
	<link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">    
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    <link rel="stylesheet" href="static/css/liststyle.css">
	<link rel="stylesheet" href="static/css/fdw-demo.css">
	<link rel="stylesheet" href="static/css/mypage.css">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">	
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/header.js"></script>
	<script>
	
		
	
	function insertaddress(){
	    var w = 505, h = 340;
	    var left = (screen.width/2)-(w/2);
    	var top = (screen.height/2)-(h/2);
	    var mapPopup = window.open('/coffee/addressInsert' ,'addressMap', 'toolbar=no, location=no, status=no, menubar=no, scrollbars=no, copyhistory=no, width=679px, height=620px, top=150, left=600');
	    mapPopup.focus();
	}
	
	function addressdelete(index){
		addressnamekey = $("#addressnamekey" + index + "").val();
			
		$.ajax({
			url : "/coffee/address/delete/" + addressnamekey,
			method : "delete",
			data : "json",
			error : function(err){
				console.log("삭제 오류");
			},
			success : function(data){
				if(data == 1){
					alert("배송 정보가 삭제되었습니다.");
					location.reload();					
				}
				
			}
			
		});
	}
	
	function back(){
		location.href = "/coffee/mypage";
	}
	
	</script>
	<style>
	body{
		font-family: 'Nanum Gothic Coding', monospace;
	}	
	
	table {
  		border-spacing: 10px;
  		border-collapse: separate;
	}
	
	input[type=text]{
		background-color: #e2e2e2;
		text-align: center;
	}
	
	.qzipcode{
		width: 80px;
	}
	.qaddress1{
		width: 400px;
	}
	
	.qaddress2{
		width: 200px;
	}
	
	#zipcode{
		width: 80px;
	}
	#address1{
		width: 400px;
	}
	
	#address2{
		width: 200px;
	}	
	.ww{
		width: 100%;
	}
	.header3{
		height:100px;
	}
	.middle3{
		margin: auto;
		width: 35%;
	    border: 2px solid #DCE192;
  	    padding: 10px;
  		border-radius: 50px 20px;
	}
	
	.footer3{
		height:100px;
	}
	
	
	</style>
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
    
<jsp:include page="header.jsp"/>
   <input type="hidden" id="userid" name="userid" value="${user.userid}" />
   <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/a3.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>Delivery Address</h2>
      </div>
      </section>
      
   <section class="middlesection">
   
	        		<%-- <h1>${user.username}님의 기본 배송지 정보</h1> --%>
		<div class="ww">
<div class="header3"></div>
<div class="middle3">
		<table>
			<tbody>
				<tr>
				    <th>배송 주소</th>
					<td><input type="text" name="zipcode" id="zipcode" readonly="readonly" value="${user.zipcode}"></td>
				</tr>
				<tr>
					<th></th>
				    <td><input type="text" name="address1" id="address1" readonly="readonly" value="${user.address1}"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="text" name="address2" id="address2" readonly="readonly" value="${user.address2}"></td>
				</tr>
			</tbody>
		</table>
</div>
<hr/>
<div>
<p style="margin-left: 620px">배송지를 추가하시려면 눌러주세요</p>
<div style="margin-left: 620px">
<button class="btn btn-default btn-lg" onclick="insertaddress();">배송지 추가하기</button>
<br/>
<br/>
</div>
</div>
	
	
	
				
				<c:if test="${!empty qa}">
                <c:forEach items="${qaddress}" var="item" step="1" varStatus="status">
                <input type="hidden" id="addressnamekey${status.index}" value="${item.qaddressname}">
                <div class="middle3">
                
                <table>
                	<tbody>
                	<tr>
                		<th>배송지 이름</th>
                		<td>${item.qaddressname}</td>
                	</tr>
                	
                	<tr>
                		<th rowspan="4">배송 주소</th>
                		<td><input type="text" class="qzipcode" name="qzipcode" id="qzipcode${status.index}" readonly="readonly" value="${item.qzipcode}"></td>
                	</tr>
                	
                	<tr>
                		<td> <input type="text" class="qaddress1" name="qaddress1" id="qaddress1${status.index}" readonly="readonly" value="${item.qaddress1}"></td>
                	</tr>
                	
                	<tr>
                		<td><input type="text" class="qaddress2" name="qaddress2" id="qaddress2${status.index}" readonly="readonly" value="${item.qaddress2}"></td>
                	</tr>
                	
                	<tr>
                		<td><button class="btn btn-default" onclick="addressdelete(${status.index});">삭제하기</button></td>                		
                	</tr>	
                	</tbody>
                </table>
				  <hr/>
				  </div>
				  </c:forEach>
				  </c:if>
				  <br>
				  <div style="text-align:center;">
               <input type='button' value='선택 배송지 삭제'  class="btn btn-danger" id="btnCancel"/>
               <input type='button' value='돌아 가기'  class="btn btn-warning" onclick="back();"/>
               </div>
				  
   <div class="footer3"></div>	
   </div>			  
   </section>
      
      

	<jsp:include page="footer.jsp"/>
				  
   <script src="static/js/jquery-2.2.4.min.js"></script>
   <!-- Popper js -->
   <script src="static/js/bootstrap/popper.min.js"></script>
   <!-- Bootstrap js -->
   <script src="static/js/bootstrap.min.js"></script>
   <!-- All Plugins js -->
   <script src="static/js/plugins/plugins.js"></script>
   <!-- Active js -->
   <script src="static/js/active.js"></script>
			
</body>
</html>