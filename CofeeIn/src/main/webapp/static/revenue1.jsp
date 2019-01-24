<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>
        
<div class="row">
    <div class="col-lg-12">
       <h3 class="page-header" id="result1">주문 매출 그래프</h3>
    </div>
</div>
     
<div class="row">
      
        <table class="table table-hover" style="text-align:center; font-size: medium;" border="1" >
         <colgroup>
            <col style="width: 19%;">
            <col style="width: 18%;">
            <col style="width: 18%;">
            <col style="width: 18%;">
            <col style="width: 18%;">
            <col style="width: 22%;">
         </colgroup>
         <thead style="text-align:center;">
         <tr>
            <th>기간</th><th>입금확인</th><th>배송전</th><th>배송중</th><th>배송완료</th><th>주문취소</th>
         </tr>
         </thead>
         
         <tbody id="result">   
         </tbody>
      </table>
   </div>
    <hr>
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
   var d1 = new Date(); // 현재시간
   var date;
   var today7 = d1.getFullYear() + "-0" +(d1.getMonth() + 1) + "-" +(d1.getDate()); 
   var today = d1.getFullYear() + "-0" +(d1.getMonth() + 1) + "-" +(d1.getDate()+1); 
   var date1;
   var date2;
   var beforeDelivery =0; //배송전
   var Delivering =0; //배송중
   var afterDelivery =0; //배송완료
   var cancelOrder =0; //주문취소
   var str = "";
   
   var p1 = 0; var p2 = 0;    var p3 = 0;   var p4 = 0;
   var p5 = 0; var p6 = 0;    var p7 = 0;    var a=0;	 var b=0; 	var c=0;	 var d2=0;
   var todayVariable1=0; var todayVariable2=0; var todayVariable3=0; var todayVariable4=0;
   ////////////////////////////////전역 변수///////////////////////////////////////
   
   for(var i=0; i<3; i++){ // 3번반복(오늘, 이번 주, 이번 달)
      if(i==0){
         date1 = today7;
         date2 = today;
      }else if(i ==1){
         var today1 = d1.getFullYear() + "-0" +(d1.getMonth() + 1) + "-" + (d1.getDate()-7); // 1주일 전
         date1 = today1;
         date2 = today;
      }else if(i ==2){
         var today1
         if((d1.getMonth()+1) == 1){
            today1 = (d1.getFullYear()-1) + "-" +12 + "-" + d1.getDate(); // 1달 전   
         }else{
            today1 = d1.getFullYear() + "-" + (d1.getMonth()-1) + "-" + d1.getDate(); // 1달 전
         }
         date1 = today1;
         date2 = today;
      }
   
   $.ajax({  // 길이만큼 반복하면 ajax
      url : "/coffee/SearchOrderCount/" + date1 + "/" + date2,
      method : "GET",
      async:false,
      success : function(data){         
         var result = data.data;

         for(var j=0; j<result.length; j++){

            if(result[j].o_state == 1){ // 배송전
               beforeDelivery ++;
            }else if(result[j].o_state == 2){ // 배송중
               Delivering ++;
            }
            else if(result[j].o_state == 3){ // 배송완료
               afterDelivery ++;
            }
            else if(result[j].o_state == 4){ // 배송전
               cancelOrder ++;
            }

         }
            if(i==0){
               date = "오늘";
            }else if(i==1){
               date = "이번 주";
            }else if(i==2){
               date = "이번 달";
            }
               str += "<tr>";
               str += "<td style='color:red'>" + date +"</td>"; // 기간
               str += "<td>" + beforeDelivery +"</td>"; // 입금확인
               str += "<td>" + beforeDelivery + "</td>"; // 배송전
               str += "<td>" + Delivering + "</td>";// 배송중
               str += "<td>" + afterDelivery + "</td>";// 배송완료
               str += "<td>" + cancelOrder + "</td>"; // 주문취소
               str += "</tr>";
   
               beforeDelivery = 0;  Delivering=0; afterDelivery=0; cancelOrder=0;
      },
      error : function(err){
         console.log("Error 발생 : " + err);
      }
   }); // ajax 끝
   } // for문 끝
   $('#result').html(str);
/////////////////////////////////////표 출력 끝////////////////////////////////////
   for(var j=0; j<7; j++){ // 일주일 : 7번 반복
      var d = new Date(); // 현재시간
      var today = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +d.getDate();
      var time = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-j);  
      
      
   $.ajax({ 
      url : "/coffee/SearchOrderCount1/" + time, // 상품그래프 뿌리기위한 정보(이번 주 상품 판매량)
      method : "GET",
      async:false,
      success : function(data){         
         var result =data.data;         
         //alert(result.length);
         if(j==0){ // 오늘
            for(var i=0; i<result.length; i++){
            p1++;               
            if(result[i].payid ==1){
               a++;
               todayVariable1 ++;
            }else if(result[i].payid ==2){
               b++;
               todayVariable2++;
            }else if(result[i].payid ==3){
               c++;
               todayVariable3++;
            }else if(result[i].payid ==4){
               d2++;
               todayVariable4++;
            }
         }
         }else if(j==1){ // 오늘 
            for(var i=0; i<result.length; i++){
            p2++;
            if(result[i].payid ==1){
               a++;
            }else if(result[i].payid ==2){
               b++;
            }else if(result[i].payid ==3){
               c++;
            }else if(result[i].payid ==4){
               d2++;
            }
            }
         }else if(j==2){ // 오늘
            for(var i=0; i<result.length; i++){
            p3++;
            if(result[i].payid ==1){
               a++;
            }else if(result[i].payid ==2){
               b++;
            }else if(result[i].payid ==3){
               c++;
            }else if(result[i].payid ==4){
               d2++;
            }
            }
         }
         else if(j==3){ // 오늘
            for(var i=0; i<result.length; i++){
            p4++;
            if(result[i].payid ==1){
               a++;
            }else if(result[i].payid ==2){
               b++;
            }else if(result[i].payid ==3){
               c++;
            }else if(result[i].payid ==4){
               d2++;
            }
            }
         }
         else if(j==4){ // 오늘
            for(var i=0; i<result.length; i++){
            p5++;
            if(result[i].payid ==1){
               a++;
            }else if(result[i].payid ==2){
               b++;
            }else if(result[i].payid ==3){
               c++;
            }else if(result[i].payid ==4){
               d2++;
            }
            }
         }
         else if(j==5){ // 오늘
            for(var i=0; i<result.length; i++){
            p6++;
            if(result[i].payid ==1){
               a++;
            }else if(result[i].payid ==2){
               b++;
            }else if(result[i].payid ==3){
               c++;
            }else if(result[i].payid ==4){
               d2++;
            }
            }
         }
         else if(j==6){ // 오늘
            for(var i=0; i<result.length; i++){
            p7++;
            if(result[i].payid ==1){
               a++;
            }else if(result[i].payid ==2){
               b++;
            }else if(result[i].payid ==3){
               c++;
            }else if(result[i].payid ==4){
               d2++;
            }
            }
         }      
         


      },//success 끝 
      error : function(err){
         console.log("Error 발생 : " + err);
      }
   }); // ajax 끝
}// for문 끝
//////////////////////////////////////반복문 끝나면 그래프 그리기////////////////////////////////////
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);

var d = new Date(); // 현재시간
var today = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +d.getDate();
var today11 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-1);
var today2 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-2);
var today3 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-3);
var today4 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-4);
var today5 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-5);
var today6 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-6);
function drawVisualization() { 
   //var data =  google.visualization.arrayToDataTable(str);
   var data = google.visualization.arrayToDataTable(
     [
      ['일','주문 수량'],
      [today6,p7],
      [today5,p6],
      [today4,p5],
      [today3,p4],
      [today2,p3],
      [today11,p2],
      [today,p1]
      ]
      );
   var options = {
         title : '이번 주 주문 수량',
         vAxis: {title: '주문 수량'},
         hAxis: {title: '일'}, 
         seriesType: 'bars',
         //series: {5: {type: 'line'}}
   };
   
   var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
   chart.draw(data, options);
}

//////////////////////////////////////////////////////////////////////
         google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);
          google.charts.setOnLoadCallback(drawChart1);

            function drawChart() {
                var data1 = google.visualization.arrayToDataTable([
                  ['결제수단', '개수'],
                  ['신용카드',a], 
                  ['무통장입금',b], 
                  ['휴대폰소액결제',c], 
                  ['카카오페이',d2], 
                ]);
                var options1 = {
                  title: '결제 수단(이번 주)'
                };
                var chart1 = new google.visualization.PieChart(document.getElementById('piechart'));
                chart1.draw(data1, options1);
              } 
   ////////////////////////////////////////////////////////////////////////////////
            google.charts.load('current', {'packages':['corechart']});
            

              function drawChart1() {
                  var data2 = google.visualization.arrayToDataTable([
                    ['결제수단', '개수'],
                    ['신용카드',todayVariable1], 
                    ['무통장입금',todayVariable2], 
                    ['휴대폰소액결제',todayVariable3], 
                    ['카카오페이',todayVariable4] 
                  ]);
                  var options2 = {
                    title: '결제 수단(오늘)'
                  };
                  var chart2 = new google.visualization.PieChart(document.getElementById('piechart1'));
                  chart2.draw(data2, options2);
                } 
}); // document.ready 끝
</script>
</head>
<body>
<table>
	<tr>
		<td colspan="2"><div id="chart_div" style="width:1300px; height: 500px;"></div> <!-- 오늘 --></td>
	</tr>
	<tr>
		<td style="width: 50%;"><div id="piechart"   style="width: 700px; height: 500px;"></div> <!-- 이번주 --></td>
		<td style="width: 50%;"><div id="piechart1"   style="width: 700px; height: 500px;"></div> <!-- 오늘 --></td>
	</tr>
</table>
   
   
   
   
   
   
<%@include file="includes/footer.jsp"%>
</body>
</html>