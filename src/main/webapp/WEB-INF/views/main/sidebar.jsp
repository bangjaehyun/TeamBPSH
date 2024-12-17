<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
  <style>
        *{
            padding: 0px;
            margin: 0px;
        }
        .side-bar{
        	position : relative;
        	z-index : 9999;
            height: calc(100vh - 50px);
            width: 55px;
            background-color: #CCCCCC;
            position : absolute;
            bottom : 0;
            padding-top: 10px;
        }
        .side-sub{
          	display: none;
          	position: absolute;
        	top : 0;
			left: 100%;
			width : 200px;
			background: #5D5C5C;
        }
        
        .side-sub > li > a{
        	text-decoration: none;
        	color: white;
        	margin: 0px;
        }
        
        .side-sub > li:hover{
        	background: red;
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
        	width : 40px;
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
        	font-weight : bold;
        	font-size: 13px;
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
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">문서</p>
				</div>
				<ul class="side-sub">
					<li>a</li>
					<li>b</li>
					<li>c</li>
					<li>d</li>
				</ul>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">문서</p>
				</div>
				<ul class="side-sub">
					<li>e</li>
					<li>f</li>
					<li>g</li>
					<li>h</li>
				</ul>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">문서</p>
				</div>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">문서</p>
				</div>
			</li>
			<li class="side-li">
				<div class="side-div">
					<div class="img-div"><img class="side-img" src="/resources/images/side-project.png" /></div>
					<p class="side-text">관리자</p>
				</div>
				<ul class="side-sub">
					<li><a href="javascript:void(0)" onclick="empWait()">회원관리</a></li>
					<li>문서관리</li>
					<li>매출관리</li>
				</ul>
			</li>
		</ul>
    </div>
    <script>
    function empWait(){
    	
    	 $.ajax({
             url : "/emp/empWait.do",
             type : "post",
             success : function(res) {
                $('.page').html(res);
             },
             error : function() {
                console.log('ajax error');
             }
          });
//       let f = document.createElement('form');
//     	f.setAttribute('method', 'post');
//     	f.setAttribute('action', '/emp/empWait.do');
//     	document.body.appendChild(f);
//     	f.submit();
    }
    $('.side-div').next().find('li').click(function(){
    	$('.side-div').next().css('display','none');
    })
    
    
    	$('.side-div').click(function(e){
    		  $('.side-div').next().css('display','none');
    		  $('.side-div').removeClass("div-color");
    		  $(this).addClass("div-color");
    		  
    		  $(this).next().css('display','block');
    	});
    
    //3번째 li 태그 달력으로 이동
    $('.side-li:nth-child(3)').on('click',function(){
        $.ajax({
            url : "/emp/calendar.do",
            type: "post",
            success : function(res) {
                $('.page').html(res);
                

            }
            , error : function() {
                console.log('ajax 통신 오류');
            }
        });
    });
    	
    </script>
</body>
</html>
