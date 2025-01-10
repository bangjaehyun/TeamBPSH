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
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.vote-wrap {
	width: 100%;
	height: calc(100vh - 50px);
	padding: 40px;
}

.add-btn{
	background: orange;
	font-size: 20px;
	font-weight: bold;
	color: white;
	border: none;
	width: 100px;
	height: 40px;
	border-radius: 5px;
}

.removeVote{
	border : none;
	color: red;
	background: white;
}

.vote{
	display: flex;
	align-items: center;
	margin: 10px;
}

.vote>input{
	height: 30px;
}

.create-btn{
	width: 100px;
	height: 40px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
}

.create-btn:hover{
	background: #75befe;	
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.voteList{
	margin : 20px 0;
	max-height: 300px;
	overflow: scroll;
}

.voteList::-webkit-scrollbar{
		display: none;
	}
.vote-top{
	width: 1000px;
	text-align: center;
	margin: 0 auto;
}
.vote-top>span{
	font-size: 25px;
	font-weight: bold;
}
.vote-title{
	margin: 10px 0;
}
.vote-title>span{
	font-size : 20px;
	font-weight: bold;	
}

.vote-title>input{
	margin-left : 7px;
	width: 90%;
	height: 40px;
	font-size: 18px;
}

.vote-content>span{
	font-size : 20px;
	font-weight: bold;	
}
.vote-content>div{
	display : flex;
	justify-content: center;
}
.vote-content>div>textarea{
	resize: none;
	width: 900px;
	height: 180px;
	font-size: 15px;
}

.vote-val{
	width: 1000px;
	margin : 0 auto;
}

.btn-div{
	display : flex;
	justify-content : center;
	gap : 10px;
}

.voteList-box{
	height: 300px;
}


.vote-date>span{
	font-size : 20px;
	font-weight: bold;	
}
.vote-date{
	display: flex;
	align-items: center;
}
.vote-date>input{
	margin-left: 7px;
}
</style>
</head>
<body>
<div class="vote-wrap">
		<div class="vote-top">
			<span>투표 수정</span>
		</div>
		<form action="/vote/insertVote" method="post" class="vote-val">
			<input type="hidden" name="voteNo" value="${vote.voteNo}">
			<input type="hidden" name="empCode" value="${loginEmp.empCode}">
			<div class="vote-date">
				<span>마감 일자</span> 
				<input type="date" id="voteEnd" name="voteEnd" value="${vote.voteEnd}" max="9999-12-31">
			</div>
			<div class="vote-title">
				<span>제목</span> 
				<input type="text" name="voteTitle" value="${vote.voteTitle}" placeholder="제목">
			</div>
			<div class="vote-content">
				<span>내용</span>
				<div>
					<textarea id="voteContent" name="voteContent">${vote.voteContent}</textarea>
				</div>
			</div>
			<div class="voteList-box">
				<div id="voteList" class="voteList">
					<c:forEach var="item" items="${vote.voteList}">
						<div class="vote">
							<input type="text" name="voteVal" value="${item.voteName}" placeholder="항목 입력">
							<button type="button" class="removeVote material-icons" onclick="remove(this)">remove_circle</button>						
						</div>
					</c:forEach>
				</div>
			</div>
			<div>
				<button type="button" class="add-btn" onclick="addVote()">+</button>
			</div>
			<div class="btn-div">
				<button type="button"  class="create-btn" onclick="updateCancle()">취소</button>
				<button type="button"  class="create-btn" onclick="voteUpdate()">수정</button>
			</div>
		</form>
	</div>
	<script>
	function addVote(){
		let divEl = $('<div>');
		divEl.addClass('vote')
		let inputEl = $('<input>');
		inputEl.attr('type','text');
		inputEl.attr('name','voteVal');
		inputEl.attr('placeholder','항목 입력');
		let btnEl = $('<button>');
		btnEl.addClass('removeVote');
		btnEl.addClass('material-icons');
		btnEl.attr('onclick', 'remove(this)');
		btnEl.attr('type', 'button');
		btnEl.html('remove_circle');
		
		divEl.append(inputEl);
		divEl.append(btnEl);
		$('#voteList').append(divEl);
		
		$('.voteList').scrollTop($('.voteList')[0].scrollHeight);
	}
	
	function remove(obj){
		$(obj).parent().remove();
	}
	
	function voteUpdate(){
		if($('input[name="voteEnd"]').val() == ""){
			msg("확인","마감일을 선택하여 주시기 바랍니다.", "warning");
			return;
		}
		
		if($('input[name="voteTitle"]').val() == ""){
			msg("확인","제목을 입력해 주시기 바랍니다.", "warning");
			return;	
		}
		
		if($('#voteContent').val() == ""){
			msg("확인","내용을 입력해 주시기 바랍니다.", "warning");
			return;	
		}
		
		if($('.voteList').children().length < 1){
			msg("확인","항목을 최소 1개 입력 바랍니다.", "warning");
			return;		
		}
		
		let formData = $('.vote-val').serialize();
		$.ajax({
			url : "/vote/updateVote.do",
			type : "post",
			data : formData,
			success : function(res){
				if(res == "1"){
					swal({
						title : "완료",
						text : "업데이트가 완료 되었습니다.",
						icon : "success"
					}).then(function(){
						 const data = {"startCount" : 1,
			    			 	   "endCount" : 15}
			    	 pageMoveParam('/vote/list.do', data);
					});
				}else{
					swal({
						title : "오류",
						text : "업데이트중 오류가 발생하였습니다.",
						icon : "error"
					}).then(function(){
						 const data = {"startCount" : 1,
			    			 	   "endCount" : 15}
			    	 pageMoveParam('/vote/list.do', data);
					});
				}
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
	}
	
	function updateCancle(){
		const data = {"voteNo" : ${vote.voteNo},
				  "empCode" : '${loginEmp.empCode}'};
	
		pageMoveParam('/vote/voteDetail.do', data);
	}
	
	</script>
</body>
</html>