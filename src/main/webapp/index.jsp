<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BPSH ERP</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/emp/login.jsp"></jsp:include>
	
	<script>
	//회원 가입
	function createEmp() {
		$.ajax({
			url : "/emp/joinFrm.do",
			type : "post",
			success : function(res) {
				$('body').html(res);
			},
			error : function() {
				console.log('ajax error');
			}
		});
	}
	</script>
</body>
</html>