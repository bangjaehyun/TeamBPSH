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
/* 전체 폼 스타일 */
.projectForm {
    width: 50%;
    margin: 50px auto;
    padding: 20px;
    background: #f9f9f9;
    border-radius: 10px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
}

/* 입력 필드와 텍스트 영역 스타일 */
.projectForm input[type="text"],
.projectForm textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

/* 체크박스 목록 스타일 */
.team {
    margin-bottom: 15px;
    padding: 10px;
    background: #ffffff;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.team p {
    font-weight: bold;
    margin-bottom: 10px;
}

.team label {
    display: inline-block;
    margin-right: 15px;
    font-size: 14px;
}

/* 라벨 스타일 */
.projectForm label {
    font-weight: bold;
    display: block;
    margin-top: 10px;
}


/* 버튼 스타일 */
#btn {
    width: 100%;
    padding: 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background 0.3s ease;
}

#btn:hover {
    background-color: #0056b3;
}
	
</style>
</head>
<body>
	<div>
		<div>
			<div>
				<form class="projectForm" action="/project/write.do" method="post">
					<input type="hidden" name="empCode" value="${loginEmp.empCode}">
					<label>제목</label> 
					<input type="text" name="projectTitle"> 
					<div class="team">
						<p>팀 목록</p>
						<c:forEach var="teamList" items="${teamList}">
							<label>${teamList.teamName}</label>
							<input type="checkbox" name="teamCode" value="${teamList.teamCode}">
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
					<button id="btn" type="submit">작성</button>
				</form>
			</div>
		</div>
	</div>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<script>
		var teamCode = [];
			$('input[name="teamCode"]:checked').each(function(i){
				teamCode.push($(this).val());
		});
		
		$('#btn').on('click',function(){
			let formData = $('.projectForm').serialize();
			formData.append("teamCode",teamCode);
			$.ajax({
				url : '/project/write.do',
				type : 'post',
				data : 'formData',
				success : function(res){
					console.log(res);
					if(res > "1"){
			               swal({
			                  title : "완료",
			                  text : "투표가 완료되었습니다.",
			                  icon : "success"
			               }).then(function(){

			            	   pageMove('/project/list.do');
			               });
			            }else{
			               swal({
			                  title : "오류",
			                  text : "투표중 오류가 발생하였습니다.",
			                  icon : "error"
			               }).then(function(){
			            	   pageMove('/project/list.do');
			               });
			            }
				},error: function(){
					console.log('ajax오류');
				}
			});
		});
			
			
		
	</script>
</body>
</html>