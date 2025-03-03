<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<!-- 메시지 API -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 구글폰트 적용 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<!-- 공통 css -->
<link rel="stylesheet" href="/resources/css/default.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet"
   href="https://fonts.googleapis.com/icon?family=Material+Icons"
   type="text/css;" />
   <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
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
        	display : flex;
        	width: 300px;
        	min-width: 280px;
        }
        .header-right{
        	margin-right : 10px;
        	display: flex;	
        }
        .header-my{
        	cursor: pointer;
        	margin: auto 15px;
        	height: 40px;
        }
        
        .header-notification{
        	cursor: pointer;
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
       		display : none;
       		align-content : center;
       		text-align: center;
       		width: 20px;
       		height: 20px;
       		border-radius: 10px;
       }
       .notification-count>span{
       		color: white;
       }
       
       .alarmAct {
       	 visibility : visible;
       	 height : 150px;
  		 transition:.5s;
       }
       
       .alarmNoRead{
       	background: #fdf0b3;
       }
       
       .alarmMsg{
       		margin : auto 1px;
       		text-decoration: none;
       		color : black;
       		font-size: 15px;	
       		margin: auto 5px;
       }
       
       .alarmDiv{
       		height: 30px;
       		display: flex;
       		justify-content: flex-start;
       		border-bottom: 1px solid black;
/*        		margin : 0 5px; */
       }
       
       .logoName{
       		margin: auto 0;
       		font-size: 20px;
       		font-weight: bold;
       		background: linear-gradient(to bottom, #7f01da, #eb85fd);
  			-webkit-background-clip: text;
  			-webkit-text-fill-color: transparent;
  			font-style:italic; 
       }
    </style>
</head>

<header>
    <div class="header-wrap">
        <div class="header-left">
            <img onclick="toggle()" class="header-toogle"  src="/resources/images/exchange.png">
            <a href="javascript:void(0)" class="mainPage"><img class="header-img" src="/resources/images/logoImg.png"></a>
            <span class="logoName">BHP SYSTEM</span>
        </div>
           <div class="header-right">
           	<img class="header-notification" src="/resources/images/notification.png">
           	<div class="notification-count">
           		<span>0</span>
           	</div>
            <img class="header-my" src="/resources/images/person.png">
        </div>                
    </div>
</header>
<script>
	$(document).ready(function(){
		let alarmCount = ${loginEmp.alarmCount}
		if(alarmCount > 0){
		    if($('.notification-count').css('display') == "none"){
		    	$('.notification-count').css('display', 'inline-block');
		    	$('.notification-count').children().html(alarmCount);
		    }
		}
	});
	//login시 sse로 empCode 전달하여 관리
	const eventSource = new EventSource("/emitter?empCode=${loginEmp.empCode}");//controller 경로
	
	//server에서 메시지 올시 알람 count 증가 처리
	eventSource.onmessage = (event) => { //데이터를 받아옴
		if(Number($('.notification-count').children().html()) < 99){
		    if($('.notification-count').css('display') == "none"){
		    	$('.notification-count').css('display', 'inline-block');
		    	$('.notification-count').children().html( Number($('.notification-count').children().html()) + 1);
		    }else{
		    	$('.notification-count').children().html( Number($('.notification-count').children().html()) + 1);
		    }
		}
	};
	<%-- 
 	eventSource.onerror = (error) => {
 	    console.error("Error occurred:", error);
 	    eventSource.close();
 	};
    --%>
	$('.header-my').on('click',function(){
		if($('.myPage').hasClass('act')){
			$('.myPage').removeClass('act');
		}else{
			$('.myPage').addClass('act');
			
			if($('.alarm-wrap').hasClass('alarmAct')){
				$('.alarm-wrap').removeClass('alarmAct');
				$('.alarm').children().remove();
			}
		}
	});
	
	let alarmStartCount = 1;
	let alarmEndCount = 5;
	
	$('.header-notification').on('click',function(){
		startCount = 1;
		endCount = 5;
		
		if($('.alarm-wrap').hasClass('alarmAct')){
			$('.alarm-wrap').removeClass('alarmAct');
			$('.alarm').children().remove();
		}else{
			if($('.myPage').hasClass('act')){
				$('.myPage').removeClass('act');
			}
			$('.alarm-wrap').addClass('alarmAct');
			$.ajax({
				url : "/emp/loadAlarmList.do",
				type : "post",
				data : {"empCode" : "${loginEmp.empCode}",
						"startCount" : startCount,
						"endCount" : endCount},
				success : function(res){
					for(let i in res.alarmList){
						
						let	data = res.alarmList[i];
						let divEl = $('<div></div>');
						let aEl = $('<a href=javascript:void(0)></a>');
						aEl.attr("onclick", "alarmMove("+"'"+data.alarmNo+"','"+data.refUrl+"','"+data.urlParam+"','" + data.alarmRead +"')");
						 
						
						aEl.html(data.alarmComment);
						aEl.attr('class', 'alarmMsg');
						divEl.attr('class', 'alarmDiv');
						divEl.attr('id',data.alarmNo);
						if(data.alarmRead == "n"){
							divEl.addClass("alarmNoRead");
						}
						divEl.append(aEl);
						
						$('.alarm').append(divEl);
					}
					
					if(endCount < res.totalCount){
						$('.alarmMore').css('display','block');
						startCount += 5
						endCount += 5;
					}else{
						$('.alarmMore').css('display','none');
					}
				},
				error : function(){
					console.log("ajax 오류");
				}
			});
		}
	});
	
	
	function alamrMore(){
		$.ajax({
			url : "/emp/loadAlarmList.do",
			type : "post",
			data : {"empCode" : "${loginEmp.empCode}",
					"startCount" : startCount,
					"endCount" : endCount},
			success : function(res){
				for(let i in res.alarmList){
					
					let	data = res.alarmList[i];
					let divEl = $('<div></div>');
					let aEl = $('<a href=javascript:void(0)></a>');
					aEl.attr("onclick", "alarmMove("+"'"+data.alarmNo+"','"+data.refUrl+"','"+data.urlParam+"','" + data.alarmRead +"')");
					 
					
					aEl.html(data.alarmComment);
					aEl.attr('class', 'alarmMsg');
					divEl.attr('class', 'alarmDiv');
					divEl.attr('id',data.alarmNo);
					if(data.alarmRead == "n"){
						divEl.addClass("alarmNoRead");
					}
					divEl.append(aEl);
					
					$('.alarm').append(divEl);
				}
				
				if(endCount < res.totalCount){
					$('.alarmMore').css('display','block');
					startCount += 5
					endCount += 5;
				}else{
					$('.alarmMore').css('display','none');
				}
			},
			error : function(){
				console.log("ajax 오류");
			}
		});
	}
	
	function alarmMove(alarmNo ,url, param, alarmRead){
		$('.alarm-wrap').removeClass('alarmAct');
		$('.alarm').children().remove();
		startCount = 1;
		endCount = 5;
		
		if(alarmRead == 'n'){
			alarmChangeRead(alarmNo);
		}
		
		 let paramObj = JSON.parse(param);
		
			$.ajax({
				url : url,
				type : "post",
				data : paramObj,
				success : function(res){
					 $('.page').html(res);
				},error : function(){
					console.log("ajax 오류");
				}
			});
	}
	
	function alarmChangeRead(alarmNo){
		console.log(alarmNo)
		$.ajax({
			url : "/emp/alarmRead.do",
			type : "post",
			data : {"alarmNo" : alarmNo},
			success : function(res){
				if(res == "1"){
					$('.notification-count').children().html( Number($('.notification-count').children().html()) - 1);
					$('#'+alarmNo).removeClass('alarmNoRead');
					if(Number($('.notification-count').children().html()) == 0){
						$('.notification-count').css('display','none');
					}
				}
			},error : function(){
				console.log('ajax 오류');
			}
		});	
	}

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
	
	<%--파라미터 없는 페이지 이동--%>
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
	
	
	function pageMoveParam(url, param){
		$('.bgx').css('display','none');
		$.ajax({
	         url : url,
	         type : "post",
	         data : param,
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