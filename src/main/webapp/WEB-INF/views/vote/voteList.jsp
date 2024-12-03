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
.vote-wrap{
	width: 100%;
	height: calc(100vh - 50px);
	overflow: auto;
	overflow-x: hidden;
	padding: 40px;
}

.voteTbl {
  min-width : 1000px;
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
.voteTbl tbody > tr:hover {
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

.vote-tr>td>a{
	text-decoration: none;
	color : black;
}

.vote-tr>td:nth-child(3){
	max-width : 200px;
 	overflow: hidden;
    text-overflow: ellipsis;
}
.seeMore{
	width: 100%;
	
}

.seeMore>button{
	width: 100%;
	font-size : 15px;
	color: white;
	background: #9fd1fe;
	border: none;
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
				<tr class="vote-tr" onclick="voteDetail('${vote.voteNo}')">
					<td>${vote.empName}</td>
					<td>${vote.voteTitle}</td>
					<td>${vote.voteContent}</td>
					<td>${vote.voteStart}</td>
					<td>${vote.voteEnd}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="seeMore">
			<button onclick="seeMore()">더보기</button>
		</div>
	</div>
	
	<script>
	var voteTotalCount = ${voteTotalCount != null ? voteTotalCount : 0};
	var startCount = 16;
	$(document).ready(function(){
		
		if(voteTotalCount < startCount){
			$('.seeMore').css('display','none');
		}
		
	});
	
	
	function voteCreate(){
		pageMove('/vote/createVote.do');
	}
	function voteDetail(voteNo){
		const data = {"voteNo" : voteNo,
					  "empCode" : '${loginEmp.empCode}'};
		
		pageMoveParam('/vote/voteDetail.do', data);
	}
	
	function seeMore(){
		$.ajax({
			url : "/vote/addVoteList.do",
			type : "post",
			data : {"startCount" : startCount,
				    "endCount" : startCount + 14},
			success : function(res){
				addVoteList(res);
				startCount += 15;
				
				if(voteTotalCount < startCount){
					$('.seeMore').css('display','none');
				}
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
	}
	
	function addVoteList(voteList){
		for(let i in voteList){
			let vote = voteList[i];
			
			let trEl = $('<tr>');
			let nameEl = $('<td>');
			let titleEl = $('<td>');
			let contentEl = $('<td>');
			let startEl = $('<td>');
			let endEl = $('<td>');
			let aEl = $('<a>');
			
			
			aEl.attr('href', 'javascript:void(0)');
			aEl.attr('onclick', 'voteDetail("' + vote.voteNo + '")');
			aEl.html(vote.voteTitle);
			nameEl.html(vote.empName);
			contentEl.html(vote.voteContent);
			startEl.html(vote.voteStart);
			endEl.html(vote.voteEnd);
			titleEl.append(aEl);
			
			trEl.attr('class','vote-tr');
			trEl.append(nameEl);
			trEl.append(titleEl);
			trEl.append(contentEl);
			trEl.append(startEl);
			trEl.append(endEl);
			
			$('.voteTbl').append(trEl);
		}
	}
	</script>
</body>
</html>