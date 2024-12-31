<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    .container {
        width: 800px;
        gap : 10px;
        margin: 0 auto;
    }

    table {
    	gap:10px;
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #f4f4f4;
        font-weight: bold;
    }

    .section {
        display: flex;
        margin-bottom: 20px;
    }

    .section .box {
        border: 1px solid #ddd;
        padding: 20px;
        flex: 1;
        margin-right: 20px;
    }

    .section .box:last-child {
        margin-right: 0;
    }

    .participants, .details {
        margin-bottom: 20px;
    }

    .footer {
        border: 1px solid #ddd;
        padding: 20px;
        text-align: center;
    }
</style>
</head>
<body>
    <div class="container">
    <input type="hidden" name="projectNo" value="${project.projectNo}">S
        <h1>프로젝트 상세 정보</h1>
        <!-- 프로젝트 기본 정보 -->
        <table>
            <tr>
                <th>프로젝트 번호</th>
                <td>${project.projectNo}</td>
                <th>프로젝트 이름</th>
                <td>${project.projectTitle}</td>
            </tr>
            <tr>
                <th>프로젝트 책임자</th>
                <td>${project.teamLeader}</td>
                <th>프로젝트 마감일</th>
                <td>${project.projectEnd}</td>
            </tr>
        </table>

        <!-- 참여 사원 리스트 -->
        <div class="participants">
            <h2>참여 사원 리스트</h2>
            <table>
                <thead>
                    <tr>
                        <th>사원 번호</th>
                        <th>이름</th>
                        <th>직급</th>
                        <th>역할</th>
                    </tr>
                </thead>
                <tbody>
                
                
                    <c:forEach var="projectPartempList" items="${projectPartempList}">
                        <tr>
                            <td class="empNo">${projectPartempList.empCode}</td>
                            <td>${projectPartempList.empName}</td>
                            <td>${projectPartempList.rankCode}</td>
                            <td>${projectPartempList.partempContent}</td>
                        </tr>
                    </c:forEach> 
               
                </tbody>
            </table>
        </div>

        <!-- 프로젝트 진행률 및 내용 -->
        <div class="section">
            <div class="box">
                <h2>프로젝트 진행률</h2>
                <canvas id="progressChart" width="400" height="200"></canvas>
            </div>
            <div class="box">
                <h2>프로젝트 내용</h2>
                <p>${project.projectContent}</p>
            </div>
        </div>
		
        <!-- 특이사항 및 첨부파일 -->
        <div class="footer">
            <h2>특이사항 및 첨부파일</h2>
            <%--
            <p>${project.specialNotes}</p>
            <p><a href="${project.attachFileUrl}" target="_blank">첨부파일 다운로드</a></p>
             --%>
        </div>
    </div>
    <script>
    const labels = ['Module 1', 'Module 2', 'Module 3']; // 데이터 확인
    const progressData = [75, 50, 90]; // 진행률 데이터 확인

    if (!labels.length || !progressData.length) {
        console.error("차트 데이터가 비어 있습니다.");
    }
    var projectNo = $('input[name="projectNo"]').val();
    function loadChart() {
        const ctx = document.getElementById('progressChart');

        if (ctx) {
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '진행률 (%)',
                        data: progressData,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100
                        }
                    }
                }
            });
        } else {
            console.error("Canvas 요소를 찾을 수 없습니다.");
        }
    }
//     pageMoveParam('/project/view.do',{ projectNo: projectNo });
    /*
    $.ajax({
        url: '/project/view.do',
        type: 'POST',
        data: { projectNo: projectNo },
        success: function (response) {
            $('body').html(response);
            loadChart(); // HTML이 갱신된 후 차트를 로드
        },
        error: function (xhr, status, error) {
            console.error('에러 발생:', error);
        }
    });
    */
    </script>
</body>
</html>