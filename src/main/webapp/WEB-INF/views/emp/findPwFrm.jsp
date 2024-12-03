<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon"/>
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.wrap{
	width: 450px;
	height: 380px;
	display : flex;
	justify-content: center;
}

.wrap-div{
	margin: auto 0px;
}

.wrap-div>div{
	margin: 5px 0;
}

.wrap-div input{
	width: 300px;
	height: 40px;
	font-size: 20px;
}

.btn {
	width: 100px;
	height: 40px;
	border: none;
	background: #9fd1fe;
	color: white;
	border-radius: 10px;
	font-size: 25px;
}

.btn:hover {
	background: #75befe;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.btn-div{
	margin-top : 10px;
	display: flex;
	justify-content: center;
}


</style>
</head>
<body>
	<div class="wrap">
		<div class="wrap-div">
			<div>
				<span>아이디</span>
			</div>
			<div>
				<input type="text" name="empId" placeholder="아이디">
			</div>
			<div class="btn-div">
				<button class="btn" onclick="success()">확인</button>
			</div>
		</div>
	</div>
	
	<script>
	function success(){
		let empId = $('input[name="empId"]').val();
		
		const regExp = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]{6,16}$/;
		
		if(!regExp.test(empId)){
			swal({
				title : "확인",
				text : "영어, 숫자를 적어도 1글자 이상으로 \n 6~16글자 사이로 입력하세요.",
				icon : "warning"
			});		
			return;
		}
		
		
		$.ajax({
			url : "/emp/chkIdSendPhone.do",
			type : "post",
			data : {"empId" : empId},
			success : function(res){
				if(res.length > 0){
					swal({
						title : "확인",
						text : "휴대폰 번호로 인증번호가 전송되었습니다.",
						icon : "success"
					}).then(function(){
						let f = document.createElement('form');
						f.setAttribute('method', 'post');
						f.setAttribute('action', '/emp/codeChk.do');
						
						let code = document.createElement('input');
						code.setAttribute('type', 'hidden');
						code.setAttribute('name', 'code');
						code.setAttribute('value', res);
						
						let empId = document.createElement('input');
						empId.setAttribute('type', 'hidden');
						empId.setAttribute('name', 'empId');
						empId.setAttribute('value',  $('input[name="empId"]').val());

						f.appendChild(code);
						f.appendChild(empId);
						
						document.body.appendChild(f);
						f.submit();
					});
				}else{
					swal({
						title : "확인",
						text : "등록된 아이디가 존재하지 않습니다.",
						icon : "warning"
					}).then(function(){
						self.close();
					});
				}
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
		
	}
	
	$(window).resize(function() {
		window.resizeTo(500, 500);
	});
	</script>
</body>
</html>