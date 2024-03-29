<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="static/css/bootstrap.css">
<link href="https://fonts.googleapis.com/css?family=Jua" rel="stylesheet"> 
<link href="https://fonts.googleapis.com/css?family=Jua|Nanum+Gothic+Coding" rel="stylesheet"> 
<script src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b3097aa351abfd48214a8cc7537ecbf&libraries=services"></script>
<style>

	body{
		font-family: 'Nanum Gothic Coding', monospace;
	}
	
	.maparea{
		text-align: center;
	}
	
	#map{
		display: inline-block;
	}
	h1{
		margin-left: 25px;
		font-size: 50px;
	}
	h2{
		font-size: 15px;
		margin-left: 30px;
		margin-top : 30px;
	}
	
	hr{
		border: 1px solid black;
		margin: 0px 30px 0px 30px;
	}
</style>

</head>
<body>
	<h1>약도 보기</h1>
	<hr/>
	<h2 id="hshopname"></h2>
	<div class="maparea">
    <div id="map" style="width:520px;height:520px;margin:5px;"></div>
    </div>
<script>
	$(function(){
		
		 var shopname = opener.document.getElementById("shopName").value;
		 var latitude = opener.document.getElementById("latitude").value;
		 var longitude = opener.document.getElementById("longitude").value;
		 
		 $("#hshopname").text(shopname + " 안내");
		 
		 var ps = new daum.maps.services.Places();
  		 // 마커를 클릭하면 장소명 표출할 인포윈도우..
 		 var infowindow = new daum.maps.InfoWindow({zIndex:1});
		
		 var container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스
		 var options = { // 지도를 생성할 때 필요한 옵션 ( 위도 , 경도)
			center: new daum.maps.LatLng(latitude, longitude), // 좌표
			level: 3 // 지도의 레벨 (확,축 정도)
		};
			var map = new daum.maps.Map(container, options); // 지도 생성 및 객체 리턴
			
			// 마커 표시
			var markerPosition  = new daum.maps.LatLng(latitude, longitude); 
			var marker = new daum.maps.Marker({
			    position: markerPosition
			});
			marker.setMap(map);
			
			// 마커에 인포윈도우 표시
			var iwContent = "<div style='padding:5px;'>" + shopname + "</div>", // 인포윈도우에 표출될 내용
			iwPosition = new daum.maps.LatLng(latitude, longitude), //인포윈도우 표시 위치
		    iwRemoveable = true;
			
			var infowindow = new daum.maps.InfoWindow({
			    map: map, // 인포윈도우가 표시될 지도
			    position : iwPosition, 
			    content : iwContent,
			    removable : iwRemoveable
			});
			
			
	});
</script>
</body>
</html>