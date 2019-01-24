<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>
        
        <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header" id="result1">주문관리</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading" id ="result2">
                             <%@include file="orderMGMT.jsp"%>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        
                          </div>
                        <!-- /.panel-body -->
                        </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
        <%@include file="includes/footer.jsp"%>
        
        
        

     
    <!-- jQuery -->
    <script src="static/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="static/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="static/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="static/resources/vendor/raphael/raphael.min.js"></script>
    <script src="static/resources/vendor/morrisjs/morris.min.js"></script>
    <script src="static/resources/data/morris-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="static/resources/dist/js/sb-admin-2.js"></script>

<body>
</body>

</html>
