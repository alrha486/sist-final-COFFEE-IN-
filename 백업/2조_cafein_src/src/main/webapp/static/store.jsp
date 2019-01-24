<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>One Music - Modern Music HTML5 Template</title>

    <!-- Favicon -->
    <link rel="icon" href="static/img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">    
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
      <script src="//code.jquery.com/jquery-1.12.4.js"></script>
  <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <script src="static/js/header.js"></script>    

<script>
$(function(){
	$.ajax({
		url : "/coffee/store/search",
		type : "post",
		data : "json",
		error : function(err){
			console.log("Err 발생 =" + err);
		},
		success : function(data){
			var data = data.data;
			var count = data.length;
			var slist = "";
			
			if(count == 0){
				slit = "<tr><td colspan='4' style='text-align:center;'> 매장 검색 결과가 없습니다 </td></tr>";
			} else if(count > 0){
				for(var i = 0 ; i < count ; i++){
					var s = data[i];
					var num = i;
						
						slist += "<tr>";
						slist += "<td>" + s.shopname + "</td>";
						slist += "<td>" + s.address + "</td>";
						slist += "<td>" + s.telenumber + "</td>";
						slist += "<td style='text-align:center;'><a href='javascript:showMap(" + num + ");' style='cursor: pointer;'>";
						slist += "<span class='glyphicon glyphicon-globe' aria-hidden='true'></span></a>";
						slist += "<form name='myform'>";
						slist += "<input type='hidden' id='shopname" + i + "' value=" + s.shopname + ">";
						slist += "<input type='hidden' id='latitude" + i + "' value=" + s.latitude + ">";
						slist += "<input type='hidden' id='longitude" + i + "' value=" + s.longitude + ">";
						slist += "</form>";
						slist += "</td>";
						slist += "</tr>";
				}
			}
			$("#stores").html(slist);
		} // success END..
		
		
	}); // ajax END..
}); // load END..


    function changing(regionValue, gugunValue){
		
    	//구/군 리스트 조회 및 출력
    	var sido = $("#region option:selected").text();
		
    	if ( regionValue == '') {  //  '' 이것이면 ..

    		var options = '<option value="">구/군 선택</option>'; // options 태그에 구/군 선택을 넣는다.

    		$("[name='gugun']").html(options);   // name gugun에 option을 넣는다.
    		$("[name='gugun'] option:first").attr('selected', 'selected'); //

    		return true;

    	}

    	$.ajax({
    		url : "/coffee/store/" + sido,
    		type: 'POST',
    		data: "json",
    		success: function(data){
				
    			if( data.rows.length > 0 ){

    				var options = '<option value="">전체</option>';

    				for (var i = 0; i < data.rows.length; i++)
    				{
    					options += '<option value="' + data.rows[i].gugun + '">' + data.rows[i].gugun + '</option>';
    				}

    				$("#gugun").html(options);
    				$("#gugun").val(gugunValue).attr("selected","selected");
//     				$("#gugun option[value=").attr("selected","selected");

    			}else{

    				var options = '<option value="">전체</option>';

    				alert($("#gugun").html());

    				$("#gugun").html(options);

    				$('#gugun option:first').attr('selected', 'selected');

    			}
    		},
            error:function(){
         	   alert("오류가 발생하였습니다.");
            }

    	});

    }
    
    function search(){
    	
    	var selectsido = $("#region option:selected").text();
    	var selectgugun = $("#gugun option:selected").text();
    	var shopname = $("#shopname").val();
    	var searchname = null;
		
    	if(shopname != ""){
    		searchshop(shopname);
    	} else {
    		
    	
			if(selectsido != "" && selectgugun == '전체'){
				searchname = selectsido;			
			} else if(selectsido != "" && selectgugun != '전체' && selectgugun != '구/군 선택'){
				searchname = selectgugun;
			}
   		}
    	
    	$.ajax({
    		url : "/coffee/store/anysearch/" + searchname,
    		method : "GET",
    		dataType : "json",
    		error : function(err){
    			console.log("검색 err 발생 =" + err);
    		},
    		success : function(anystore){
    			var anystore = anystore.data;
    			var countstore = anystore.length;
    			var anylist = "";
				
    			if(countstore == 0){
    				anylist = "<tr><td colspan='4' style='text-align:center;'> 매장 검색 결과가 없습니다 </td></tr>";
    			} else if(countstore > 0){
	    			for(var i = 0 ; i < countstore ; i++){
	    				var anys = anystore[i];
	    				var num = i;
	    				
						anylist += "<tr>";
						anylist += "<td>" + anys.shopname + "</td>";
						anylist += "<td>" + anys.address + "</td>";
						anylist += "<td>" + anys.telenumber + "</td>";
						anylist += "<td style='text-align:center;'><a href='javascript:showMap(" + num + ");' style='cursor: pointer;'>";
						anylist += "<span class='glyphicon glyphicon-globe' aria-hidden='true'></span></a>";
						anylist += "<form name='myform'>";
						anylist += "<input type='hidden' id='shopname" + i + "' value=" + anys.shopname + ">";
						anylist += "<input type='hidden' id='latitude" + i + "' value=" + anys.latitude + ">";
						anylist += "<input type='hidden' id='longitude" + i + "' value=" + anys.longitude + ">";
						anylist += "</form>";
						anylist += "</td>";
						anylist += "</tr>";
    				}
    			}
    			$("#stores").empty();
    			$("#stores").html(anylist);
    		}	
    	
    	}); // ajax END..
    } // search function END ..
    
    function showMap(num){ // 약도 찾기
    	
    	$("#shopName").val ($("#shopname" + num).val() );
    	$("#latitude").val ($("#latitude" + num).val() );
    	$("#longitude").val($("#longitude" + num).val());
		
    	var shopname = $("#shopName").val();
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
		
    	
	    var w = 585, h = 690 ;
    	var left = (screen.width/2)-(w/2);
    	var top = (screen.height/2)-(h/2);
	    var mapPopup = window.open('' ,'shopMap', 'toolbar=no, location=no, status=no, menubar=no, scrollbars=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	    mapPopup.focus();


    	$("#fmPop").attr('action', "/coffee/store/searchmap/");
    	$("#fmPop").attr('method', 'post');
    	$("#fmPop").attr('target', 'shopMap');
    	$("#fmPop").submit();
		
    }
    
    function searchshop(shopname){
    	
    	$.ajax({
    		url : "/coffee/store/shopsearch/" + shopname,
    		type : "GET",
    		data : "json",
    		error : function(err){
    			console.log("숍 네임 검색 오류" + err);
    		},
    		success : function(anystore){
    			var anystore = anystore.data;
    			var countstore = anystore.length;
    			var anylist = "";
				
    			if(countstore == 0){
    				anylist = "<tr><td colspan='4' style='text-align:center;'> 매장 검색 결과가 없습니다 </td></tr>";
    			} else if(countstore > 0){
	    			for(var i = 0 ; i < countstore ; i++){
	    				var anys = anystore[i];
	    				var num = i;
	    				
						anylist += "<tr>";
						anylist += "<td>" + anys.shopname + "</td>";
						anylist += "<td>" + anys.address + "</td>";
						anylist += "<td>" + anys.telenumber + "</td>";
						anylist += "<td style='text-align:center;'><a href='javascript:showMap(" + num + ");' style='cursor: pointer;'>";
						anylist += "<span class='glyphicon glyphicon-globe' aria-hidden='true'></span></a>";
						anylist += "<form name='myform'>";
						anylist += "<input type='hidden' id='shopname" + i + "' value=" + anys.shopname + ">";
						anylist += "<input type='hidden' id='latitude" + i + "' value=" + anys.latitude + ">";
						anylist += "<input type='hidden' id='longitude" + i + "' value=" + anys.longitude + ">";
						anylist += "</form>";
						anylist += "</td>";
						anylist += "</tr>";
    				}
    			}
    			$("#stores").empty();
    			$("#stores").html(anylist);
    		}
    	});
    	
    	
    }
</script>
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

    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/coffee.png);">
        <div class="bradcumbContent">
            <p>See what’s new</p>
            <h2>STORE</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Contact Area Start ##### -->
    
    <form id="fmPop" name="fmPop">
	<input type="hidden" id="shopName" name="shopName">
	<input type="hidden" id="latitude" name="latitude">
	<input type="hidden" id="longitude" name="longitude">
	</form>
    <br/>
    <br/>
        
    <section class="album-catagory section-padding-100-0">
    <div class="container" style="height:700px;">
    
    <div class="row">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="region" name="region" class="form-control" style="width:150px;" onchange="javascript:changing(this.value);">
				      <option value="">시/도 선택</option>
				      <option value="001">강원</option>
				      <option value="002">경기</option>
				      <option value="003">경남</option>
				      <option value="004">경북</option>
				      <option value="005">광주</option>
				      <option value="006">대구</option>
				      <option value="007">대전</option>
				      <option value="008">부산</option>
				      <option value="009">서울</option>
				      <option value="010">울산</option>
				      <option value="011">인천</option>
				      <option value="012">전남</option>
				      <option value="013">전북</option>
				      <option value="014">제주</option>
				      <option value="015">충남</option>
				      <option value="016">충북</option>
					</select>
				<div class="col-xs-2">
					<select id="gugun" name="gugun" class="form-control" style="width:150px;">
						<option value="">구/군 선택</option>
					</select>
				</div>
						
					<input id="shopname" name="shopname" class="form-control" style="width:300px" type="text" value="" placeholder="매장명 검색">
					<button onclick="search();" alt="검색" class="btn btn-primary">검색</button>
	</div>
	<br/>		
	
	
	<table class="table table-bordered">
	<thead>
		<tr>
			<th>매장명</th>
			<th>주소</th>
			<th>전화번호</th>
			<th style="width:50px;text-align:center;">약도</th>
		</tr>
	</thead>
	<tbody id="stores">
	
	</tbody>		
	
	</table>
	</div>
	</section>
	
    
    <!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />
    <!-- ##### Footer Area Start ##### -->

    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <!-- Popper js -->
    <script src="static/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="static/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="static/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="static/js/active.js"></script>
</body>

</html>