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
         	width : 140px;
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
  			text-align: center;
  			margin-bottom 5px: 
  		}
  		
  		.myPage>ul>li>a{
  			text-decoration: none;
  			color: white;
  			font-weight: bold;
  		}
  		
  		
  		.alarm{
  			visibility : hidden;
  			position : absolute;
         	width : 300px;
         	height:0px;
         	top: 55px;
         	right : 10px;
    		background: white;
    		border : 1px solid black; 
    		border-radius:5px; 
    		color: black;
    		text-align: center;
    		transition: .5s;
    		overflow: hidden;
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
			<div>
				<div class="alarm">
					
				</div>
			</div>
			 <div class="myPage">
            	 	<ul>
            	 		<li>
            	 		<c:forEach var="dept" items="${deptList}">
            	 			<c:if test="${loginEmp.deptCode eq dept.deptCode}">
            	 				${dept.deptName}(${loginEmp.empName})
            	 			</c:if>
            	 		</c:forEach>
            	 		</li>
            	 		<li><hr></li>
            	 		<li><a href="javascript:void(0)" onclick="myPage()">내정보</a></li>
            	 		<li><a href="javascript:void(0)" onclick="chatOpen()">채팅</a></li>
            	 		<li><a href="javascript:void(0)" onclick="logOut()">로그아웃</a></li>
            	 	</ul>
            	 </div>
		</div>
	</div>
	<script>
	function chatOpen(){
		let popupWidth = 700;
		let popupHeight = 850;
		
		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = window.innerWidth + window.screenX; 

		let popupWindow = window.open("", "windowName", "width="+popupWidth+", height=" + popupHeight + ", top=" + top + ", left=" + left + ",resizable=0");
		let f = document.createElement('form');
		        f.setAttribute('method', 'post');
		        f.setAttribute('action', '/emp/chatFrm.do');
		popupWindow.document.body.appendChild(f);
		f.submit();
	}
	
	function myPage(){
		pageMoveParam("/emp/myPage.do", {"empCode" : "${loginEmp.empCode}"});
	}
	
	<%--로그 아웃--%>
	function logOut(){
	       let f = document.createElement('form');
		        f.setAttribute('method', 'post');
		        f.setAttribute('action', '/emp/logout.do');
		        document.body.appendChild(f);
		        f.submit();
	}
	
	<%-- 사이드바 toggle하여 숨기고 보여주기--%>
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