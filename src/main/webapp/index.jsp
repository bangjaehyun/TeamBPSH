<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<link rel="shortcut icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon"/>
<link rel="icon" href="<c:url value='/resources/images/favicon.ico'/>" type="image/x-icon"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<c:choose>
	<c:when test="${not empty loginEmp}">
		<jsp:include page="/WEB-INF/views/main/mainPage.jsp"></jsp:include>
	</c:when>
	<c:when test="${empty loginEmp}">
		<jsp:include page="/WEB-INF/views/emp/login.jsp"></jsp:include>
	</c:when>
	</c:choose>
	
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