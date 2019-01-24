<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<script src="static/js/jquery.min.js"></script>
<script>
	$(function(){
		$.ajax({
			url : "hot_product_list_back.jsp",
			method : "GET",
			dataType : "json",
			success : function(){
						
				
			},
			
			error : function(error){
				console.log("error 발생 = " + error);
			}
		});		
		// ajax 끝
	}); 
</script>
<section class="latest-albums-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading style-2">
                        <p>See what’s new</p>
                        <h2>Latest Products</h2>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-12 col-lg-9">
                    <div class="ablums-text text-center mb-70">
                        <p>Nam tristique ex vel magna tincidunt, ut porta nisl finibus. Vivamus eu dolor eu quam varius rutrum. Fusce nec justo id sem aliquam fringilla nec non lacus. Suspendisse eget lobortis nisi, ac cursus odio. Vivamus nibh velit, rutrum at ipsum ac, dignissim iaculis ante. Donec in velit non elit pulvinar pellentesque et non eros.</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="albums-slideshow owl-carousel">
                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/caramel.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>아이스 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>

                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/moka.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>모카 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>

                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/solt.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>씨솔트 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>

                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/caramel.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>아이스 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>

                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/moka.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>모카 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>

                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/solt.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>씨솔트 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>

                        <!-- Single Album -->
                        <div class="single-album">
                            <img src="static/img/bg-img/caramel.jpg" alt="">
                            <div class="album-info">
                                <a href="#">
                                    <h5>아이스 캐러멜</h5>
                                </a>
                                <p>Ice Coffee</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>