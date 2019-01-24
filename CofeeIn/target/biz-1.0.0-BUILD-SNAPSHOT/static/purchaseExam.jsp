<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="data" value="${productids}" />
<!DOCTYPE html>
<html>
<head>
<script src="static/js/jquery.min.js"></script>
<script>
// 윈도우 로드될 때 
	var data = '${data}';
	var array = new Array();
	array = data.split('&');
	var str = "";
	for(var i=0; i<array.length; i++){ // 넘어온 상품 수만큼 돌면서 호출
		$.ajax({  // 길이만큼 반복하면 ajax
			url : "/coffee/productInfoSelect/" +array[i], //회원가입 ajax
			method : "GET",
			success : function(data){			
				var result = data.data;
				
				str += "<tr>";
				str += "<td>" + result[0].productname + "</td>"
				str += "<td>" + result[0].p_count + "</td>"
				str += "<td>" + result[0].price + "</td>"
				str += "</tr>";
				$('#result').html(str);
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	}
	
	//alert(str);
	
</script>
<meta charset="UTF-8">
<title>구매창</title>
</head>
<body>
	<table border = "1">
		<thead>
			<tr>
				<th>상품명</th><th>수량</th><th>가격</th>
			</tr>
		</thead>
		<tbody id="result">
		</tbody>
	</table>
</body>
</html>