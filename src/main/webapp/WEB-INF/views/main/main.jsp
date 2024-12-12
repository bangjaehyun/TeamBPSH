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
		margin : 0;
		padding: 0;
		box-sizing: border-box;
	}

	#content {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        
    }    
    
    .doc {
        width: 400px; /* 테이블 고정 너비 */
        background-color: #f9f9f9;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .docTitle {
        padding: 10px;
        
        color: black;
        font-size: 18px;
        font-weight: bold;
        height: 350px;
        justify-content: space-between;
        align-items: center;
    }
    
    .docName {
    	display: flex;
    	justify-content: space-between;
    }
    
    .doc {
    	border:1px solid black;
    }
    
    .docName > div:nth-child(1){
    	border-top: 1px solid black;
    	border-right: 1px solid black;
    	border-left: 1px solid black;
    	border-radius: 5px;
    	background-color: red;
    	display:flex;
    	align-items: center;
    	
    }
    
    .docName > div > div {
    	font-size: 10px;
    	text-align: center;
    	justify-content: center;
    	
    }

    #emailWrite {
        background-color: white;
        color: #333;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    #emailWrite:hover {
        background-color: #f1f1f1;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        height: 350px;
    }


    .docContent {
        
    }

    .docList {
        
    }
    
    thead {
     width: calc(100% - 17px);
     display: table;
     border:1px solid white;
     font-size: 15px;
    }
    
    tbody {
    display: block;
    width: 100%;
    height: 350px;
    overflow-y: auto;
    margin-right: -1px;
    border:1px solid white;
    }
    
    tr {
    display: table; /* tr을 table로 설정 */
    width: 100%;
    table-layout: fixed; /* 열 너비를 고정 */
}
    
    
</style>
</head>
<body>
	<div id="content">
	<%--<c:forEach var="doctypeCode" items="${docTypeCode}">  --%>
	<div class="doc">
			<div class="docTitle">
				<div class="docName">
					<div>이메일 &nbsp
						<div><p>admin@naver.com</p></div>
					</div>
					<div id="emailWrite">신규</div>
				</div>
				<div>
				<table border="1">
				<thead>
					<tr class="docContent">
						<th>글쓴이</th>
						<th>제목</th>
						<th>날짜</th>
						<th>첨부파일</th>
					</tr>
					</thead>
					</div>
					<div>
					<tbody>
					<tr class="docList">
						<td>이름</td>
						<td>제목</td>
						<td>발송날짜</td>
						<td>갯수</td>
					</tr>
					</tbody>
				</table>
				</div>
				<%--
				<div class="docContent">
					<div>글쓴이</div>
					<div>제목</div>
					<div>날짜</div> --%>
				</div>
				<%--<c:forEach></c:forEach> --%>
				<%--<div class="docList">
					<div style="border-right: 1px solid black;">docWrite</div>
					<div>docTitle</div>
					<div style="border-left: 1px solid black;">docDate</div>
				</div>
			</div>
			 --%>
	</div>
	 <%--</c:forEach>   --%>
	</div>
	
	
	<script>
		$('#emailWrite').click(function(){
			$.ajax({
				url : "emailiURL",
				data : "/",
				success : function(){
					
				}
			, error : function(){
				alert('ajax 오류');
			}
			})
		});
		
		
	</script>
</body>
</html>