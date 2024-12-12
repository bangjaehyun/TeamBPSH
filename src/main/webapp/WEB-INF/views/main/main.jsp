<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/main/sidevar.jsp"></jsp:include>
<style>
	
	* {
		margin : 0;
		padding: 0;
	}
	
	body {
		display: flex;
	}
	#maindoc {
        display: flex;
        flex-wrap: wrap;        
        gap : 5px;

    }
    
    #content {
    	flex:1;
    }
    .doc {
      display: flex;
      justify-content: flex-start;
        
        
    }
    
    table {
    	border-collapse: collapse;
    	margin : 50px;
    }
</style>
</head>
<body>
	<div id="content">
	<div class="doc">
		<table class="doc" border="1">
                    <thead>
                        <tr>
                            <td colspan="2">문서 이름</td>
                            <td>신규문서 작성</td>
                        </tr>
                        <tr id="vaClick">
                            <td>사람</td>
                            <td>제목</td>
                            <td>날짜</td>
                        </tr>
                    </thead>
                
                
                    <tbody>
                        <c:forEach var="email" items="email">
                            <tr>
                                <td>보낸이</td>
                                <td>제목</td>
                                <td>날짜</td>
                            </tr>
                        </c:forEach>
                    </tbody>
               
                </table>
                <table border="1">
                    <thead>
                        <tr>
                            <td colspan="2">문서 이름</td>
                            <td>신규문서 작성</td>
                        </tr>
                        <tr>
                            <td>사람</td>
                            <td>제목</td>
                            <td>날짜</td>
                        </tr>
                    </thead>
                
                
                    <tbody>
                        <c:forEach var="email" items="email">
                            <tr>
                                <td>보낸이</td>
                                <td>제목</td>
                                <td>날짜</td>
                            </tr>
                        </c:forEach>
                    </tbody>
               
                </table>
	</div>
	</div>
	<script>
		$('#vaClick').click(function(){
			$.ajax({
				url : "",
				data : "",
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