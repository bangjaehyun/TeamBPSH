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
		margin : 0px;
		padding: 0px;
		box-sizing: border-box;
 }
.develop-wrap{
	width: 100%;
	height: calc(100vh - 50px);
	overflow: scroll;
	overflow-x: hidden;
	padding: 40px;
}
.change-btn{
	width: 100px;
	height: 30px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
}

.change-btn:hover{
	background: #75befe;	
	transform: scale(1.1);
	text-transform: scale(1.1);
}
.develop-title{
	font-size: 30px;
	font-weight: bold;
	min-width: 230px;
}

.team-title{
	font-size: 20px;
	margin: 10px;
	min-width: 230px;
}

.table-wrap{
	width: 80%;
	margin: 0 auto;
}

.table{
	width: 100%;
	height: 100%;
	border-spacing: 0;
	margin-bottom: 100px;
}

.table th {
  background-color: #f4fedc;
}

.table th,
.table td {
  text-align: center;
  border-bottom: 1px solid black;
  padding: 10px 20px;
  min-width: 230px;
}

</style>
</head>
<body>
	<div class="develop-wrap">
		<c:forEach var="dept" items="${deptList}">
			<c:if test="${dept.deptCode eq 'RI' or dept.deptCode eq 'DD'}">
				<div class="table-wrap">
				<div class="develop-title">${dept.deptName}</div>
					<c:forEach var="team" items="${teamList}">
						<c:if test="${dept.deptCode eq team.deptCode}">
							<div class="team-title">${team.teamName}</div>
							<table class="table">
							<tr>
								<th>직급</th>
								<th>가격</th>
								<th>변경</th>
							</tr>
							<c:forEach var="rank" items="${rankList}">
								<tr>
									<td>${rank.rankName}</td>
									<td>
									<input type="number" min="0" id="${team.teamCode}${rank.rankCode}" name="price" value="0">
									<span>원</span>
									</td>
									<td><button class="change-btn" onclick="changePrice(this)">변경</button></td>
								</tr>
							</c:forEach>
							</table>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
		</c:forEach>

	</div>

	<script>
		$(document).ready(function(){
			// JSON 형태로 처리
			let developPrice = ${developPrice};
			for(let i in developPrice){
				let priceId = developPrice[i].teamCode + developPrice[i].rankCode;
				$("#"+priceId).val(developPrice[i].price);
			}
		});
		
		function changePrice(obj){
			let price = $(obj).parent().parent().find('input[name="price"]').val();
			let inputId = $(obj).parent().parent().find('input[name="price"]').attr('id');
			let teamCode = inputId.substring(0,2);
			let rankCode = inputId.substring(2,4);
			
			$.ajax({
				url : "/emp/changePrice.do",
				type : "post",
				data : {"teamCode" : teamCode,
						"rankCode" : rankCode,
						"price" : price},
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
		}
	</script>
</body>
</html>