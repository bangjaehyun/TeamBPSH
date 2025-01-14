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
				<span>인증코드</span>
			</div>
			<div>
				<input type="text" name="inCode" placeholder="인증코드 6자리">
			</div>
			<div class="btn-div">
				<button class="btn" onclick="success()">확인</button>
			</div>
		</div>
	</div>
	
	<script>
	function success(){
		
		let inCode = $('input[name="inCode"]').val();
		
		if(inCode != '${code}'){
			swal({
				title : "확인",
				text : "인증 번호가 일치하지 않습니다.",
				icon : "warning"
			}).then(function(){
				self.close();
				return;
			});
		}else{
			let f = document.createElement('form');
			f.setAttribute('method', 'post');
			f.setAttribute('action', '/emp/changePwFrm.do');
			
			let empId = document.createElement('input');
			empId.setAttribute('type', 'hidden');
			empId.setAttribute('name', 'empId');
			empId.setAttribute('value', '${empId}');

			f.appendChild(empId);
			
			document.body.appendChild(f);
			f.submit();
		}
		
	}
		$(window).resize(function() {
			window.resizeTo(500, 500);
		});
	</script>
</body>
</html>