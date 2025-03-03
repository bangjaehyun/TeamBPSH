<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
  <style>
        *{
            padding: 0px;
            margin: 0px;
        }
        .side-bar{
        	z-index : 9999;
            height: 100%;
            width: 55px;
            background-color: #CCCCCC;
            bottom : 0;
            padding-top: 10px;
        }
        
          .side-bar>ul{
            list-style: none;        
        }
        
        .side-sub{
        	z-index : 9999;
          	display: none;
          	position: absolute;
        	top : 0;
			left: 100%;
			width : 200px;
/* 			background: #5D5C5C; */
			background: white;
        }
        
        
        .side-sub > li > a{
        	text-decoration: none;
        	color: black;
        	margin: 0px;
        	width: 100%;
        	display: block;
        }
        
        .side-sub > li:hover{
        	background: #adadad;
        }
        
        .side-sub > li:hover > a{
        	color: white;
        }
        
        .side-bar>ul>li{
        	position: relative;
        }
        
        .side-sub>li{
        	 list-style: none;
        }
        
        .side-bar>ul>li{
        	text-align: center;
        	margin-bottom: 10px;
        }
        .side-div{
        	width : 45px;
        	cursor: pointer;
        	 margin:0 auto;
        	 border-radius: 10px;
        }
        .side-img{
        	height : 100%;
        	object-fit: cover;
        }
        .side-text{
        	color : #434343;
        	font-size: 11px;
        }
        .img-div{
        	height: 30px;
        }
        
        .div-color{
        	background: white;
        }
        
      
        
    </style>
</head>

<body>
	<div class="side-bar">
		<ul>
			<li class="side-li">
				<div id="mainPage" class="side-div mainPage">
					<div class="img-div"><img class="side-img" src="/resources/images/main.png" /></div>
					<p class="side-text">main</p>
				</div>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">문서</p>
				</div>
				<ul class="side-sub">
					<li><a href="javascript:void(0)" onclick="selectList('all')">문서목록</a></li>
					<li><a href="javascript:void(0)"onclick="writeDoc('va')">휴가신청서 작성</a></li>
					<li><a href="javascript:void(0)"onclick="writeDoc('co')">협조문 작성</a></li>
					<li><a href="javascript:void(0)"onclick="writeDoc('es')">견적서 작성</a></li>
					<li><a href="javascript:void(0)"onclick="writeDoc('bt')">출장보고서 작성</a></li>
					<li><a href="javascript:void(0)"onclick="writeDoc('sp')">지출결의서 작성</a></li>
				</ul>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">달력</p>
				</div>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">프로젝트</p>
				</div>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-vote.png" /></div>
					<p class="side-text">투표</p>
				</div>
			</li>
			<c:if test="${loginEmp.empId eq 'admin'}">
				<li class="side-li">
					<div class="side-div">
						<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
						<p class="side-text">관리자</p>
					</div>
					<ul class="side-sub">
						<li><a href="javascript:void(0)" onclick="empWait()">신규 회원 관리</a></li>
						<li><a href="javascript:void(0)" onclick="empManager()">회원 관리</a></li>
						<li><a href="javascript:void(0)" onclick="empDevelopPrice()">개발 단가 관리</a></li>
						<li><a href="javascript:void(0)" onclick="deptLeaderApPoint()">부서장 관리</a></li>
						<li><a href="javascript:void(0)" onclick="teamLeaderApPoint()">팀장 관리</a></li>
						<li><a href="javascript:void(0)" onclick="empCheck()">출퇴근 관리</a></li>
						<li><a href="javascript:void(0)" onclick="salesManager()">매출 관리</a></li>
						<li><a href="javascript:void(0)" onclick="salarySend()">월급 전송</a></li>
					</ul>
				</li>
			</c:if>
		</ul>
    </div>
    <script>
	$(document).ready(function(){
		$('#mainPage').addClass('div-color');
	});
	
	<%-- 월급 전송(메시지) --%>
	function salarySend(){
		pageMove('/emp/salarySendFrm.do');
	}	
	
    <%-- 부서장 관리 --%>
    function deptLeaderApPoint(){
    	pageMove("/emp/deptLeaderApPoint.do");	
    }
    <%-- 팀장 관리 --%>
    function teamLeaderApPoint(){
    	pageMove("/emp/teamLeaderApPoint.do");	
    }
    <%--매출 관리 페이지 이동--%>
    function salesManager(){
    	  let date = new Date();
          let yearMonth = date.getFullYear() + pad(date.getMonth()+1);
          data = {'yearMonth' : yearMonth};
    	
    	pageMoveParam("/emp/salesManager.do", data);	
    }
    <%--회원 관리 --%>
    function empManager(){
    	pageMove("/emp/empManager.do");	
    }
    <%--신규 회원 관리 --%>
    function empWait(){
    	pageMove("/emp/empWait.do");
    }
    <%--개발 단가 관리 --%>
    function empDevelopPrice(){
        pageMove("/emp/empDevelopPrice.do");
    }
    
    <%-- 출퇴근 관리 --%>
    function empCheck(){
        let date = new Date();
        let yearMonth = date.getFullYear() + pad(date.getMonth()+1);
        data = {'yearMonth' : yearMonth};
         pageMoveParam("/emp/empCheck.do", data)
    }
    
    function pad(d) {
        return (Number(d) < 10) ? '0' + d.toString() : d.toString();
  }
    
  	<%--sub메뉴클릭시 숨기기 위한 이벤트--%>
    $('.side-div').next().find('li').click(function(){
    	$('.side-div').next().css('display','none');
    	$('.bgx').css('display','none');
    })
    
    	<%--sub메뉴 보여주기 위함--%>
    	$('.side-div').click(function(e){
    		  $('.bgx').css('display','block');
    		  $('.side-div').next().css('display','none');
    		  $('.side-div').removeClass("div-color");
    		  $(this).addClass("div-color");
    		  
    		  $(this).next().css('display','block');
    	});
    
    <%--3번째 li 태그 달력으로 이동--%>
    $('.side-li:nth-child(3)').on('click',function(){
    	pageMove('/emp/calendar.do');
    });
    
    <%--4번째 li 태그로 이동--%>
     $('.side-li:nth-child(4)').on('click',function(){
    	 pageMove('/project/list.do');
        
    });
     
     <%--5번째 li 태그로 이동--%>
     $('.side-li:nth-child(5)').on('click',function(){
    	 const data = {"startCount" : 1,
    			 	   "endCount" : 15}
    	 pageMoveParam('/vote/list.do', data);
    });
    
    <%--main 페이지로 이동--%>
    $('.mainPage').on('click',function(){
    	pageMove("/emp/empMain.do");
    });
    
    function writeDoc(e){
    	$.ajax({
    	url:"/doc/writeDoc.do",
    	type:"post",
    	data:{"type":e},
    	success:function(res){
    	$('.page').html(res);
    },
    error:function(){
    	console.log("오류");
    }
    	});
    }
    
    <%--리스트 목록--%>
    function selectList(e){
    	$.ajax({
    		url:"/doc/selectList.do",
    		type:"post",
    		data:{"type":e},
    		success:function(res){
    			$('.page').html(res);
    		},
    		error:function(){
    			console.log("오류");
    		}
    		
    		
    	});
    }
  
    </script>
</body>
</html>
