<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		background: #e0e0e0;
	}
	
	.chat-div{
		height: 85%;
		background: #cdeefd;
		opacity: 0.4;
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
				<textarea class="message-box"></textarea>
				<button class="send" onclick="fn.sendValidate()">버튼</button>
			</div>
		</div>
	</div>
	
	<script>
	var ws;
	var empCode = '${loginMember.empCode}';
	var empName = '${loginMember.empName}';
	var groupNo;	
	let fn = {
		init : function () {
			//연결
			ws = new WebSocket("ws://192.168.10.48/chat/doChat.do");
			
			//연결 시, 이벤트 핸들러
			ws.onopen = function(){
				var msg = {
					type     : "connect",
					empName : empName
				};
				
				ws.send(JSON.stringify(msg));
			};
			
			//메시지 수신 시, 이벤트 핸들러
			ws.onmessage = function(e){
				var msg = e.data;
				var chat = $("#msgArea").html() + "\n <h4>" + msg + "</h4>";
				$("#msgArea").html(chat);
			};
			
			//소켓 연결 종료 이벤트 핸들러
			ws.onclose = function(){
				console.log("연결종료");
			};
		}	
		,sendValidate : function () {
			//파일 서버 업로드 -> 메시지 전송
			let file = $('input[type=file]')[0].files;

			if(file.length > 0){
				file = file[0];
				
				const formData = new FormData();
				formData.append("file", file);
				formData.append("memberId", memberId);
				
				$.ajax({
		            url: "/chat/fileUpload.do",
		            type: "post",
		            data: formData,
		            processData: false,
		            contentType: false,
		            success: function(obj) {
		            	fn.sendChat(obj); //fileName, filePath
		            	
		            },
		            error: function() {
		                alert("파일 업로드 실패: " + error);
		            }
		        });
			}else {
				let obj = {};
				fn.sendChat(obj);
			}
			
		}
		,sendChat : function (sendObj) {
			
			sendObj.type = "chat";
			sendObj.groupNo = groupNo;
			sendObj.empCode= empCode;
			sendObj.empName = empName;
			sendObj.msg = $("#chatMsg").val();
			
			ws.send(JSON.stringify(sendObj));
			
			//기존 입력값 초기화
			$("#chatMsg").val(""); 
			$('input[type=file]').val("");
			
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
					var liEmp = $("<li></li>");
					var item = $("<a class='empName' href='javascript:void(0)' onclick='choose(this)'></a>");
					item.html(emp.empName);
					item.attr('id',emp.empCode);
					liEmp.append(item);
					liEmp.attr('class','menu-emp');
					
					$('#'+ emp.teamCode).append(liEmp);
				};
				
			},
			error : function(){
				console.log('ajax 오류');	
			}
		});
	});
	
	function choose(obj){
		$.ajax({
			url : '/emp/chatList.do',
			type : 'post',
			data : {'fromEmpCode' : '${loginEmp.empCode}',
					'toEmpCode' : $(obj).attr('id')},
			success : function(res){
				console.log(res);
			},
			error : function(){
				console.log('ajaxError')
			}
					
		});
	}
	
	$(window).resize(function () {
	    window.resizeTo(600, 800);
	});
	
	
	//test
	$(window).bind('beforeunload', function() {
		console.log("11111");
		self.close();
	});
	
	$(window).on('beforeunload', function() {
		console.log("222222");
		self.close();
	});
	
	</script>
</body>
</html>