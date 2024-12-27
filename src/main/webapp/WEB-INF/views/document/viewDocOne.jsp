<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background-color: #f5f5f5;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            border: 1px solid #ddd;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* 결제자 영역 */
        .approver-container {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-bottom: 10px;
        }

        .approver-box {
            width: 80px;
            height: 40px;
            border: 1px solid #007bff;
            background-color: #e7f3ff;
            color: #0056b3;
            text-align: center;
            line-height: 40px;
            font-size: 12px;
            font-weight: bold;
            border-radius: 5px;
        }

        /* 제목 영역 */
        .title-section {
            display: flex;
            justify-content: center;
            align-items: center;
            border-bottom: 2px solid #007bff;
            padding: 10px 0;
            margin-bottom: 15px;
        }

        .title {
            font-size: 18px;
            font-weight: bold;
            color: #333333;
        }

        /* 정보 영역 */
        .info-section {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            border-bottom: 2px solid #ddd;
            padding: 10px 0;
            gap: 10px;
            text-align: center;
            margin-bottom: 20px;
        }

        .info-box {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .info-box div {
            font-size: 14px;
            color: #555555;
        }

        /* 내용 영역 */
        .content-section {
            margin-top: 20px;
            padding: 15px;
            height: 300px;
            border: 1px solid #ddd;
            background-color: #fefefe;
            color: #333333;
            border-radius: 5px;
            font-size: 14px;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Approver Section -->
        <div class="approver-container" id="approverContainer">
            <!-- 결제자가 동적으로 추가됨 -->
        </div>

        <!-- Title Section -->
        <div class="title-section">
            <div class="title">문서 제목</div>
        </div>

        <!-- Information Section -->
        <div class="info-section">
            <div class="info-box">
                <div>시작일</div>
                <div>마감일</div>
            </div>
            <div class="info-box">
                <div>첨부파일</div>
            </div>
            <div class="info-box">
                <div>작성일</div>
            </div>
        </div>

        <!-- Content Section -->
        <div class="content-section">
            내용
        </div>
    </div>
    <script>
    // 결제자를 동적으로 추가하는 예제
    const approvers = ['결재자1', '결재자2', '결재자3']; // 결재자 목록
    const approverContainer = document.getElementById('approverContainer');
    approvers.forEach(approver => {
        const box = document.createElement('div');
        box.className = 'approver-box';
        box.textContent = approver;
        approverContainer.appendChild(box);
    });
</script>
    
</body>
</html>

