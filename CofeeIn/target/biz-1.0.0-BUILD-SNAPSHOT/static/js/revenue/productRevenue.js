function week(){ // 이번 주
	var p1 = 0; var p2 = 0; 	var p3 = 0;	var p4 = 0;
	var p5 = 0; var p6 = 0; 	var p7 = 0; var p8 = 0; 	var p9 = 0;
	
	var pa1 = 0; var pa2 = 0; 	var pa3 = 0;	var pa4 = 0;
	var pa5 = 0; var pa6 = 0; 	var pa7 = 0; var pa8 = 0; 	var pa9 = 0;
	
	var pb1 = 0; var pb2 = 0; 	var pb3 = 0;	var pb4 = 0;
	var pb5 = 0; var pb6 = 0; 	var pb7 = 0; var pb8 = 0; 	var pb9 = 0;
	
	var pc1 = 0; var pc2 = 0; 	var pc3 = 0;	var pc4 = 0;
	var pc5 = 0; var pc6 = 0; 	var pc7 = 0; var pc8 = 0; 	var pc9 = 0;
	
	var pd1 = 0; var pd2 = 0; 	var pd3 = 0;	var pd4 = 0;
	var pd5 = 0; var pd6 = 0; 	var pd7 = 0; var pd8 = 0; 	var pd9 = 0;
	
	var pe1 = 0; var pe2 = 0; 	var pe3 = 0;	var pe4 = 0;
	var pe5 = 0; var pe6 = 0; 	var pe7 = 0; var pe8 = 0; 	var pe9 = 0;
	
	var pf1 = 0; var pf2 = 0; 	var pf3 = 0;	var pf4 = 0;
	var pf5 = 0; var pf6 = 0; 	var pf7 = 0; var pf8 = 0; 	var pf9 = 0;
///////////////////////////////////////어쩔수없는 노가다 변수//////////////////////////////////////
	var coffee = 0;
	var food = 0;
	var goods = 0;
////////////////////////////////////////////////////////////////////////////////////////
	for(var j=0; j<7; j++){ // 일주일 : 7번 반복
		var d = new Date(); // 현재시간
		var today = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +d.getDate();
		var time = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-j);		
	$.ajax({ 
		url : "/coffee/selectProductGrape2/" + time, // 상품그래프 뿌리기위한 정보(이번 주 상품 판매량)
		method : "GET",
		async:false,
		success : function(data){			
			var result =data.data;			
			if(j==0){
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
			} // 이거 7개

			
			else if(j==1){
				for(var i=0; i<result.length; i++){
					if(result[i].kind_idx == 1){
						pa1 += result[i].pcount;
						coffee += result[i].pcount;
					}else if(result[i].kind_idx == 2){
						pa2 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 3){
						pa3 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 4){
						pa4 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 5){
						pa5 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 6){
						pa6 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 7){
						pa7 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 8){
						pa8 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 9){
						pa9 += result[i].pcount;
						goods += result[i].pcount;
					} //else문 끝				
				} // for문 끝
				} // 이거 7개
			
			else if(j==2){
				for(var i=0; i<result.length; i++){
					if(result[i].kind_idx == 1){
						pb1 += result[i].pcount;
						coffee += result[i].pcount;
					}else if(result[i].kind_idx == 2){
						pb2 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 3){
						pb3 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 4){
						pb4 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 5){
						pb5 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 6){
						pb6 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 7){
						pb7 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 8){
						pb8 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 9){
						pb9 += result[i].pcount;
						goods += result[i].pcount;
					} //else문 끝				
				} // for문 끝
				} // 이거 7개
			
			else if(j==3){
				for(var i=0; i<result.length; i++){
					if(result[i].kind_idx == 1){
						pc1 += result[i].pcount;
						coffee += result[i].pcount;
					}else if(result[i].kind_idx == 2){
						pc2 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 3){
						pc3 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 4){
						pc4 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 5){
						pc5 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 6){
						pc6 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 7){
						pc7 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 8){
						pc8 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 9){
						pc9 += result[i].pcount;
						goods += result[i].pcount;
					} //else문 끝				
				} // for문 끝
				} // 이거 7개
			
			else if(j==4){
				for(var i=0; i<result.length; i++){
					if(result[i].kind_idx == 1){
						pd1 += result[i].pcount;
						coffee += result[i].pcount;
					}else if(result[i].kind_idx == 2){
						pd2 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 3){
						pd3 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 4){
						pd4 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 5){
						pd5 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 6){
						pd6 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 7){
						pd7 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 8){
						pd8 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 9){
						pd9 += result[i].pcount;
						goods += result[i].pcount;
					} //else문 끝				
				} // for문 끝
				} // 이거 7개
			
			else if(j==5){
				for(var i=0; i<result.length; i++){
					if(result[i].kind_idx == 1){
						pe1 += result[i].pcount;
						coffee += result[i].pcount;
					}else if(result[i].kind_idx == 2){
						pe2 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 3){
						pe3 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 4){
						pe4 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 5){
						pe5 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 6){
						pe6 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 7){
						pe7 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 8){
						pe8 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 9){
						pe9 += result[i].pcount;
						goods += result[i].pcount;
					} //else문 끝				
				} // for문 끝
				} // 이거 7개
			
			
			else if(j==6){
				for(var i=0; i<result.length; i++){
					if(result[i].kind_idx == 1){
						pf1 += result[i].pcount;
						coffee += result[i].pcount;
					}else if(result[i].kind_idx == 2){
						pf2 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 3){
						pf3 += result[i].pcount;
						coffee += result[i].pcount;
					}
					else if(result[i].kind_idx == 4){
						pf4 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 5){
						pf5 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 6){
						pf6 += result[i].pcount;
						food += result[i].pcount;
					}
					else if(result[i].kind_idx == 7){
						pf7 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 8){
						pf8 += result[i].pcount;
						goods += result[i].pcount;
					}
					else if(result[i].kind_idx == 9){
						pf9 += result[i].pcount;
						goods += result[i].pcount;
					} //else문 끝				
				} // for문 끝
				} // 이거 7개
			

			
				
							
		},//success 끝 
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	}); // ajax 끝
}// for문 끝
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawVisualization);
	
	var d = new Date(); // 현재시간
	var today = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +d.getDate();
	var today1 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-1);
	var today2 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-2);
	var today3 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-3);
	var today4 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-4);
	var today5 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-5);
	var today6 = d.getFullYear() + "-0" +(d.getMonth() + 1) + "-" +(d.getDate()-6);
	
	function drawVisualization() { 
		//var data =  google.visualization.arrayToDataTable(str);
		var data = google.visualization.arrayToDataTable(
         [
			['Month','Beans', 'Bottle Coffee', 'Drip Bag', 'Cake', 'Bakery', 'Sandwich', 'Mug', 'Tumbler', 'Accessory'],
			[today6,  pf1,pf2,pf3,pf4,pf5,pf6,pf7,pf8,pf9],		 	// 여기가 오늘
			[today5,  pe1,pe2,pe3,pe4,pe5,pe6,pe7,pe8,pe9],   //오늘 -1
			[today4,  pd1,pd2,pd3,pd4,pd5,pd6,pd7,pd8,pd9],  // 오늘 -2
			[today3,  pc1,pc2,pc3,pc4,pc5,pc6,pc7,pc8,pc9],	 	//오늘 -3
			[today2,  pb1,pb2,pb3,pb4,pb5,pb6,pb7,pb8,pb9],  //오늘-4
			[today1,  pa1,pa2,pa3,pa4,pa5,pa6,pa7,pa8,pa9], 	//오늘 -5
			[today,  p1,p2,p3,p4,p5,p6,p7,p8,p9]			//오늘 -6
			]
			);
		var options = {
				title : '이번 주 상품별 판매량',
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
		title: '이번 주 상품 종류별 판매현황'
		};
		var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		chart.draw(data, options);
		}	
}// week끝




function month(){
	alert("이번 달 버튼");
}


function today(){
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
						[today,  123,      144,         89,             67,           107,      144,		94,           67,      88]
						//['2019-01-16',  p1,      p2,         p3,             p4,           p5,      p6,		p7,           p8,      p9]					
					]);
				var options = {
						title : '오늘 하루 상품별 판매량',
						vAxis: {title: '판매량'},
						hAxis: {title: '일'}, 
						seriesType: 'bars',
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
		            ['COFFEE',     123], // coffe
		            ['FOOD',      89], //food
		            ['GOODS',    400] // goods
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
}