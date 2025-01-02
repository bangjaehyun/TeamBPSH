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


	
	.title-container{
  		background-color:gray;
  		color:white;
	}
	
	.detail{
		display: flex;
		gap:10px;
	}
	
	#grid{
		width: 1210px;
		height: 500px;
	}
	
</style>
</head>
<body>
	<div>
		<div id="grid"></div>
	</div>



<script>
var obj=[];

$(document).ready(function(){
  

    <c:forEach var="doc" items="${docList}">
        var rowData = {
            documentCode: '${doc.documentCode}',
            documentTypeName: '${doc.documentTypeName}',
            progress: '${doc.progress}',
            documentTitle: '${doc.documentTitle}',
            empName: '${doc.empName}',
            documentDate: '${doc.documentDate}'
        };
        obj.push(rowData);
    </c:forEach>

    const gridOption = {
        rowData: obj,
        pagention:true,
        rowSelection:"single",
        enableRangeSelection: true,
        suppressRowClickSelection: false,
        onRowClicked : function(event){
        	viewOneDoc(event.data.documentCode);
        },
        
        paginationPageSize: 3,        
        paginationPageSizeSelector: [10, 20, 50],
        defaultColDef: {
       		editable: true,
            resizable: false,
            sortable: true,
            
            headerClass: 'title-container',
        },
//         rowSelection: {
//             mode: "multiRow",
//             groupSelects: "descendants",
//           },
        columnDefs: [
            { field: "documentCode", headerName: "문서번호"},
            { field: "documentTypeName", headerName: "문서타입" },
            { field: "progress", headerName: "진행상황" },
            { field: "documentTitle", headerName: "제목",},
            { field: "empName", headerName: "작성자" },
            { field: "documentDate", headerName: "작성일" }
        ],
       
    };

    const gridDiv = document.querySelector('#grid');
    const gridApi = agGrid.createGrid(gridDiv, gridOption);

    console.log(obj);
});

//상세페이지 이동
function viewOneDoc(e){
	console.log(e);
	$.ajax({
		url:"/doc/selectOneDoc.do",
		type:"post",
		data:{"documentCode":documentCode},
		success:function(res){
			$('.page').html(res);
		},
		error:function(){
			console.log("오류");
		}
	});
}



// Grid Options: Contains all of the Data Grid configurations

// Your Javascript code to create the Data Grid

// const gridOptions = {
// 	    // Row Data: The data to be displayed.
// 	    rowData: [
// 	        { make: "Tesla", model: "Model Y", price: 64950, electric: true },
// 	        { make: "Ford", model: "F-Series", price: 33850, electric: false },
// 	        { make: "Toyota", model: "Corolla", price: 29600, electric: false },
// 	    ],
// 	    // Column Definitions: Defines the columns to be displayed.
// 	    columnDefs: [
// 	        { field: "make" },
// 	        { field: "model" },
// 	        { field: "price" },
// 	        { field: "electric" }
// 	    ]
// 	};
// const myGridElement = document.querySelector('#grid');
// agGrid.createGrid(myGridElement, gridOptions);
	
		
</script>
</body>
</html>