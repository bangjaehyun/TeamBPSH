<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	*{
		box-sizing: border-box;
	}
	.my-page{
		width: calc(100vw - 55px);
		height: calc(100vh - 50px);
		display: flex;
		justify-content: center;
	}
	
	.my-wrap{
		margin : auto 0;
		width: calc(100vw - 200px);
		height: calc(100vh - 100px);
	}
	
	.my-name{
		display : flex;
		justify-content : center;
		align-items : center;
		font-size: 25px;
		font-weight: bold;
		height: 50px;
		width : 70%;
		min-width: 800px;
		margin : 0 auto;
	}
	
	.my-info{
		margin : 0 auto;
		border: 1px solid black;
		border-radius : 20px;
		width : 70%;
		min-width: 800px;
		height : 90%;
		min-height: 720px;
	}
	
	.emp-div{
		display : flex;
		height: 50px;
		align-items: center;
		padding-left : 50px; 
	}
	
	.emp-div>span {
		font-size: 20px;
		font-weight: bold;
	}
	
	.emp-div>input {
		margin-left : 10px;
		font-size: 20px;
	}
	
</style>
</head>
<body>
	<div class="my-page">
		<div class="my-wrap">
			<div class="my-name">${loginEmp.empName} 정보 수정</div>
			<div class="my-info">
				<form action="/emp/updateEmp" method="post">
					<div class="emp-div">
						<span>이름 : </span>
						<input type="text" value=${loginEmp.empName}>
					</div>
					<div class="emp-div">
						<span>부서 : </span>
						<c:forEach var="dept" items="${deptList}">
						<c:if test="${dept.deptCode == loginEmp.deptCode}">
								<input value="${dept.deptName}" disabled>
						</c:if>
						</c:forEach>
					</div>
					<div class="emp-div">
						<span>팀 : </span>
						<c:forEach var="team" items="${teamList}">
						<c:if test="${team.teamCode == loginEmp.teamCode}">
								<input value="${team.teamName}" disabled>
						</c:if>
						</c:forEach>
					</div>
					<div class="emp-div">
						<span>직급 : </span>
						<c:forEach var="rank" items="${rankList}">
						<c:if test="${rank.rankCode == loginEmp.rankCode}">
								<input value="${rank.rankName}" disabled>
						</c:if>
						</c:forEach>
					</div>
					<div class="emp-div">
						<span>아이디 : </span>
						<input value="${loginEmp.empId}" disabled>
					</div>
					
					<div class="emp-div">
						<span>전화번호 : </span>
						<input value="${loginEmp.empPhone}">
					</div>
					<div>
						<button type="button" onclick="update()">수정</button>
					</div>
					<div>
						<button type="button" onclick="onWork('${loginEmp.empCode}')">출근</button>
						<button type="button" onclick="offWork()">퇴근</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
	function onWork(empCode){
		console.log(empCode);
		$.ajax({
			url : "/emp/onWork.do",
			type : "post",
			data : {"empCode" : empCode},
			success : function(res){
				if(res == "1"){
					msg("완료","출근이 완료되었습니다.", "success");
				}else if(res == "-1"){
					msg("확인","이미 출근을 완료하였습니다.", "warning");
				}else{
					msg("오류","관리자에게 문의 바랍니다.", "error");
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