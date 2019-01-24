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
					
						str += "<div class='col-12 col-sm-6 col-md-4 col-lg-2'>";
						str += "<div class='single-album-area wow fadeInUp' data-wow-delay='100ms'>";
						str += "<div class='album-thumb'>";
						str += "<a href='javascript:void(0);' onclick='goView(" + ps.productid + ");'><img src='static/img/product/" + ps.productname + ".jpg'></a>";
						str += "</div>";
						str += "<div class='album-info'>";
						str += "<h5>" + ps.productname + "</h5>";
						str += "<p>" + ps.price + "원</p>";
						str += "</div>";
						str += "</div>";
						str += "</div>";
	                
					}
				}
				
				$("#results").html(str);
				$("#count").text(count +"건이 검색되었습니다.");
				
				
			} // success ! END..
		});  // ajax END...
	}
}

function goView(productid){
	
	$("#fmPop").attr('action', "/coffee/view/" + productid);
	$("#fmPop").attr('method', "GET");
	$("#fmPop").submit();
}

