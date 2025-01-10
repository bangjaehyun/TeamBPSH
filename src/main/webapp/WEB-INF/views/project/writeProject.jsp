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
            font-family: 'Arial', sans-serif;
        }

        /* 폼 컨테이너 */
        .projectForm {
            
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* 제목 입력란 */
        .projectForm input[type="text"],
        .projectForm textarea {
            width: calc(100% - 20px);
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        /* 마감일 + 팀 목록 컨테이너 */
        .deadline-team {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        /* 마감일 스타일 */
        .deadline {
            width: 30%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }

        /* 팀 목록 스타일 */
        .team-list {
            width: 65%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
            background: #f9f9f9;
        }

        /* 내용 입력란 */
        textarea {
            width: calc(100% - 20px);
            height: 150px;
            padding: 10px;
            resize: none;
        }

        /* 작성 버튼 */
        .submit-btn {
            display: block;
            width: 50%;
            padding: 12px;
            margin: 20px auto 0;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #0056b3;
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
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
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