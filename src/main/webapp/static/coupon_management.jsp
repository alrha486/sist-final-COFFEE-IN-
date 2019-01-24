<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
  
  <form>
<h4>쿠폰 관리</h4>
   <br/><br/>
   <br>
   <br>
   
   <div>
      <div>
		 <div>	
			<div style="float:left;">
				<button type="button" id="btnInsert" class='btn btn-success' >쿠폰 등록</button>
				<button type="button" id="btnIssue" class='btn btn-danger' >쿠폰 발급</button>
			</div>
            <div style="text-align: right;padding-left: 0px; padding-right: 0px; margin-bottom: 15px;">
                  <span style="margin-bottom: 5px; font-size: 1.3em;">쿠폰종류 : <span id="length">0</span>개</span>
            <span style="padding-right: 0px; margin-bottom: 5px; margin-bottom: 15px; margin-left: 20px;">
                  <button type="button" id="btnModify" class='btn btn-primary' >선택쿠폰 수정</button>
                  <button type="button" id="btnDelete" class='btn btn-warning' >선택쿠폰 삭제</button>
            </span>
            </div>
         </div>  
            <table class="table table-striped">
               <thead class="a">
                  <tr>
                     <th style="text-align: center;width:5%"></th>
                     <th style="text-align: center;width:5%">쿠폰번호</th>
                     <th style="text-align: center;width:20%">쿠폰이름</th>
                     <th style="text-align: center;width:30%">쿠폰내용</th>
                     <th style="text-align: center;width:10%">쿠폰할인금액</th>
                     <th style="text-align: center;width:15%">쿠폰등록날짜</th>
                     <th style="text-align: center;width:10%">쿠폰사용가능금액</th>
                  </tr>
               </thead>
               <tbody id="result">
                  
               </tbody>
            </table>
      </div>
      <div class="container2">
	     <ul class="pagination" id="paging" style="text-align:center;"></ul>
	  </div>
   </div>
   </form>