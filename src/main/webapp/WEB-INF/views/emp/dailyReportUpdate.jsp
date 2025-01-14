<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
    <body>
        <div class="container">
            <form id="dailyReportForm"  method="post">
            <input type="hidden" name="EmpCode" value="${loginEmp.empCode}">
                <!-- Title Section -->
                <div class="title-section">
                    <div class="title">${loginEmp.empCode}일일 업무 일지</div>
                </div>
                <!-- Content Section -->
                <div class="content-section">
                    <textarea name="reportContent"  maxlength="600" placeholder="최대 600자까지 입력 가능합니다.">${dailyReport.reportContent}</textarea> 
                </div>
                <button id="btnSubmit" data-action="create">수정</button>
            </form>
        </div>
        <script>
        $(document).ready(function () {
            // 폼 제출 이벤트
            $('#dailyReportForm').on('submit', function (e) {
                e.preventDefault();

                const formData = $(this).serialize();

                $.ajax({
                    url: '/emp/dailyReportUpdate.do', // 또는 Context Path를 포함한 URL
                    type: 'post',
                    data: formData,
                    dataType: 'json',
                    success: function (response) {
                        if (response.success) {
                        	swal({
    	                        title: "완료",
    	                        text: "일일 업무일지 수정이 완료되었습니다.",
    	                        icon: "success"
    	                    }).then(function() {
    	                    	$('#controllerModal').removeClass('show');
    	                    });
                            
                        } else {
                        	swal({
    	                        title: "실패",
    	                        text: "일일 업무일지 수정 중 오류가났습니다.",
    	                        icon: "error"
    	                    }).then(function() {
    	                    	$('#controllerModal').removeClass('show');
    	                    });
                        }
                    },
                    error: function () {
                        alert('등록 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
        });
        </script>
    </body>
</html>