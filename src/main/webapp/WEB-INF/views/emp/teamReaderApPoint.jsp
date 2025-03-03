<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.leader-wrap {
	width: 100%;
	height: calc(100vh - 50px);
	padding: 50px;
}

.leader-tbl {
/* 	min-width: 100%; */
	width: 100%;
	border-spacing: 0;
}

.leader-tbl th, .leader-tbl td {
	text-align: center;
	border-bottom: 1px solid black;
	padding: 10px 20px;
	min-width: 130px;
}

.leader-tbl th {
	background-color: #f4fedc;
}

.leader-tbl.leader-tbl-hover tbody>tr:hover {
	cursor: pointer;
	background-color: rgba(0, 76, 161, 0.1);
}

.change-btn {
	width: 100px;
	height: 30px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
}

.change-btn:hover {
	background: #75befe;
	transform: scale(1.1);
	text-transform: scale(1.1);
}
</style>
</head>
<body>
	<div class="leader-wrap">
		<table class="leader-tbl">
			<tr>
				<th>팀</th>
				<th>사원</th>
				<th>변경</th>
			</tr>
			<c:forEach var="team" items="${teamList}">
				<tr>
					<td>${team.teamName}</td>
					<td><select id="${team.teamCode}">
							<c:forEach var="emp" items="${empList}">
								<c:if test="${team.teamCode eq emp.teamCode}">
									<option id="${emp.empCode}" value="${emp.empCode}">${emp.empName} ${emp.rankName}</option>
								</c:if>
							</c:forEach>
					</select></td>
					<td><button class="change-btn" onclick="changeLeader(this)">변경</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<script>
	$(document).ready(function(){
		<%-- 리더 정보가 담긴 json배열 --%>
		let list = ${leaderList};
		for(let i in list){
			$('#'+list[i].empCode).attr('selected',true);
		}
	});
	
	function changeLeader(obj){
		let empCode = $(obj).parent().parent().find('select').val();
		let teamCode = $(obj).parent().parent().find('select').attr('id');
		
		$.ajax({
			url : "/emp/changeTeamLeader.do",
			type : "post",
			data : {"teamCode" : teamCode,
					"empCode" : empCode},
			success : function(res){
				if(res == "1"){
					swal({
						title : "완료",
						text : "팀장 변경이 완료되었습니다.",
						icon : "success"
					}).then(function(){
						pageMove("/emp/teamLeaderApPoint.do");	
					});
				}else{
					swal({
						title : "오류",
						text : "팀장 변경중 오류가 발생하였습니다.",
						icon : "success"
					}).then(function(){
						pageMove("/emp/teamLeaderApPoint.do");	
					});
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