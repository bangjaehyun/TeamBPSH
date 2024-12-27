<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>



<%-- 달력 오픈소스 주소 --%>
<style>
.calDiv {
	display: flex;
	justify-content: center;
	width: calc(100vw - 55px);
	height: calc(100vh - 50px);
}

#calendar {
	margin: auto 0;
	width: 80%;
}

.divEl{
	display:flex;
}

.modal {
    display: none; /* 기본적으로 숨김 */
    position: fixed; /* 화면 중앙에 고정 */
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1050; /* 다른 요소보다 위에 표시 */
    width: 90%; /* 화면 너비의 90% */
    max-width: 1100px; /* 최대 너비 제한 */
    height: 80%; /* 화면 높이의 80% */
    max-height: 700px; /* 최대 높이 제한 */
    background: #fff; /* 흰색 배경 */
    border-radius: 10px; /* 둥근 모서리 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    overflow: hidden; /* 내용 넘침 숨김 */
}

/* 모달 활성화 */
.modal.show {
    display: block; /* 보이도록 변경 */
}

/* 모달 내용 정렬 */
.modal-dialog {
    padding: 20px;
    height: 100%; /* 모달 내부 높이 100% */
    display: flex;
    flex-direction: column; /* 세로 정렬 */
}

/* 모달 헤더 */
.modal-header {
    display: flex;
    justify-content: space-between; /* 제목과 닫기 버튼 양쪽 정렬 */
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ddd; /* 하단 구분선 */
    margin: 0;
    font-size: 20px;
    color: #333;
}


/* 닫기 버튼 스타일 */
.close {
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    background: none;
    border: none;
    color: #333;
    transition: color 0.3s ease;
}

.close:hover {
    color: red; /* 닫기 버튼 호버 시 빨간색 */
}

/* 모달 본문 */
.modal-body {
    padding: 20px;
    overflow-y: auto; /* 내용이 많을 경우 스크롤 활성화 */
    flex-grow: 1; /* 남은 공간을 채움 */
    font-size: 16px;
    line-height: 1.6;
    color: #333;
}

/* 문서 종류 사이드바 */
.divEl {
	display:flex;
    width: 250px; /* 고정된 너비 */
    background-color: #007bff; /* 사이드바 배경색 */
    color: white;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    gap: 15px; /* 항목 간 간격 */
}

.divEl  {
    font-size: 18px;
    margin-bottom: 20px;
    color: #ffffff;
}

/* 문서 종류 항목 스타일 */
.documentType {
    display: flex;
    align-items: center; /* 텍스트와 체크박스 수직 정렬 */
    gap: 10px; /* 체크박스와 텍스트 간격 */
}
#dailyReport {
    background-color: #ffffff; /* 기본 배경색 */
    color: #007bff; /* 기본 글자색 */
    padding: 10px 20px;
    border: 2px solid #007bff; /* 테두리 */
    border-radius: 5px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease;
}

/* 호버 상태 */
#dailyReport:hover {
    background-color: #007bff;
    color: #ffffff;
}

/* 클릭(활성화) 상태에서도 스타일 유지 */
#dailyReport:active {
    background-color: #ffffff;
    color: #007bff;
    transform: none; /* 눌렸을 때 변형되지 않도록 */
}


</style>
</head>
<body>
	<div class="calDiv">
		<input type="hidden" name="empCode" value="${loginEmp.empCode}">
		<input type="hidden" name="teamCode" value="${loginEmp.teamCode}">
		<div class="divEl">
			<button type="button"  class="documentType" id="dailyReport">일일 업무일지 작성</button>
			<div class="modal" id="controllerModal">
				<div class="modal-dialog">
					<div class="modal-header">

						<span class="close" id="closeModalController">X</span>
					</div>
					<div class="modal-body" id="modalContent">
						<!-- 서버에서 데이터를 불러옵니다 -->
						<p>데이터를 불러오는 중...</p>
					</div>
				</div>
			</div>
			
			<div class="documentType"><input type="checkbox">문서 종류</div>
			<div class="documentType"><input type="checkbox">문서 종류</div>
			<div class="documentType"><input type="checkbox">문서 종류</div>
			<div class="documentType"><input type="checkbox">문서 종류</div>
			<%--<c:forEach var="documentTypeName" items="${documentTypeList}">
				
			</c:forEach> --%>
			
		</div>
		<div id="calendar"></div>
	</div>
	</div>

	<script
		src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
	<script>
		$(document).ready(function() {
			var calendarEl = document.getElementById('calendar');
							// 공통 AJAX 처리 함수
							function eventDoc(url, color, successCallback,failCallback) {
								$.ajax({
										url : url,
										type : 'POST',
										dataType : 'json',
										success : function(data) {
											var events = data.map(function(item) {
												return {
													id : item.projectNo|| item.documentCode,
													title : item.projectTitle|| item.documentTitle,
													description : item.projectContent|| item.documentContent,
													start : item.documentDate,
													end : item.projectEnd|| null,
													color : color
														};
											});
												successCallback(events);
											},
											error : function() {
												failCallback("오류");
											}
										});
							}

							var calendar = new FullCalendar.Calendar(
									calendarEl,
									{
										initialView : 'dayGridMonth',
										headerToolbar : {
											start : 'today prev',
											center : 'title',
											end : 'next dayGridMonth,dayGridWeek,dayGridDay'
										},
										titleFormat : function(date) {
											return date.date.year
													+ '년 '
													+ (parseInt(date.date.month) + 1)
													+ '월';
										},
										eventSources : [
												{
													events : function(info,
															successCallback,
															failCallback) {
														eventDoc(
																'/project/api/projectList.do?teamCode=${loginEmp.teamCode}',
																'#99CCFF',
																successCallback,
																failCallback);
													}
												},
												{
													events : function(info,
															successCallback,
															failCallback) {
														eventDoc(
																'/doc/api/documentType.do?empCode=${loginEmp.empCode}',
																'#CCCCFF',
																successCallback,
																failCallback);
													}
												}
										/* 휴가 결제 후 완료 되면 받아오기
										{
											events: function (info, successCallback, failCallback) {
												
											}
										}
										 */
										],
										navLinks : true,
										nowIndicator : true,
										locale : 'ko'
									});

							calendar.render();
						});
		/*
		$(document).ready(function(){
			$('#openModal').on('click',function(){
				swal({
					title : "일일 업무 일지",
					text : "업무내용을 입력하세요",
					content : {
						element : "textarea",
						attributes:{
							placeholder : "최대 600자 입력 가능합니다.",
							maxlenght : 600,
							rows : 5,
							cols : 40,
						},
					},
					button : {
						cancel : "취소",
						confirm : {
							text : "작성",
							closeModal : false
						
					}
					}
				}).then((value) => {
					if(!value){
						swal("취소됨","작업이 취소되었습니다.","info");
						return;
					}
					
					$.ajax({
						url : '/emp/dailyReportCreate.do',
						type : 'post',
						contentType : 'application/json',
						data : JSON.stringfy({
							reportContent : value,
						}),
						success : function(res){
							if(res.success){
								swal("성공", res.message,"success");
							}else {
								swal("실패",res.message,"error");
							}
						},
						error : function(){
							swal("오류","ajax오류","error");
						}
					});
				});
			});
		});	
		*/
		
		$(document).ready(function() {
			// 모달 창 열기
			$('#dailyReport').on('click', function() {
				$('#controllerModal').addClass('show'); // 모달 창 표시

				// AJAX로 Spring 컨트롤러에 요청
				$.ajax({
					url : '/emp/dailyReportWrite.do', // 컨트롤러 경로
					type : 'post', // 또는 POST
					success : function(data) {
						// 가져온 데이터를 모달 창에 삽입
						$('#modalContent').html(data);
					},
					error : function() {
						$('#modalContent').html('<p>데이터를 불러오지 못했습니다.</p>');
					}
				});
			});

			// 모달 창 닫기
			$('#closeModalController').on('click', function() {
				$('#controllerModal').removeClass('show');
			});
		});	
		/*
		$('#dailyReport').on('click', function () {
		    // 팝업 창 URL 및 옵션 설정
		    var popupUrl = "/emp/dailyReportWrite.do"; // 이동할 JSP 페이지 경로
		    var popupOptions = "width=800,height=600,resizable=yes,scrollbars=yes";
		    
		    // 팝업 창 열기
		    window.open(popupUrl, "dailyReport", popupOptions);
		});
			
		    if (popup) {
		        // 팝업 창이 정상적으로 열렸을 경우, URL 설정
		        popup.location.href = popupUrl;
		        popup.focus(); // 팝업 창 활성화
		    } else {
		        // 팝업 창이 차단되거나 열리지 않은 경우 처리
		        swal({
		            title: "팝업 차단",
		            text: "팝업 창을 열 수 없습니다. 팝업 차단 설정을 확인해주세요.",
		            icon: "error",
		        });
		    }
		 */
	</script>
</body>
</html>