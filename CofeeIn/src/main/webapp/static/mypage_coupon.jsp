<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>One Music - Modern Music HTML5 Template</title>

    <!-- Favicon -->
    <link rel="icon" href="static/img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="static/style.css">
    <link rel="stylesheet" href="static/css/bootstrap.css">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/header.js"></script>
   
   <script>
   $(document).ready(function(){   

      $.ajax({ 
         url : "/coffee/selectUserCoupon", // 사용자가 가지고있는 쿠폰조회
         method : "GET",
         success : function(data){
            var result = data.data;
            var str = "";
            $("#length").text(result.length);
            if(result.length == 0){ // 유저가 가지고 있는 쿠폰이 아무것도 없을 떄
                    str +="<td colspan='5' style='text-align:center;'>사용가능한 쿠폰이 없습니다.</td>";  
            }else{         
                for(var i=0; i<result.length; i++){
                      
                   str += "<tr >" +
                              "<td style='text-align: center;'>"+ result[i].c_name+"</td>" +
                              "<td style='text-align: center;'>"+ result[i].c_content+"</td>" +
                              "<td style='text-align: center;'>"+ result[i].c_discount +"</td>" +
                              "<td style='text-align: center;'>"+ result[i].c_dead +"</td>" +
                              "<td style='text-align: center;'>"+ result[i].c_condition +"</td>" +
                           "</tr>";   
                 } 
            }
            $('#result').html(str);
         },
         error : function(err){
            console.log("Error 발생 : " + err);
         }
      }); // ajax 끝
      
      $.ajax({ 
         url : "/coffee/selectMySaving", // 사용자가 가지고있는 적립금조회
         method : "GET",
         success : function(data){ // 로드될 떄
            console.log(data+100);
            $('#saving').html(data + "원");
            $('#saving').val(data);
         },
         error : function(err){
            console.log("Error 발생 : " + err);
         }
      }); // ajax 끝
   });

   function back(){
	   history.back();
   }
   </script>
</head>
<body>    
    
<jsp:include page="header.jsp" />
    <!-- ##### Header Area End ##### -->


    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(static/img/main.jpg);">
        <div class="bradcumbContent">
            <p>CAFE-IN</p>
            <h2>COUPON</h2>
        </div>
    </section>      
      
      
  <form>
   <br/><br/>
   <br>
   <br>
   
   <div>
      <div>
       <div>   
            <div style="width:80%; text-align: right;padding-left: 0px; padding-right: 0px; margin-bottom: 15px; margin-right:auto; margin-left:auto;">
                  <span style="margin-bottom: 5px; font-size: 1.8em;">내 적립금 : <span id="saving" style="color:red">0</span></span>
                  <br><br>
                  <span style="margin-bottom: 5px; font-size: 1.8em;">내 쿠폰 개수 : <span id="length">0</span>개</span>
            </div>
         </div>  
            <table class="table table-striped" style="width:80%; margin-right:auto; margin-left:auto;" border="1">
               <thead class="a">
                  <tr>
                     <th style="text-align: center;width:20%">쿠폰이름</th>
                     <th style="text-align: center;width:30%">쿠폰내용</th>
                     <th style="text-align: center;width:10%">쿠폰할인금액</th>
                     <th style="text-align: center;width:15%">쿠폰마감날짜</th>
                     <th style="text-align: center;width:10%">쿠폰사용가능금액</th>
                  </tr>
               </thead>
               <tbody id="result">
                  
               </tbody>
               
            </table>
              <div style="text-align:center;">
			<div style="text-align:center;">
	               <input type='button' value='선택 쿠폰 삭제'  class="btn btn-danger" id="btnCancel"/>
	               <input type='button' value='돌아 가기'  class="btn btn-warning" onclick="back();"/>
               </div>
               </div>     
      </div>
               
      <div class="container2">
        <ul class="pagination" id="paging" style="text-align:center;"></ul>
     </div>
   </div>
   </form>
</body>
</html>   