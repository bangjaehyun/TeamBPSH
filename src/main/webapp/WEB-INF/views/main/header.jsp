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
            width: 100%;
            height: 50px;
            background: linear-gradient(#99CCFF, #CCCCFF);
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
    </style>
</head>

<header>
    <div class="header-wrap">
        <div class="header-left">
            <img onclick="toggle()" class="header-toogle"  src="/resources/images/exchange.png">
            <img class="header-img" src="/resources/images/logo.png">
        </div>        
    </div>
</header>
<script>
	function callbackMsg(title,msg,icon, callback){
		swal({
			title : title,
			text : msg,
			icon : icon
		}).then(function(){
			location.href = callback;
		});
	}

	//메시지
	function msg(title,msg,icon, callback){
		swal({
			title : title,
			text : msg,
			icon : icon
		});
	}
	
	//기본 페이지 이동
	function pageMove(url){
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