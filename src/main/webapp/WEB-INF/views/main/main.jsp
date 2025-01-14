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
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

/* 콘텐츠 영역 */
.content {
	display: flex;
	flex-wrap: wrap;
	width: 100%;
	min-height: calc(100vh - 50px);
	gap: 20px; /* 상단 이메일 테이블과 문서 타입 테이블 간격 */
	padding: 20px;
}

/* 문서 타입 테이블 컨테이너 */
.docType {
	display: flex;
	flex-wrap: wrap; /* 가로 배치하며 줄바꿈 허용 */
	gap: 20px; /* 테이블 간 간격 */
	justify-content: flex-start; /* 왼쪽 정렬 */
}

/* 카드 스타일 */
.doc {
	flex: 1 1 calc(20% - 30px); /* 너비는 부모의 50%, 간격 포함 */
	min-width: 500px; /* 최소 너비 설정 */
	max-width: 700px; /* 최대 너비 설정 */
	background-color: #f9f9f9;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	display: flex;
	flex-wrap: wrap; /* 가로 배치하며 줄바꿈 허용 */
}

/* 문서 제목 */
.docTitle {
	padding: 15px;
	color: #333;
	font-size: 18px;
	font-weight: bold;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

/* 이름 영역 */
.docName {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

/* "이메일" 스타일 */
.docName>div:first-child {
	color: #C35DE3;
	font-weight: bold;
	display: flex;
	align-items: center;
	padding: 5px 10px;
}

/* "신규" 버튼 스타일 */
#emailWrite, .docWrite {
	background-color: #007bff;
	color: white;
	padding: 8px 15px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	font-size: 14px;
	font-weight: bold;
	transition: background-color 0.3s;
	text-align: center;
}

#emailWrite:hover, .docWrite:hover {
	background-color: #0056b3;
}

/* 테이블 스타일 */

table {
	width: 100%; /* 테이블 너비를 부모에 맞춤 */
	min-width:400px;
	border-collapse: collapse; /* 셀 경계선을 합침 */
	margin-top: 10px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	border: 1px solid #ccc; /* 테두리 추가 */
}

/* 테이블 헤더 */
table th {
	background-color: #f4f4f4;
	color: #333;
	font-weight: bold;
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center; /* 중앙 정렬 */
}

/* 테이블 본문 */
table td {
	border: 1px solid #ccc; /* 셀 테두리 */
	padding: 10px;
	text-align: center; /* 가로 중앙 정렬 */
	vertical-align: middle; /* 세로 중앙 정렬 */
}

/* 스크롤 가능한 tbody */
tbody {
	display: block;
	width: 100%;
	height: 200px; /* 고정 높이 */
	overflow-y: auto; /* 세로 스크롤 허용 */
	border: 1px solid #ccc;
}

thead {
	display: table-header-group;
	width: 100%;
	table-layout: fixed; /* 헤더와 본문 정렬 */
}

tr {
	display: table;
	width: 100%;
	table-layout: fixed;
}

/* 행 배경색 */
table tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tr:nth-child(odd) {
	background-color: #ffffff;
}

/* 행에 마우스 올릴 때 효과 */
table tr:hover {
	background-color: #e6f7ff;
}


</style>
</head>
<body>
	<div class="content">
		<input type="hidden" name="empCode" value="${loginEmp.empCode}">
		<div class="docType">
		</div>
		<%--문서 타입별 출력될 div --%>
	</div>

	<script>

	//회원번호로 main 랜더링
		$(document).ready(function() {
			var empCode = $('input[name="empCode"]').val();
			
			// AJAX 요청
			$.ajax({
				type : 'post',
				url : '/emp/docMain.do',
				data : {
					empCode : empCode
				},
				success : function(res) {
				    if(res.loc == null){
						docList(res); // 데이터를 HTML로 출력하는 함수 호출
	                }else{
	                    callbackMsg(res.title, res.msg,res.icon, res.loc);
	                }
				},
				error : function() {
					console.log('ajax 오류');
				}
			});
		});
		
		
		// 데이터를 HTML 테이블에 삽입하는 함수
		function docList(data) {
			var newType = $('.docType').first();
			// 기존 .docType을 유지하고 새로운 것을 추가
			$('.content').append(newType);

			// 데이터가 비어 있는지 확인
			if (!data || Object.keys(data).length === 0) {

				return;
			}
			
			// 문서 타입별 데이터 순회
			$.each(data,function(type, documents) {
								var documentTypeName = documents[0] ? documents[0].documentTypeName
										: type;
								var documentTypeCode = documents[0] ? documents[0].documentTypeCode
										: typeCode;
								//각 조건 추가할 함수
								var singue = type !== 'pj';
								
								var table = '<div class="doc">'
										+ '<div class="docTitle">'
										+ '<div class="docName">'
										+ '<div>'
										+ documentTypeName
										+ '</div>';
										//조건 추가될때 마다 필터해줄 if
										if(singue){
											table += '<div class="docWrite" data-type='+ type +'>신규</div>';
										}
								  table += '</div>' + '<div>'
										+ '<table border="1">' + '<thead>'
										+ '<tr>' + '<th>글쓴이</th>'
										+ '<th>제목</th>' + '<th>날짜</th>'
										+ '<th>첨부파일</th>' + '<th>결제상태</th>'
										+ '</tr>' + '</thead>'
										+ '<tbody></tbody>' + '</table>'
										+ '</div>' + '</div>' + '</div>';
								var tableEl = $(table);
								var tbody = tableEl.find('tbody');
								// 해당 문서 타입의 문서 데이터를 테이블에 추가
								$.each(documents,function(index, doc) {
													var row = '<tr class="viewDoc" data-documentTypeCode="'+ doc.documentTypeCode +'"data-documentCode="'+ doc.documentCode +'">' + '<td>'
															+ doc.empName
															+ '</td>' + '<td>'
															+ doc.documentTitle
															+ '</td>' + '<td>'
															+ doc.documentDate
															+ '</td>'
															+ '<td>' + doc.fileCount +'개</td>';
															//결과에 따라 css 처리할려고
													if (doc.progress === '결제 완료') {
														row += '<td class="completedSign">결제완료</td>';
													} else if (doc.progress === '대기 중') {
														row += '<td class="waitSign">대기 중</td>';
													} else if (doc.progress === '반려') {
														row += '<td class="backSign">반려</td>';
													}
													row += '</tr>';
													tbody.append(row);
													
												});
								
								
								
								newType.append(tableEl); // 테이블을 콘텐츠 영역에 추가
							});
		}
		
		
		//문서 클릭 이벤트 
		$(document).on('click', '.viewDoc', function() {
			var documentCode = $(this).attr('data-documentCode'); // 문서 코드 읽기
	        var documentTypeCode = $(this).attr('data-documentTypeCode'); // 문서 타입 코드 읽기
	        var empCode = $('input[name="empCode"]').val();
			
			
				
				var type=documentTypeCode;
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
				
				case 'pj':{
					urls+="selectOnePt.do";
					break;
				}
				
				}
				
				console.log(type);
				$.ajax({
					url:urls,
					type:"post",
					data:{"documentCode":documentCode},
					success:function(res){
						console.log(res);
						$('.page').html(res);
					},
					error:function(){
						console.log("오류");
					}
				});
			
		/*
	        var documentCode = $(this).attr('data-documentCode'); // 문서 코드 읽기
	        var documentTypeCode = $(this).attr('data-documentTypeCode'); // 문서 타입 코드 읽기
	        var empCode = $('input[name="empCode"]').val();
	        pageMoveParam('/doc/viewDocOne.do',{ documentCode: documentCode ,
	        								   	 documentTypeCode: documentTypeCode,
	        								   	 empCode : empCode
	        								   });
		*/
	    });
		
		
		//문서 페이지 이동
		
		
		//신규 클릭시 문서작성 페이지로 이동
		$(document).ready(function() {
			$(document).on('click', '.docWrite', function() {
				var documentTypeCode = $(this).data('type');
				$.ajax({
					url : "/doc/writeDoc.do",
					type : "post",
					data : {
						"type" : documentTypeCode
					},
					success : function(res) {
						$('.page').html(res);
					},
					error : function() {
						console.log("오류");
					}
				});

			});

		});
		
	</script>
</body>
</html>