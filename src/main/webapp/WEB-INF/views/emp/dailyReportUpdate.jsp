<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    * {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
.container {
    width: 100%;
    max-width: 600px; /* 컨테이너 최대 너비 */
    margin: 20px auto;
    border: 1px solid #ddd;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px; /* 모서리 둥글게 */
    display: flex;
    flex-direction: column; /* 세로 정렬 */
}

/* 제목 섹션 스타일 */
.title-section {
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: 2px solid #007bff;
    padding: 10px 0;
    margin-bottom: 20px;
}

.title {
    font-size: 20px;
    font-weight: bold;
    color: #333333;
}

/* 내용 섹션 스타일 */
.content-section {
    flex-grow: 1; /* 남은 공간을 모두 차지 */
    border: 1px solid #ddd;
    background-color: #fefefe;
    color: #110708;
    border-radius: 5px;
    font-size: 14px;
    line-height: 1.6;
    box-sizing: border-box;
    overflow-y: auto; /* 스크롤 가능 */
    padding: 10px; /* 내부 여백 */
    margin-bottom: 20px; /* 버튼과 간격 */
}

/* 텍스트 입력 스타일 */
textarea {
    width: 100%;
    height: 200px; /* 고정 높이 */
    border: none;
    resize: none; /* 크기 조절 비활성화 */
    font-size: 14px;
    line-height: 1.6;
    padding: 10px;
    background-color: transparent;
    color: #333333;
    outline: none; /* 포커스 시 외곽선 제거 */
    box-sizing: border-box;
}

/* 텍스트 입력 포커스 스타일 */
textarea:focus {
    background-color: #f0f8ff; /* 포커스 시 강조 배경 */
    border: 1px solid #007bff;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 외곽 강조 */
}

/* 버튼 스타일 */
button {
    width: 100%;
    border: none;
    background-color: #007bff;
    color: white;
    padding: 15px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #0056b3;
}
    </style>
    <body>
        <div class="container">
            <form id="reportForm" action="/emp/dailyReportCreate.do" method="post">
            <input type="hidden" name="EmpCode" value="${loginEmp.empCode}">
                <!-- Title Section -->
                <div class="title-section">
                    <div class="title">${loginEmp.empName}일일 업무 일지</div>
                </div>
                <!-- Content Section -->
                <div class="content-section">
                    <textarea name="reportContent"  maxlength="600" placeholder="최대 600자까지 입력 가능합니다.">${dailyReport.reportContent}</textarea> 
                </div>
                <button id="btnSubmit" data-action="create">수정</button>
            </form>
        </div>
    </body>
</html>