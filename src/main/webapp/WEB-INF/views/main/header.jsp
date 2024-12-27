<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 메시지 API -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 구글폰트 적용 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<!-- 공통 css -->
<link rel="stylesheet" href="/resources/css/default.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet"
   href="https://fonts.googleapis.com/icon?family=Material+Icons"
   type="text/css;" />
    <style>
        *{
            padding: 0px;
            margin: 0px;
        }
        .header-wrap{
        	display : flex;
        	justify-content : space-between;
            width: 100%;
            height: 50px;
            background: #e0e0e0;
        }
        
        .header-img{
            height: 50px;
            background-color:transparent;
        }
        .header-toogle{
            height: 50px;
        }
        .header-left{
        	width: 300px;
        }
        .header-right{
        	margin-right : 10px;
        	display: flex;	
        }
        .header-my{
        	margin: auto 15px;
        	height: 40px;
        }
        
        .header-notification{
        	margin: auto 0;
        	height: 40px;
        }
         
       .act {
       	 visibility: visible;
       	 height : 80px;
       	 opacity: 1;
       }
       
       .notification-count{
       		background : red;
       		display : inline-block;
       		align-content : center;
       		text-align: center;
       		width: 20px;
       		height: 20px;
       		border-radius: 10px;
       }
       .notification-count>span{
       		color: white;
       }
       
    </style>
</head>

<header>
    <div class="header-wrap">
        <div class="header-left">
            <img onclick="toggle()" class="header-toogle"  src="/resources/images/exchange.png">
            <a href="javascript:void(0)" class="mainPage"><img class="header-img" src="/resources/images/logo.png"></a>
        </div>
           <div class="header-right">
           	<img class="header-notification" src="/resources/images/notification.png">
           	<div class="notification-count">
           		<span>1</span>
           	</div>
            <img class="header-my" src="/resources/images/person.png">
        </div>                
    </div>
</header>
<script>
	$('.header-my').on('click',function(){
		if($('.myPage').hasClass('act')){
			$('.myPage').removeClass('act');
		}else{
			$('.myPage').addClass('act');
		}
	})

	<%-- 콜백 있는 메시지 --%>
	function callbackMsg(title,msg,icon, callback){
		swal({
			title : title,
			text : msg,
			icon : icon
		}).then(function(){
			<%-- 자식 창일경우 로그인이 필요하면 종료--%>
			if($(window.opener) != null){
				self.close();
			}
			location.href = callback;
		});
	}

	<%--메시지--%>
	function msg(title,msg,icon, callback){
		swal({
			title : title,
			text : msg,
			icon : icon
		});
	}
	
	//기본 페이지 이동
	function pageMove(url){
		$('.bgx').css('display','none');
		$.ajax({
	         url : url,
	         type : "post",
	         success : function(res) {
	        	try {
	        		const errMsg = JSON.parse(res);
	        		if(errMsg.loc == null){
	        			msg(errMsg.title, errMsg.msg,errMsg.icon);
	        		}else{
	        			callbackMsg(errMsg.title, errMsg.msg,errMsg.icon, errMsg.loc);
	        		}
	        		
	        	} catch (e) {
	        		 $('.page').html(res);
	        	}
	         },
	         error : function() {
	            console.log('ajax error');
	         }
	      });
	}
	
	
</script>

</html>