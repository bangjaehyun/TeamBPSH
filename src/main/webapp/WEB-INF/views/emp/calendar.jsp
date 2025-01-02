<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
/* 전체 레이아웃 스타일 */
/* 전체 레이아웃 스타일 */
.calDiv {
    display: flex;
    justify-content: center;
    width: calc(100vw - 55px);
    height: calc(100vh - 50px);
    gap: 10px;
}

#calendar {
    margin: auto 0;
    width: 80%;
}

/* 사이드바 스타일 */
.divEl {
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    gap: 15px; /* 항목 간 간격 */
    width: 250px; /* 고정된 너비 */
    background-color: #fff; /* 사이드바 배경색 */
    color: white;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    font-size: 18px;
    color: #ffffff;
}

/* 공통 버튼 및 label 스타일 */
.button-style {
	width: 210px;
    display: block; /* 세로 배치 */
    padding: 10px 20px; /* 버튼 및 label의 패딩 */
    margin: 0; /* 기본 마진 제거 */
    background-color: #C760E3; /* 기본 배경색 */
    color: #007bff; /* 기본 글자색 */
    border-radius: 10px;
    font-size: 14px; /* 글자 크기 */
    font-weight: bold; /* 글자 굵기 */
    text-align: center; /* 텍스트 중앙 정렬 */
    cursor: pointer; /* 마우스 커서 스타일 */
    box-sizing: border-box; /* 크기 계산 방식 */
    transition: background-color 0.3s ease, color 0.3s ease; /* 부드러운 효과 */
}

/* 버튼 및 label 간 간격 */
.button-style + .button-style {
    margin-top: 10px;
}

/* 호버 상태 */
.button-style:hover {
    background-color: #007bff;
    color: #ffffff;
}

/* 클릭 상태 초기화 */
.button-style:active {
    background-color: #ffffff;
    color: #007bff;
    transform: none; /* 크기 변화 방지 */
    padding: 10px 20px; /* 패딩 초기화 */
    outline: none; /* 클릭 시 테두리 제거 */
    box-shadow: none; /* 클릭 시 그림자 제거 */
}

/* 체크박스 숨기기 */
#result input[type="checkbox"] {
    display: none;
}

/* 체크박스 선택 시 label 스타일 변경 */
#result input[type="checkbox"]:checked + label {
    background-color: #007bff;
    color: #ffffff; /* 체크 상태에서도 기본 글자색 유지 */
    border-color: #007bff; /* 테두리 색상 유지 */
}
/* 호버 상태 */
.button-style:hover {
    background-color: #007bff;
    color: #ffffff;
}

/* 모달 스타일 */
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

/* 모달 헤더 */
.modal-header {
    display: flex;
    justify-content: space-between; /* 제목과 닫기 버튼 양쪽 정렬 */
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ddd; /* 하단 구분선 */
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

</style>
</head>
<body>
	<div class="calDiv">
		<input id="empCode" type="hidden" name="empCode" value="${loginEmp.empCode}">
		<input type="hidden" name="teamCode" value="${loginEmp.teamCode}">
		<div class="divEl">
			<div id="result">
			<span class="button-style" id="dailyReport">일일 업무일지 작성</span>
			</div>
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
			
		</div>
		<div id="calendar"></div>
	</div>
	

	<script
		src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
	<script>
		
		$(document).ready(function() {
			$.ajax({
		        url: '/doc/apiPageDocType',
		        type: 'POST',
		        success: function (response) {
		            var container = document.getElementById('result');
		            if (!container) {
		                console.error("컨테이너 요소를 찾을 수 없습니다.");
		                return;
		            }
					
		            var dynamicElements = container.querySelectorAll('input[type="checkbox"], label');
		            dynamicElements.forEach(function (element) {
		                element.remove(); // 기존 체크박스와 label 제거
		            });
		            

		            response.forEach(function (doc) {
		            	var input = document.createElement('input');
		                input.type = 'checkbox';
		                input.id = doc.documentTypeCode;
		                input.name = doc.documentTypeCode;
		                

		                var label = document.createElement('label');
		                label.htmlFor = doc.documentTypeCode; // input과 연결
		                label.className = 'button-style'; // 공통 버튼 스타일 추가
		                label.textContent = doc.documentTypeName; // 텍스트 추가
						
		                container.appendChild(input);
		                container.appendChild(label);
		            });
		        },
		        error: function () {
		            console.error('AJAX 요청 오류');
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
													// 두 번째 이벤트 소스 (색상 동적 설정)
										            events: function(info, successCallback, failCallback) {
										                $.ajax({
										                    url: '/doc/api/documentType.do?empCode=${loginEmp.empCode}',
										                    type: 'POST',
										                    dataType: 'json',
										                    success: function(data) {
										                        const documentTypeColors = {
										                            "va": "#FFCCCC",
										                            "co": "#CCCCFF",
										                            "es": "#CCFFCC",
										                            "bt": "#FFCCFF",
										                            "sp": "#DDCCFF"
										                        };

										                        var events = data.map(function(item) {
										                            const color = documentTypeColors[item.documentTypeCode] || '#FFFFFF';
										                            return {
										                                id: item.documentCode,
										                                title: item.documentTitle,
										                                start: item.documentDate,
										                                end: item.documentEnd || null,
										                                color: color,
										                                extendedProps: {
										                                    documentTypeCode: item.documentTypeCode,
										                                    empCode : item.empCode,
										                                	documentCode : item.documentCode    
										                                }
										                            };
										                        });
										                        console.log(events);
										                        successCallback(events);
										                    },
										                    error: function() {
										                        console.error("두 번째 이벤트 소스 AJAX 요청 실패");
										                        failCallback("오류");
										                    }
										                });
												}
											}
										 
										],
										navLinks : true,
										nowIndicator : true,
										locale : 'ko',
										eventClick: function(info) {
										        const empCode = info.event.extendedProps.empCode;
										        const documentTypeCode = info.event.extendedProps.documentTypeCode;
										        const documentCode = info.event.extendedProps.documentCode;

										        if (empCode && documentCode) {
										            // URL과 파라미터 준비
										            const targetUrl = '/doc/viewDocOne.do';
										            const params = {
										                empCode: empCode,
										                documentTypeCode: documentTypeCode,
										                documentCode: documentCode
										            };

										            // 페이지 이동 메서드 호출
										            pageMoveParam(targetUrl, params);
										        } else {
										            alert('필요한 정보가 없습니다.');
										        }
										    }
										});

							calendar.render();
	
	//사이드 바에서 문서타입 클릭시 fullcalendar에서 이벤트 제거
    // 체크박스 change 이벤트
    $('#result').on('change', 'input[type="checkbox"]', function() {
        const documentType = $(this).attr('id'); // 체크박스의 데이터 타입 가져오기
        const isChecked = $(this).is(':checked'); // 체크 상태 확인
        const events = calendar.getEvents(); // FullCalendar의 모든 이벤트 가져오기
		
        if (!isChecked) {
            // 체크박스 체크 시 이벤트 표시
            events.forEach(event => {
                if (event.extendedProps.documentTypeCode === documentType) {
                    event.setProp('display', 'auto'); // 이벤트 표시
                }
            });
        } else {
            // 체크박스 해제 시 이벤트 숨기기
            events.forEach(event => {
                if (event.extendedProps.documentTypeCode === documentType) {
                    event.setProp('display', 'none'); // 이벤트 숨기기
                }
            });
        }
    });
		
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
		                $('#dailyReport').blur(); // 클릭 후 포커스 제거
		                
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
		    
		    $('#closeModalController').on('click', function() {
		        $('#controllerModal').removeClass('show');
		        $('#dailyReport').blur(); // 닫기 시 포커스 제거
		    });
		});

	</script>
</body>
</html>