<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/default.css" />
<style>
body {
	padding: 0px;
	margin: 0px;
	width: 100vw;
	height: 100vh;
	background: linear-gradient(#99CCFF, #CCCCFF);
}

.container {
	width: 100%;
	height: 100%;
	align-content: center;
}

.wrap {
	margin: 0 auto;
	height: 500px;
	width: 500px;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.login-wrap>div {
	width: 400px;
}

.wrap input {
	padding: 5px;
	width: 395px;
	height: 60px;
	border-radius: 20px;
	border-color: white;
	font-size: 20px;
}

.opacity-div {
	position: absolute;
	height: 500px;
	width: 500px;
	background-color: white;
	border-radius: 30px;
	opacity: 0.3;
	z-index: 0;
}

.login-wrap {
	position: absolute;
	z-index: 1;
	width: 400px;
	height: 400px;
	align-content: center;
}

.login-wrap * {
	border: 0px;
}

.login-btn {
	width: 100%;
	height: 80px;
	background-color: #E5CCFF;
	border-radius: 20px;
	color: white;
	font-size: 30px;
	font-weight: bold;
}

.div-wrap>p {
	color: #999999;
	margin: 7px;
}

.div-wrap {
	margin-bottom: 20px;
}

.div-wrap>a {
	text-decoration: none;
	color: #999999;
}

.bottom-wrap {
	display: flex;
	justify-content: center;
	gap: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="wrap">
			<div class="opacity-div"></div>
			<form action="emp/mainPage.do" method="post"  class="login-wrap">
				<div class="div-wrap">
					<p>아이디</p>
					<input type="text" name="empId" placeholder="아이디">
				</div>
				<div class="div-wrap">
					<p>비밀번호</p>
					<input type="password" name="empPw" placeholder="비밀번호">
				</div>
				<div class="div-wrap">
					<input type="submit" class="login-btn" value="로그인">
				</div>
				<div class="div-wrap bottom-wrap">
					<a href="javascript:void(0)" onclick="createEmp()">회원 가입</a> <a
						href="javascript:void(0)" onclick="findId()">아이디 찾기</a> <a
						href="javascript:void(0)" onclick="findPw()">비밀번호 찾기</a>
				</div>
			</form>
		</div>
	</div>
	
	<script>
	function findId(){
		let popupWidth = 500;
		let popupHeight = 500;

		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;

		let popupWindow = window.open("", "windowName", "width="
				+ popupWidth + ", height=" + popupHeight + ", top=" + top
				+ ", left=" + left + ",resizable=0");
		popupWindow.resizeTo(500, 500);
		let f = document.createElement('form');
		f.setAttribute('method', 'post');
		f.setAttribute('action', '/emp/findIdFrm.do');

		popupWindow.document.body.appendChild(f);
		f.submit();
	}
	
	function findPw(){
		let popupWidth = 500;
		let popupHeight = 500;

		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;

		let popupWindow = window.open("", "windowName", "width="
				+ popupWidth + ", height=" + popupHeight + ", top=" + top
				+ ", left=" + left + ",resizable=0");
		popupWindow.resizeTo(500, 500);
		let f = document.createElement('form');
		f.setAttribute('method', 'post');
		f.setAttribute('action', '/emp/findPwFrm.do');

		popupWindow.document.body.appendChild(f);
		f.submit();
	}
	
	</script>
</body>
</html>