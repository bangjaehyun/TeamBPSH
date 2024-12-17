<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.wrap{
		display: flex;
	}
	.side{
		width: 55px;	
	}
	.page{
		width: 100%;
	}

</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<div class="wrap">
		<div class="side">
			<jsp:include page="/WEB-INF/views/main/sidebar.jsp"></jsp:include>
		</div>
		<div class="page">
			<jsp:include page="/WEB-INF/views/main/main.jsp"></jsp:include>
		</div>
	</div>
	<script>
    function toggle(){
   if($(".side").css('display') == "block"){
            $('.side').css('display','none');
         }else{
            $('.side').css('display','block');
         }
    }   
</script>
</body>
</html>