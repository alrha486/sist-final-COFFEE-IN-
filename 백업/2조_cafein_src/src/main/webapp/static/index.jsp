<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>CAFE IN - Modern cafe</title>

    <!-- Favicon -->
    
    <link rel="icon" href="static/img/core-img/favicon.ico">



    <!-- Stylesheet -->
    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    
  <script src="//code.jquery.com/jquery-1.12.4.js"></script>
  <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="static/js/header.js"></script>
    
    
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

    
    <!-- ##### Main image Start ##### -->
  	<jsp:include page="hero_area.jsp"/>
    <!-- ##### Main image End ##### -->

    
    <!-- ##### hot_product_list Area Start ##### -->
    <jsp:include page="newlist.jsp"/>
    <!-- ##### hot_product_list Area End ##### -->

    
    <!-- ##### Instagram Area Start ##### -->
    <jsp:include page="instagram_list.jsp"/>
    <!-- ##### Instagram Area End ##### -->


    <!-- ##### Footer Area Start ##### -->
	<jsp:include page="footer.jsp" />
    <!-- ##### Footer Area Start ##### -->



    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->

    <!-- Popper js -->
    <script src="static/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="static/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="static/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="static/js/active.js"></script>
    <!--  instagram js -->
</body>

</html>