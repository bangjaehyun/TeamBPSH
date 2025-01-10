<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.name-div{
	height: 50px;
}

.name-div>span{
	font-size: 25px;
	font-weight: bold;
}

.salary-tbl {
  min-width : 100%;
  width: 100%;
  border-spacing: 0;
}

.salary-tbl th,
.salary-tbl td {
  text-align: center;
  border-bottom: 1px solid black;
  padding: 10px 20px;
  min-width: 130px;
}

.salary-tbl th {
  background-color: #f4fedc;
}
.salary-tbl.salary-tbl-hover tbody > tr:hover {
  cursor: pointer;
  background-color: rgba(0, 76, 161, 0.1);
}

</style>
</head>
<body>
	<div>
		<div class="name-div">
			<span>${salaryList[0].empName} ${salaryList[0].rankName}</span>
		</div>
		<div>
			<table class="salary-tbl">
				<tr>
					<th>날짜</th>
					<th>금액</th>
					<th>내용</th>
				</tr>
				<c:forEach var="salary" items="${salaryList}">
					<tr>
						<td>${salary.day}</td>
						<td>${salary.salary}원</td>
						<td>${salary.salaryType}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
<script>
<%-- 사이즈 변경 못하게 고정 --%>
$(window).resize(function () {
    window.resizeTo(800, 750);
});

</script>
</body>
</html>