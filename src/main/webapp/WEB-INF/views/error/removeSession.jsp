<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<script>
		const title = '${title}';
		const msg   = '${msg}';  
		const icon  = '${icon}'; 
		const url   = '${url}' ;
		const obj   = '${obj}';
		
		console.log(JSON.parse(obj));
		swal({
			title : title,
			text  : msg,
			icon  : icon,
			buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm :{
					text : "확인",
					value : true,
					visible : true,
					closeModal : true
				}
			}
		}).then(function(isConfrim){
			if(isConfrim){
				$.ajax({
					url : url,
					type : "post",
					data : JSON.parse(obj),
					success : function(res){
						if(res == "1"){
							console.log("로그인 세션 종료");
						}
					},
					error : function(){
						console.log('ajax 오류');
					}
				});			
			}
			location.href = "/";
		});
	</script>
</body>
</html>