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

.vote-wrap {
	width: calc(100vw - 55px);
	height: calc(100vh - 50px);
	padding: 40px;
}

.add-btn {
	background: orange;
	font-size: 20px;
	font-weight: bold;
	color: white;
	border: none;
	width: 100px;
	height: 40px;
	border-radius: 5px;
}

.removeVote {
	border: none;
	color: red;
	background: white;
}

.vote {
	display: flex;
	align-items: center;
	margin: 10px;
}

.vote>input {
	height: 30px;
}

.create-btn {
	width: 100px;
	height: 40px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
}

.create-btn:hover {
	background: #75befe;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.voteList {
	margin: 20px 0;
	max-height: 300px;
	overflow: auto;
}

.voteList>div{
	margin: 10px;
}

.voteList>div>span:nth-child(3){
	margin-left: 20px;
}

.vote-top {
	width: 1000px;
	text-align: center;
	margin: 0 auto;
}

.vote-top>span {
	font-size: 25px;
	font-weight: bold;
}

.vote-writer,
.vote-title {
	margin: 10px 0;
}



.vote-content>div {
	display: flex;
	justify-content: center;
}

.vote-content>div>textarea {
	resize: none;
	width: 900px;
	height: 180px;
	font-size: 15px;
}

.vote-val {
	width: 1000px;
	margin: 0 auto;
}

.btn-div {
	display: flex;
	justify-content: center;
}

.voteList-box {
	height: 300px;
}

.vote-title>span:nth-child(1),
.vote-content>span:nth-child(1),
.vote-date>span:nth-child(1),
.vote-writer>span:nth-child(1){
	font-size: 20px;
	font-weight: bold;
}

.vote-title>span:nth-child(2),
.vote-date>span:nth-child(2),
.vote-writer>span:nth-child(2){
	font-size: 18px;
	margin-left: 10px;
}

.vote-date,
.vote-writer {
	display: flex;
	align-items: center;
}

.vote-btn{
	width: 100px;
	height: 40px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
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
		<div class="vote-top">
			<span>투표 작성</span>
		</div>
		<form action="/vote/insertVote" method="post" class="vote-val">
			<div class="vote-date">
				<span>마감 일자</span> <span>${vote.voteEnd}</span>
			</div>
			<div class="vote-writer">
				<span>작성자</span> <span>${vote.empName}</span>
			</div>
			<div class="vote-title">
				<span>제목</span> <span>${vote.voteTitle}</span>
			</div>
			<div class="vote-content">
				<span>내용</span>
				<div>
					<textarea name="voteContent" disabled>${vote.voteContent}</textarea>
				</div>
			</div>
			<div class="voteList-box">
				<div id="voteList" class="voteList">
						<c:forEach var="voteList" items="${vote.voteList}">
							<div>
								<input type="radio" name="vote" value="${voteList.voteListNo}" <c:if test="${!empty vote.voteListNo}">disabled</c:if> <c:if test="${!empty vote.voteListNo and vote.voteListNo eq voteList.voteListNo}">checked</c:if> >
								<span>${voteList.voteName}</span>
								<span>${voteList.voteCount}명</span>
							</div>
						</c:forEach>
				</div>
			</div>
			<div class="btn-div">
				<c:if test="${empty vote.voteListNo}">
					<button type="button"  class="vote-btn" onclick="voting()">투표</button>
				</c:if>
			</div>
		</form>
	</div>
	<script>
	function voting(){
		let chkNo = $('input[name="vote"]:checked').val();
		let voteNo = '${vote.voteNo}';
		let empCode = '${loginEmp.empCode}';
		
		$.ajax({
			url : '/vote/doVoteEmp.do',
			type : 'post',
			data : {"empCode" : empCode,
				    "voteListNo" : chkNo,
				    "voteNo" : voteNo},
			success : function(res){
				if(res == "1"){
					swal({
						title : "완료",
						text : "투표가 완료되었습니다.",
						icon : "success"
					}).then(function(){
						const data = {"voteNo" : voteNo,
								  "empCode" : empCode};
						pageMoveParam('/vote/voteDetail.do', data);
					});
				}else{
					swal({
						title : "오류",
						text : "투표중 오류가 발생하였습니다.",
						icon : "error"
					}).then(function(){
						const data = {"voteNo" : voteNo,
								  "empCode" : empCode};
						pageMoveParam('/vote/voteDetail.do', data);
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