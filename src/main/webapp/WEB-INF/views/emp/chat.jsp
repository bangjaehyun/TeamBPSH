<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
		background: #fce025;
		border: none;
	}
	
	.send>img{
		width: 50%;
	}
	
	.empName{
		text-decoration: none;
		font-size: 12px;
		color : #d3d3d3;
	}
	
	.empName:hover{
		font-size: 13px;
	}
	
	.login{
		color: black;
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
		margin-left : 30px;
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
	
	.readCount{
		width : 18px;
		text-align : center;
		display : inline-block;
		margin-left : 3px;
		font-size: 12px;
		color: white;
		background-color: red;
 		border-radius: 12px; 
	}
	
	.fileBox{
		display : flex;
		gap : 5px;
		text-align : center;
		align-items: center;
		background: white;
		padding: 5px;
		border-radius: 15px;
	}
	
	
	.fileBox a{
		width : 50px;
		height : 50px;
		border: 1px solid black;
		border-radius: 50px;
		align-content: center;
	}
	
	.fileBox img{
		margin : auto 0;
		height: 38px;
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
				<button class="send" onclick="fn.sendValidate()"><img src="/resources/images/send.png"></button>
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
			ws = new WebSocket("ws://192.168.10.48/emp/doChat.do");
			
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
				console.log(e.data);
				
				if(JSON.parse(e.data).type == "chat"){
					const chat = JSON.parse(e.data).data;
					if(JSON.parse(chat).chatMsgGb == "1"){
						addFile(JSON.parse(chat));
					}else{
						addChat(JSON.parse(chat));
					}
					$('.chat-div').scrollTop($('.chat-div')[0].scrollHeight);
				}else if(JSON.parse(e.data).type == "login"){
					$("#"+JSON.parse(e.data).empCode).addClass("login");
				}
				else if(JSON.parse(e.data).type == "logout"){
					$("#"+JSON.parse(e.data).empCode).removeClass("login");
				}else if(JSON.parse(e.data).type == "readCount"){
					$.ajax({
						url : "/emp/addReadCount.do",
						type : "post",
						data : {"empCode" : JSON.parse(e.data).empCode,
								"groupNo" : JSON.parse(e.data).groupNo},
						success : function(res){
							if(JSON.parse(e.data).socket != null){
								if($("#"+JSON.parse(e.data).empCode).next().length == 0){
									let readCount = $('<div></idv>');
									readCount.html(1);
									readCount.attr('class','readCount');
									$("#"+JSON.parse(e.data).empCode).parent().append(readCount);
								}else{
									$("#"+JSON.parse(e.data).empCode).next().html(Number($("#"+JSON.parse(e.data).empCode).next().html())+1);
								}
							}
							console.log("알람 카운트 증가");
						},
						error : function(){
							console.log("ajax 오류")
						}
					});
				}else if(JSON.parse(e.data).type == "null"){
					console.log("Gdgd");
					swal({
						title : "확인",
						text : "채팅 대상을 선택하여 주세요",
						icon : "warning"
					});
				}
			};
			
			<%-- 소켓 연결 종료 이벤트 핸들러 --%>
			ws.onclose = function(){
				console.log("연결종료");
				ws.close();
				ws = null
			};
		}	
		,sendValidate : function (enter) {
				let obj = {};
				fn.sendChat(obj,enter);
		}
		,sendChat : function (sendObj,enter) {
			str = $('.message-box').val();
			str = str.replace(/(?:\r\n|\r|\n)/g, "<br/>");
			
			if(enter != null){
				str = str.slice(0, -5);
			}
			
			sendObj.type = "chat";
			sendObj.groupNo = groupNo;
			sendObj.empCode= empCode;
			sendObj.empName = empName;
			sendObj.toEmp = toEmp;
			sendObj.msg = str;
			
			ws.send(JSON.stringify(sendObj));
			
			//기존 입력값 초기화
			$(".message-box").val(""); 
			
		}
		,chatFileDown : function(fileName, filePath){
			fileName = encodeURIComponent(fileName);
			filePath = encodeURIComponent(filePath);
			
			location.href = "/emp/chatFileDown.do?fileName="+fileName+"&filePath="+filePath;
		}
	};
	
	
	<%-- 기본 드래그 오버 방지--%>
	 $('#message-box').on("dragover", function(e) {
		    e.preventDefault();
		  });

		  <%-- 드롭 이벤트 처리 --%>
		  $('#message-box').on("drop", function(e) {
		    e.preventDefault();
		    const files = e.originalEvent.dataTransfer.files; // 드롭된 파일 가져오기

		    if (files.length > 0) {
		      uploadFile(files[0]);
		    } else {
		      console.warn("드롭된 파일이 없습니다.");
		    }
		  });
		  
		  
		// 파일 업로드 함수
		  function uploadFile(file) {
		    const formData = new FormData();
		    formData.append("file", file); // 서버에서 받을 파일 필드 이름
			
		    $.ajax({
		      url: '/emp/chatUpload.do', // 서버의 파일 업로드 처리 URL
		      type: 'POST',
		      data: formData,
		      processData: false, 
		      contentType: false, 
		      success: function(obj) {
		        fn.sendChat(obj);
		      },
		      error: function() {
		        console.error("업로드 실패");
		      }
		    });
		}
	
	<%-- 컨텍스트 메뉴 클릭시에 해당 img 동적으로 변경 --%>
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
		<%-- 팀별로 li태그 생성--%>
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
		
		<%-- 본인 제외 사원 조회후 각 팀별로 넣어주고 읽지 않은 메시지가 있다면 표시 --%>
		$.ajax({
			url : '/emp/chatEmpList.do',
			type : "post",
			data : {"empCode" : "${loginEmp.empCode}"},
			success : function(list){
				for(idx in list){
					let emp = list[idx];
					console.log(emp);
						let liEmp = $("<li></li>");
						<%-- 사원 이름 --%>
						let item = $("<a class='empName' href='javascript:void(0)' onclick='choose(this)'></a>");
						
						item.html(emp.empName);
						item.attr('id',emp.empCode);
						<%-- 로그인 하였을 경우와 하지 않았을경우에 색 다르게 표현 --%>
						if(emp.login){
							item.addClass('login');
						}
						
						liEmp.append(item);
						<%-- 기존 읽지 않은 메시지가 있다면 표현 --%>
						if(emp.readCount > 0){
							let readCount = $('<div></idv>');
							readCount.html(emp.readCount);
							readCount.attr('class','readCount');
							liEmp.append(readCount);
						}
						liEmp.attr('class','menu-emp');
						
						$('#'+ emp.teamCode).append(liEmp);
				}
				
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
		$(obj).next().html("");
		toEmp =  $(obj).attr('id');
		<%-- 기존 채팅내용 제거 --%>
		$(".chat-div").children().remove();
		$.ajax({
			url : '/emp/chatList.do',
			type : 'post',
			data : {'fromEmpCode' : '${loginEmp.empCode}',
					'toEmpCode' : toEmp},
			success : function(res){
				let msg = {
						type     : "group",
						empCode : empCode,
						groupNo : res.groupNo
					};
					<%-- 채팅 그룹 설정하기 위하여 서버에 전송 --%>
					ws.send(JSON.stringify(msg));
				
				for(let i = 0; i < res.chatList.length; i++){
					let chat = res.chatList[i];
					<%--채팅 정보--%>
					if(chat.chatMsgGb == "1"){
						addFile(chat);
					}else{
						addChat(chat);
					}
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
	
	
	function addFile(chat){
		if(chat.empCode == ${loginEmp.empCode}){
			let divEl = $('<div></div>');
			let namDiv = $('<div></div>');
			let name = $('<span></span>');
			let msgDiv = $('<div></div>');
			let fileBox = $('<div></div>');
			let fileName = $('<span></span>');
			let fileDown = $('<a></a>');
			let img = $('<img src="/resources/images/filedown.png"></img>');
			let time = $('<span></span>');
			name.html(chat.empName);
			namDiv.append(name);
			namDiv.attr('class', 'name-right');
			time.html(getTime(chat.chatDate));
			time.attr('class', 'time');
			msgDiv.append(time);
			fileDown.attr('href','javascript:void(0)');
			fileDown.attr('onclick', 'fn.chatFileDown('+ "'" + chat.chatFileName + "'" +','+  "'" + chat.chatFilePath + "'" +')');
			fileDown.append(img);
			fileName.html(chat.chatFileName);
			fileBox.append(fileName);
			fileBox.append(fileDown);
			fileBox.attr('class','fileBox');
			msgDiv.append(fileBox);
			msgDiv.attr('class', 'msg-right');
			divEl.append(namDiv);
			divEl.append(msgDiv);
			divEl.attr('class','msg-div');
			$(".chat-div").append(divEl);
		}else{
			let divEl = $('<div></div>');
			let namDiv = $('<div></div>');
			let name = $('<span></span>');
			let msgDiv = $('<div></div>');
			let fileBox = $('<div></div>');
			let fileName = $('<span></span>');
			let fileDown = $('<a></a>');
			let img = $('<img src="/resources/images/filedown.png"></img>');
			let time = $('<span></span>');
			name.html(chat.empName);
			namDiv.append(name);
			namDiv.attr('class', 'name-left');
			time.html(getTime(chat.chatDate));
			time.attr('class', 'time');
			fileDown.attr('href','javascript:void(0)');
			fileDown.attr('onclick', 'fn.chatFileDown('+ "'" + chat.chatFileName + "'" +','+  "'" + chat.chatFilePath + "'" +')');
			fileDown.append(img);
			fileName.html(chat.chatFileName);
			fileBox.append(fileName);
			fileBox.append(fileDown);
			fileBox.attr('class','fileBox');
			msgDiv.append(fileBox);
			msgDiv.append(time);
			msgDiv.attr('class', 'msg-left');
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
	
	$('body').keyup(function(e){
		if (e.keyCode == 27){
	        self.close();
		 }	
	})
	
	<%-- 사이즈 변경 못하게 고정 --%>
	$(window).resize(function () {
	    window.resizeTo(700, 850);
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