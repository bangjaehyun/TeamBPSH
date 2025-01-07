<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
#mainContainer {
	justify-content: center;
	width: calc(100vw - 55px);
	height: calc(100vh - 50px);
	gap: 10px;
	background-color: #f9f9f9; /* 배경색 추가 (선택 사항) */
	border-radius: 10px;
}

#pjHeader, #pjBody {
	gap: 10px;
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	min-width: 100%;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #0087FF; /* 헤더 배경: 진한 파랑 */
	color: #fff; /* 헤더 텍스트: 흰색 */
	font-weight: bold;
}

.pjSection {
	display: flex;
	margin-bottom: 20px;
}

.pjSection .box {
	border: 1px solid #ddd;
	padding: 20px;
	flex: 1;
	margin-right: 20px;
}

.pjSection .box:last-child {
	margin-right: 0;
}

.participants, .details {
	margin-bottom: 20px;
}

.footer {
    border: 1px solid #ddd;
    padding: 20px;
    text-align: center;
    background-color: #0087FF;
    border-radius: 10px;
    color: white;
}
/* 댓글 입력 폼 */
#footerSec {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    text-align: left;
}
/* 댓글 입력란 스타일 */
#comment {
    width: 100%;
    height: 100px;
    border: 1px solid #ccc;
    padding: 10px;
    font-size: 14px;
    border-radius: 5px;
}
/* 파일 업로드 스타일 */
#fileUpload {
    display: block;
    margin-top: 10px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
}
/* 댓글 추가 버튼 스타일 */
#submitComment {
    background-color: #0056b3;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}

#submitComment:hover {
    background-color: #003d82;
}

#commentsContainer{
	display:flex;
	list-style-type: none;
	flex-direction: column;
    align-items: flex-start; /* 세로 정렬 */
    margin-bottom:5px;
}
/* 각 댓글 스타일 */
#commentsContainer li {
    background: #fff;
    padding: 10px;
    border: 1px solid #ddd;
    margin-bottom: 5px;
    border-radius: 5px;
    font-size: 14px;
    color:#000;
}

/* 댓글 내 텍스트 */
#commentsContainer li p {
    margin: 0;
    font-weight: bold;
    color: #000;
}

/* 첨부파일 다운로드 링크 */
#commentsContainer li a {
    color: #007bff;
    text-decoration: none;
    font-size: 14px;
    margin-left: 5px;
}

#commentsContainer li a:hover {
    text-decoration: underline;
}
.editContent{
	width: 100%;
    height: 100px;
}


</style>
</head>
<body>
	<div id="mainContainer">

		<h1>프로젝트 상세 정보</h1>
		<!-- 프로젝트 기본 정보 -->
		<table id="pjHeader">
			<tr>
				<th>프로젝트 번호</th>
				<td>${project.projectNo}</td>
				<th>프로젝트 이름</th>
				<td>${project.projectTitle}</td>
			</tr>
			<tr>
				<th>프로젝트 작성자</th>
				<td>${project.empCode}</td>
				<th>프로젝트 마감일</th>
				<td>${project.projectEnd}</td>
			</tr>
		</table>
		
		<div id="addEmp">
				<label for="empSelect">사원 선택 : </label>
				<select id="empSelect">
					<c:forEach var="emp" items="${empList}">
						<option value="${emp.empCode}">${emp.empName}(${emp.rankCode})</option>
					</c:forEach>
				</select>
				<input type="text" name="partempContent" placeholder="역할 입력">
				<button type="button" id="addEmp">참여추가</button>
			</div>
		
		<!-- 참여 사원 리스트 -->
		<div class="participants">
			<h2>참여 사원 리스트</h2>
			<table id="pjBody">
				<thead>
					<tr>
						<th>사원 번호</th>
						<th>이름</th>
						<th>직급</th>
						<th>역할</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="projectPartempList" items="${projectPartempList}">
						<tr>
							<td class="empNo">${projectPartempList.empCode}</td>
							<td>${projectPartempList.empName}</td>
							<td>${projectPartempList.rankCode}</td>
							<td>${projectPartempList.partempContent}</td>
							<td>
                    			<button class="removeEmp" data-empcode="${projectEmp.empCode}">삭제</button>
               				</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>

		<!-- 프로젝트 진행률 및 내용 -->
		<div class="pjSection">
			<div class="box">
				<h2>프로젝트 진행률</h2>
				<canvas id="progressChart" width="400" height="200"></canvas>
			</div>
			<div class="box">
				<h2>프로젝트 내용</h2>
				<p>${project.projectContent}</p>
			</div>
		</div>

		<!-- 특이사항 및 첨부파일 -->
		<div class="footer">
			<h2>특이사항 및 첨부파일</h2>
			<div id="footerSec">
				<%-- <c:if test="${user.hasCommentPermission}"> --%>
				<form id="commentForm" enctype="multipart/form-data">
				<input type="hidden" name="empCode" value="${loginEmp.empCode}">
				<input type="hidden" name="projectNo" value="${project.projectNo}">
    				<div id="commentsList" style="margin-top: 20px;">
        				<h3>댓글 목록</h3>
        				<ul id="commentsContainer">
            			<!-- 댓글이 여기 추가됩니다. -->
        				</ul>
    				</div>
    				<textarea id="comment" name="commContent" rows="4"
        			placeholder="특이사항을 작성하세요..." style="width: 500px;; resize: none;"></textarea>
    
    				<!-- comm_gb를 숨겨진 입력 필드로 설정 -->
    				<input type="hidden" id="comm_gb" name="commGb" value="0">
    
    				<input type="file" id="fileUpload" name="fileUpload" style="margin-top: 10px;">
    
    				<button type="button" id="submitComment" style="margin-top: 10px;">댓글 추가</button>
				</form>
				
					
				
				<%--<c:if test="${!user.hasCommentPermission}">  --%>
				<p>댓글을 작성할 권한이 없습니다.</p>
				


			</div>
		</div>
	</div>
	<script>
		function loadComment(){
			let projectNo = $('input[name="projectNo"]').val();
			
			$.ajax({
				url : '/project/commList.do',
				type : 'post',
				data : {projectNo : projectNo},
				dataType: "json",
				success : function(comments){
		            let commentHtml = "";
					
		            if (comments.length > 0) {
		                comments.forEach(function(comment,index) {
		                    commentHtml += 
		                    	'<li>'+ '<input type="hidden" class="comm-no" value="'+comment.commNo+'">'+
		                    	'<p>' + comment.empCode + '</p>'
		                     				 +  comment.commContent
		                        
		                   	console.log(comment.filePath);
		                    if (comment.fileName) {
		                    	commentHtml += '<a href="javascript:void(0);" onclick="downloadFile(\'' + comment.filePath + '\', \'' + comment.fileName + '\')">' + comment.fileName + '</a>';
		                        
		                    }
		                    
		                    commentHtml += '<div class="comment-buttons">'
                                + '<button type="button" class="edit-btn" onclick="editComment(\'' + comment.commNo + '\', \'' + comment.commContent + '\', \'' + comment.fileName + '\', \'' + comment.filePath +'\', \'' + comment.commGb + '\' )">수정</button>'
                                + '<button type="button" class="delete-btn" onclick="deleteComment(\'' + comment.commNo + '\')">삭제</button>'
                                + '</div>';
							
		                    commentHtml += '</li>';
		                });
		            } else {
		                commentHtml = "<li>등록된 댓글이 없습니다.</li>";
		            }

		            $("#commentsContainer").html(commentHtml);
				},
				error : function(){
					console.log('ajax 오류');
				}
			});
		}
		function downloadFile(filePath,fileName) {
		    location.href = "/project/downloadFile.do?filePath=" + encodeURIComponent(filePath) + "&fileName=" + encodeURIComponent(fileName);
		}
		
		function editComment(commNo, commContent, commGb, fileName, filePath) {
			var commentElement = $("li").has("input.comm-no[value='" + commNo + "']"); // 해당 commNo를 가진 <li> 찾기

		    // 요소가 없을 경우 오류 방지
		    if (commentElement.length === 0) {
		        console.error("Error: #comment-" + commNo + " 요소를 찾을 수 없습니다.");
		        alert("댓글 요소를 찾을 수 없습니다.");
		        return;
		    }

		    console.log("수정할 댓글 정보:", {
		        commNo: commNo,
		        commContent: commContent,
		        commGb: commGb,
		        fileName: fileName,
		        filePath: filePath
		    });

		    // 기존 댓글 내용을 수정할 수 있도록 input 폼으로 변환
		    var editFormHtml = "";
		    editFormHtml += '<input type="hidden" class="comm-no" value="' + commNo + '">';
		    editFormHtml += '<input type="text" class="editContent" value="' + commContent + '" style="width: 70%; margin-bottom: 5px;">';
		    editFormHtml += '<input type="file" class="editFile" style="display: block; margin-top: 5px;">';
		    editFormHtml += '<input type="hidden" class="editCommGb" value="' + commGb + '">';

		    if (fileName) {
		        editFormHtml += '<p>첨부파일: ' + fileName + ' ';
		        editFormHtml += '<a href="javascript:void(0);" onclick="downloadFile(\'' + filePath + '\', \'' + fileName + '\')">' + fileName + '</a>';
		        editFormHtml += '</p>';
		        editFormHtml += '<input type="checkbox" class="deleteFile" value="delete"> 기존 파일 삭제';
		    }

		    // 저장 및 취소 버튼 추가
		    editFormHtml += '<button type="button" class="save-edit-btn">저장</button>';
		    editFormHtml += '<button type="button" class="cancel-edit-btn">취소</button>';

		    // 기존 댓글을 수정 입력 폼으로 변경
		    commentElement.html(editFormHtml);
		}
		$(document).on('click', '.save-edit-btn', function() {
		    var commentElement = $(this).closest('li'); // 클릭한 버튼이 속한 li 찾기
		    var commNo = commentElement.find('.comm-no').val(); // hidden input에서 commNo 가져오기
		    var newContent = commentElement.find('.editContent').val(); // 수정된 댓글 내용
		    var newFile = commentElement.find('.editFile')[0].files[0]; // 새 파일 선택
		    var commGb = commentElement.find('.editCommGb').val(); // commGb 값
		    var deleteFile = commentElement.find('.deleteFile').is(':checked') ? "delete" : "";

		    console.log("수정된 데이터:", {
		        commNo: commNo,
		        commContent: newContent,
		        commGb: commGb,
		        file: newFile ? newFile.name : "첨부파일 없음",
		        deleteFile: deleteFile
		    });

		    var formData = new FormData();
		    formData.append("commNo", commNo);
		    formData.append("commContent", newContent);
		    formData.append("commGb", commGb);
		    formData.append("deleteFile", deleteFile); // 기존 파일 삭제 여부 전달

		    if (newFile) {
		        formData.append("file", newFile);
		    }

		    if (deleteFile) {
		        formData.append("deleteFile", deleteFile);
		    }

		    $.ajax({
		        url: "/project/updateComment.do",
		        type: "POST",
		        data: formData,
		        processData: false,
		        contentType: false,
		        success: function(response) {
		            if (response.success) {
		                alert("댓글이 수정되었습니다.");
		                loadComment(); // 수정 후 댓글 목록 다시 불러오기
		            } else {
		                alert("댓글 수정 실패");
		            }
		        },
		        error: function() {
		            alert("서버 오류 발생");
		        }
		    });
		});
		
		$(document).on('click', '.cancel-edit-btn', function() {
		    var commentElement = $(this).closest('li'); // 클릭한 버튼이 속한 li 찾기
		    var commNo = commentElement.find('.comm-no').val(); // hidden input에서 commNo 가져오기

		    loadComment(); // 댓글 목록 다시 불러와서 원래 내용으로 복구
		});
		
		
		
		
	
		$(document).ready(function() {
		    loadComment();
		    loadEmployeeList(); // 참여 사원 리스트 불러오기

		    // 📌 프로젝트 진행률 차트
		    const labels = ['Module 1', 'Module 2', 'Module 3'];
		    const progressData = [75, 50, 90];

		    if (!labels.length || !progressData.length) {
		        console.error("차트 데이터가 비어 있습니다.");
		    }

		    function loadChart() {
		        const ctx = document.getElementById('progressChart');

		        if (ctx) {
		            new Chart(ctx, {
		                type: 'bar',
		                data: {
		                    labels: labels,
		                    datasets: [{
		                        label: '진행률 (%)',
		                        data: progressData,
		                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
		                        borderColor: 'rgba(75, 192, 192, 1)',
		                        borderWidth: 1
		                    }]
		                },
		                options: {
		                    scales: {
		                        y: {
		                            beginAtZero: true,
		                            max: 100
		                        }
		                    }
		                }
		            });
		        } else {
		            console.error("Canvas 요소를 찾을 수 없습니다.");
		        }
		    }

		    // 📌 파일 업로드 시 comm_gb 값 변경
		    $("#fileUpload").on("change", function() {
		        let commGbInput = $("#comm_gb");
		        commGbInput.val(this.files.length > 0 ? "1" : "0");
		    });

		    // 📌 댓글 추가 버튼 클릭 이벤트
		    $("#submitComment").on("click", function() {
		        let formData = new FormData($("#commentForm")[0]);
		        $.ajax({
		            url: "/project/submitComment.do",
		            type: "POST",
		            data: formData,
		            processData: false,
		            contentType: false,
		            dataType: "json",
		            success: function(res) {
		                if (res) {
		                    console.log(res);
		                    alert("댓글이 추가되었습니다.");
		                    loadComment(); // 댓글 목록 갱신
		                } else {
		                    alert("댓글 추가 실패");
		                }
		            },
		            error: function() {
		                console.log("ajax 오류");
		            }
		        });
		    });

		    // 📌 참여 사원 추가 버튼 클릭 이벤트
		    $("#addEmpBtn").on("click", function() {
		        var empCode = $("#empSelect").val();
		        var partempContent = $('input[name="partempContent"]').val();
		        var projectNo = $('input[name="projectNo"]').val();

		        if (!partempContent) {
		            alert("역할을 입력하세요.");
		            return;
		        }

		        $.ajax({
		            url: "/project/addPartEmp.do",
		            type: "POST",
		            data: {
		                empCode: empCode,
		                partempContent: partempContent,
		                projectNo: projectNo
		            },
		            success: function(response) {
		                if (response.success) {
		                    alert("참여 사원이 추가되었습니다.");
		                    loadEmployeeList(); // 참여 사원 리스트 새로고침
		                } else {
		                    alert("참여 사원 추가 실패");
		                }
		            },
		            error: function() {
		                alert("서버 오류 발생");
		            }
		        });
		    });

		    // 📌 참여 사원 삭제 버튼 클릭 이벤트
		    $(document).on("click", ".removeEmp", function() {
		        var empCode = $(this).data("empcode");
		        var projectNo = $('input[name="projectNo"]').val();

		        $.ajax({
		            url: "/project/removeEmployee.do",
		            type: "POST",
		            data: {
		                empCode: empCode,
		                projectNo: projectNo
		            },
		            success: function(response) {
		                if (response.success) {
		                    alert("참여 사원이 삭제되었습니다.");
		                    loadEmployeeList(); // 참여 사원 리스트 새로고침
		                } else {
		                    alert("삭제 실패");
		                }
		            },
		            error: function() {
		                alert("서버 오류 발생");
		            }
		        });
		    });

		    // 📌 참여 사원 리스트 로딩 함수
		    function loadEmployeeList() {
		        var projectNo = $('input[name="projectNo"]').val();

		        $.ajax({
		            url: "/project/partEmpList.do",
		            type: "POST",
		            data: { projectNo: projectNo },
		            dataType: "json",
		            success: function(data) {
		                var html = "";
		                data.forEach(function(emp) {
		                    html += "<tr>";
		                    html += "<td>" + emp.empCode + "</td>";
		                    html += "<td>" + emp.empName + "</td>";
		                    html += "<td>" + emp.rankCode + "</td>";
		                    html += "<td>" + emp.partempContent + "</td>";
		                    html += "<td><button class='removeEmp' data-empcode='" + emp.empCode + "'>삭제</button></td>";
		                    html += "</tr>";
		                });

		                $("#employeeTableBody").html(html);
		            },
		            error: function() {
		                console.log("사원 리스트 로딩 실패");
		            }
		        });
		    }
		});
	</script>
</body>
</html>