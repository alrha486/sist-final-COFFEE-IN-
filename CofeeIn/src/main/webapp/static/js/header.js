$(function(){
/*	$("#btnMessage").click(function({
		
	});*/
	//  -----------   searchicon start
	$("#searchicon").click(function(){
			goPage();   // goPage Method move..
	}); 	
	// --------------  searchicon END ..
	
	// -------------  
	$("#productName").keydown(function(key){
		if(key.keyCode == 13){
			goPage();  // goPage Method move..
		}
	});      // productName click END..
//	--------------------------------------------
	
	$("#logoutBtn").click(function(){
		$.ajax({ 
			url : "logout", //
			method : "GET",
			success : function(data){
				if(data == 1) { // 성공시 1를 반환
					location.href = "/coffee/";
				} else{
					alert("로그아웃 실패");
				}
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	});
// ----------------------------------------------
	$("#btnCart").click(function(){
		$.ajax({ 
			url : "cartCheck", //
			method : "GET",
			success : function(data){
				 if(data == "1") { // 세션 없다면
					alert("로그인 후 이용해주세요");
				} else if(data == "2"){
					location.href="/coffee/cart"
				} 
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	});
	
	$("#Coffee").on("click", function() {
		$("#shopmenu").text('Coffee');
		
        var p_type = 'COFFEE';
		goAjaxType(p_type);
	});
	$("#Foods").on("click", function() {
		$("#shopmenu").text('Foods');
		
		var p_type = 'FOODS';
		goAjaxType(p_type);
	});
	$("#Goods").on("click", function() {
		$("#shopmenu").text('Goods');
        
		var p_type = 'GOODS';
		goAjaxType(p_type);
	});
   $("#beans1").on("click", function() {
	   $("#shopmenu").text('Coffee');
      
      var number = 1;
      goAjax(number);
   });
   $("#bottle1").on("click", function() {
	   $("#shopmenu").text('Coffee');
      
      var number = 2;
      goAjax(number);
   });
   $("#drip1").on("click", function() {
	   $("#shopmenu").text('Coffee');
      
      var number = 3;
      goAjax(number);
   });
   $("#cake1").on("click", function() {
	   $("#shopmenu").text('Foods');
      
      var number = 4;
      goAjax(number);
   });
   
   $("#bakery1").on("click", function() {
	   $("#shopmenu").text('Foods');
      
      var number = 5;
      goAjax(number);
   });
   $("#sandwich1").on("click", function() {
	   $("#shopmenu").text('Foods');
      
      var number = 6;
      goAjax(number);
   });
 
   $("#mug1").on("click", function() {
	   $("#shopmenu").text('Goods');
      
      var number = 7;
      goAjax(number);
   });
   $("#tumbler1").on("click", function() {
	   $("#shopmenu").text('Goods');
      
      var number = 8;
      goAjax(number);
   });
   $("#accessory1").on("click", function() {
	   $("#shopmenu").text('Goods');
      
      var number = 9;
      goAjax(number);
   });
	
}); // load END ..

function goPage(){
	var productName = $("#productName").val();
	if(productName == ""){
		alert("검색어를 입력하세요");
	} else if(productName != ""){
		location.href = "/coffee/search/" + productName;
	}
}

function goAjaxType(p_type){
    $.ajax({          
        url : "/coffee/productLists/"+ p_type,
        dataType : "json",
        method : "POST",
        success : function(data) {
           var result = data.data;
           display(data);
        },
        error : function(err) {
           console.log("Error 발생 : " + err);
        }
     });
}

function goAjax(number){
    $.ajax({          
        url : "/coffee/productList/"+ number,
        dataType : "json",
        method : "POST",
        success : function(data) {
           var result = data.data;
           display(data);
        },
        error : function(err) {
           console.log("Error 발생 : " + err);
        }
     });
}