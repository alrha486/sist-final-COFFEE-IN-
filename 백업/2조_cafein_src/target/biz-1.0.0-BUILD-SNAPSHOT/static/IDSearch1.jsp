<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>ID찾기</title>

    <link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

    <link rel="stylesheet" href="static/style.css">
    
<script src="static/js/jquery.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
	function search(){
		var username = $('#username').val();
		var tel = $('#tel').val();
		$.ajax({ // 쇼핑카트 list
			url : "/coffee/selectUserInfo1/"+username + "/" + tel, 
			method : "GET",
			success : function(data){
				var result = data.data;
				if(result.length != 0){ // ID가 DB에 존재한다면
					var str = "<br>";
					str += "<h3 style='color:brown'>총 "+ result.length +"건의 검색 결과가 있습니다.</h3> ";
					str += "<table border='1'><tr><thead><th>이름</th><th>아이디</th><th>가입일자</th></thead></tr>";
					for(var i=0; i<result.length; i++){
						var array1 = new Array()
						array1[0] = result[i].username.substring(0,1);
						array1[1] = '*';
						array1[2] = result[i].username.substring(2,3);
						var username = array1[0] +array1[1] +array1[2];
						
						
						var array2 = new Array()
						array2[0] = result[i].userid.substring(0,3);
						array2[1] = "**"
						array2[2] = result[i].userid.substring(6);

						var userid = array2[0] +array2[1] +array2[2];
						str += "<tr>";
						str += "<td>"+username +"</td><td>"+userid+"</td><td>"+ result[i].regdate+"</td>";
						str += "</tr>";
					}
					
					str+= "</table>";
					$('#result').html(str);
				
				}else if(result.length == 0){
					alert("존재하지 않는 ID입니다.");
					return false;
				}
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); // ajax끝
	}
</script>
</head>

<body >
    <!-- ##### Login Area Start ##### -->
        <div class="container">
            <div class="row justify-content-center" id="result">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h5 style="color:brown">이름과 전화번호를 입력 후 ID찾기 버튼을 눌러주세요</h5><br><br>
                        
                        
                        <!-- Login Form -->
                        <div class="login-form">
                                <div class="form-group">
                                    <label for="userid">이름</label>
                                    <input type="text" class="form-control" id="username" aria-describedby="emailHelp" placeholder="username">
                                    
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">전화번호</label>
                                    <input type="text" class="form-control" id="tel" placeholder="tel">
                                </div>
                                <button type="button" class="btn oneMusic-btn mt-30" onclick="search();">ID찾기</button><br/>
                                <div>
                           <br>  
                           
                        </div>

                        </div>
                    </div>
                </div> 
            </div>
        </div>
    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="static/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="static/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="static/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="static/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="static/js/active.js"></script>
</body>
</html>
