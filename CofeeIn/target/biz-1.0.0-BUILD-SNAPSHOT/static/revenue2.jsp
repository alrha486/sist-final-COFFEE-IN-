<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>
        
<div class="row">
    <div class="col-lg-12">
       <h3 class="page-header" id="result1">매출 통계</h3>
    </div>
</div>
     
<div class="row">  
      <table class="table table-hover" style="text-align:center; font-size: medium;" border="1" >
         <thead>
         <tr>
            <th style="width:5%;text-align:center;">/</th><th style="width:24%;text-align:center;">매출액</th>
            <th style="width:24%;text-align:center;">할인 금액</th><th style="width:24%;text-align:center;">최종 매출액(순이익)</th>
         </tr>
         </thead>
         <tbody id="result">   
         </tbody>
      </table>
   </div>
    <hr>
<div class="row">
	<div style="float: right;margin-right: 350px">
		<button type="button" class="btn btn-default btn-sm" onclick="week();">이번 주</button>
		<button type="button" class="btn btn-default btn-sm" onclick="month();">이번 달</button>
		
	</div>
 </div>
    <script src="static/js/revenue/Revenue.js"></script>                  
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
	week();
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
   
   var todayMoney =0;     var weekMoney =0;    var monthMoney =0;
   var todayMoney1 =0;     var weekMoney1 =0;    var monthMoney1 =0;
   var todayMoney2 =0;     var weekMoney2 =0;    var monthMoney2 =0;
   var todayMoney3 =0;     var weekMoney3 =0;    var monthMoney3 =0;
   
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
		
            if(i==0){
            	for(var j=0; j<result.length; j++){
            		todayMoney +=  result[j].realtotalprice;
            		todayMoney1 +=  result[j].totalprice;
            		todayMoney2 +=  result[j].coupon_discount;
            		todayMoney2 +=  result[j].saving_discount;
            		todayMoney3 +=  result[j].delivery;
            	}
               date = "오늘의 매출";
            }else if(i==1){
            	for(var j=0; j<result.length; j++){
            		weekMoney +=  result[j].realtotalprice;
            		weekMoney1 +=  result[j].totalprice;
            		weekMoney2 +=  result[j].coupon_discount;
            		weekMoney2 +=  result[j].saving_discount;
            		weekMoney3 +=  result[j].delivery;
            	}
               date = "이번 주 매출";
            }else if(i==2){
            	for(var j=0; j<result.length; j++){
            		monthMoney +=  result[j].realtotalprice;
            		monthMoney1 +=  result[j].totalprice;
            		monthMoney2 +=  result[j].coupon_discount;
            		monthMoney2 +=  result[j].saving_discount;
            		monthMoney3 +=  result[j].delivery;
            	}
               date = "이번 달 매출";
            }
            
            if(i==0){
               str += "<tr>";
               str += "<td style='color:blue'>오늘</td>"; // 기간
               str += "<td style='color:gray'>" + todayMoney +"원</td>"; // 기간
               str += "<td style='color:gray'>" + todayMoney2 +"원</td>"; // 기간
               str += "<td style='color:red'>" + (todayMoney1-todayMoney3) +"원</td>"; // 기간
               str += "</tr>";
            }else if(i==1){
                str += "<tr>";
                str += "<td style='color:blue'>이번 주</td>"; // 기간
                str += "<td style='color:gray'>" + weekMoney +"원</td>"; // 기간
                str += "<td style='color:gray'>" + weekMoney2 +"원</td>"; // 기간
                str += "<td style='color:red'>" + (weekMoney1-weekMoney3) +"원</td>"; // 기간
                str += "</tr>";
             }else if(i==2){
                 str += "<tr>";
                 str += "<td style='color:blue'>이번 달</td>"; // 기간
                 str += "<td style='color:gray'>" + monthMoney +"원</td>"; // 기간
                 str += "<td style='color:gray'>" + weekMoney2 +"원</td>"; // 기간
                 str += "<td style='color:red'>" + (monthMoney1-monthMoney3) +"원</td>"; // 기간
                 str += "</tr>";
              }

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

}); // document.ready 끝
</script>
</head>
<body>
<table>
	<tr>
		<td colspan="2"><div id="chart_div" style="width:1300px; height: 500px;"></div> <!-- 오늘 --></td>
	</tr>

</table>
   
   
   
   
   
   
<%@include file="includes/footer.jsp"%>
</body>
</html>