<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	*{
		padding : 0px;
		margin : 0px;
	}
	.chat-wrap{
		padding : 0px;
		margin : 0px;
		width: 100vw;
		height: 100vh;
		display: flex;
	}
	
	.side-left{
		width: 20%;
		height: 100%;
		background: #f4f4f4;
	}
	
	.chat-div{
		height: 85%;
		background: #cdeefd;
		overflow: scroll;
	}
	
	.chat-div::-webkit-scrollbar{
		display: none;
	}
	
	
	.message-div{
		display : flex;
		width : 100%;
		height: 15%;
	}
	.chat-main{
		width: 80%;
	}
	
	.message-box{
		width: 85%;
		height : 100%;
 		resize: none; 
		outline: none;
		border: none;
	}
	
	.message-box::-webkit-scrollbar{
		display: none;
	}
	
	.send{
		width: 15%;
	}
	
	.empName{
		text-decoration: none;
		font-size: 12px;
		color : blue;
	}
	
	.empName:hover{
		font-size: 13px;
	}
	.arrow{
		height: 14px;
	}
	
	.menu-div:hover{
		 cursor: pointer;
	}
	
	.sub-menu{
		display : none;
		cursor: pointer;
	}
	
	.arrow{
		margin-left : 3px; 
	}
	
	.menu-team{
		margin-left : 15px;
	}
	
	
	
	.menu-emp{
		margin-left : 40px;
	}
	
	ul{
		list-style: none;
	}
	
	.dept-li>div>span{
		font-size: 15px;
	}
	
	.menu-team>span{
		font-size: 12px;
	}
	
	.msg{
		background: white;
		border-radius : 5px;
		padding: 5px;
		font-size: 15px;
	}
	
	.msg-right{
		display : flex;
		justify-content : flex-end;
		padding: 5px;
		align-items: flex-end;
	}
	
	.msg-left{
		display : flex;
		justify-content : flex-start;
		padding: 5px;
		align-items: flex-end;
	}
	
	.name-right{
		display : flex;
		justify-content : flex-end;
		align-items: flex-end;
	}
	
	.name-right>span{
		font-size: 14px;
		margin-right: 5px;
	}
	
	.name-left>span{
		font-size: 14px;
		margin-left: 5px;
	}
	
	.name-left{
		display : flex;
		justify-content : flex-start;
		align-items: flex-end;
	}
	
	.msg-div{
		word-break:break-word;
		margin-bottom: 10px;
	}
	
	.time{
		font-size: 11px;
		margin: 0 3px;
		min-width: 50px;
	}
	
</style>
</head>
<body>
	<div class="chat-wrap">
		<div class="side-left">
			<ul>
				<c:forEach var="dept" items="${deptList}">
					<li class="dept-li">
						<div class="menu-div" onclick="menuClick(this)"><span>${dept.deptName}</span><img class="arrow" src="/resources/images/arrow.png"></div>
						<ul class="sub-menu" id="${dept.deptCode}"></ul>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="chat-main">
			<div class="chat-div"></div>
			<div class="message-div">
				<textarea id="message-box" class="message-box" ></textarea>
				<button class="send" onclick="fn.sendValidate()">버튼</button>
<!-- 				<input type="file" name="uploadFile"> <br> -->
			</div>
		</div>
	</div>
	
	<script>
	
	var ws;
	<%-- 사원 코드 --%>
	var empCode = '${loginEmp.empCode}';
	<%-- 사원 이름 --%>
	var empName = '${loginEmp.empName}';
	<%-- 채팅 그룹 --%>
	var groupNo;
	<%--채팅 할 사원--%>
	var toEmp;
	let fn = {
		init : function () {
			<%-- 소켓 연결 --%>
			ws = new WebSocket("ws://192.168.10.51/emp/doChat.do");
			
			<%-- 연결 시, 이벤트 핸들러 --%>
			ws.onopen = function(){
				var msg = {
					type     : "connect",
					empCode : empCode
				};
				
				ws.send(JSON.stringify(msg));
			};
			
			<%-- 메시지 수신 시, 이벤트 핸들러 --%>
			ws.onmessage = function(e){
				const chat = JSON.parse(e.data);
				
				addChat(chat);
				
				$('.chat-div').scrollTop($('.chat-div')[0].scrollHeight);
			};
			
			<%-- 소켓 연결 종료 이벤트 핸들러 --%>
			ws.onclose = function(){
				console.log("연결종료");
			};
		}	
		,sendValidate : function (enter) {
			//파일 서버 업로드 -> 메시지 전송
// 			let file = $('input[type=file]')[0].files;

// 			if(file.length > 0){
// 				file = file[0];
				
// 				const formData = new FormData();
// 				formData.append("file", file);
// 				formData.append("memberId", memberId);
				
// 				$.ajax({
// 		            url: "/chat/fileUpload.do",
// 		            type: "post",
// 		            data: formData,
// 		            processData: false,
// 		            contentType: false,
// 		            success: function(obj) {
// 		            	fn.sendChat(obj); //fileName, filePath
		            	
// 		            },
// 		            error: function() {
// 		                alert("파일 업로드 실패: " + error);
// 		            }
// 		        });
// 			}else {
				let obj = {};
				fn.sendChat(obj,enter);
// 			}
			
		}
		,sendChat : function (sendObj,enter) {
			str = $('.message-box').val();
			str = str.replace(/(?:\r\n|\r|\n)/g, "<br/>");
			
			if(enter != null){
				str = str.slice(0, -5);
			}
			
			console.log(str);
			sendObj.type = "chat";
			sendObj.groupNo = groupNo;
			sendObj.empCode= empCode;
			sendObj.empName = empName;
			sendObj.toEmp = toEmp;
			sendObj.msg = str;
			
			
			ws.send(JSON.stringify(sendObj));
			
			//기존 입력값 초기화
			$(".message-box").val(""); 
// 			$('input[type=file]').val("");
			
		}
		,chatFileDown : function(fileName, filePath){
			fileName = encodeURIComponent(fileName);
			filePath = encodeURIComponent(filePath);
			
			location.href = "/chat/fileDown.do?fileName="+fileName+"&filePath="+filePath;

		}
	};
	
	
	function menuClick(obj){
		if($(obj).next().css('display') == 'none'){
			$(obj).children('img').css('transform','rotate(90deg)');
			$(obj).next().css('display', 'block');
		}else{
			$(obj).children('img').css('transform','rotate(0deg)');
			$(obj).next().css('display', 'none');
		}
	}
	
	$(document).ready(function(){
		<c:forEach var="team" items="${teamList}">
			var liEl = $('<li></li>');
			var divEl = $('<div onclick="menuClick(this)"></div>')
			var imgEl = $('<img>')
			var spanEl = $('<span></span>')
			var ulEl = $('<ul></ul>')
			spanEl.html('${team.teamName}');
			imgEl.attr('class','arrow');
			imgEl.attr('src','/resources/images/arrow.png');
			ulEl.attr('id', '${team.teamCode}');
			ulEl.attr('class', 'sub-menu');
			divEl.attr('class','menu-team');
			
			divEl.append(spanEl);
			divEl.append(imgEl);
			liEl.append(divEl);
			liEl.append(ulEl);
			$('#${team.deptCode}').append(liEl);
		</c:forEach>
		
		
		
		$.ajax({
			url : '/emp/chatEmpList.do',
			type : "post",
			success : function(list){
				
				for(idx in list){
					let emp = list[idx];
					if(emp.empCode != ${loginEmp.empCode}){
						var liEmp = $("<li></li>");
						var item = $("<a class='empName' href='javascript:void(0)' onclick='choose(this)'></a>");
						item.html(emp.empName);
						item.attr('id',emp.empCode);
						liEmp.append(item);
						liEmp.attr('class','menu-emp');
						
						$('#'+ emp.teamCode).append(liEmp);
					}
				};
				
			},
			error : function(){
				console.log('ajax 오류');	
			}
		});
		<%-- 소켓 초기화 --%>
		fn.init();
	});
	
	<%-- 사원 선택시 채팅리트스 select --%>
	function choose(obj){
		toEmp =  $(obj).attr('id');
		<%-- 기존 채팅내용 제거 --%>
		$(".chat-div").children().remove();
		$.ajax({
			url : '/emp/chatList.do',
			type : 'post',
			data : {'fromEmpCode' : '${loginEmp.empCode}',
					'toEmpCode' : toEmp},
			success : function(res){
				for(let i = 0; i < res.chatList.length; i++){
					let chat = res.chatList[i];
					<%--채팅 정보--%>
					addChat(chat);
				}
				<%--스크롤 최 하단으로 이동--%>
				$('.chat-div').scrollTop($('.chat-div')[0].scrollHeight);
				groupNo = res.groupNo;
			},
			error : function(){
				console.log('ajaxError');
			}
					
		});
	}
	
	const months = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
	const day = ['일요일','월요일','화요일','수요일','목요일','금요일','토요일',]
 	<%-- 채팅 내용 동적 추가 --%>
	function addChat(chat){
		let date = getDay(chat.chatDate);
		if(chat.empCode == ${loginEmp.empCode}){
			let divEl = $('<div></div>');
			let namDiv = $('<div></div>');
			let name = $('<span></span>');
			let msgDiv = $('<div></div>');
			let msg = $('<span></span>');
			let time = $('<span></span>');
			name.html(chat.empName);
			namDiv.append(name);
			namDiv.attr('class', 'name-right');
			time.html(getTime(chat.chatDate));
			time.attr('class', 'time');
			msg.html(chat.chatMsg);
			msg.attr('class', 'msg');
			msgDiv.attr('class', 'msg-right');
			msgDiv.append(time);
			msgDiv.append(msg);
			divEl.append(namDiv);
			divEl.append(msgDiv);
			divEl.attr('class','msg-div');
			$(".chat-div").append(divEl);
		}else{
			let divEl = $('<div></div>');
			let namDiv = $('<div></div>');
			let name = $('<span></span>');
			let msgDiv = $('<div></div>');
			let msg = $('<span></span>');
			let time = $('<span></span>');
			name.html(chat.empName);
			namDiv.append(name);
			namDiv.attr('class', 'name-left');
			msg.html(chat.chatMsg);
			msg.attr('class', 'msg');
			time.html(getTime(chat.chatDate));
			time.attr('class', 'time');
			msgDiv.attr('class', 'msg-left');
			msgDiv.append(msg);
			msgDiv.append(time);
			divEl.append(namDiv);
			divEl.append(msgDiv);
			divEl.attr('class','msg-div');
			$(".chat-div").append(divEl);
		}
	}
	
	$('.message-box').keyup(function(e){
		 if (e.keyCode == 13 && !e.shiftKey){
	        fn.sendValidate(false);
		 }
	});
	
	$(window).resize(function () {
	    window.resizeTo(600, 800);
	});
	
	function getDay(chatDate){
		let date = new Date(chatDate);
		return date.getFullYear() + "년 " + months[date.getMonth()] + " " + date.getDate() + "일 " + day[date.getDay()];
	}
	
	function getTime(chatDate){
		console.log(chatDate);
		let date = new Date(chatDate);
		
		const hours = date.getHours();
		const minutes = date.getMinutes();
		
		if (hours > 12) {
	 		const pmHours = hours - 12;
			return "오후 " + pmHours + ":"+ pad(minutes);
	  	} else {
	    	return "오전 " + hours + ":" + pad(minutes);
	  	}
	}
	
	 function pad(d) {
	    	return (Number(d) < 10) ? '0' + d.toString() : d.toString();
	  }
	</script>
</body>
</html>