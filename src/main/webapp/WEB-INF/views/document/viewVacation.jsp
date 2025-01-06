<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
 <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f3f3f3;
    }
    
    .container {
        width: 1200px;
        max-width: 900px;
        margin: 20px auto;
        padding: 20px;
        background-color: white;
        border-radius: 8px;
    }
    
   

        .signs {
            display: flex;
			justify-content: right;
			margin: 0px;
			padding:0px;
			
        }

        .sign-box {
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 1px solid black;
            margin:0;
           
        }

        .name {
            border-bottom: 1px solid black;
            width: 100%;
            height: 30px;
            text-align: center;
            
            background-color: white;
        }

        .sign {
            
            width: 90px;
            height: 50px;
            text-align: center;
            line-height: 50px;
            background-color: white;
        }
        .header {
            width:100%;
            display: flex;
            justify-content: center;
            align-items: center;
           
        }
        .header>div{
            width:50%;
        }

     
    h1 {
        display: flex;
        justify-content: center;
        font-size: 24px;
        margin: 0;
    }
    
    
    
    .form {
        
        display: flex;
        justify-content: space-between;
        width: 100%;
        
    }
    
    .form label {
        width: 30%;
        font-weight: bold;
        text-align: center;
        padding: 10px 0;
        background-color: gray;
        border:1px solid black;
        padding: 10px 0px;
    }
    
    .form span {
        width:70%;
        flex-grow: 1;
        padding:0;
        border: 1px solid black;
        text-align: center;
        padding: 10px 0px;
    }
    
    .let-date{
    	display: flex;
    	gap:20px;
    	
    }
    .let-date label{
    	font-weight: bold;
    	font-size: 20px;
    }
    
    
    
   
   .file{
   	margin-top:1%;
    display: flex;
   }
   .file>label{
   align-content: center;
   background-color: gray;
   padding: 0px 2px;
   }
   .detail-content{
    width:98%;
    height: 30px;
    border: 1px solid black;
    background-color: gray;
   display: flex;
   justify-content: center;
   }
   .detail-content label{
    text-align: center;
    
    font-size: 26px;
   }

   .content{
        width:98%;
        height:300px;
        margin-bottom: 10px;
        padding:0;
    }
  

    .sign-text{
    	display:flex;
    	margin-top: 1%;
    	width:100%;
    	font-size: 20px;
    	justify-content: center;
    }	
    .sign-buttons {
		display:flex;
    	justify-content: center;
		gap: 20px;
		margin-top: 5px;
	}
	
	.sign-buttons button {
		padding: 10px 20px;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		font-size: 14px;
	}
	.confirm{
		background-color:yellowgreen;
		color: white;
	}
   .reject{
   		color: white;
   		background-color:red;
   }
 
   
</style>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css"/>

</head>
<body>
    <div class="container">
        <header>
            <h1>지출결의서</h1>
        </header>
       
        <div class="header">
            <div>
                <div class="form">
                    <label for="date">신청일</label>
                    <span>${doc.documentDate }</span>
                </div>
                <div class="form">
                    <label for="emp">신청인</label>
                    <span>${doc.empName }</span>
                    
                </div>
                <div class="form">
                    <label for="title" name="title" readonly>제목</label>
                    <span>${doc.documentTitle }</span>
                </div>
            </div>
            <div>
                <div class="signs">
                <c:forEach var="signEmp" items="${signList}">
           
                    <div class="sign-box">
                    	
                        <div class="name">${signEmp.empRank} ${signEmp.empName}</div>
                        <div class="sign">
                        <c:choose>
                        	<c:when test="${signEmp.signYn==1 }">승인</c:when>
                        	<c:when test="${signEmp.signYn==-1 }">기각</c:when>
                        	<c:otherwise>진행중</c:otherwise>
                        </c:choose>
                        </div>
                    </div>
                </c:forEach>
                    
                </div>
            </div>
          
        </div>
        
        <section class="date-section">
           <div class="let-date">
         		<c:choose>
           				<c:when test="${vacType eq 'annual' }">
							<div class="date">
								<label for="vac-start">휴가 시작일자</label> <div>${startDay }</div>
									
							</div>
							<div class="date" >
								<label for="vac-end">휴가 종료일자</label> <div>${endDay }</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="date">
								<label for="vac-start">반차 날짜</label> <div>${vacDate }</div>
									
							</div>
							<div class="date" >
								<label for="vac-end">반차시간대</label>
								<c:if test="${time eq 'a'}">
								<div>오전</div>
								</c:if>
								<c:if test="${time eq 'p'}">
								<div>오후</div>
								</c:if>
							</div>
						</c:otherwise>
				</c:choose>
					</div>
        </section>
        <div>
            <div class="file">
                <label for="file">첨부파일</label>
                <c:forEach var="file" items="${fileList}">
                    <a href="javascript:void(0)" onclick="fileDown('${file.fileName}', '${file.filePath}',)">${file.fileName}</a>
                </c:forEach>
                
            </div>
        </div>
        <div class="detail-content">
            <label for="content">내용</label>
        </div>
            <div class="content" >
                <textarea id=summernote name="docContent" escapeXml="false"  readonly>${doc.documentContent }</textarea>
            </div>
       <c:if test="${loginEmp.empCode eq signableEmp  }">
       	
       	<div class="sign-text">결재하기</div>
       		<div class="sign-buttons">
				<button class="confirm" type="button" onclick="signDocument('1')">승인</button>
				<button class="reject" type="button" onclick="signDocument('-1')">기각</button>
			</div>
			
       </c:if>

    </div>
    <script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>

<script>
$('#summernote').summernote( {
	 codeviewFilter : false, // 코드 보기 필터 비활성화
     codeviewIframeFilter : true, // 코드 보기 iframe 필터 비활성화
     height : 300, // 에디터 높이
     width : '100%',
     minHeight : null, // 최소 높이
     maxHeight : null, // 최대 높이
     toolbar: [],
     focus : false, // 에디터 로딩 후 포커스 설정
     lang : 'ko-KR', // 언어 설정 (한국어)
     disableDragAndDrop : true,
     tabDisable : true,
     disableDragAndDrop : false,
     disableResizeEditor : true // Does not work either  
}).summernote('disable');

function fileDown(fileName, filePath) {
	location.href = '/notice/fileDown?fileName=' + fileName + '&filePath=' + filePath;
}

function msg(title, text, icon, callback){
	swal({
		title : title,
		text : text,
		icon : icon
	}).then(function(){
		if(callback != "0"){
			location.href = "/";
		}
	});
	
}

function signDocument(e){
	$.ajax({
		url:"/doc/approveDoc.do",
		type:"post",
		data:{"check":e,
			  "empCode":${loginEmp.empCode},
			  "documentCode":${documentCode},
			  "type":"va",
			  "writer":${doc.empCode}
		},
		success:function(res){
			msg("알림","결재가 완료되었습니다.","success","1")
		},
		error:function(){
			msg("알림","결재중 오류가 발생하였습니다.","error","0");
			console.log("오류");
		}
	});
	
}

</script>
</body>
</html>