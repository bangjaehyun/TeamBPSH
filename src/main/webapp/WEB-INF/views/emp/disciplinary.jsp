<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.di-btn {
	width: 80px;
	height: 35px;
	border-radius: 15px;
	border: none;
	background: #d8d8d8;
	color: white;
	font-weight: bold;
	font-size: 20px;
}

.di-btn:hover {
	background: #d3d3d3;
	transform: scale(1.1);
	text-transform: scale(1.1);
}

.btn-div{
	margin : 10px 0;
	text-align: center;
}

.wrap{
	padding : 10px 10px;
	display : flex;
	justify-content: center;
}

.value-wrap{
	width : 100%;
	margin : auto 0;
}
.emp-div{
	height: 40px;
	display: flex;
	align-items: center;
	gap : 10px;
}
.selectType{
	margin: auto 0;
}

.emp-div>input{
	width: 50px;
}

.date{
	display: none;
}

#comment{
	width: 100%;
	height: 60px;
	resize: none;
}

</style>
</head>
<body>
	<div class="wrap">
		<div class="value-wrap">
			<div class="emp-div">
				<span>${empName}</span> 
				<select class="selectType">
					<c:forEach var="type" items="${typeList}">
						<option value="${type.CODE}">${type.NAME}</option>
					</c:forEach>
				</select>
				<input type="number" id="value" min="0" placeholder="일">
				<span id="sub">일</span>
			</div>
			<div class="date">
				<span>종료일</span>
				<input type="date" id="endDay">
			</div>
			<div>
				<div>
					<span>사유</span>
				</div>
				<textarea id="comment"></textarea>
			</div>
			<div class="btn-div">
				<button type="button" class="di-btn" onclick="disciplinary()">징계</button>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function(){
		 const today = new Date().toISOString().split('T')[0];
	     
	      $('#endDay').attr('min', today);
	});
	<%-- 사이즈 변경 못하게 고정 --%>
	$(window).resize(function () {
	    window.resizeTo(500, 350);
	});
	
	$('.selectType').change(function(){
		if(this.value == "su"){
			$('#value').attr('placeholder', '일');
			$('#sub').html('일');
			$('#value').css('display', 'block');
			$('#sub').css('display', 'block');
			$('.date').css('display', 'none');
		}else if(this.value == "cu"){
			$('#value').attr('placeholder', '%');
			$('#sub').html('%');
			$('#value').css('display', 'block');
			$('#sub').css('display', 'block');
			$('.date').css('display', 'block');
		}else{
			$('#sub').css('display', 'none');
			$('#value').css('display', 'none');
			$('.date').css('display', 'none');
		}
	})
	
	
	function disciplinary(){
		let empCode = '${empCode}';
		let typeCode = $('.selectType').val();
		let comment = $('#comment').val();
		let value = $('#value').val();
		let endDay = $('#endDay').val();
		
		if(comment.length < 1){
			msg("확인", "사유를 입력해주세요", "warning");
			return;
		}
		
		if(typeCode == "su"){
			if(value.length < 1){
				msg("확인", "모든 입력값 입력해주세요", "warning");
				return;
			}
		}else if(typeCode == "cu"){
			if(endDay.length < 1 || value.length < 1){
				msg("확인", "모든 입력값 입력해주세요", "warning");
				return;
			}
		}
		<%-- 징계 처리 --%>
		$.ajax({
			url : "/emp/doDisciplinary.do",
			type : "post",
			data : {"empCode" : empCode,
					"typeCode" : typeCode,
					"disReason" : comment,
					"value" : value,
					"disEnd" : endDay},
			success : function(res){
				swal({
					title : "완료",
					text : "징계 처리가 완료되었습니다.",
					icon : "success"
				}).then(function(){
					opener.updatePage();
					self.close();
				});
			},
			error : function(){
				console.log("ajax 오류");
			}
			
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
	

	</script>
</body>
</html>