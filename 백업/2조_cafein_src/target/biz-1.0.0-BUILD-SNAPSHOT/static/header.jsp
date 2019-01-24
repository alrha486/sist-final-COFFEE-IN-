<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value="static/js/sockjs-0.3.4.js"/>"></script>
<script type="text/javascript" src="<c:url value="static/js/bot/bot.js"/>"></script>
<script type="text/javascript">
$(document).ready(function(){ // 페이지 로드 시

	
	 $.ajax({ // id별로 장바구니에 몇개의 상품이 들어있는지 알아오는 ajax
			url : "/coffee/cartEaSearch",
			method : "GET",
			success : function(data){
				if(data == 0){
					$('#cartEaResult').html(0);	
				}else if(data != 0){
					$('#cartEaResult').html(data);
				}				
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		}); // 장바구니 ajax
		
		 $.ajax({ // id별로 메시지함에 안읽은 메시지가 몇개있는지
				url : "/coffee/MessageEaSearch",
				method : "GET",
				success : function(data){
					if(data == 0){
						$('#spanResult').html(0);	
					}else if(data != 0){
						$('#spanResult').html(data);
					}				
				},
				error : function(err){
					console.log("Error 발생 : " + err);
				}
			}); // 메시지 개수 ajax
});
var sock; //웸소켓을 지정한 url(EchoHandler)로 연결한다.
sock = new SockJS("<c:url value="/echo"/>");  
//    /echo/ =  EchoHandler클래스 호출  >> HechoHandler 생성자로 객체생성

//데이터가 나한테 전달되읐을 때 자동으로 실행되는 function
sock.onmessage = onMessage;

//데이터를 끊고싶을때 실행하는 메소드
sock.onclose = onClose;

/*소켓으로 보내겠다.  */
function sendMessage() {   
	//alert("메시지보냄");
}
//evt 파라미터는 웹소켓을 보내준 데이터다.(자동으로 들어옴)
function onMessage(evt) { // 메시지 받으면 
	var a =$("#spanResult").html();
	a ++;
	$('#spanResult').html(a); // 아이콘 옆에 안읽은 메시지 개수 표시해주기	
}

function onClose(evt) { // 웹소켓 연결 끊김 
	//alert("연결끊김")
}


</script>

	    <header class="header-area">
        <!-- Navbar Area -->
        <div class="oneMusic-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="/coffee" class="nav-brand"><img src="static/img/core-img/logo3.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- Close Button -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                	<li><a href="/coffee/">Home</a></li>
                                    <li><a href="/coffee/about">About</a></li>
                                    <!-- <li><a href="albums-store.html">Albums</a></li> -->
                                    <li><a href="/coffee/productList/COFFEE">Shop</a>
                                        <ul class="dropdown">
                                            <li><a href="/coffee/productList" id="Coffee">Coffee</a>
                                                <ul class="dropdown">
		                                            <li><a href="#" id="beans1">Beans</a></li>
		                                            <li><a href="#" id="bottle1">Bottle coffee</a></li>
		                                            <li><a href="#" id="drip1">Drip bag</a></li>
                                            	</ul>
                                            </li>
                                            <li><a href="#" id="Foods">Foods</a>
                                                <ul class="dropdown">
		                                            <li><a href="#" id="cake1">Cake</a></li>
		                                            <li><a href="#" id="bakery1">Bakery</a></li>
		                                            <li><a href="#" id="sandwich1">Sandwich</a></li>
                                            	</ul>
                                            </li>
                                            <li><a href="#" id="Goods">Goods</a>
                                                <ul class="dropdown">
		                                            <li><a href="#" id="mug1">Mug/Tumbler</a></li>
		                                            <li><a href="#" id="tumbler1">Coffee goods</a></li>
		                                            <li><a href="#" id="accessory1">Accessory</a></li>
                                            	</ul>
                                            </li>
                                        </ul>
                                      
                                    <li><a href="#">Contact</a>
                                        <ul class="dropdown">
                                            <li><a href="#">Notce</a></li>
                                            <li><a href="/coffee/goQnA">QnA</a></li>
                                        </ul>                                    
                                    </li>
                                    
                                    <li><a href="/coffee/store">Store</a></li>
                                </ul>
                                

                                <!-- Login/Register & Cart Button -->
                                
                                <div class="login-register-cart-button d-flex align-items-center">
                                   
                                    <div class="login-register-btn mr-50">
                                        <input type="text" name="productName" id="productName" >
                                        <img id="searchicon" src="//image.istarbucks.co.kr/common/img/common/icon_magnifier_white.png">
                                    </div>     
                                   
	                                 <!-- Login/Register -->
									<c:if test="${empty sessionScope.userid}">
									<div class="login-register-btn mr-50">
	                                        <a href="/coffee/login" id="loginBtn">Login</a>
	                                    </div>
									</c:if>
									<c:if test="${not (empty sessionScope.userid)}">
									<div class="login-register-btn mr-50">
	                                        <a id="logoutBtn">LogOut</a>
	                                    </div>
									</c:if>
									
									
								<c:if test="${not (empty sessionScope.userid) && (sessionScope.userid ne 'wlsdnd123')}"> <!-- 세션이 있어야 마이페이지 보이게 -->
                                    <div class="login-register-btn mr-50">
                                        <a href="/coffee/mypage">Mypage</a> 
                                    </div>        
                                 </c:if>  
                                                               
                                    <c:if test="${not (empty sessionScope.userid) && (sessionScope.userid ne 'wlsdnd123')}"> <!-- 세션이 있으면 장바구니함 보이게 -->                     
							        <!-- Cart Button -->
							        <div class="cart-btn">
                                    <p><a id="btnCart"><span class="icon-shopping-cart" id="btnCart"></span> 
                                    <span class="quantity" id="cartEaResult"></span></a></p>
                                    </div>
                                    </c:if>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                              
                                    
                                    <c:if test="${not (empty sessionScope.userid) && (sessionScope.userid ne 'wlsdnd123')}"> <!-- 세션이 있으면 메시지함 보이게 -->                       
										<div class="cart-btn">
	                                    <p><a href="javascript:void(window.open('/coffee/chatRoom', '채팅방','width=370, height=550 top=180, left=1450'))"><span class="icon-shopping-cart"></span> 
	                                    <span class="quantity" id="spanResult" ></span></a></p></div>
									</c:if>

									


	                                <c:if test="${sessionScope.userid eq 'wlsdnd123'}"> <!-- 아이디가 wlsdnd123(관리자)이어야만 관리자페이보이게 -->
	                               		<div class="classynav">
											<ul><li>
												<a href="/coffee/admin">관리자페이지</a>                     
		                                    </li></ul>
	                                    </div>
									</c:if>     

                                </div>
                            </div>
                            <!-- Nav End -->
     										
                        </div>
                    </nav>
                </div>    
            </div>
        </div>
    </header>