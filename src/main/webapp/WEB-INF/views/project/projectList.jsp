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


/* 테이블 */

.page-wrap {
    justify-content: center;
    width:100%;
    gap: 10px;
	
	
}
#pjHead{
	margin : 0 auto;
    height: 100px; 
    width: 80%;
    min-width: 1000px;
    display: flex;
    justify-content: space-between; /* 양쪽으로 정렬 */
    align-items: center; /* 세로 정렬 */
    position: relative; /* 자식 요소의 배치를 위해 설정 */
	
	}
#pjHead>h1 {
	position: absolute;
    left: 50%; /* 부모의 가로 중앙으로 이동 */
    transform: translateX(-50%); /* 가운데 정렬 */
    text-align: center;
}
#pjBtn {
   margin-left: 300px;; /* 오른쪽으로 정렬 */ 
   margin-left: auto; /* 오른쪽으로 정렬 */
   text-align: right; /* 내부 요소 오른쪽 정렬 */
   border:1px solid #fff;
   background: #007EF7;
   border-radius: 15px;
   padding:15px;
   color:#fff;
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
	<div id="pjHead">
	<h1>프로젝트 리스트</h1>
	<div id="pjBtn">신규</div>
	</div>
	
		<table class="tbl tbl-hover">
			<thead>
				<tr>
					<th>프로젝트 번호</th>
					<th>프로젝트 이름</th>
<!-- 					<th>프로젝트 책임자</th> -->
					<th>프로젝트 공정률</th>
					<th>프로젝트 마감일</th>
				</tr>
			</thead>
			<tbody id="projectList">
				<c:forEach var="project" items="${projectList}">
					<tr onclick="projectView('${project.projectNo}')">
						<td>${project.projectNo}</td>
						<td>${project.projectTitle}</td>
<%-- 						<td>${project.teamLeader}</td> --%>
						<td>공정률</td>
						<td>${project.projectEnd}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script>
	
	  function projectView(projectNo) {
		console.log(projectNo);
		pageMoveParam('/project/view.do',{ projectNo: projectNo,
										   teamCode : '${loginEmp.teamCode}'});
    }
	  
	 $('#pjBtn').on('click',function(){
		 pageMove('/project/writeFrm.do');
	 });
	  
	
	</script>
</body>
</html>