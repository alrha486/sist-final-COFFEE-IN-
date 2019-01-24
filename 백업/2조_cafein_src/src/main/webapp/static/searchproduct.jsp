<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap"%>
<%@ page import="java.util.List, com.example.vo.ProductVO, java.util.Vector"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="product" value="${data}" />

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>카페-인 | 상품 검색</title>

<!-- Favicon -->
<link rel="icon" href="static/img/core-img/favicon.ico">

<!-- Stylesheet -->
<link
   href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|East+Sea+Dokdo|Nanum+Gothic:400,700,800|Noto+Serif+KR:400,500,600,700,900&amp;subset=korean"
   rel="stylesheet">

<link rel="stylesheet" href="static/style.css">
<link rel="stylesheet" href="static/css/bootstrap.css">
<link rel="stylesheet" href="static/css/header.css">
<link rel="stylesheet" href="static/css/footer.css">
<link rel="stylesheet" href="static/css/searchproduct.css">

<script src="static/js/jquery.min.js"></script>
<!-- autocomplete 기능 -->


<link href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>

<script src="static/js/header.js"></script>
<script src="static/js/searchproduct.js"></script>

<script>
$(function(){
   $.ajax({
     url:"/coffee/productNameAll",
     data:"json",
     method:"GET",
     success : function(data) {
        var data=data.data;
        var array=[];
        
        for(var i=0; i<data.length; i++){
           array.push(data[i].productname);
          
        }
          $("#innerSearch").autocomplete({
                source: array
          });
     },
     error : function(err) {
      console.log("error 발생 : " + err);
     }
    });       
});
</script>



<!-- 검색 자동완성 테스트 -->
<!-- <link href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script> -->

<style>


.row{
   width:100%;
}
#aaa{
text-align: center;
}
#bbb{
   display: inline-block;
}
</style>


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
   
   <input type="hidden" id="userid" value="${sessionScope.userid}"/>
   <!-- ##### Breadcumb Area Start ##### -->
   <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/bg-img/searchmainimg.jpg);">
      <div class="bradcumbContent">
         <p>카페 - 인</p>
         <h2>SEARCH RESULT</h2>
      </div>
   
   <form id="fmPop"></form>
   </section>
   
      <section class="oneMusic-buy-now-area has-fluid bg-gray section-padding-100" style="height:1300px;">
        <div>       
            <input type="text" class="form-control" style="width:50%;"name="innerSearch" id="innerSearch" placeholder="상품명을 입력하세요">
            <br/>
             <p id="count" style="color:green;">${fn:length(data)}건이 검색되었습니다   </p>
             <hr/>
                     
          <c:if test="${empty product}">
               <p style="text-align: center;" id="resultcount">검색 결과가 없습니다</p>
           </c:if>
       </div>
        
        
        <div class="container-fluid" id="results">
                <c:if test="${!empty product}">
                <c:forEach items="${data }" var="item" step="1">
        
                <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                    <div class="single-album-area wow fadeInUp" data-wow-delay="100ms">
                        <div class="album-thumb">
                            <a href="javascript:void(0);" onclick="goView(${item.productid});">
                            <img src="static/img/product/${item.productname}.jpg" ></a>
                        </div>
                        <div class="album-info">
                                <h5>${item.productname }</h5>
 
                            <p>${item.price }원</p>
                        </div>
                    </div>
                </div>
                
                </c:forEach>
                </c:if>
        
         </div>
         
    </section>

   <!-- ##### Breadcumb Area End ##### -->

   <!-- ##### Footer Area Start ##### -->
   <jsp:include page="footer.jsp" />
   <!-- ##### Footer Area Start ##### -->


   <!-- ##### All Javascript Script ##### -->
   <!-- jQuery-2.2.4 js -->
   <!-- <script src="static/js/jquery/jquery-2.2.4.min.js"></script> -->
   
   <!-- Popper js -->
   <script src="static/js/popper.min.js"></script>
   <!-- Bootstrap js -->
   <script src="static/js/bootstrap.min.js"></script>
   <!-- All Plugins js -->
   <script src="static/js/plugins/plugins.js"></script>
   <!-- Active js -->
   <script src="static/js/active.js"></script>
</body>

</html>