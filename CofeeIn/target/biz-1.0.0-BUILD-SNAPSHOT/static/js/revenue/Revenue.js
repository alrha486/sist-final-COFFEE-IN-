function week(){ // 이번 주
	var p1 = 0; var p2 = 0; 	var p3 = 0;	var p4 = 0;
	var p5 = 0; var p6 = 0; 	var p7 = 0;
	
	var pa1 = 0; var pa2 = 0; 	var pa3 = 0;	var pa4 = 0;
	var pa5 = 0; var pa6 = 0; 	var pa7 = 0;

	for(var j=0; j<7; j++){ // 일주일 : 7번 반복
		var d1 = new Date(); // 현재시간
		var today = d1.getFullYear() + "-0" +(d1.getMonth() + 1) + "-" +d1.getDate();
		var time = d1.getFullYear() + "-0" +(d1.getMonth() + 1) + "-" +(d1.getDate()-j);	
		
		if(d1.getDate() == 1 ){
			time = d1.getFullYear() + "-0" +(d1.getMonth() - 1) + "-" +(31-j);	
		}
		
		
	$.ajax({ 
		url : "/coffee/SearchOrderCount1/" + time, 
		method : "GET",
		async:false,
		success : function(data){		
			var result =data.data;			
			if(j==0){
				for(var i=0; i<result.length; i++){
					p1 +=  result[i].totalprice;
            		pa1 +=  result[i].realtotalprice;
				}
			}
			else if(j==1){
				for(var i=0; i<result.length; i++){
					p2 += result[i].totalprice;
					pa2 += result[i].realtotalprice;
				}
			}
			else if(j==2){
				for(var i=0; i<result.length; i++){
					p3 += result[i].totalprice;
					pa3 += result[i].realtotalprice;
				}
			}
			else if(j==3){
				for(var i=0; i<result.length; i++){
					p4 += result[i].totalprice;
					pa4 += result[i].realtotalprice;
				}
			}
			else if(j==4){
				for(var i=0; i<result.length; i++){
					p5 += result[i].totalprice;
					pa5 += result[i].realtotalprice;
				}
			}
			else if(j==5){
				for(var i=0; i<result.length; i++){
					p6 += result[i].totalprice;
					pa6 += result[i].realtotalprice;
				}
			}
			else if(j==6){
				for(var i=0; i<result.length; i++){
					p7 += result[i].totalprice;
					pa7 += result[i].realtotalprice;
			}
			}	

		},//success 끝 
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); // ajax 끝
}// for문 끝
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawVisualization);

	
	var d = new Date(); // 현재시간
	var todays = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +d.getDate();
	var todays1 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-1);
	var todays2 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-2);
	var todays3 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-3);
	var todays4 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-4);
	var todays5 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-5);
	var todays6 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-6);
	
	function drawVisualization() { 
		//var data =  google.visualization.arrayToDataTable(str);
		var data = google.visualization.arrayToDataTable(
         [
			['일자','매출액', '실제 매출액','할인 금액(손해금액)'],
			[todays6,  p7,pa7,p7-pa7],
			[todays5,  p6,pa6,p6-pa6],
			[todays4,  p5,pa5,p5-pa5],
			[todays3,  p4,pa4,p4-pa4],
			[todays2,  p3,pa3,p3-pa3],
			[todays1,  p2,pa2,p2-pa2],
			[todays,  p1,pa1,p1-pa1]			
			]
			);
		var options = {
				title : '이번 주 매출액',
				vAxis: {title: '매출액'},
				hAxis: {title: '일'}, 
				seriesType: 'bars',
				//series: {5: {type: 'line'}}
		};		
		var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
		chart.draw(data, options);
	}
}// week끝



///////////////////////////////////////////////////////////////////////////////////////////////////////////
function month(){
	var p1 = 0; var p2 = 0; 	var p3 = 0;	var p4 = 0;
	var p5 = 0; var p6 = 0; 	var p7 = 0;   var p8 = 0;
	var p9 = 0; var p10 = 0;  var p11 = 0;  var p12 = 0;	
	
	
	var pa1 = 0; var pa2 = 0; 	var pa3 = 0;	var pa4 = 0;
	var pa5 = 0; var pa6 = 0; 	var pa7 = 0;   var pa8 = 0;
	var pa9 = 0; var pa10 = 0;  var pa11 = 0;  var pa12 = 0;	

	for(var j=1; j<=12; j++){ // 일주일 : 7번 반복
		var d1 = new Date(); // 현재시간
		var today = d1.getFullYear() + "-0" + j;
		if(j >= 10){
			today = d1.getFullYear() + "-" + j;
		}
		
		$.ajax({ 
			url : "/coffee/SearchOrderCount2/" + today, 
			method : "GET",
			async:false,
			success : function(data){
				var result=data.data;
				if(j==1){ //1월
					for(var i=0; i<result.length; i++){
						p1 +=  result[i].totalprice;
	            		pa1 +=  result[i].realtotalprice;
					}
				}
				else if(j==2){
					for(var i=0; i<result.length; i++){
						p2 +=  result[i].totalprice;
	            		pa2 +=  result[i].realtotalprice;
					}
				}
				else if(j==3){
					for(var i=0; i<result.length; i++){
						p3 +=  result[i].totalprice;
	            		pa3 +=  result[i].realtotalprice;
					}
				}
				else if(j==4){
					for(var i=0; i<result.length; i++){
						p4 +=  result[i].totalprice;
	            		pa4 +=  result[i].realtotalprice;
					}
				}
				else if(j==5){
					for(var i=0; i<result.length; i++){
						p5 +=  result[i].totalprice;
	            		pa5 +=  result[i].realtotalprice;
					}
				}
				else if(j==6){
					for(var i=0; i<result.length; i++){
						p6 +=  result[i].totalprice;
	            		pa6 +=  result[i].realtotalprice;
					}
				}
				else if(j==7){
					for(var i=0; i<result.length; i++){
						p7 +=  result[i].totalprice;
	            		pa7 +=  result[i].realtotalprice;
					}
				}
				else if(j==8){
					for(var i=0; i<result.length; i++){
						p8 +=  result[i].totalprice;
	            		pa8 +=  result[i].realtotalprice;
					}
				}
				else if(j==9){
					for(var i=0; i<result.length; i++){
						p9 +=  result[i].totalprice;
	            		pa9 +=  result[i].realtotalprice;
					}
				}
				else if(j==10){
					for(var i=0; i<result.length; i++){
						p10 +=  result[i].totalprice;
	            		pa10 +=  result[i].realtotalprice;
					}
				}
				else if(j==11){
					for(var i=0; i<result.length; i++){
						p11 +=  result[i].totalprice;
	            		pa11 +=  result[i].realtotalprice;
					}
				}
				else if(j==12){
					for(var i=0; i<result.length; i++){
						p12 +=  result[i].totalprice;
	            		pa12 +=  result[i].realtotalprice;
					}
				}
			},//success 끝 
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); // ajax 끝

	}// for문 끝
	
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() { 
		var data = google.visualization.arrayToDataTable(
         [
			['월','매출액', '실제 매출액','할인 금액(손해금액)'],
			["1월",  p1,pa1,p1-pa1],
			["2월",  p2,pa2,p2-pa2],
			["3월",  p3,pa3,p3-pa3],
			["4월",  p4,pa4,p4-pa4],
			["5월",  p5,pa5,p5-pa5],
			["6월",  p6,pa6,p6-pa6],
			["7월",  p7,pa7,p7-pa7],
			["8월",  p8,pa8,p8-pa8],
			["9월",  p9,pa9,p9-pa9],
			["10월",  p10,pa10,p10-pa10],
			["11월",  p11,pa11,p11-pa11],
			["12월",  p12,pa12,p12-pa12]
	
			]
			);
		var options = {
				title : '2019년 매출액',
				vAxis: {title: '매출액'},
				hAxis: {title: '월'}, 
				seriesType: 'bars',
				//series: {5: {type: 'line'}}
		};		
		var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
		chart.draw(data, options);
	}
}

