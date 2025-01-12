<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
.salarySend-wrap{
	width: calc(100vw - 55px);
	min-width : 100%;
	height: calc(100vh - 50px);
	padding : 50px;
	overflow: auto;
}

.salary-table {
	min-width: 100%;
	width: 100%;
	border-spacing: 0;
}

.salary-table th, .salary-table td {
	text-align: center;
	border-bottom: 1px solid black;
	padding: 10px 20px;
	min-width: 130px;
}

.salary-table th {
	background-color: #f4fedc;
}

.salary-table tbody>tr:hover {
	cursor: pointer;
	background-color: rgba(0, 76, 161, 0.1);
}

.send-btn {
	width: 40px;
	height: 25px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
}

.send-btn:hover {
	background: #75befe;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

</style>
</head>
<body>
	<div class="salarySend-wrap">
		<table class="salary-table">
			<tr>
				<th>부서</th>
				<th>팀</th>
				<th>이름</th>
				<th>직급</th>
				<th>급여</th>
				<th>전화번호</th>
				<th>전송</th>
			</tr>
			<c:forEach var="emp" items="${empList}">
				<tr>
					<td>${emp.deptName}</td>
					<td>${emp.teamName}</td>
					<td id="empName">${emp.empName}</td>
					<td>${emp.rankName}</td>
					<td id="empSalary"><fmt:formatNumber value="${emp.salary / 12}" pattern="#"/>원</td>
					<td id="empPhone">${emp.empPhone}</td>
					<td>
						<button class="send-btn" onclick="sendSalary(this)">전송</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<script>
	function sendSalary(obj){
		const empPhone = $(obj).parents('tr').find('#empPhone').html();
		const salary = $(obj).parents('tr').find('#empSalary').html();
		const empName = $(obj).parents('tr').find('#empName').html();
		
		$.ajax({
			url : "emp/sendSalry.do",
			type : "post",
			data : {"empName" : empName,
					"salary" : salary,
					"empPhone" : empPhone},
			success : function(res){
				if(res == "1"){
					msg('완료','월급 전송이 완료되었습니다', 'success');
				}else{
					msg('오류', '월급 전송중 오류가 발생하였습니다.' , 'error');
				}
			},
			error : function(){
				console.log("ajax 오류");	
			}
			
		});
		
		
	}
	</script>
</body>
</html>