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
<script>
	function pwSearch(){
		 window.open("/coffee/pwSearch", "비밀번호찾기", "width=566, height=517 top=280, left=630, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  		 
	}
	function back(){
		history.back();
	}
	function IDSearch(){
		window.open("/coffee/IDSearch1", "ID찾기", "width=566, height=517 top=280, left=630, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
	}
</script>
</head>

<body>
    <!-- ##### Header Area Start ##### -->
	<jsp:include page="header.jsp" />
    <!-- ##### Header Area End ##### -->

    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/breadcumb3.jpg);">
        <div class="bradcumbContent">
            <p>카페-인</p>
            <h2>ID/PW 찾기</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h3>아이디, 비밀번호가 생각나지 않으세요?</h3>
						<h6 style="color:brown">본인 인증을 통해 Coffe-In 회원 아이디,</h6>
						<h6 style="color:brown">비밀번호를 찾으실 수 있습니다.</h6>
					<br><br><hr>
					<table>
						<thead>
							<tr>
								<th>
									<h5 style="color:blue">ID 찾기</h5>
									<h6>아래 인증방법을 선택하시면,</h6>
									<h6> 본인인증을 통해 고객님의 비밀번호를 찾아드립니다.</h6>
									<button type="button" class="btn oneMusic-btn mt-30" id="pwSearch" onclick="IDSearch();">ID찾기</button>
								</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th> <!-- 여기지워 -->
									<th>
									<h5 style="color:blue">PW 찾기</h5>
									<h6>아래 인증방법을 선택하시면,</h6>
									<h6> 본인인증을 통해 고객님의 비밀번호를 찾아드립니다.</h6>
									<button type="button" class="btn oneMusic-btn mt-30" id="pwSearch" onclick="pwSearch();">PW찾기</button>
								</th>
								
							</tr>
						</thead>
					</table>
						
         			
                        </div>
	                        <div class="row justify-content-center">
		                        <button type="button" class="btn oneMusic-btn mt-30" onclick="back();">뒤로 가기</button>			
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
</html>
