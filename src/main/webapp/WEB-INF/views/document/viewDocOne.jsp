<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
       li{
       list-style-type: none;
       }
    </style>
</head>
<body>
    <h1>${document.documentTitle}</h1>
   <p>문서 유형: ${document.documentTypeCode}</p>
    <p>작성일: ${document.documentDate}</p>
    <div>
        <h3>문서 내용</h3>
        <p>${document.documentContent}</p>
    </div>
    <div>
        <h3>결제자 정보</h3>
        <ul>
            <c:forEach items="${document.signList}" var="signList">
                <li>${signList.documentSeq}. ${signList.empCode} - 승인 여부: ${signList.signYn ? '승인' : '대기'}</li>
            </c:forEach>
        </ul>
    </div>
    <div>
        <h3>첨부 파일</h3>
        <ul>
        <%--
            <c:forEach items="${document.files}" var="file">
                <li><a href="${file.filePath}">${file.fileName}</a></li>
            </c:forEach>
             --%>
        </ul>
    </div>
    
    <script>
    
</script>
    
</body>
</html>

