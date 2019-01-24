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

    <title>PW찾기</title>

    <link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

    <link rel="stylesheet" href="static/style.css">
    
<script src="static/js/jquery.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
	function search(){
		var username = $('#username').val();
		var userid = $('#userid').val();
		$.ajax({ // 쇼핑카트 list
			url : "/coffee/selectUserInfo/"+username + "/" + userid, 
			method : "GET",
			success : function(data){
				var result1 = data.data;
				if(result1.length == 0){
					alert("존재하지 않는 ID입니다.");
					return false;
				}
				var result = data.data;
				
				var email = result[0].email;
				var username = result[0].username;
				var userid = result[0].userid;
				if(result.length != 0){ // ID가 DB에 존재한다면
					$.ajax({ // 새로운 비밀번호 가입한 보내주는 ajax
						url : "/coffee/sendNewPasswordMessage",
						method : "GET",
						data : {
							"username" : username,
							"email" : email,
							"userid" : userid
						}, 
						success : function(data){
							if(data == 1){
								alert("가입 시 입력하신 메일로 새로운 비밀번호를 보내드렸습니다. 확인 후 로그인해주시길 바랍니다.");
								self.close();
								opener.location.href="/coffee/login";
							}
						},
						error : function(err){
							console.log("Error 발생 : " + err);
						}
					}); // ajax끝
					
				}
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); // ajax끝
	}
</script>
</head>

<body>
    <!-- ##### Login Area Start ##### -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h5 style="color:brown">이름과 ID를 입력 후 PW찾기 버튼을 눌러주세요</h5><br><br>
                        
                        
                        <!-- Login Form -->
                        <div class="login-form">
                                <div class="form-group">
                                    <label for="userid">이름</label>
                                    <input type="text" class="form-control" id="username" aria-describedby="emailHelp" placeholder="username">
                                    
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">ID</label>
                                    <input type="text" class="form-control" id="userid" placeholder="userid">
                                </div>
                                <button type="button" class="btn oneMusic-btn mt-30" onclick="search();">PW찾기</button><br/>
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
