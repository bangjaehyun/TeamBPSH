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
</style>
</head>
<body>
	<div class="calDiv">
	<input type="hidden" name="empCode" value="${loginEmp.empCode}">
	<input type="hidden" name="teamCode" value="${loginEmp.teamCode}">
		<div id="calendar"></div>
	</div>
	<script
		src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
	<script>

	$(document).ready(function () {
	    var calendarEl = document.getElementById('calendar');

	    // 공통 AJAX 처리 함수
	    function eventDoc(url, color, successCallback, failCallback) {
	        $.ajax({
	            url: url,
	            type: 'POST',
	            dataType: 'json',
	            success: function (data) {
	                var events = data.map(function (item) {
	                    return {
	                        id: item.projectNo || item.documentCode,
	                        title: item.projectTitle || item.documentTitle,
	                        description: item.projectContent || item.documentContent,
	                        start: item.documentDate,
	                        end: item.projectEnd || null,
	                        color: color
	                    };
	                });
	                successCallback(events);
	            },
	            error: function () {
	                failCallback("오류");
	            }
	        });
	    }

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        headerToolbar: {
	            start: 'today prev',
	            center: 'title',
	            end: 'next dayGridMonth,dayGridWeek,dayGridDay'
	        },
	        titleFormat: function (date) {
	            return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
	        },
	        eventSources: [
	            {
	                events: function (info, successCallback, failCallback) {
	                	eventDoc('/project/api/projectList.do?teamCode=${loginEmp.teamCode}', '#99CCFF', successCallback, failCallback);
	                }
	            },
	            {
	                events: function (info, successCallback, failCallback) {
	                	eventDoc('/doc/api/documentType.do?empCode=${loginEmp.empCode}', '#CCCCFF', successCallback, failCallback);
	                }
	            }
	            /* 휴가 결제 후 완료 되면 받아오기
	            {
	            	events: function (info, successCallback, failCallback) {
	            		
	            	}
	            }
	            */
	        ],
	        navLinks: true,
	        nowIndicator: true,
	        locale: 'ko'
	    });

	    calendar.render();
	});

	
	</script>
</body>
</html>