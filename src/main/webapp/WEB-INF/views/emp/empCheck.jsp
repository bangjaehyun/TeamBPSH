<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	box-sizing: border-box;
}

.empCheck-wrap {
	width: calc(100vw - 55px);
	min-width : 100%;
	height: calc(100vh - 50px);
	padding : 50px;
	overflow: auto;
}

.empCheck-wrap>div{
	min-width: 1000px;
}

.weekend {
	background: red;
	color: white;
}
.empCheck-table{
	min-width: 100%;
	width: 100%;
	border: 1px solid black;
	border-spacing: 0;
}
.empCheck-table th, .empCheck-table td{
	text-align: center;
	border: 1px solid black;
	padding: 5px;
	min-width: 70px;
}
.empCheck-table th{
	font-size: 13px;
}
.empCheck-table td{
	font-size: 10px;
}

.gray-color{
 	background: #d6d6d6;
}

.empCheck-title{
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
	<div class="empCheck-wrap">
		<div>
			<button onclick="moveMonth('left')" class="material-icons">chevron_left</button>
			<span class="empCheck-title">${date.getYear()}년 ${date.getMonthValue()}월 출 퇴근 관리</span>
			<button onclick="moveMonth('right')" class="material-icons">chevron_right</button>
		</div>
		<div>
			<button class="excelOutput-btn" onclick="exportExcel()" >엑셀 출력</button>
		</div>
		<table id="checkTable" class="empCheck-table">
			<tr>
				<th rowspan="2">이름</th>
				<c:forEach var="i" begin="1" end="${date.lengthOfMonth()}">
					<c:choose>
						<c:when
							test="${date.withDayOfMonth(i).getDayOfWeek().getValue() eq 6 || date.withDayOfMonth(i).getDayOfWeek().getValue() eq 7}">
							<th class="weekend" colspan="3">${i}</th>
						</c:when>
						<c:otherwise>
							<th class="gray-color" colspan="3">${i}</th>
						</c:otherwise>

					</c:choose>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="i" begin="1" end="${date.lengthOfMonth()}">
					<td class="gray-color">출근</td>
					<td class="gray-color">퇴근</td>
					<td class="gray-color">비고</td>
				</c:forEach>
			</tr>
			<c:forEach var="emp" items="${empList}">
				<tr>
					<td>${emp.empName}</td>
					<c:forEach var="i" begin="1" end="${date.lengthOfMonth()}">
						<c:set var="found" value="false" />
						<c:forEach var="check" items="${emp.checkList}">
							<c:choose>
								<c:when test="${fn:substring(check.day,6,8) eq (i < 10 ? '0' : '') + i}">
									<td class="checkTime">${check.checkIn}</td>
									<td class="checkTime">${check.checkOut}</td>
									<td>${check.checkNote}</td>
									<c:set var="found" value="true" />
								</c:when>
							</c:choose>
						</c:forEach>
						<c:if test="${!found}">
							<td></td>
							<td></td>
							<td></td>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>

		</table>
	</div>
	<script>
	$(document).ready(function(){
		for (const element of document.getElementsByClassName("checkTime")){
			  if($(element).html().length > 0){
				  let date =  $(element).html();
				  
				  let hour = date.substring(0,2);
				  let min = date.substring(2,4);
				  let sec = date.substring(4,6);
				  $(element).html(hour + ":" + min + ":" + sec);
			  }
			}
	});
	
	function exportExcel(){ 
		const year = '${date.getYear()}';
		const month = '${date.getMonthValue()}';
		
		let form = $('<form>');
		form.attr('method','get');
		form.attr('action', '/emp/empCheckExport.do');
		
		let yearEl = $('<input>');
		yearEl.attr('type', 'hidden');
		yearEl.attr('name', 'year');
		yearEl.attr('value', year);
		
		let monthEl = $('<input>');
		monthEl.attr('type', 'hidden');
		monthEl.attr('name', 'month');
		monthEl.attr('value', month);
		
		
		form.append(yearEl);
		form.append(monthEl);
		$('body').append(form);
		form.submit();
	}
	
	function moveMonth(icon){
		let month = icon == 'left' ? ${date.getMonthValue()} - 1 : ${date.getMonthValue()} + 1;
		let year = ${date.getYear()};
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
     	pageMoveParam("/emp/empCheck.do", data);
	}
	
	 function pad(d) {
	    	return (Number(d) < 10) ? '0' + d.toString() : d.toString();
	  }
	</script>
</body>
</html>