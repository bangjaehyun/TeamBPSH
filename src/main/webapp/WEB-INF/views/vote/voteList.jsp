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
		margin : 0px;
		padding: 0px;
		box-sizing: border-box;
 }
.vote-wrap{
	width: calc(100vw - 55px);
	height: calc(100vh - 50px);
	overflow: auto;
	overflow-x: hidden;
	padding: 40px;
}

.voteTbl {
  min-width : 100%;
  width: 100%;
  border-spacing: 0;
}

.voteTbl th,
.voteTbl td {
  text-align: center;
  border-bottom: 1px solid black;
  padding: 10px 20px;
  min-width: 150px;
}

.voteTbl th {
  background-color: #f4fedc;
}
.voteTbl.voteTbl-hover tbody > tr:hover {
  cursor: pointer;
  background-color: rgba(0, 76, 161, 0.1);
}

.vote-btn{
	width: 100px;
	height: 40px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
	margin-bottom: 10px;
}
.btn-wrap{
	display: flex;
	justify-content: flex-end;
}
.vote-btn:hover{
	background: #75befe;	
	transform: scale(1.1);
	text-transform: scale(1.1);
}
</style>
</head>
<body>
	<div class="vote-wrap">
		<div class="btn-wrap">
			<button class="vote-btn" onclick="voteCreate()">작성하기</button>
		</div>
		<table class="voteTbl">
			<tr>
				<th>작성자</th>
				<th>제목</th>
				<th>내용</th>
				<th>시작일</th>
				<th>마감일</th>
			</tr>
			<c:forEach var="vote" items="${voteList}">
				<tr>
					<td>${vote.empName}</td>
					<td><a href="javascript:void(0)" onclick="voteDetail('${vote.voteNo}')">${vote.voteTitle}</a></td>
					<td>${vote.voteContent}</td>
					<td>${vote.voteStart}</td>
					<td>${vote.voteEnd}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<script>
	function voteCreate(){
		pageMove('/vote/createVote.do');
	}
	function voteDetail(voteNo){
		const data = {"voteNo" : voteNo,
					  "empCode" : '${loginEmp.empCode}'};
		
		pageMoveParam('/vote/voteDetail.do', data);
	}
	</script>
</body>
</html>