<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
 <style>
  .body{
            padding: 0%;
        }
        .title{
            
            margin-top: 10%;
            display: flex;
            justify-content: space-around;
        }
        .content-container{
            
            display: flex;
            justify-content: space-around;
            padding: 0%;
        }
        .select {
           display: flex;
           flex-direction: column;
           padding:0;
           width:33%;
           border:1px solid black;
        }

       .filter-title{
        display: flex;
        width:33%;
        justify-content: center;
        background-color: gray;
        border: 1px solid black;
       }

       .selectOne{
       display: flex;
        justify-content: center;
        width:100%;
       }

       .filter{
        display: flex;
        padding: 0;
        border:1px solid black;
        width:33%;
        align-items: center;
        flex-direction: column;
       
       }
       .filter button{
        
        justify-content: center;
        align-items: center;
       }
       .selectedEmp{
        display: flex;
       }
    </style>
</head>
<body>
	<div class="title">
    <div class="filter-title">
        <label>부서</label>
    </div>
    <div class="filter-title">
        <label>팀</label>
    </div>
    <div class="filter-title">
        <label>직급, 성함</label>
    </div>

    </div>
    <div class="content-container">

        <div class="filter" id="filter1">
          
            <c:forEach var="dept" items="${deptList}">
                <button name="filter1" value="dept.deptCode" onclick="srchTeam('${dept.deptCode}')">${dept.deptName}</button>
            </c:forEach>
           
        </div>

        <div class="filter" id="filter2">
           
            
           
        </div>

        <div class="select" id="select">
           
            
               
                
            
        </div>
    </div>
    <span>결제 순서대로 체크해 주세요.</span>
    <div class="selectedEmp">
        <!--체크함수따라 체크예정-->
    </div>
    <button type="button" class="submit" onclick="submit()">확인</button>
	
<script>
	function srchTeam(e){
		$('#filter2').empty();
        $('#select').empty();
        $.ajax({
        	url:"/doc/srchTeam",
        	type:"post",
        	data:{"deptCode":e},
        	success:function(res){
        		for( let i in res){
                    let filter= $('#filter2');
                    let team= $('div');
                    
                    team.innerHTML='';
                    team.innerHTML += '<div class="filter"><button type="button" name="filter2" value="${res[i].teamCode}" onclick="srchEmp('${res[i].teamCode}')">'${res[i].teamName}'</button></div>';

                    filter.appendChild(team);
                    }
        	},
        	error:function(){
        		console.log("오류");
        	}
        });
	}
</script>
</body>
</html>