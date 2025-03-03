<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<style>
* {
		margin : 0px;
		padding: 0px;
		box-sizing: border-box;
 }
	
	
	/*테이블*/
	.page-wrap{
	width: 100%;
	height: calc(100vh - 50px);
	}
.tbl {
  min-width : 100%;
  width: 100%;
  border-spacing: 0;
}

.tbl th,
.tbl td {
  text-align: center;
  border-bottom: 1px solid black;
  padding: 10px 20px;
  min-width: 130px;
}

.salary-div{
	min-width: 185px;
}

.tbl th {
  background-color: #f4fedc;
}
.tbl.tbl-hover tbody > tr:hover {
  cursor: pointer;
  background-color: rgba(0, 76, 161, 0.1);
}
.page-wrap{
	padding : 50px;
}
.approval-btn{
	width: 100px;
	height: 30px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
}

.approval-btn:hover{
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
				<th>연봉</th>
				<th>승인</th>
			</tr>
			<c:forEach var="empWait" items="${empWaitList}">
				<tr>
					<td id="empCode">${empWait.empCode}</td>
					<td>${empWait.empName}</td>
					<td>
						<select id="deptCode" onchange="changeTeam(this)">
							<c:forEach var="dept" items="${deptList}">
								<option value="${dept.deptCode}">${dept.deptName}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<select id="teamCode">
							<c:forEach var="team" items="${teamList}">
								<c:if test="${team.deptCode == 'RI'}">
									<option value="${team.teamCode}">${team.teamName}</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
					<td>
						<select id="rankCode">
							<c:forEach var="rank" items="${rankList}">
								<option value="${rank.rankCode}">${rank.rankName}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<div class="salary-div">
							<input type="number" min="0" name="salary" placeholder="급여" autocomplete="off">
							<span>원</span>
						</div>
					</td>
					<td>
						<button class="approval-btn" onclick="approval(this)">승인</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	 <script>
	 	function changeTeam(obj){
	 		 $(obj).parents('tr').find('#teamCode').children().remove();
	 		<c:forEach var="team" items="${teamList}">
			if("${team.deptCode}" == $(obj).val()){
				var option = $("<option></option>");
				$(option).html('${team.teamName}');
				$(option).val('${team.teamCode}');
				
				 $(obj).parents('tr').find('#teamCode').append(option);
			}
		</c:forEach>
	 	}
       function approval(obj){
    	   let empCode = $(obj).parent().parent().find('#empCode').html();
    	   let deptCode = $(obj).parent().parent().find('#deptCode').val();
    	   let teamCode = $(obj).parent().parent().find('#teamCode').val();
    	   let rankCode = $(obj).parent().parent().find('#rankCode').val();
    	   let salary = $(obj).parent().parent().find('input[name=salary]').val();
    	   
			if(salary.length > 0){    	   
	    	   $.ajax({
	    		  url : "/emp/approval.do",
	    		  type : "post",
	    		  data : {"empCode" : empCode,
	    			  	  "teamCode" : teamCode,
	    			  	  "rankCode" : rankCode,
	    			  	  "deptCode" : deptCode,
	    			  	  "salary" : salary
	    			  	  },
	    	   	  success : function(res){
	    	   		try{
	    	   			const errMsg = JSON.parse(res);
	    	   			callbackMsg(errMsg.title, errMsg.msg,errMsg.icon, errMsg.loc);
	    	   		}catch(e){
	    	   			$('.page').html(res);
	    	   			msg("확인", "승인이 완료되었습니다.", "success");
	    	   		}
	    	   	  },
	    	   	  error : function(){
	    	   		  console.log("ajax 오류");
	    	   	  }
	    	   });
			}else{
				msg("확인", "금액을 입력하여 주시기 바랍니다.","warning");
			}
    	   
       }
    </script>
</body>
</html>