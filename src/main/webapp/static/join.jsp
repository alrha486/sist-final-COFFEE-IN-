<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<c:if test="${not empty(sessionScope.userid)}"> <!--  session에 ID가 있다면 api 회원가입-->
<c:set var="idCheck1" value="yes" />
</c:if>   
<c:if test="${empty(sessionScope.userid)}"> <!--  session에 ID가 없다면 (일반회원가입)-->
<c:set var="idCheck1" value="no" />
</c:if>   

<script src="static/js/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script> 
   $(function(){ 
      $('#zipSearch').click(function(){ // Daum 주소 API 
         
         new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullRoadAddr;
                document.getElementById('address2').value = "";
 
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;

 
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
 
                } 
            }
        }).open();
       });
   });  // Daum 주소 API 끝
   
   window.addEventListener('load', setup); // 윈도우가 로딩되면 setup 함수 실행
         
   function setup(){
	   		var idcheck1 = "${idCheck1}";
	   		document.getElementById("idCheck").setAttribute("value",idcheck1);
            document.getElementById("userid").addEventListener('blur', idCheck); // ID중복체크
            document.getElementById("usernickname").addEventListener('blur', nickCheck); //닉네임중복체크
            document.getElementById("pw1").addEventListener('blur', myPw); // PW체크
            document.getElementById("pw2").addEventListener('blur', myPw1); // PW체크
            document.getElementById("btnJoin").addEventListener('click', sendit); // 회원가입
            document.getElementById("btnCancel").addEventListener('click', cancel); // 취소
   }
   function cancel(){ // 회원가입 취소버튼 누르면
		$.ajax({ 
			url : "cancel", //회원가입 ajax
			method : "GET",
			success : function(data){
				if(data == 1) { // 성공시 1를 반환
					location.href = "/coffee/";
				} else{
					alert("뒤로가기 실패");
				}
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
   }
   function sendit() {  // 회원가입폼의 submit 버튼 누르면 호출되는 함수
            //var idResult = document.getElementById("idresult").value; // id 중복체크 했는지 여부 
            var pw1 = document.getElementById("pw1").value;  // 비밀번호
            var pw2 = document.getElementById("pw2").value; // 비밀번호 확인
             //var nickResult = document.getElementById("nickresult").value; // 닉네임 중복체크 했는지 여부            
             var usename = document.getElementById("username");               
             var pattern = /^[가-힣]{2,4}$/; // 이름 정규식
             var regExp = /^\d{3}\d{4}\d{4}$/; // 전화번호 정규식
             var pattern1 = /^[A-Za-z0-9]{4,12}$/; // 비밀번호 정규식
             var pattenr2 =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일정규식
             var tel = document.getElementById("tel");
             var email = document.getElementById("email");
             var idCheck = document.getElementById("idCheck").value;
             var nickCheck = document.getElementById("nickCheck").value;
             var address1 = document.getElementById("address1").value;
             var address2 = document.getElementById("address2").value;

              if(idCheck == "no"){ // ID중복체크 안했으면
                alert("ID를 확인해주세요"); 
                return false;
             }else if(!pattern1.test(pw1) && pw1 != "1"){ // 비밀번호 정규식 위반
                alert('비밀번호는  영문대,소문자 , 숫자 4 ~12 자리로 입력해 주세요.');
                pw1 = "";
                pw2 = "";
                return false;
             }else if(pw1 != pw2){
                alert('비밀번호를 확인해주세요!');
                pw2 = "";
                return false;
             }else if(!pattern.test(username.value)){
                alert('이름은 2 ~ 4글자(공백 없음)로 입력해 주세요.');
                username.value = "";
                return false;
             }else if(nickCheck == "no"){ // 중복체 크 안하면 그대로 none 
                alert("닉네임을 확인해주세요"); 
                return false;
             }else if(!pattenr2.test(email.value)){
                 alert('이메일을 형식을 지켜주세요');
                 email.value = "";
                 return false;
              }else if(!regExp.test(tel.value)){
                alert('전화번호를 제대로 입력해주세요');
                tel.value = "";
                return false;
             }else if(address1 =="" && address2 ==""){
			       alert('주소를 입력해주세요.');
			       return false;
			  }  
  			$.ajax({ // IF문 조건 다 거치면 회원가입 처리 AJAX 실행
				url : "joinMember", //회원가입 ajax
				dataType : "json",
				method : "POST",
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					"userid" : $("#userid").val(),
					"passwd" : $("#pw1").val(),
					"username" : $("#username").val(),
					"usernickname" : $("#usernickname").val(),
					"email" : $("#email").val(),
					"tel" : $("#tel").val(),
					"zipcode" : $("#zipcode").val(),
					"address1" : $("#address1").val(),
					"address2" : $("#address2").val(),
				}),
				success : function(data){
					if(data.code) { // 성공시 true를 반환
						alert("회원가입을 축하드립니다.");
						location.href = "/coffee/";
					} else alert("회원가입 실패");
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			});
             
            } // sendit() 끝

            
            function idCheck(){ // ID 입력칸의 포커스가 변경되면
            	 var apiUserid = "${idCheck1}"; 
            	 var idReg =  /^[A-Za-z0-9]{5,13}$/;
             	 var userid = $('#userid').val();
             	 if(userid == ""){
             		$('#ajaxID').html('<p style="color:red">ID를 입력해주세요.</p>'); 
             	 }else if(!idReg.test(userid) && apiUserid == "no"){
            		 $('#ajaxID').html('<p style="color:red">아이디는 영문자로 시작하는 5~13자 영문자 또는 숫자이어야 합니다.</p>');
            	 }else{
        			$.ajax({
        				url : "idCheck/"+userid, // /coffee/
        				type : "POST",
        				success : function(data){
        				 	 if(data == 0) {
        				 			$('#ajaxID').html('<p style="color:blue">사용가능한 아이디입니다.</p>');
            						$('#idCheck').attr('value','yes'); // check 여부를 yes로 바꿔주기        				 
        				 	}else if(data == 1){
        						$('#ajaxID').html('<p style="color:red">이미 존재하는 아이디입니다.</p>');
        					}  
        				},
        				error : function(err){
        					console.log("Error 발생 : " + err);
        				}
        			}); 
               }
            }

             
             function nickCheck(){ // 닉네임 입력칸의 포커스가 변경되면
            	 var idReg = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{5,13}$/;
             	 var usernickname = $('#usernickname').val();
             	 if(usernickname == ""){
             		$('#ajaxNick').html('<p style="color:red">닉네임을 입력해주세요.</p>'); 
             	 }else if(!idReg.test(usernickname)){
            		 $('#ajaxNick').html('<p style="color:red">닉네임은 한/영으로 시작하는 5~13자 한/영문자 또는 숫자이어야 합니다.</p>');
            	 }else{
        			$.ajax({
        				url : "nickCheck/"+usernickname, // /coffee/
        				type : "POST",
        				success : function(data){
        				 	 if(data == 0) {
        						$('#ajaxNick').html('<p style="color:blue">사용가능한 닉네임입니다.</p>');
        						$('#nickCheck').attr('value','yes'); // check 여부를 yes로 바꿔주기
        					}else if(data == 1){
        						$('#ajaxNick').html('<p style="color:red">이미 존재하는 닉네임입니다.</p>');
        					}  
        				},
        				error : function(err){
        					console.log("Error 발생 : " + err);
        				}
        			}); 
               }
            }
             
            function myPw(){
                var pattern1 = /^[A-Za-z0-9]{4,12}$/; // 비밀번호 정규식
                var pw1 = document.getElementById("pw1").value;
                 if(!pattern1.test(pw1)){ // 비밀번호 정규식 위반
                   document.getElementById("ajaxPW1").innerHTML = '비밀번호는  영문대,소문자 , 숫자 4 ~12 자리로 입력해 주세요.';
                   document.getElementById("ajaxPW1").style.color = "red";
                    pw1 = "";
                    pw2 = "";
                 }else if(pattern1.test(pw1)){
                    document.getElementById("ajaxPW1").innerHTML = "";
                 }

             }
            
             function myPw1(){ 
                var pw1 = document.getElementById("pw1").value;
                var pw2 = document.getElementById("pw2").value;             
                if(pw1 !== pw2){
                  document.getElementById("ajaxPW").innerHTML = "비밀번호가 일치하지 않습니다.";             
                  document.getElementById("ajaxPW").style.color = "red";
                }else{
                  document.getElementById("ajaxPW").innerHTML = "일치";             
                  document.getElementById("ajaxPW").style.color = "green";
                }
             }
   </script>
 
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>카페-인 | JOIN</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/iconfinder_cup-coffee-hearts_2903267.ico">

<!-- Stylesheet -->
<link rel="stylesheet" href="static/style.css">

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
   <header class="header-area">
      <!-- Navbar Area -->
      <div class="oneMusic-main-menu">
         <div class="classy-nav-container breakpoint-off">
            <div class="container">
               <!-- Menu -->
               <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                  <!-- Nav brand -->
                  <a href="index.html" class="nav-brand"><img
                     src="static/img\core-img\logo2.png" alt=""></a>

                  <!-- Navbar Toggler -->
                  <div class="classy-navbar-toggler">
                     <span class="navbarToggler"><span></span><span></span><span></span></span>
                  </div>

                  <!-- Menu -->
                  <div class="classy-menu">

                     <!-- Close Button -->
                     <div class="classycloseIcon">
                        <div class="cross-wrap">
                           <span class="top"></span><span class="bottom"></span>
                        </div>
                     </div>

                     <!-- Nav Start -->
                     <div class="classynav">
                        <ul>
                           <li><a href="index.html">Home</a></li>
                           <li><a href="#">About</a></li>
                           <!-- <li><a href="albums-store.html">Albums</a></li> -->
                           <li><a href="#">Shop</a>
                              <ul class="dropdown">
                                 <li><a href="#">Coffee</a>
                                    <ul class="dropdown">
                                       <li><a href="#">Beans</a></li>
                                       <li><a href="#">Bottle coffee</a></li>
                                       <li><a href="#">Drip bag</a></li>
                                    </ul></li>
                                 <li><a href="index.html">Foods</a>
                                    <ul class="dropdown">
                                       <li><a href="#">Cake</a></li>
                                       <li><a href="#">Bakery</a></li>
                                       <li><a href="#">Sandwich</a></li>
                                    </ul></li>
                                 <li><a href="index.html">Goods</a>
                                    <ul class="dropdown">
                                       <li><a href="#">Mug/Tumbler</a></li>
                                       <li><a href="#">Coffee goods</a></li>
                                       <li><a href="#">Accessory</a></li>
                                    </ul></li>
                              </ul>
                           <li><a href="event.html">Contact</a>
                              <ul class="dropdown">
                                 <li><a href="#">Notice</a></li>
                                 <li><a href="#">QnA</a></li>
                              </ul></li>

                           <li><a href="#">Store</a></li>
                        </ul>


                        <!-- Login/Register & Cart Button -->

                        <div
                           class="login-register-cart-button d-flex align-items-center">
                           <!-- Login/Register -->
                           <div class="login-register-btn mr-50">
                              <a href="login.html" id="loginBtn">Login / Join</a>
                           </div>
                           <div class="login-register-btn mr-50">
                              <a href="login.html" id="loginBtn">Mypage</a>
                           </div>
                           <div class="login-register-btn mr-50">
                              <a href="#" id="searchBtn"><img
                                 src="//image.istarbucks.co.kr/common/img/common/icon_magnifier_white.png"></a>

                           </div>


                           <!-- Cart Button -->
                           <div class="cart-btn">
                              <!-- <p> <a href="cart.jsp" id="cartBtn"><span class="icon-shopping-cart"></span> <span class="quantity"></span></a></p> -->
                              <a href="cart.jsp" id="cartBtn">
                                 <p>
                                    <span class="icon-shopping-cart"></span> <span
                                       class="quantity">1</span>
                                 </p>
                              </a>
                           </div>




                        </div>
                     </div>
                     <!-- Nav End -->

                  </div>
               </nav>
            </div>
         </div>
      </div>
   </header>
   <!-- ##### Header Area End ##### -->

   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay"
      style="background-image: url(static/img/bg-img/aaa.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>JOIN</h2>
      </div>
   </section>
   <!-- ##### Breadcumb Area End ##### -->



   <!--회원가입폼  Start -->

    <section class="newsletter-testimonials-area" >
        <div class="container">   <!-- 여기 변경하면 밑에 서브스크라이브 버튼 변경된다 -->
                <!-- Newsletter Area -->
                
                
                <div class="col-12 col-lg-12" style="padding: 50px" >
                    <div class="newsletter-area mb-100" style="width:52% ;margin: auto;">
                        <div class="section-heading text-left mb-50">
                            <p>Membership Registration</p>
                            <p>* 필수 항목</p>
                        </div>
                        <div class="newsletter-form">
                            <form name="myform" id="myform"> 
                            	<c:if test="${empty sessionScope.userid}" > <!--  세션이 없다면 -->
	                                <input type="text" name="userid" id="userid" placeholder="ID *" required="required" autofocus>
	                                <span id="ajaxID"></span>
                            	</c:if>
                            	<c:if test="${not (empty sessionScope.userid)}" > <!--  세션이 있다면 -->
	                                <input type="hidden" name="userid" id="userid" placeholder="ID *" readonly value="${sessionScope.userid}">
	                                <span id="ajaxID"></span>
                            	</c:if>
                            	<c:if test="${not (empty sessionScope.userid)}" > <!--  세션이 있다면 -->                            	
	                                <input type="hidden" name="passwd" id="pw1" placeholder="Password *" required="required" value="1">
	                                   <span id="ajaxPW1"></span>
	                                <input type="hidden" name="passwd1" id="pw2" placeholder="Confirm Password *" required="required" value="1">
	                                   <span id="ajaxPW"></span>
                                 </c:if>
                                 <c:if test="${empty sessionScope.userid}" > <!--  세션이 있다면 -->                            	
	                                <input type="password" name="passwd" id="pw1" placeholder="Password *" required="required">
	                                   <span id="ajaxPW1"></span>
	                                <input type="password" name="passwd1" id="pw2" placeholder="Confirm Password *" required="required">
	                                   <span id="ajaxPW"></span>
                                 </c:if>
                                <c:if test="${empty sessionScope.username}" > <!--  세션이 없다면 -->
                                <input type="text" name="username" id="username" placeholder="Name *" required="required">
                                </c:if>
                                 <c:if test="${not (empty sessionScope.username)}" > <!--  세션이 없다면 -->
                                <input type="text" name="username" id="username" placeholder="Name *" readonly value=${sessionScope.username}>
                                </c:if>
                                <input type="text" name="usernickname" id="usernickname" placeholder="Nickname *" required="required">
                                   <span id="ajaxNick"></span>
                                <input type="email" name="email" id="email" placeholder="E-mail *" required="required">
                                <input type="text" name="tel" id="tel" placeholder="Phone Number *" required="required">
                                <button type="button" id="zipSearch" class="btn btn-outline-dark btn-sm">우편번호검색</button>
                                <input type="text" name="zipcode" id="zipcode" placeholder="Zip-code"readonly="readonly">                                
                                <input type="text" name="address1" id="address1" placeholder="Address" readonly="readonly" >
                                <input type="text" name="address2" id="address2" placeholder="Address detail" required="required">
                                <input type="hidden" id="idCheck" value="no"/>
                                <input type="hidden" id="nickCheck" value="no"/>
                                
                                <div align="center"><button type="button" class="btn oneMusic-btn" id="btnJoin">Join in<i class="fa fa-angle-double-right"></i></button></div>
                                 <div align="center"><button type="button" class="btn oneMusic-btn" id="btnCancel">Cancel<i class="fa fa-angle-double-right"></i></button></div>
                                
                            </form>
                        </div>
                    </div>
                </div>
   
   
   
   <!-- ##### Contact Area End ##### -->


   <div class="col-12 col-lg-3" align="right">
      <div class="contact-content mb-100">
         <!-- Contact Social Info -->
         <div class="contact-social-info mt-50">
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Pinterest"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Dribbble"><i class="fa fa-dribbble" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Behance"><i class="fa fa-behance" aria-hidden="true"></i></a>
            <a href="#" data-toggle="tooltip" data-placement="top"
               title="Linkedin"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
         </div>

      </div>
   </div>
   </section>
   <!-- ##### Contact Area End ##### -->

   <!-- ##### Footer Area Start ##### -->
   <footer class="footer-area">
      <div class="container">
         <div class="row d-flex flex-wrap align-items-center">
            <div class="col-12 col-md-6">
               <a href="index.html"><img src="static/img/core-img/logo3.png" alt="" width="20%"></a>
               <p class="copywrite-text">
                  <a href="#">
                     <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                     Copyright &copy;<script>
                        document.write(new Date().getFullYear());
                     </script>
                     All rights reserved | This template is made with <i
                     class="fa fa-heart-o" aria-hidden="true"></i> by <a
                     href="https://colorlib.com" target="_blank">Colorlib</a> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
               </p>
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


