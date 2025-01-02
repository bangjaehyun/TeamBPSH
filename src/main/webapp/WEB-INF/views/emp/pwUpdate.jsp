<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
* {
	padding: 0px;
	margin: 0px;
}

.pw-wrap{
	display: flex;
	justify-content: center;
	width: calc(100vw);
	height: calc(100vh);
	align-items: center;
}

.pw-tbl {
	width: 80%;
	height: 70%;
}

form{
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.pw-btn {
	width: 80px;
	height: 35px;
	border-radius: 15px;
	border: none;
	background: #d8d8d8;
	color: white;
	font-weight: bold;
	font-size: 20px;
}

.pw-btn:hover {
	background: #d3d3d3;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.pw-tbl tr{
	height: 40px;
}

.pw-tbl td{
	width: 180px;
	text-align: center;
}

.title{
	font-size: 16px;
	font-weight: bold;
}

.pw-tbl input{
	width : 150px;
	height: 30px;
	font-size: 16px;
}

.btn-td{
	text-align: center;
}
</style>
</head>
<body>
	<div class="pw-wrap">
		<form action="/emp/updatePw.do" method="post">
			<table class="pw-tbl">
				<tr>
					<td><span class="title">기존 비밀번호</span></td>
					<td><input type="password" name="oldPw" autocomplete="off"></td>
				</tr>
				<tr>
					<td><span class="title">새 비밀번호</span></td>
					<td><input type="password" name="newPw" autocomplete="off"></td>
				</tr>
				<tr>
					<td><span class="title">새 비밀번호 확인</span></td>
					<td><input type="password" name="newPwChk" autocomplete="off"></td>
				</tr>
				<tr>
					<td colspan="2" class="btn-td">
						<button type="button" class="pw-btn" onclick="update()">변경</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script>
		function update() {
			if($('input[name="newPw"]').val() != $('input[name="newPwChk"]').val()){
				msg("확인", "새 비밀번호가 일치하지 않습니다.", "warning");
			}else{
				const regExp = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/;
				if(regExp.test($('input[name="newPw"]').val())){
					$.ajax({
						url : "/emp/updatePw.do",
						type : "post",
						data : {"empCode" : '${loginEmp.empCode}',
								"empPw"	: '${loginEmp.empPw}',
								"oldPw" : $('input[name="oldPw"]').val(),
								"newPw" : $('input[name="newPw"]').val()},
						success : function(res){
							if(res == "1"){
								opener.parent.updateSuccess();
								self.close();
							}
							else if(res == "-1"){
								msg("확인", "기존 비밀번호가 일치하지 않습니다.", "warning");	
							}
							else{
								msg("알림", "비밀번호 변경중 오류가 발생하였습니다.", "error");
							}
						},
						error : function(){
							console.log("ajax 오류");
						}
					});
				}else{
					msg("확인", "영어, 숫자,특수문자\n (1개포함 8~20글자 사이로 입력하세요.)", "warning");	
				}
			}
		}

		$(window).resize(function() {
			window.resizeTo(500, 440);
		});
		
		function msg(title,msg,icon){
			swal({
				title : title,
				text : msg,
				icon : icon
			});
		}
	</script>
</body>
</html>