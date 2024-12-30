<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 .container {
    width: 100%; /* 부모 모달 창에 맞게 너비 조정 */
    max-width: none; /* 최대 너비 제한 해제 */
    height: auto; /* 높이는 콘텐츠에 따라 자동 조정 */
    margin: 0; /* 모달 내부에 맞게 정렬 */
    border: 1px solid #ddd;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: none; /* 중첩된 그림자를 제거 */
}

/* 내용 섹션 */
.content-section {
    height: 400px; /* 콘텐츠 높이 자동 조정 */
    border: 1px solid #ddd;
    background-color: #fefefe;
    color: #110708;
    border-radius: 5px;
    font-size: 14px;
    line-height: 1.6;
    box-sizing: border-box;
    overflow-y: auto; /* 스크롤 가능 */
    padding: 10px; /* 여백 추가 */
}

/* 텍스트 입력 */
textarea {
    width: 100%;
    height:100%;
    border: none;
    resize: none;
    font-size: 14px;
    line-height: 1.6;
    padding: 5px;
    background-color: transparent;
    color: inherit;
    outline: none;
}

/* 버튼 */
button {
    border: none;
    background-color: #007bff;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 10px;
    align-self: flex-end; /* 버튼을 오른쪽으로 정렬 */
}

    </style>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    </head>
    <body>
        <div class="container">
            <form id="reportForm"method="post">
            <input type="hidden" name="empCode" value="${loginEmp.empCode}">
                <!-- Title Section -->
                <div class="title-section">
                    <div class="title">일일 업무 일지</div>
                </div>
                <!-- Content Section -->
                <div class="content-section">
                    <textarea name="reportContent"  maxlength="600" placeholder="최대 600자까지 입력 가능합니다."></textarea> 
                </div>
                <button type="submit" id="btnSubmit">작성</button>
            </form>
        </div>
    
    <script>
    $(document).ready(function () {
        // 폼 제출 이벤트
        $('#reportForm').on('submit', function (e) {
            e.preventDefault();

            const formData = $(this).serialize();

            $.ajax({
                url: '/emp/dailyReportCreate.do', // 또는 Context Path를 포함한 URL
                type: 'post',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        alert(response.message);
                        $('#controllerModal').removeClass('show');
                    } else {
                        alert(response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX 오류 상태:", status);
                    console.error("AJAX 오류 메시지:", error);
                    console.error("AJAX 응답 내용:", xhr.responseText);
                    alert('등록 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    });
  
    </script>
</html>