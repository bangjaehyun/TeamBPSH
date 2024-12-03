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
				<span>휴대폰 번호</span>
			</div>
			<div>
				<input type="text" name="phone" placeholder="숫자만 입력">
			</div>
			<div class="btn-div">
				<button class="btn" onclick="success()">확인</button>
			</div>
		</div>
	</div>
	
	<script>
	function success(){
		let phone = $('input[name="phone"]').val();
		
		const regExp = /^010[0-9]{8}$/;
		
		if(!regExp.test(phone)){
			swal({
				title : "확인",
				text : "입력 양식이 올바르지 않습니다.\n 숫자로 11자리 입력 바랍니다.",
				icon : "warning"
			});		
			return;
		}
		
		
		$.ajax({
			url : "/emp/chkPhoneToId.do",
			type : "post",
			data : {"phone" : phone},
			success : function(res){
				if(res == "1"){
					swal({
						title : "확인",
						text : "휴대폰 번호로 아이디가 전송되었습니다.",
						icon : "success"
					}).then(function(){
						self.close();
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