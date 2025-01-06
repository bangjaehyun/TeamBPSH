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
	.container{
		
	}
	.head-title{
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.head-title h1{
		font-size:30px;
	}

	
	.title-container{
  		background-color:gray;
  		color:white;
	}
	.filter-container{
		width:100%;
		display: flex;
		justify-content: center;
	}
	.type-filter{
		display: flex;
		justify-content: space-around;
		width:60%;
	}
	.type-filter button{
		padding:2px 3px;
		border-radius: 5px;
		background-color: gray;
		color:white;
		font-size:16px;
	}
	
	
	.detail{
		display: flex;
		gap:10px;
	}
	
	#grid{
		width: 1200px;
		height: 900px;
		overflow: scroll;
	}
	::-webkit-scrollbar{
	 width: 0;  /* remove scrollbar space */
     background: transparent;
	}
	
	
	
</style>
</head>
<body>
<div class="container">
	<div class="head-title">
		<h1>문서목록</h1>
	</div>
	<div class="filter-container">
	<div class="type-filter">
		<button type="button" onclick="typeFilter('all')" value="all">전체</button>
		<c:forEach var="type" items="${docTypeList }">
			<button type="button" onclick="typeFilter('${type.documentTypeCode }')" value="${type.documentTypeCode }">${type.documentTypeName }</button>
		</c:forEach>
	</div>
	</div>
	<div>
		<div id="grid"></div>
	</div>
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
            documentDate: '${doc.documentDate}',
            documentTypeCode: '${doc.documentTypeCode}',
        };
        obj.push(rowData);
    </c:forEach>

    const gridOption = {
        rowData: obj,
        pagention:true,
        rowSelection:"single",
        enableRangeSelection: true,//이거 수정 예정
        suppressRowClickSelection: false,
        onRowDoubleClicked : function(event){
        	viewOneDoc(event.data);
        },
        pagination: true,
        paginationPageSize: 10,        
        paginationPageSizeSelector: [10, 20, 50],
        scrollbarWidth:0,
        defaultColDef: {
        	
       		editable: false,
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
        
        onGridReady: function (event) {
            event.api.sizeColumnsToFit();

        }
       
    };

    const gridDiv = document.querySelector('#grid');
    const gridApi = agGrid.createGrid(gridDiv, gridOption);

    console.log(obj);
});

<%-- 필터링 기능--%>
function typeFilter(e){
	$.ajax({
		url:"/doc/selectList.do",
		type:"post",
		data:{"type":e},
		success:function(res){
			$('.page').html(res);
		},
		error:function(){
			console.log("오류");
		}
		
		
	});
}






<%--상세페이지 이동--%>
function viewOneDoc(e){
	
	var type=e.documentTypeCode;
	var urls="/doc/";
	
	switch(type){
	case 'va':{
		urls+="selectOneVa.do";
		break;
	}
	case 'sp':{
		urls+="selectOneSp.do";
		break;
	}
	
	case 'co':{
		urls+="selectOneCo.do";
		break;
	}
	case 'es':{
		urls+="selectOneEs.do";
		break;
	}
	case 'bt':{
		urls+="selectOneBt.do";
		break;
	}
	
	case 'pt':{
		urls+="selectOnePt.do";
		break;
	}
	
	}
	
	
	$.ajax({
		url:urls,
		type:"post",
		data:{"documentCode":e.documentCode},
		success:function(res){
			console.log(res);
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