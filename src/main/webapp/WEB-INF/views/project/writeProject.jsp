<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css"/>
<style>
	
</style>
</head>
<body>
	<div>
		<div>
			<input type="hidden" name="empCode" value="${loginEmp.empCode}">
			<div>
				<form action="/project/write.do" method="post">
					<label>제목</label> 
					<input type="text" name="projectTitle"> 
					<div class="team">
						<p>팀 목록</p>
						<c:forEach var="teamList" items="${teamList}">
							<label>${teamList.teamName}</label>
							<input type="checkbox" name="teamCode">
						</c:forEach>
					</div>
					<div>
					<label>마감일</label> 
					<input type="text" name="projectEnd">
					<div>
					<label>내용</label> 
					<textarea id="summernote" name="projectContent"></textarea>
					</div>
					</div>
					<button type="submit">작성</button>
				</form>
			</div>
		</div>
	</div>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<script>
		function teamCodeArr() {
		var teamCode = [];
			$('input[name="teamCode"]:checked').each(function(i){
				teamCode.push($(this).val());
				console.log('')
		});
		$.ajax({
			url : '/project/write.do',
			type: 'post',
			data : {teamCode : teamCode},
			success : function(){
				
			},error : function(){
				console.log('ajax 오류');
			}
			
		});
		}
	</script>
</body>
</html>