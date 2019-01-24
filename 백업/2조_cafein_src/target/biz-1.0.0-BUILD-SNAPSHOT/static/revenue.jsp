<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>
        
<div class="row">
    <div class="col-lg-12">
       <h3 class="page-header" id="result1">매출그래프</h3>
    </div>
</div>
     
<div class="row">
	<div style="float: right;margin-right: 350px">
		<button type="button" class="btn btn-default btn-sm" onclick="today();">오늘</button>
		<button type="button" class="btn btn-default btn-sm" onclick="week();">이번 주</button>
		<button type="button" class="btn btn-default btn-sm" onclick="month();">이번 달</button>
	</div>
 </div>
    
    <script src="static/js/revenue/productRevenue.js"></script>                  
    <script src="static/resources/vendor/jquery/jquery.min.js"></script>
    <script src="static/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="static/resources/vendor/metisMenu/metisMenu.min.js"></script>
    <script src="static/resources/vendor/raphael/raphael.min.js"></script>
    <script src="static/resources/vendor/morrisjs/morris.min.js"></script>
    <script src="static/resources/data/morris-data.js"></script>
    <script src="static/resources/dist/js/sb-admin-2.js"></script>
    

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(document).ready(function(){ // 페이지 로드될 때
	var d = new Date(); // 현재시간
	var today = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +d.getDate();
	$.ajax({ 
		url : "/coffee/selectProductGrape1", // 상품그래프 뿌리기위한 정보(오늘의 상품 판매량)
		method : "GET",
		success : function(data){
			var result =data.data;
			var p1 = 0; var p2 = 0; 	var p3 = 0;	var p4 = 0;
			var p5 = 0; var p6 = 0; 	var p7 = 0; var p8 = 0; 	var p9 = 0;
			
			var coffee = 0;
			var food = 0;
			var goods = 0;
			
			for(var i=0; i<result.length; i++){
				if(result[i].kind_idx == 1){
					p1 += result[i].pcount;
					coffee += result[i].pcount;
				}else if(result[i].kind_idx == 2){
					p2 += result[i].pcount;
					coffee += result[i].pcount;
				}
				else if(result[i].kind_idx == 3){
					p3 += result[i].pcount;
					coffee += result[i].pcount;
				}
				else if(result[i].kind_idx == 4){
					p4 += result[i].pcount;
					food += result[i].pcount;
				}
				else if(result[i].kind_idx == 5){
					p5 += result[i].pcount;
					food += result[i].pcount;
				}
				else if(result[i].kind_idx == 6){
					p6 += result[i].pcount;
					food += result[i].pcount;
				}
				else if(result[i].kind_idx == 7){
					p7 += result[i].pcount;
					goods += result[i].pcount;
				}
				else if(result[i].kind_idx == 8){
					p8 += result[i].pcount;
					goods += result[i].pcount;
				}
				else if(result[i].kind_idx == 9){
					p9 += result[i].pcount;
					goods += result[i].pcount;
				} //else문 끝				
			} // for문 끝
			google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(drawVisualization);
			function drawVisualization() { 
				var data = google.visualization.arrayToDataTable([
						['Month',		 'Beans', 'Bottle Coffee', 'Drip Bag', 'Cake', 'Bakery', 'Sandwich', 'Mug', 'Tumbler', 'Accessory'],
						[today,  p1,      p2,         p3,             p4,           p5,      p6,		p7,           p8,      p9]				
					]);
				var options = {
						title : '오늘 하루 상품별 판매량',
						vAxis: {title: '판매량'},
						hAxis: {title: '일'}, 
						seriesType: 'bars',
						//series: {5: {type: 'line'}}
					};
				
				var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
				chart.draw(data, options);
			}
	////////////////////////////////파이차트//////////////////////////////////////////////////////		
			google.charts.load('current', {'packages':['corechart']});
		    google.charts.setOnLoadCallback(drawChart);

		      function drawChart() {
		          var data = google.visualization.arrayToDataTable([
		            ['상품종류', '판매량'],
		            ['COFFEE',     coffee], // coffe
		            ['FOOD',      food], //food
		            ['GOODS',    goods] // goods
		          ]);
		          var options = {
		            title: '오늘 하루 상품 종류별 판매현황'
		          };
		          var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		          chart.draw(data, options);
		        }	
		},//success 끝 
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); // ajax 끝
}); // document.ready 끝
</script>
</head>
<body>
	<div id="chart_div" style="width:900px; height: 500px;"></div>
	<div id="piechart" style="width: 900px; height: 500px;"></div>
	
<%@include file="includes/footer.jsp"%>
</body>
</html>