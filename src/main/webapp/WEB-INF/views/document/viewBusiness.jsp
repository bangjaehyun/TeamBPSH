<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
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
            text-align:right;
			margin: 0px;
			padding:0px;
			width:100%;
			display: inline-block;
			
        }

        .sign-box {
            display: inline-block;
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
    
    .form .span-title {
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
    .let-date span{
    	font-weight: bold;
    	font-size: 20px;
    }
    
    
    
   
   .file{
   	 margin-top:5px;
    display: flex;
   }
   .file>span{
   align-content: center;
   background-color: gray;
   padding: 0px 2px;
   }
   .detail-content{
    width:100%;
    height: 30px;
    border: 1px solid black;
    background-color: gray;
   display: flex;
   justify-content: center;
   }
   .detail-content span{
    text-align: center;
    
    font-size: 26px;
   }

   .content{
        width:100%;
        height:300px;
        margin-bottom: 10px;
        padding:0;
    }
  
	.sign-content{
		margin-top:2%;
	}
    .sign-text{
    	display:flex;
    	
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
            <h1>출장보고서</h1>
        </header>
       
        <div class="header">
            <div>
                <div class="form">
                    <span class="span-title" >신청일</span>
                    <span>${doc.documentDate }</span>
                </div>
                <div class="form">
                    <span class="span-title">신청인</span>
                    <span>${doc.empName }</span>
                    
                </div>
                <div class="form">
                    <span class="span-title">제목</span>
                    <span>${doc.documentTitle }</span>
                </div>
                <div class="form">
                    <span class="span-title">출장지</span>
                    <span>${business.businessTo }</span>
                </div>
                <div class="form">
                    <span class="span-title">출장목적</span>
                    <span>${business.businessPurpose }</span>
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
                        	<c:when test="${signEmp.signYn==-1 }">반려</c:when>
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
         		
           				
							<div class="date">
								<span >출장 시작일</span> <div>${business.businessStart}</div>
									
							</div>
							<div class="date" >
								<span >출장 종료일</span> <div>${business.businessEnd }</div>
							</div>
						
						
					</div>
        </section>
        <div>
            <div class="file">
                <span>첨부파일</span>
                <c:forEach var="file" items="${fileList}">
                    <a href="javascript:void(0)" onclick="fileDown('${file.fileName}', '${file.filePath}',)">${file.fileName} </a>
                </c:forEach>
                
            </div>
        </div>
        <div class="detail-content">
            <span>내용</span>
        </div>
            <div class="content" >
                <textarea id=summernote name="docContent"   readonly>${doc.documentContent }</textarea>
            </div>
       <c:if test="${loginEmp.empCode eq signableEmp  }">
       	<div class="sign-content">
       	<div class="sign-text">결재하기</div>
       		<div class="sign-buttons">
				<button class="confirm" type="button" onclick="signDocument('1')">승인</button>
				<button class="reject" type="button" onclick="signDocument('-1')">반려</button>
			</div>
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
	$.ajax({
		url:"doc/fileDown",
		type:"post",
		data:{"fileName":fileName,
			 "filePath":filePath},
			 success:function(res){
				 console.log("성공");
			 },
			 error:function(){
				 console.log("오류");
			 }
	});
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
			  "type":"bt",
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

function fileDown(fileName, filePath) {
	location.href="/doc/fileDown.do?fileName="+fileName+"&filePath="+filePath;
}

</script>
</body>
</html>