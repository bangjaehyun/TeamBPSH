<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
* {
		margin : 0px;
		padding: 0px;
		box-sizing: border-box;
	}
	h1{
		margin-left : 10px;
	}
	
	/*테이블*/
.tbl {
  width: 100%;
  border-spacing: 0;
}
.tbl th,
.tbl td {
  text-align: center;
  border-bottom: 1px solid var(--line4);
  padding: 10px 20px;
}
.tbl th.left,
.tbl td.left {
  text-align: left;
}
.tbl th {
  background-color: rgba(0, 76, 161, 0.3);
}
.tbl.tbl-hover tbody > tr:hover {
  cursor: pointer;
  background-color: rgba(0, 76, 161, 0.1);
}
.page-wrap{
	margin : 50px;
}

</style>
</head>
<body>
<!-- 	<div class="page-wrap"> -->
<!-- 		<table class="tbl hover"> -->
<!-- 			<tr> -->
<!-- 				<th>회원번호</th> -->
<!-- 				<th>이름</th> -->
<!-- 				<th>부서</th> -->
<!-- 				<th>직급</th> -->
<!-- 				<th>승인</th> -->
<!-- 			</tr> -->
<%-- 			<c:forEach var="empWait" items="${empWaitList}"> --%>
<!-- 				<tr> -->
<%-- 					<td>${empWait.empCode}</td> --%>
<%-- 					<td>${empWait.empName}</td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->
		     <div id="myGrid" style="height: 250px; width:600px" class="ag-theme-quartz-dark"></div>
<!-- 	</div> -->
	
	 <script>
        // 샘플 ROW 데이타 정의, DB Select의 1줄 Row들의 모임 list가 될거시당
        const rowData = [
            { name: "민지", birth: "2004-05-07", nationality: "대한민국" },
            { name: "하니", birth: "2004-10-06", nationality: "호주|베트남" },
            { name: "다니엘", birth: "2005-04-11", nationality: "호주|한국" },
            { name: "해린", birth: "2006-05-15", nationality: "대한민국" },
            { name: "혜인", birth: "2008-04-21", nationality: "대한민국" }
        ];

        // 통합 설정 객체, 아주 많은 속성들이 제공됨(일단 몇개만)
        const gridOptions = {
            rowData: rowData,
            columnDefs: [                            // 컬럼 정의
                { field: "name", headerName: "이름" },
                { field: "birth", headerName: "생일" },
                { field: "nationality", headerName: "국적" }
            ],
            autoSizeStrategy: {                    // 자동사이즈정책
                type: 'fitGridWidth',              // 그리드넓이기준으로
                defaultMinWidth: 150               // 컬럼 최소사이즈
            },
            rowHeight: 45                          // row 높이지정
        };

        const gridDiv = document.querySelector('#myGrid');
         new agGrid.Grid(gridDiv, gridOptions);  // deprecated
//         const gridApi = agGrid.createGrid(gridDiv, gridOptions);
    </script>
</body>
</html>