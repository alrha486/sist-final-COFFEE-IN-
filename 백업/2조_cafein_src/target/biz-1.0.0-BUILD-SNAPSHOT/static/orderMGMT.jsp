<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<form method="GET" role="form" name="myform" id="myform">
		<!-- <input type="hidden" name="page" value="">
		<input type="hidden" name="S" value="1">
		<input type="hidden" name="ostatus" value=""> 페이징 사용할떄 주석풀자-->

		<table class="table table-hover">
			<colgroup>
				<col style="width: 10%;">
				<col style="width: 30%;">
				<col style="width: 10%;">
				<col style="width: 30%;">
				<col style="width: 10%;">
			</colgroup>
			<tbody class="a">
				<tr>
					<!--  첫번째 줄  기간,상품명-->
					<th style="vertical-align: middle;">기간</th>
					<td>
						<input class="form-control input-sm" type="text" name="date1" style="width: 250px; float: left;"id="date1" value="" data-date="2018-12-04" data-date-format="yyyy-mm-dd"> 
				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;~ 
						<input class="form-control input-sm" type="text" name="date2" style="width: 250px; float: right;" id="date2" value="" data-date="2018-12-11" data-date-format="yyyy-mm-dd"></td>
					<th></th>
					<td  >
						<button type="button" id="today" class="btn btn-default btn-sm" style="margin-left: 90px">오늘</button>
						<button type="button" id="week" class="btn btn-default btn-sm">일주일</button>
						<button type="button" id="month" class="btn btn-default btn-sm">한달</button>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">상품명</th>
					<td style="vertical-align: middle;" >
					<input
						class="form-control input-sm" type="text" name="productname"
						style="width: 250px" id="productname"></td>


					<th style="vertical-align: middle;">결제방식</th>
					<td style="vertical-align: middle;" ><select
						class="form-control input-sm" name="pay" id="pay"
						style="width: 250px;">
							<option value="0">-- 선택 --</option>
							<option value="1">신용카드</option>
							<option value="2">무통장입금</option>
							<option value="3">휴대폰소액결제</option>
							<option value="4">카아오페이</option>
					</select></td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">정렬</th>
					<td style="vertical-align: middle;" ><select
						class="form-control input-sm" name="sort" id="sort"
						style="width: 250px;">
							<option value="0">-- 선택 --</option>
							<option value="1">주문일</option>
							<option value="2">주문번호</option>
							<option value="3">가격</option>
					</select></td>

					<th style="vertical-align: middle;">주문상태</th>
					<td style="vertical-align: middle;"><select
						class="form-control input-sm" name="status" id="status"
						style="width: 250px;">
							<option value="0">-- 선택 --</option>
							<option value="1">주문확인</option>
							<option value="2">배송준비</option>
							<option value="3">배송중</option>
							<option value="4">배송완료</option>
							<option value="5">취소완료</option>
					</select></td>
				</tr>
			</tbody>
		</table>
		<div style="float: right;margin-right: 350px">
			<button id="btnSearch" type="button" class="btn btn-default btn-sm">
				검 색</button>
			<button id="btnSearchAll" type="button"
				class="btn btn-default btn-sm">전 체 검 색</button>
			</td>
		</div>
		<br>
		<br>
		<br>
		<hr>
		<br>
		<br>
		<br>
	</form>
	<form method="post" role="form" class="form-horizontal"
		name="regi_form" id="regi_form">

		<div style="text-align: right; margin-bottom: 8px; padding-left: 0px;">
			<span style="font-size: 1.3em; padding-left: 0px;">총 주문건수 : <strong
				class="text-danger"><span id="length"></span></strong>개
				<button class="btn btn-default btn-sm" type="button" id="ChkSms"
					style="margin-left: 20px; cursor: pointer;">선택 SMS발송</button>
				<button class="btn btn-default btn-sm" type="button"
					onclick="CheckGroup(2);return false;">선택주문취소</button>
				<button class="btn btn-default btn-sm" type="button"
					onclick="xlsdown();return false;">엑셀저장</button> <!--button class="btn btn-primary btn-sm" type="button" onclick="sendCashReceipt();return false;">선택 현금영수증 발행</button-->


				<select class="form-control input-sm" name="status_update"
				id="status_update"
				style="margin-left: 30px; width: 190px; display: inline-block;">
					<option value="">-- 주문상태 선택변경 --</option>
					<option value="0">미결제</option>
					<option value="1">미입금</option>
					<option value="2">신규주문</option>
					<option value="3">배송준비</option>
					<option value="4">배송중</option>
					<option value="5">배송완료</option>
					<option value="6">배송예약</option>
					<option value="7">취소접수</option>
					<option value="8">취소완료</option>
					<option value="9">반품중</option>
					<option value="10">반품완료</option>
					<option value="11">교환중</option>
					<option value="12">교환완료</option>
			</select>
				<button class="btn btn-default btn-sm" type="button"
					onclick="CheckGroup(4);return false;">선택변경하기</button>

			</span>
		</div>
		<table class="table table-striped">
			<colgroup>
				<col style="width: 5%;">
				<col style="width: 10%">
				<col style="width: 10%">
				<col style="width: 10%">
				<col style="width: 5%">
				<col style="width: 90px">
				<col style="width:">
				<col style="width:">
				<col style="width: 90px;">
				<col style="width: 90px;">
				<col style="width:">
				<col style="width: 90px">

			</colgroup>
			<thead class="a">
				<tr>
					<!-- 출력 table header -->
					<th style=" text-align: center;">#</th>
					<th style="text-align: center;">주문번호</th>
					<th style="text-align: center;">주문일</th>
					<th style="text-align: center;">상품정보</th>
					<th style="text-align: center;">수량</th>
					<th style="text-align: center;">결제금액</th>
					<th style="text-align: center;">결제방법</th>
					<th style="text-align: center;">주문인</th>
					<th style="text-align: center;">주문자전화</th>
					<th style="text-align: center;">수령인</th>
					<th style="text-align: center;">수령인전화</th>
					<th style="text-align: center;">주문상태</th>

				</tr>
			</thead>
			<tbody id="result">
			</tbody>
		</table>
	</form>