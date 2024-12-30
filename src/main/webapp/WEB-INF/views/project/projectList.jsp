<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

/* 테이블 */
.page-wrap {
	width: calc(100vw - 55px);
	height: calc(100vh - 50px);
	padding: 50px;
}

.tbl {
	min-width: 100%;
	width: 100%;
	border-spacing: 0;
}

.tbl th, .tbl td {
	text-align: center;
	border-bottom: 1px solid black;
	padding: 10px 20px;
	min-width: 130px;
}

.tbl th {
	background-color: #f4fedc;
}

.tbl-hover tbody>tr:hover {
	cursor: pointer;
	background-color: rgba(0, 76, 161, 0.1);
}
</style>
</head>
<body>
	<div class="page-wrap">
	<input type="hidden" name="teamCode" value="${loginEmp.teamCode}">
	<input type="hidden" name="projectNo" value="${project.projectNo}">
		<table class="tbl tbl-hover">
			<thead>
				<tr>
					<th>프로젝트 번호</th>
					<th>프로젝트 이름</th>
					<th>프로젝트 책임자</th>
					<th>프로젝트 공정률</th>
					<th>프로젝트 마감일</th>
				</tr>
			</thead>
			<tbody id="projectList">
				<c:forEach var="project" items="${projectList}">
					<tr onclick="projectView('${project.projectNo}')">
						<td>${project.projectNo}</td>
						<td>${project.projectTitle}</td>
						<td>${project.teamLeader}</td>
						<td>0</td>
						<td>${project.projectEnd}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script>
	/*
		function projectView(projectNo){
			const form = document.createElement('form');
			form.method = 'post';
			form.action = '/project/view.do';
			
			const inputEl = document.createElement('input');
			inputEl.type = 'hidden';
			inputEl.name = 'projectNo';
			inputEl.value = projectNo;
			form.appendChild(inputEl);
			
			document.body.appendChild(form);
			form.submit();
		}
	*/
	  function projectView(projectNo) {
        $.ajax({
            url: '/project/view.do',
            type: 'POST',
            data: { projectNo: projectNo },
            success: function(response) {
                // 성공 시 서버에서 받은 HTML을 body에 렌더링
                $('body').html(response);
            },
            error: function(xhr, status, error) {
                console.error("에러 발생:", error);
                alert("프로젝트 정보를 가져오는 데 실패했습니다.");
            }
        });
    }
	
	</script>
</body>
</html>