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
	box-sizing: border-box;
}

.my-page {
	width: width: 100%;
	height: calc(100vh - 50px);
	display: flex;
	justify-content: center;
	overflow: auto;
}

.my-wrap {
	margin : auto 0;
	width: calc(100vw - 300px);
	height: calc(100vh - 100px);
/* 	overflow: scroll; */
}

.my-name{
	margin : 0 auto;
 	height: 100px; 
	width: 80%;
	min-width: 1000px;
	
	display: flex;
    justify-content: space-between; /* 양쪽으로 정렬 */
    align-items: center; /* 세로 정렬 */
    position: relative; /* 자식 요소의 배치를 위해 설정 */
}

.my-name span{
	font-size: 25px; 
	font-weight: bold; 
}

.my-info {
	margin: 0 auto;
	width: 60%;
	min-width: 1000px;
/* 	height: 90%; */
/* 	min-height: 800px; */
	display: flex;
/* 	justify-content: center; */
}

.emp-div {
	height: 80px;
	align-items: center;
	margin: 20px 0;
}

.emp-div>p {
	font-size: 20px;
	font-weight: bold;
}

.emp-div>input {
	width: 80%;
	min-width: 1000px;
	height : 50px;
	border : none;
	border-bottom : 1px solid black;
	font-size: 20px;
	background: white;
}

.work-btn{
	width: 80px;
	height: 35px;
	border-radius: 15px;
	border: none;
 	background: #efefef; 
	color : white;
	font-weight: bold;
	font-size: 20px;
	margin: 3px 0;
}
.name-div{
	  position: absolute;
    left: 50%; /* 부모의 가로 중앙으로 이동 */
    transform: translateX(-50%); /* 가운데 정렬 */
    text-align: center;
}
.work{
/* 	margin-left: 300px;; /* 오른쪽으로 정렬 */ 
	margin-left: auto; /* 오른쪽으로 정렬 */
    text-align: right; /* 내부 요소 오른쪽 정렬 */
}

.upd-div{
	margin : 0 auto;
	display: flex;
 	justify-content: center;
 	gap : 20px; 
 	height: 50px; 
	width: 80%;
	min-width: 1000px;
}

.upd-btn{
	width: 80px;
	height: 35px;
	border-radius: 15px;
	border: none;
 	background: #d8d8d8; 
	color : white;
	font-weight: bold;
	font-size: 20px;
}

.upd-btn:hover {
	background: #d3d3d3;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.work-btn:hover{
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.updPw-btn{
	width: 150px;
	height: 35px;
	border-radius: 15px;
	border: none;
 	background: #d8d8d8; 
	color : white;
	font-weight: bold;
	font-size: 20px;
}

.updPw-btn:hover{
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.salary-btn {
	width: 180px;
	height: 35px;
	border-radius: 15px;
	border: none;
	background: #a9d51a;
	font-weight: bold;
	color: white;
	font-size: 20px;
}

.salary-btn:hover {
	background: #c5de71;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

</style>
</head>
<body>
	<div class="my-page">
		<div class="my-wrap">
			<div class="my-name">
				<div class="name-div">
					<span>${loginEmp.empName}${loginEmp.rankName}</span>
				</div>
				<div class="work">
					<div class="onWork">
						<button class="work-btn" type="button" onclick="onWork('${loginEmp.empCode}')">출근</button>
					</div>
					<div class="offWork">
						<button class="work-btn" type="button" onclick="offWork('${loginEmp.empCode}')">퇴근</button>
					</div>
					<div>
						<button class="salary-btn" onclick="history()">연봉 변경 이력</button>
					</div>
				</div>
			</div>
			<div class="my-info">
				<div>
					<div class="emp-div">
						<p>이름</p> 
						<input type="text" name="empName" value="${loginEmp.empName}">
					</div>
					<div class="emp-div">
						<p>부서</p>
						<c:forEach var="dept" items="${deptList}">
							<c:if test="${dept.deptCode == loginEmp.deptCode}">
								<input value="${dept.deptName}" disabled>
							</c:if>
						</c:forEach>
					</div>
					<div class="emp-div">
						<p>팀</p>
						<c:forEach var="team" items="${teamList}">
							<c:if test="${team.teamCode == loginEmp.teamCode}">
								<input value="${team.teamName}" disabled>
							</c:if>
						</c:forEach>
					</div>
					<div class="emp-div">
						<p>직급</p>
						<c:forEach var="rank" items="${rankList}">
							<c:if test="${rank.rankCode == loginEmp.rankCode}">
								<input value="${rank.rankName}" disabled>
							</c:if>
						</c:forEach>
					</div>
					<div class="emp-div">
						<p>아이디</p> 
						<input value="${loginEmp.empId}" disabled>
					</div>

					<div class="emp-div">
						<p>전화번호</p> 
						<input name="empPhone" value="${loginEmp.empPhone}">
					</div>
					<div class="upd-div">
						<button class="upd-btn" onclick="updateEmp()">수정</button>
						<button class="updPw-btn" onclick="updatePw()">비밀번호 수정</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	function history(){
		
		let empCode = '${loginEmp.empCode}';

			let popupWidth = 800;
			let popupHeight = 750;

			let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
			let left = (window.innerWidth - popupWidth) / 2 + window.screenX;

			let popupWindow = window.open("", "windowName", "width="
					+ popupWidth + ", height=" + popupHeight + ", top=" + top
					+ ", left=" + left + ",resizable=0");
			popupWindow.resizeTo(800, 750);
			let f = document.createElement('form');
			f.setAttribute('method', 'post');
			f.setAttribute('action', '/emp/salesHistory.do');

			let inputEl = popupWindow.document.createElement('input');
			inputEl.setAttribute('type', 'hidden');
			inputEl.setAttribute('name', 'empCode');
			inputEl.setAttribute('value', empCode); // empCode는 미리 정의되어 있어야 함

			f.appendChild(inputEl);

			popupWindow.document.body.appendChild(f);
			f.submit();
		}
	
	
	function updatePw(){
		let popupWidth = 500;
		let popupHeight = 440;
		
		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;

		let popupWindow = window.open("", "windowName", "width="+popupWidth+", height=" + popupHeight + ", top=" + top + ", left=" + left + ",resizable=0");
		popupWindow.resizeTo(500, 440);
		let f = document.createElement('form');
		        f.setAttribute('method', 'post');
		        f.setAttribute('action', '/emp/empPwUpdateFrm.do');
		popupWindow.document.body.appendChild(f);
		f.submit();
		
	}
	
	function updateSuccess(){
		swal({
			title : "성공",
			text : "비밀번호 변경이 완료되었습니다. \n 로그인을 다시 해주시기 바랍니다.",
			icon : "success"
		}).then(function(){
			location.href = "/";	
		});
		
	}
	
	
	$(document).ready(function(){
		var chk = false;
		if(${!empty commute.onWork}){
			let spanEl = $('<span>');
		 	let str = '${commute.onWork}';
		    let hour = str.slice(0, 2);
			let min = str.slice(2, 4);
			let sec = str.slice(4, 6);
			spanEl.html(hour+":"+min+":"+sec);
			$('.onWork').append(spanEl);
			$('.onWork').children('.work-btn').css('background','#7bc9fd');
		}else{
			$('.onWork').children('.work-btn').css('background','#fc2f2f');
			chk = true;
		}
		
		if(${!empty commute.offWork}){
			let spanEl = $('<span>');
			let str = '${commute.offWork}';
		    let hour = str.slice(0, 2);
			let min = str.slice(2, 4);
			let sec = str.slice(4, 6);
			spanEl.html(hour+":"+min+":"+sec);
			$('.offWork').append(spanEl);
			$('.offWork').children('.work-btn').css('background','#7bc9fd');
		}else{
			if(chk == false){
				$('.offWork').children('.work-btn').css('background','#fc2f2f');	
			}
			
		}
	});
	
	function onWork(empCode){
		$.ajax({
			url : "/emp/onWork.do",
			type : "post",
			data : {"empCode" : empCode},
			success : function(res){
				if(res == "1"){
					msg("완료","출근이 완료되었습니다.", "success");
					pageMoveParam("/emp/myPage.do",{"empCode" : '${loginEmp.empCode}'});
				}else if(res == "-1"){
					msg("확인","이미 출근을 완료하였습니다.", "warning");
				}else{
					msg("오류","관리자에게 문의 바랍니다.", "error");
				}
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
	}
	
	function offWork(empCode){
		$.ajax({
			url : "/emp/offWork.do",
			type : "post",
			data : {"empCode" : empCode},
			success : function(res){
				if(res == "1"){
					msg("완료","퇴근이 완료되었습니다.", "success");
					pageMoveParam("/emp/myPage.do",{"empCode" : '${loginEmp.empCode}'});
				}else if(res == "-1"){
					msg("확인","출근을 먼저 해주시기 바랍니다.", "warning");
				}else{
					msg("오류","관리자에게 문의 바랍니다.", "error");
				}
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
	}
	
	function updateEmp(){
		const nameExp = /^[가-힣]{2,4}$/;
		const phoneExp = /^010[0-9]{8}$/;
		
		if(!nameExp.test($('input[name="empName"]').val())){
			msg("확인","이름 형식이 올바르지 않습니다.\n(2~4자의 한글 이름)", "warning");
			$('input[name="empName"]').val("");
			return;
		}
		
		if(!phoneExp.test($('input[name="empPhone"]').val())){
			msg("확인","전화번호 형식이 올바르지 않습니다.\n(-없이 13자리)", "warning");
			$('input[name="empPhone"]').val("");
			return;
		}
		
		$.ajax({
			url : "/emp/updateEmp.do",
			type : "post",
			data : {"empCode" : '${loginEmp.empCode}',
					"empName" : $('input[name="empName"]').val(),
					"empPhone" : $('input[name="empPhone"]').val()
					},
			success : function(res){
				if(res == "1"){
					msg("완료","수정이 완료되었습니다.", "success");				
				}else{
					msg("오류","수정중 오류가발생하였습니다..", "error");
				}
				pageMoveParam("/emp/myPage.do",{"empCode" : '${loginEmp.empCode}'});
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
	}
	
	</script>
</body>
</html>