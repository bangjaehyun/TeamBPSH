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
	gap:10px;
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

/* 공통 버튼 스타일 */
.documentType,
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
    display: inline-block; /* 체크박스와 버튼의 동일한 배치 */
    text-align: center;
}

/* 호버 상태 */
.documentType:hover,
#dailyReport:hover {
    background-color: #007bff;
    color: #ffffff;
}

/* 클릭(활성화) 상태에서도 스타일 유지 */
.documentType:active,
#dailyReport:active {
    background-color: #ffffff;
    color: #007bff;
    transform: none; /* 눌렸을 때 변형되지 않도록 */
}

/* 체크박스 스타일 조정 (documentType 내부) */
.documentType input[type="checkbox"] {
    margin-right: 10px; /* 체크박스와 텍스트 간의 간격 */
    transform: scale(1.2); /* 체크박스 크기 조정 */
    cursor: pointer;
}
/* 버튼 크기와 위치를 고정 */
#dailyReport {
    position: relative; /* 버튼의 위치를 고정 */
    display: block; /* 인라인 요소의 크기를 명확히 지정 */
    margin: 0 auto; /* 수평 중앙 정렬 */
    width: auto; /* 버튼 너비를 고정 */
    height: auto; /* 버튼 높이를 고정 */
}

/* 버튼의 클릭 후에도 스타일이 유지되도록 설정 */
#dailyReport:focus,
#dailyReport:active {
    outline: none; /* 클릭 후 발생하는 윤곽선을 제거 */
    box-shadow: none; /* 클릭 시 버튼 주변 그림자를 제거 */
    background-color: #ffffff; /* 활성화 상태에서도 배경 유지 */
    color: #007bff; /* 텍스트 색상 유지 */
}



</style>
</head>
<body>
	<div class="calDiv">
		<input id="empCode" type="hidden" name="empCode" value="${loginEmp.empCode}">
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
			<c:forEach var="docList" items="${documentList}">
			<div id="result">
			<input type="checkbox" name="${docList.documentTypeCode}">${docList.documentTypeName}
			</div>
			</c:forEach>
			
		</div>
		<div id="calendar"></div>
	</div>
	

	<script
		src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
	<script>
		
		$(document).ready(function() {
			var empCodeEl = $('#empCode').val();
			$.ajax({
				url : '/doc/apiPageDocType',
				type : 'post',
				data : {'empCode' : empCodeEl},
				success : function(res){
					console.log(res);
				},
				error : function(){
					console.log('ajax오류');
				}
			});
			
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
													events : function(info,successCallback,failCallback) {
														eventDoc(
																'/project/api/projectList.do?teamCode=${loginEmp.teamCode}',
																'#99CCFF',
																successCallback,failCallback);
													}
												},
												{
													events : function(info,successCallback,failCallback) {
														eventDoc(
																'/doc/api/documentType.do?empCode=${loginEmp.empCode}',
																'#CCCCFF',
																successCallback,failCallback);
													}
												}
												//휴가 결제 완료 후 받아오기
												/*
										{
											events: function (info, successCallback, failCallback) {
												eventDoc(
														'/doc/api/documentType.do?empCode=${loginEmp.empCode}',
														'#222',
														successCallback,failCallback
												);
												
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
		
		
		$(document).ready(function () {
		    let isUpdateMode = false;

		    // 작성/수정 버튼 클릭
		    $('#dailyReport').on('click', function (e) {
		        e.preventDefault();
		        const empCode = $('#empCode').val();
		        const url = isUpdateMode
		            ? '/emp/dailyReportUpdateForm.do'
		            : '/emp/dailyReportWrite.do';

		        $.ajax({
		            url: url,
		            type: 'post',
		            data: { empCode: empCode },
		            success: function (response) {
		                $('#modalContent').html(response);
		                $('#controllerModal').addClass('show');
		            },
		            error: function () {
		                alert('데이터를 불러오는 중 오류가 발생했습니다.');
		            }
		        });
		    });
		    
		    // 상태 확인 (등록/수정 모드 설정)
		    function checkDailyReportStatus(empCode) {
		        $.ajax({
		            url: '/emp/dailyReportCheck.do',
		            type: 'post',
		            data: { empCode: empCode },
		            dataType: 'json', // 서버가 JSON을 반환해야 함
		            success: function (response) {
		                if (response) { // true: 수정 가능 상태
		                    $('#dailyReport').text('일일 업무일지 수정'); // 버튼 상태 변경
		                    isUpdateMode = true; // 수정 모드 활성화
		                } else { // false: 작성 가능 상태
		                    $('#dailyReport').text('일일 업무일지 작성');
		                    isUpdateMode = false; // 등록 모드 활성화
		                }
		            },
		            error: function (xhr, status, error) {
		                console.error("AJAX 오류:", status, error);
		                alert('상태 확인에 실패했습니다. 다시 시도해주세요.');
		            }
		        });
		    }

		    // 페이지 로드 시 상태 확인
		    const empCode = $('#empCode').val();
		    checkDailyReportStatus(empCode);
		});

	</script>
</body>
</html>