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
            <form id="reportForm" action="/emp/dailyReportCreate.do" method="post">
            <input type="hidden" name="empCode" value="${loginEmp.empCode}">
                <!-- Title Section -->
                <div class="title-section">
                    <div class="title">일일 업무 일지</div>
                </div>
                <!-- Content Section -->
                <div class="content-section">
                    <textarea name="reportContent"  maxlength="600" placeholder="최대 600자까지 입력 가능합니다."></textarea> 
                </div>
                <button id="btnSubmit"  data-action="create">작성</button>
            </form>
        </div>
    
    <script>
    
    /*
        //하루에 한번 작성 하게 어디서 할지?
        //작성 후 수정만 가능하게 
        window.onbeforeunload = function() {};
        function closePopup() {
            if (confirm('정말로 작업을 종료하시겠습니까?')) {
                window.close(); // 팝업 창 닫기
            }
        }
        
        window.addEventListener('beforeunload', function (event) {
            // 부모 창에 메시지를 전달
            if (window.opener) {
                window.opener.alert('팝업 창이 닫혔습니다. 작업 상태를 확인하세요.');
            }
        });
        */
        $(document).ready(function () {
            // 폼 제출 이벤트
            $('#reportForm').on('submit', function (e) {
                e.preventDefault(); // 기본 폼 제출 방지
				console.log($('input[name=empCode]').val());
                $.ajax({
                    url: '/emp/dailyReportCreate.do',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                          reportContent: $('textarea[name="reportContent"]').val(),
                    }),
                    success: function (res) {
                        // 서버 응답 처리
                        if (res.success) {
                            swal({
                                title: "성공",
                                text: res.message,
                                icon: "success",
                            }).then(function () {
                            	self.close();
                            });
                        } else {
                            swal({
                                title: "실패",
                                text: res.message,
                                icon: "error",
                            });
                        }
                    },
                    error: function () {
                        swal({
                            title: "오류",
                            text: "서버와의 통신 중 문제가 발생했습니다.",
                            icon: "error",
                        });
                    }
                });
            });
        });
        
        window.addEventListener('beforeunload', function (event) {
            // SweetAlert를 표시
            swal({
                title: "창을 닫으시겠습니까?",
                text: "현재 작업이 저장되지 않을 수 있습니다.",
                icon: "warning",
                buttons: ["취소", "닫기"],
                dangerMode: true,
            }).then(function (willClose) {
                if (!willClose) {
                    // 사용자가 닫기를 취소하면 기본 동작을 중단
                    
                } else {
                    // 팝업 창을 정상적으로 닫을 수 있도록 처리
                    window.onbeforeunload = null;
                    window.close();
                }
            });

            // preventDefault()가 브라우저에 따라 작동하지 않을 경우를 대비해 메시지를 반환
            return event.returnValue = "현재 창을 닫으시겠습니까?";
        });
        
        */
    </script>
</html>