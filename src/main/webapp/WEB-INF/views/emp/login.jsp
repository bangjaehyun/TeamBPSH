<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</body>
</html>