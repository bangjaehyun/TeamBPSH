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
#con {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f4f4f4;
}

/* 폼 컨테이너 */
.projectForm {
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    text-align: center;
    width: 80%;
    max-width: 700px;
}

/* 제목 입력란 */
.projectForm input[type="text"],
.projectForm input[type="date"],
.projectForm textarea {
    width: calc(100% - 20px);
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 18px;
}

/* 팀 목록 스타일 */
.team {
    text-align: left;
    margin-bottom: 20px;
}

.team label {
    display: inline-block;
    margin-right: 10px;
    font-size: 16px;
}

.team input[type="checkbox"] {
    margin-left: 5px;
}

/* 마감일 스타일 */
.deadline {
    margin-bottom: 20px;
}

/* 내용 입력란 */
textarea {
    width: calc(100% - 20px);
    height: 180px;
    padding: 15px;
    resize: none;
    font-size: 18px;
}

/* 작성 버튼 */
#btn {
    display: block;
    width: 60%;
    padding: 15px;
    margin: 30px auto 0;
    background-color: #28a745; /* 버튼 색상 (녹색) */
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    cursor: pointer;
    transition: background 0.3s ease;
}

#btn:hover {
    background-color: #218838; /* 버튼 호버 색상 (어두운 녹색) */
}
</style>
</head>
<body>
	<div id="con">
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
					<input type="date" name="projectEnd">
					<div>
					<label>내용</label> 
					<textarea id="summernote" name="projectContent"></textarea>
					</div>
					</div>
					<button id="btn" type="button">작성</button>
				</form>
			
		</div>
	</div>
	<script>
	$('#btn').on('click',function(){
        
        
        var form = $('.projectForm')[0];
        var formData = new FormData(form);
        
        $.ajax({
           url : '/project/write.do',
           type : 'post',
           data : formData,
           contentType: false,
             processData: false,
           success : function(res){
              console.log(res);
              if(res > "0"){
                       swal({
                          title : "완료",
                          text : "프로젝트 생성이 완료되었습니다.",
                          icon : "success"
                       }).then(function(){

                          pageMove('/project/list.do');
                       });
                    }else{
                       swal({
                          title : "오류",
                          text : "프로젝트중 생성 중 오류가 발생하였습니다.",
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