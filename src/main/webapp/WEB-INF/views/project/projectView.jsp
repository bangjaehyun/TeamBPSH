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
	background-color: #8FCEFF; /* 헤더 배경: 진한 파랑 */
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
    background-color: #8FCEFF;
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
    background-color: #DDDDFF;
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

/* 공통 버튼 스타일 */
.comment-buttons button {
    border: none;
    padding: 8px 12px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin: 5px 5px 0 0;
}

/* 수정 버튼 스타일 */
.comment-buttons .edit-btn {
    background-color: #fc8383; 
    color: white;
}

.comment-buttons .edit-btn:hover {
    background-color: #f9cfcf; 
}

/* 삭제 버튼 스타일 */
.comment-buttons .delete-btn {
    background-color: #a5a5ff; 
    color: white;
}

.comment-buttons .delete-btn:hover {
    background-color: #DDDDFF; 
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
				<th>프로젝트 참가팀</th>
				<td>
				<c:forEach var="team" items="${project.teamList}" varStatus="status">
        			${team.teamName} <c:if test="${!status.last}">, </c:if>
    			</c:forEach>
    			</td>
				<th>프로젝트 마감일</th>
				<td>${project.projectEnd}</td>
			</tr>
		</table>

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
		                    	'<p>'+ comment.teamName+'&nbsp;' +comment.rankName + '&nbsp;' + comment.empName + '</p>'
		                     				 +  comment.commContent  +'<br> 작성일 : '+ comment.commDate;
		                        
		                   	
		                    if (comment.fileName) {
		                    	commentHtml += '<br> 첨부파일 : <a href="javascript:void(0);" onclick="downloadFile(\'' + comment.filePath + '\', \'' + comment.fileName + '\')">' + comment.fileName + '</a>';
		                        
		                    }
		                    
		                    	 commentHtml += '<div class="comment-buttons">';
		                         commentHtml += '<button type="button" class="edit-btn" onclick="editComment(\'' 
		                             + comment.commNo + '\', \'' 
		                             + comment.commContent + '\', \'' 
		                             + comment.commGb + '\', \''  
		                             + comment.fileName + '\', \'' 
		                             + comment.filePath + '\')">수정</button>'; 

		                             commentHtml += '<button type="button" class="delete-btn" onclick="deleteComment(\'' + comment.commNo + '\')">삭제</button>'
		                             commentHtml += '</div>';
							
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
		    var commentElement = $("li").has("input.comm-no[value='" + commNo + "']");

		    if (commentElement.length === 0) {
		        console.error("Error: 해당 댓글 요소를 찾을 수 없습니다.");
		        alert("댓글 요소를 찾을 수 없습니다.");
		        return;
		    }

		    
		    console.log("수정할 댓글 정보:", {
		        commNo: commNo.trim(),  // 공백 제거
		        commContent: commContent,
		        commGb: commGb,
		        fileName: fileName,
		        filePath: filePath
		    });

		    var editFormHtml = "";
		    editFormHtml += '<input type="hidden" class="comm-no" value="' + commNo.trim() + '">';
		    editFormHtml += '<textarea class="editContent" style="width: 70%; height: 60px;">' + commContent + '</textarea>';
		    editFormHtml += '<br>';
		    editFormHtml += '<input type="file" class="editFile">';
		    editFormHtml += '<input type="hidden" class="editCommGb" value="' + commGb + '">';

		    // 📌 기존 파일이 있는 경우 파일 다운로드 링크 및 삭제 체크박스 추가
		    if (fileName !== "없음") {
		        editFormHtml += '<p>첨부파일: <a href="javascript:void(0);" onclick="downloadFile(\'' + filePath + '\', \'' + fileName + '\')">' + fileName + '</a></p>';
		        editFormHtml += '<label><input type="checkbox" class="deleteFile"> 기존 파일 삭제</label>';
		    } else {
		        commGb = "0"; // 기존 파일이 없으면 commGb를 0으로 설정
		    }

		    editFormHtml += '<button type="button" class="save-edit-btn">저장</button>';
		    editFormHtml += '<button type="button" class="cancel-edit-btn">취소</button>';

		    commentElement.html(editFormHtml);

		    // 📌 파일이 선택되면 commGb 값을 1로 변경
		    commentElement.find(".editFile").on("change", function() {
		        commentElement.find(".editCommGb").val("1");
		    });

		    // 📌 기존 파일 삭제 체크박스 선택 시 commGb 값을 0으로 변경
		    commentElement.find(".deleteFile").on("change", function() {
		        if ($(this).is(":checked")) {
		            commentElement.find(".editCommGb").val("0");
		        }
		    });
		}
			
		$(document).on('click', '.save-edit-btn', function() {
		    var commentElement = $(this).closest('li');
		    var commNo = commentElement.find('.comm-no').val().trim(); // 공백 제거
		    var newContent = commentElement.find('.editContent').val();
		    var newFile = commentElement.find('.editFile')[0].files[0];
		    var commGb = commentElement.find('.editCommGb').val();
		    var deleteFileChecked = commentElement.find('.deleteFile').is(':checked');

		    // 기본값 설정
		    commGb = commGb !== undefined && commGb !== "undefined" ? commGb : "0";

		    console.log("수정된 데이터:", {
		        commNo: commNo,
		        commContent: newContent,
		        commGb: commGb,
		        file: newFile ? newFile.name : "첨부파일 없음",
		        deleteFile: deleteFileChecked ? "1" : "0"
		    });

		    var formData = new FormData();
		    formData.append("commNo", commNo);
		    formData.append("commContent", newContent);

		    if (deleteFileChecked) {
		        formData.append("deleteFile", "1"); 
		        formData.append("commGb", "0"); // 기존 파일 삭제 시 commGb = 0
		    } else {
		        formData.append("deleteFile", "0");
		    }

		    if (newFile) {
		        formData.append("newFile", newFile);
		        formData.append("commGb", "1"); // 새 파일 업로드 시 commGb = 1
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
		                loadComment(); 
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
		
		function deleteComment(commNo) {
		    if (!confirm("정말 이 댓글을 삭제하시겠습니까?")) {
		        return;
		    }

		    console.log("🔴 삭제할 댓글 번호:", commNo);

		    $.ajax({
		        url: "/project/deleteComment.do",
		        type: "POST",
		        data: { commNo: commNo },
		        dataType: "json",
		        success: function(response) {
		            if (response.success) {
		                console.log("✅ 댓글 삭제 성공: ", commNo);
		                alert("댓글이 삭제되었습니다.");
		                loadComment(); // 삭제 후 댓글 목록 다시 로드
		            } else {
		                console.log("❌ 댓글 삭제 실패");
		                alert("댓글 삭제에 실패했습니다.");
		            }
		        },
		        error: function() {
		            console.log("❌ 서버 오류 발생");
		            alert("서버 오류가 발생했습니다.");
		        }
		    });
		}
		
		
	
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