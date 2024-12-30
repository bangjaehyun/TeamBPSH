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
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

/*테이블*/
.page-wrap {
	width: calc(100vw - 55px);
	height: calc(100vh - 50px);
	overflow: scroll;
	overflow-y: hidden
}

.tbl {
	min-width: 100%;
	width: 100%;
	border-spacing: 0;
}

.tbl th, .tbl td {
	text-align: center;
	border-bottom: 1px solid black;
	padding: 10px 20px;
	min-width: 130px;
}

.salary-div {
	min-width: 165px;
}

.salary-div>input{
	width: 100px;
}

.vacation-div {
	min-width: 50px;
}

.vacation-div>input{
	width: 50px;
}

.tbl th {
	background-color: #f4fedc;
}

.tbl.tbl-hover tbody>tr:hover {
	cursor: pointer;
	background-color: rgba(0, 76, 161, 0.1);
}

.page-wrap {
	padding: 50px;
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
	<div class="page-wrap">
		<table class="tbl hover">
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>부서</th>
				<th>팀</th>
				<th>직급</th>
				<th>급여</th>
				<th>총 휴가</th>
				<th>사용 휴가</th>
				<th>변경</th>
			</tr>
			<c:forEach var="emp" items="${empList}">
				<tr>
					<td id="empCode">${emp.empCode}</td>
					<td>${emp.empName}</td>
					<td><select id="deptCode" onchange="changeTeam(this)">
							<c:forEach var="dept" items="${deptList}">
								<option value="${dept.deptCode}"
									<c:if test="${dept.deptCode == emp.deptCode}">selected</c:if>>
									${dept.deptName}</option>
							</c:forEach>
					</select></td>
					<td><select id="teamCode">
							<c:forEach var="team" items="${teamList}">
								<c:if test="${team.deptCode == emp.deptCode}">
									<option value="${team.teamCode}"
									<c:if test="${team.teamCode == emp.teamCode}">selected</c:if>>
									${team.teamName}</option>
								</c:if>
							</c:forEach>
					</select></td>
					<td><select id="rankCode">
							<c:forEach var="rank" items="${rankList}">
								<option value="${rank.rankCode}"
								<c:if test="${rank.rankCode == emp.rankCode}">selected</c:if>>
								${rank.rankName}</option>
							</c:forEach>
					</select></td>
					<td>
						<div class="salary-div">
							<input type="number" name="salary" placeholder="급여"
								value="${emp.salary}" autocomplete="off"> <span>원</span>
						</div>
					</td>
					<td>
						<div class="vacation-div">
							<input type="number" name="vacationTotal" placeholder="휴가 총 갯수"
								value="${emp.vacationTotal}" autocomplete="off"> <span>일</span>
						</div>
					</td>
					<td>
						<div class="vacation-div">
							<input type="number" name="vacationUse" placeholder="휴가 사용 횟수"
								value="${emp.vacationUse}" autocomplete="off"> <span>일</span>
						</div>
					</td>
					<td>
						<button class="change-btn" onclick="changeEmp(this)">변경</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<script>
		function changeTeam(obj) {
			$('#teamCode').children().remove();
			<c:forEach var="team" items="${teamList}">
			if ("${team.deptCode}" == $(obj).val()) {
				var option = $("<option></option>");
				$(option).html('${team.teamName}');
				$(option).val('${team.teamCode}');

				$('#teamCode').append(option);
			}
			</c:forEach>
		}
		
		 function changeEmp(obj){
	    	   let empCode = $(obj).parent().parent().find('#empCode').html();
	    	   let deptCode = $(obj).parent().parent().find('#deptCode').val();
	    	   let teamCode = $(obj).parent().parent().find('#teamCode').val();
	    	   let rankCode = $(obj).parent().parent().find('#rankCode').val();
	    	   let salary = $(obj).parent().parent().find('input[name=salary]').val();
	    	   let vacationTotal = $(obj).parent().parent().find('input[name=vacationTotal]').val();
	    	   let vacationUse = $(obj).parent().parent().find('input[name=vacationUse]').val();
	    	   
				if(salary.length > 0 && vacationTotal.length > 0 && vacationUse.length > 0){    	   
		    	   $.ajax({
		    		  url : "/emp/changeEmp.do",
		    		  type : "post",
		    		  data : {"empCode" : empCode,
		    			  	  "teamCode" : teamCode,
		    			  	  "rankCode" : rankCode,
		    			  	  "deptCode" : deptCode,
		    			  	  "salary" : salary,
		    			  	  "vacationTotal" : vacationTotal,
		    			  	  "vacationUse" : vacationUse,
		    			  	  },
		    	   	  success : function(res){
		    	   		try{
		    	   			const errMsg = JSON.parse(res);
		    	   			callbackMsg(errMsg.title, errMsg.msg,errMsg.icon, errMsg.loc);
		    	   		}catch(e){
		    	   			$('.page').html(res);
		    	   			msg("확인", "변경이 완료되었습니다.", "success");
		    	   		}
		    	   	  },
		    	   	  error : function(){
		    	   		  console.log("ajax 오류");
		    	   	  }
		    	   });
				}else{
					msg("확인", "입력 정보를 확인하여 주시기 바랍니다.","warning");
				}
	    	   
	       }
	</script>
</body>
</html>