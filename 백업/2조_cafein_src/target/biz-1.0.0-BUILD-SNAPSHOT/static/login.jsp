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

    <!-- Title -->
    <title>카페-인 | LOGIN</title>

    <!-- Favicon -->
    <link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="static/style.css">
    
<script src="static/js/jquery.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
$(function(){
   $("#btnJoin").bind('click',function(){ //회원가입 버튼 누르면
      location.href = "/coffee/join";
   });

   
   $("#login").bind('click',function(){ // 로그인
	   var userid = $("#userid").val();
   	   var passwd = $("#passwd").val();
   	   if(userid == ""){
   		   alert("ID를 입력해주세요");
   	   }else if(passwd == ""){
   		   alert("비밀번호를 입력해주세요.");
   	   }else{
			$.ajax({ // IF문 조건 다 거치면 회원가입 처리 AJAX 실행
				url : "loginMember", //회원가입 ajax
				dataType : "json",
				method : "POST",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"userid" : $("#userid").val(),
					"passwd" : $("#passwd").val()
				}),
				success : function(data){
					if(data == 1) { // 성공시 true를 반환
						alert("환영합니다.");
						location.href = "/coffee/";
					}else if(data == 2){
						alert("비밀번호가 일치하지않습니다.");
					}else if(data == -1){
						alert("존재하지 않는 ID입니다.");
					}
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
   	   }
	   });
   
   $("#naver").click(function(){ // 네이버 회원가입 API 
		var clientId = "6XdcN0HDkORTF33yi1jD";//애플리케이션 클라이언트 아이디값";
	    var redirectURI = "<%=getURI()%>";
	    var state = "<%=getState()%>";
	    var apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	 //   window.open = apiURL; // 버튼누르면 navercallback.jsp로 이동
	 	var left = (screen.availWidth-660)/2;
	 	var top = (screen.availHeight-430)/2;
	    //var win1 = window.open( apiURL, '_blank', 'left='+left+',top='+ top);
	    window.location=apiURL;
   });
   
   
});


function enterkey() {
    if (window.event.keyCode == 13) {
 	   var userid = $("#userid").val();
   	   var passwd = $("#passwd").val();
   	   if(userid == ""){
   		   alert("ID를 입력해주세요");
   	   }else if(passwd == ""){
   		   alert("비밀번호를 입력해주세요.");
   	   }else{
			$.ajax({ // IF문 조건 다 거치면 회원가입 처리 AJAX 실행
				url : "loginMember", //회원가입 ajax
				dataType : "json",
				method : "POST",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"userid" : $("#userid").val(),
					"passwd" : $("#passwd").val()
				}),
				success : function(data){
					if(data == 1) { // 성공시 true를 반환
						alert("환영합니다.");
						location.href = "/coffee/";
					}else if(data == 2){
						alert("비밀번호가 일치하지않습니다.");
					}else if(data == -1){
						alert("존재하지 않는 ID입니다.");
					}
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
   	   }
    }
}

</script>
</head>

<body>
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="lds-ellipsis">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>

    <!-- ##### Header Area Start ##### -->
	<jsp:include page="header.jsp" />
    <!-- ##### Header Area End ##### -->


    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/breadcumb3.jpg);">
        <div class="bradcumbContent">
            <p>카페-인</p>
            <h2>Login</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h3>Welcome Back</h3>
                        
                        
                        <!-- Login Form -->
                        <div class="login-form">
                            <form class="form-horizontal" method="POST" action="login.jsp">
                                <div class="form-group">
                                    <label for="userid">ID</label>
                                    <input type="text" class="form-control" name="userid" id="userid" aria-describedby="emailHelp" placeholder="Enter ID" onkeyup="enterkey();">
                                    
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" class="form-control" name="passwd" id="passwd" placeholder="Password" onkeyup="enterkey();">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>We'll never share your information with anyone else.</small>
                                </div>
                                <button type="button" class="btn oneMusic-btn mt-30" id="login">Login</button><br/>
                                <div>
                            <a id="kakao-login-btn" ></a><br>  
                           
                           <!-- <a id="kakao-login-btn" href="javascript:loginWithKakao()">
                              <img src="images/kakao_narrow.png" width="213"  height="49"/>
                              </a> <br/>
                            -->
                           <a href="<%="https://nid.naver.com/oauth2.0/authorize?response_type=code"%>">
                              <img width="213"  height="49"  src="static/images/naver_narrow.png" id="naver"/></a>
                           
                        </div>
                                <div>
                                <a href="/coffee/idSearch" class="d-ib" style="color: gray; font-size: 13px;font-weight: lighter;">아이디·비밀번호 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                <a href="/coffee/join" class="d-ib" style="color: gray; font-size: 13px;font-weight: lighter;">회원가입</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
    </section>
    <!-- ##### Login Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="#"><img src="static/img/core-img/logo3.png" alt="" width="20%"></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Albums</a></li>
                            <li><a href="#">Events</a></li>
                            <li><a href="#">News</a></li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area Start ##### -->

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

<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('415bc6029e5f00cc41281a3fef06583b');
    
/*     function loginWithKakao() {
        // 로그인 창을 띄웁니다.
        Kakao.Auth.login({
          success: function(authObj) {
            alert(JSON.stringify(authObj));
          },
          fail: function(err) {
            alert(JSON.stringify(err));
          }
        });
      };
     */
    
    
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        // 로그인 성공시, API를 호출합니다.
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(res) { // 로그인에 성공했으면 
             //alert(JSON.stringify(res)); //회원정보 출력
             //window.location="kakaojoin.jsp?userid="+userid +"&username=" + username;
            var userid = JSON.stringify(res.id);
            var username = JSON.stringify(res.properties['nickname']);  // ajax 전 
            
  			$.ajax({ // IF문 조건 다 거치면 회원가입 처리 AJAX 실행
				url : "joinKakao", //회원가입 ajax
				//dataType : "json",
				method : "POST",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"userid" : userid,
					"username" : username
				}),
				success : function(data){ // ajax 전 
		  			$.ajax({ // ID가 이미 DB에 저장되어있으면 바로 로그인되는 AJAX
						url : "kakaoCheck", //회원가입 ajax
						//dataType : "json",
						method : "POST",
						contentType : 'application/json; charset=UTF-8',
						data : JSON.stringify({
							"userid" : userid
						}),
						success : function(data){ 
							if(data == 1){
							alert("환영합니다.");
							location.href="/coffee/"; // 바로 로그인 성공								
							}else if(data ==-1){
								location.href="/coffee/join"; // 회원가입 창으로 이동
							}			
						}, 
						error : function(err){
							console.log("Error 발생 : " + err);
						}
					});		
				},  // ajax 후 
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
			
          },// ajax 후 
          fail: function(error) {
            alert(JSON.stringify(error));
          }
        });
      },
      fail: function(err) {
        alert(JSON.stringify(err));
      }
    }); 
  //]]>
</script>
</html>

<%!
   private String getURI() throws Exception{
      return URLEncoder.encode("http://localhost:8080/callback", "UTF-8");
   }
%>
<%! 
   private String getState(){
      SecureRandom random = new SecureRandom();
       String state = new BigInteger(130, random).toString();
       return state;
   }
%>