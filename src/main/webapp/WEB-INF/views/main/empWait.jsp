<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
		margin : 0px;
		padding: 0px;
		box-sizing: border-box;
	}
	h1{
		margin-left : 10px;
	}
	
	/*테이블*/
.tbl {
  width: 100%;
  border-spacing: 0;
}
.tbl th,
.tbl td {
  text-align: center;
  border-bottom: 1px solid black;
  padding: 10px 20px;
}
.tbl th {
  background-color: #e1fd85;
}
.tbl.tbl-hover tbody > tr:hover {
  cursor: pointer;
  background-color: rgba(0, 76, 161, 0.1);
}
.page-wrap{
	margin : 50px;
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
						<input type="text" name="salary" placeholder="급여">
						<span>원</span>
					</td>
					<td>
						<button onclick="approval(this)">승인</button>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	 <script>
	 	function changeTeam(obj){
	 		console.log($(obj).val());
	 		$('#teamCode').children().remove();
	 		
	 		<c:forEach var="team" items="${teamList}">
			if("${team.deptCode}" == $(obj).val()){
				var option = $("<option></option>");
				$(option).html('${team.teamName}');
				$(option).val('${team.teamCode}');
				
				$('#teamCode').append(option);
			}
		</c:forEach>
	 	}
       function approval(obj){
    	   let empCode = $(obj).parent().parent().find('#empCode').html();
    	   let deptCode = $(obj).parent().parent().find('#deptCode').val();
    	   let teamCode = $(obj).parent().parent().find('#teamCode').val();
    	   let rankCode = $(obj).parent().parent().find('#rankCode').val();
    	   let salary = $(obj).parent().parent().find('input[name=salary]').val();
    	   
    	   console.log(salary.length);
    	   
    	   $.ajax({
    		  url : "emp/approval.do",
    		  type : "post",
    		  data : {"empCode" : empCode,
    			  	  "teamCode" : teamCode,
    			  	  "rankCode" : rankCode,
    			  	  "deptCode" : deptCode,
    			  	  "salary" : salary
    			  	  },
    	   	  success : function(res){
    	   		  $('.page').html(res);
    	   	  },
    	   	  error : function(){
    	   		  console.log("ajax 오류");
    	   	  }
    	   });
    	   
       }
    </script>
</body>
</html>