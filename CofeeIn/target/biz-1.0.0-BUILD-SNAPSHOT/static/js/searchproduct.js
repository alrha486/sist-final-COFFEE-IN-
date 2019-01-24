$(function(){
	$("#innerSearch").keydown(function(key){
		if(key.keyCode == 13){
			innerPage();  // innerPage Method Move..
		}
	});
	
	
	$("#btninnerSearch").click(function(){
		innerPage();   // innerPage Method Move..
	});
	
}); // window load END..

function innerPage(){
	var innerName = $("#innerSearch").val();
	
	if(innerName == ""){
		alert("검색어를 입력하세요");
	} else if(innerName != ""){

		$("#listzz").empty();   
		$.ajax({
			url : "/coffee/search/" + innerName,
			method : "POST",
			dataType : "json",
			error : function(err){
				console.log("Err 발생" + err)
			},
			
			success : function(data){
				var data = data.data;
				var count = data.length;
				var str = "";
				
				if(count == 0) {
					alert("상품 검색 결과가 없습니다.");
				} else if(count > 0){
					for(var i = 0 ; i < count ; i++){
						var ps = data[i];
						
					str += "<li>";
					str += "<p class='photo'>";
					str += "<img src='../static/img/product/" + ps.productname + ".jpg' width='150px' height='200px'></p>"; 
					str += "<p class='txt_box'>";
					str += "<span class='name'>" + ps.productname + "</span>";
					str += "<span class='num'>" + ps.productex + "</span>";
					str += "<span class='price'>" + ps.price + "</span>";
					str += "</p>";
					str += "</li>";
					}
				}
				
				$("#result").html(str);
				$("#count").text(count +"건이 검색되었습니다.");
				
				
			} // success ! END..
		});  // ajax END...
	}
}