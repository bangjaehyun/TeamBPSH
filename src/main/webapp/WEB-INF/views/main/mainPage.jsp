<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	.bgx{
		position : absolute;
		z-index : 9998;
		width : calc(100vw - 55px);
		height : calc(100vh - 50px);
		background: black;
		opacity : 0.5;
		display: none;
	}
	
 		.myPage{
 			position : absolute;
         	visibility: hidden;
         	width : 100px;
         	height : 0px;
         	top: 55px;
         	right : 10px;
    		background: #898989; 
    		border-radius:5px; 
    		color: #fff; 
    		text-align: center;
    		transition: all 1s;
    		opacity: 0;
    		display: flex;
    		justify-content: center;
  		}
  		
  		.myPage>ul{
  			margin : auto 0;
  			width : 80%;
  			list-style: none;
  			text-align: left;
  		}
  		
  		.myPage>ul>li{
  			font-size: 13px;
  			font-weight: bold;
  		}
  		
  		
  		
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<div class="wrap">
		<div class="side">
			<jsp:include page="/WEB-INF/views/main/sidebar.jsp"></jsp:include>
		</div>
		<div class="page-div">
			<div class="bgx"></div>
			<div class="page">
				<jsp:include page="/WEB-INF/views/main/main.jsp"></jsp:include>
			</div>
			 <div class="myPage">
            	 	<ul>
            	 		<li>
            	 		<c:forEach var="dept" items="${deptList}">
            	 			<c:if test="${loginEmp.deptCode eq dept.deptCode}">
            	 				${dept.deptName}
            	 			</c:if>

            	 		</c:forEach>
            	 		
            	 		</li>
            	 		<li><hr></li>
            	 		<li>내정보</li>
            	 		<li>채팅</li>
            	 		<li>로그아웃</li>
            	 	</ul>
            	 </div>
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
    
    $('.bgx').on('click',function(){
    	$('.bgx').css('display','none');
    	$('.side-div').next().css('display','none');
    });
</script>
</body>
</html>