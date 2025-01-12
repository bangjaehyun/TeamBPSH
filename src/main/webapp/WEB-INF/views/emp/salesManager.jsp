<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	box-sizing: border-box;
}

.manager-wrap {
	width: 100%;
	height: 100%;
 	min-height: calc(100vh - 50px);  
	padding : 50px;
}

.manager-wrap>div{
	min-width: 1000px;
}

.manager-menu {
	width : 100%;
	height : 50px;
	list-style: none;
	display: flex;
}

.manager-menu>div {
	width: 100%;
	height: 50px;
	background: #e5e5e5;
	border: 1px solid black;
	text-align: center;
}

.manager-menu>div>a {
	display: block;
	text-decoration: none;
	width: 100%;
	height: 50px;
	line-height: 50px;
	font-size: 20px;
	font-weight: bold;
	color: white;
}
.manager-content{
	width: 100%;
	height: 100%;
	overflow: auto;
}

.manager-content table {
	min-width: 100%;
	width: 100%;
	border: 1px solid black;
	border-spacing: 0;
	margin-top: 5px; 
}

.manager-content table th, .manager-content table td {
	text-align: center;
	border: 1px solid black;
	padding: 5px;
}

.manager-content table th {
	background : #b2b2b2;
	font-size: 13px;
	color: white;
}

.manager-content table td {
	font-size: 10px;
}

.manager-content>div>table th:nth-child(1) {
	width: 20%;
}

.manager-content>div>table th:nth-child(2) {
	width: 30%;
}

.manager-content>div>table th:nth-child(3) {
	width: 50%;
}

.sales {
	display: block;
}

.spending {
 	display: none; 
}


.noMessage-div{
	width: 100%;
	height: 100%;
}

.manager-title {
	font-size: 30px;
	font-weight: bold;
}

.excelOutput-btn {
	width: 100px;
	height: 30px;
	border: none;
	background: #45da01;
	color: white;
	border-radius: 10px;
	margin: 20px 0;
}

.excelOutput-btn:hover {
	background: #3dc100;
	transform: scale(1.1);
	text-transform: scale(1.1);
}
</style>
</head>
<body>
	<div class="manager-wrap">
		<div>
			<span class="manager-title">매출 및 지출 관리</span>
		</div>
		<div>
			<button onclick="moveMonth('left')" class="material-icons">chevron_left</button>
			<span class="manager-title">${year}년</span><span
				class="manager-title">${month}월</span>
			<button onclick="moveMonth('right')" class="material-icons">chevron_right</button>
		</div>
		<div>
			<button class="excelOutput-btn" onclick="exportExcel()">엑셀 출력</button>
		</div>
		<div class="manager-menu">
			<div  id="salesMenu">
				<a href="javascript:void(0)" onclick="menuChange('sales')">매출</a>
			</div>
			<div id="spendingMenu">
				<a href="javascript:void(0)" onclick="menuChange('spending')">지출</a>
			</div>
		</div>
		<div class="manager-content">
			<c:choose>
				<c:when test="${salesSpendingList.salesList.size() ne 0}">
				<div class="sales">
					<table>
						<tr>
							<th>매출일</th>
							<th>금액</th>
							<th>내용</th>
						</tr>
						<c:forEach var="sales" items="${salesSpendingList.salesList}">
							<tr>
								<td>${sales.salesDay}</td>
								<td>${sales.salesCost} 원</td>
								<td>${sales.salesContent}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				</c:when>
				<c:otherwise>
					<div class="sales noMessage-div">
						<span>매출 내역이 존재하지 않습니다.</span>
					</div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${salesSpendingList.spendingList.size() ne 0}">
				<div class="spending">
					<table >
						<tr>
							<th>지출일</th>
							<th>금액</th>
							<th>내용</th>
						</tr>
						<c:forEach var="spending"
							items="${salesSpendingList.spendingList}">
							<tr>
								<td>${spending.spendingDay}</td>
								<td>${spending.spendingCost} 원</td>
								<td>${spending.spendingContent}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				</c:when>
				<c:otherwise>
					<div class="spending noMessage-div">
						<span>지출 내역이 존재하지 않습니다.</span>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
	</div>
	
	<script>
	$(document).ready(function(){
		$('#salesMenu').css('background','#b2b2b2');	
	});
	
	function exportExcel(){ 
		const year = '${year}';
		const month = '${month}';
		const salesManager = JSON.stringify(${salesSpendingListJson}); 
		
		let form = $('<form>');
		form.attr('method','get');
		form.attr('action', '/emp/salesManagerExport.do');
		
		let yearEl = $('<input>');
		yearEl.attr('type', 'hidden');
		yearEl.attr('name', 'year');
		yearEl.attr('value', year);
		
		let monthEl = $('<input>');
		monthEl.attr('type', 'hidden');
		monthEl.attr('name', 'month');
		monthEl.attr('value', month);
		
		let empListEl = $('<input>');
		empListEl.attr('type', 'hidden');
		empListEl.attr('name', 'salesManager');
		empListEl.attr('value', salesManager);
		
		
		form.append(yearEl);
		form.append(monthEl);
		form.append(empListEl);
		$('body').append(form);
		form.submit();
	}
	
	function menuChange(menuName){
		if(menuName == "sales"){
			$('.spending').css('display','none');
			$('.sales').css('display','block');
			
			$('#salesMenu').css('background','#b2b2b2');
			$('#spendingMenu').css('background','#e5e5e5');
			
			
		}else{
			$('.sales').css('display','none');
			$('.spending').css('display','block');
			
			$('#spendingMenu').css('background','#b2b2b2');
			$('#salesMenu').css('background','#e5e5e5');
		}
		
	}
	
	function moveMonth(icon){
		let month = icon == 'left' ? ${month} - 1 : ${month} + 1;
		let year = ${year};
		if(month < 1){
			month = 12;
			year = year -1;
		}else if(month > 12){
			month = 1;
			year = year + 1;
		}
		let yearMonth = year + pad(month);
		
		 let date = new Date();
         let newYearMonth = date.getFullYear() + pad(date.getMonth()+1);
         
         if(yearMonth > newYearMonth){
        	 msg("확인", "확인 가능한 날짜가 아닙니다.","warning");
        	 return;
         }

		
		data = {'yearMonth' : yearMonth};
		pageMoveParam("/emp/salesManager.do", data);
	}
	
	 function pad(d) {
	    	return (Number(d) < 10) ? '0' + d.toString() : d.toString();
	  }
	
	</script>
	
</body>
</html>