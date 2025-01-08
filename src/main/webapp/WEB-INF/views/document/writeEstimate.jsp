<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/summernote/summernote-lite.css"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
      

<style>
* {
	padding: 0px;
	margin: 0px;
	
}

.board{
	
	display: flex;
	justify-content: center;
	align-items: center;
	margin-left:300px;
}

.container {
	
	display: flex;
	justify-content: center;
	align-items: center;
	box-sizing: border-box;
}
button:hover{
	cursor:pointer;
}



.header {
	margin : auto 0;
	align-items: center;
}

.header h1 {
	display: flex;
	justify-content: center;
	font-size: 24px;
	margin: 0;
}

.main-container {
	
	border: 1px solid #ccc;
	padding: 10px;
	border-radius: 8px;
}

.main-container>* {
	margin-left: 2%;
}
	.work-day{
		display: flex;
		gap:5px;
	}



	.doc-title {
	width: 550px;
	display: flex;
	border:none;
	border: 1px solid #ccc;
	
	
	border-radius: 8px;
	align-items:center;	
	margin: 0px;
	margin-bottom: 10px;
}
	.doc-title input{
		background:none;
		width:550px;
		border:none;
		font-size: 18px;
	}

.ref {
	display: flex;
}
.ref>button{
	padding: 7px 4px;
	border-radius: 4px;
	background-color:gray;
	border:none;
	color:white;
	
	
}

.ref>button:hover{
	scale:1.1;
}

.ref>button:active{
	scale:1;
	background-color:black;
}

.sign {
	display: flex;
}

.reference {
	display: flex;
}

 .selectedBtn{
       	border:none;
       	background:none;
       	font-size:16px;
       	padding:3px;
       }



	form {
		margin-bottom: 20px;
	}
	
	form * {
		margin-bottom: 5px;
	}
	
	label {
		font-weight: bold;
		background-color: #ccc;
		
		border: 1px solid black;
	}

	.selectedBtn:hover{
		cursor: pointer;
		
	}


	.form-content {
	           
	            margin-bottom: 6px;
	            border: 1px solid #ccc;
	            border-radius: 4px;
	            padding: 10px;
	            background-color:#f5f5f5;
	            display: flex;
	            flex-direction: column;
	            gap: 10px;
	            box-sizing: border-box;
	            
	        }


	.column-title{
           margin-left: 1%;
           display: grid;
           grid-template-columns: 22% 22% 22% 22% 8%;  
           justify-items: center;
           box-sizing:border-box;
           align-items: center;
	}
	
	.column-title label{
		background-color: white;
		border: none;
		font-size:20px;
	}       

	.content-title{
		background-color: white;
		border: none;
		font-size:18px;
	}
	
       .column-row {
           margin-left: 1%;
           display: grid;
           grid-template-columns:22% 22% 22% 22% 8%;  
           gap: 5px;  
          align-items:center;
          margin-top: 3px;
          box-sizing: border-box;
       }
       
       .column-result {
           margin-left: 1%;
           display: grid;
           grid-template-columns:50% 50%;  
           gap: 5px;  
          align-items:center;
          margin-top: 3px;
          box-sizing: border-box;
       }
       
       .column-row select {
    		width: 100%;  
    		display: block;
    		font-size:18px;
		}

       .column-row input {
           width: 100%;
           padding: 8px 0px;
           border: 1px solid #ccc;
           border-radius: 4px;
           font-size: 16px;
           height: 100%;
           box-sizing: border-box;
       }

       .column-row button {
           width: 100%;  
           padding: 10px 4px;
           background-color: gray;
           color: white;
           border: none;
           border-radius: 4px;
           cursor: pointer;
       }

       .add-btn{
           padding: 8px;
           background-color: gray;
           color: white;
           border: none;
           border-radius: 4px;
           cursor: pointer;
       }

	.add-btn:active{
		scale:0.8;
		background-color: black;
	}

	.vac-content {
		width: 550px;
		height: 300px;
	}
	
	.vac-content textarea {
		width: 100%;
		height: 100%;
		resize: none;
	}
	
	.buttons {
		display: flex;
		justify-content: flex-end;
		gap: 20px;
		margin-right: 3%;
	}
	
	.buttons button {
		padding: 10px 20px;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		font-size: 14px;
	}
	
	.buttons .submit {
		background-color: gray;
		color: white;
	}
	
	.buttons .cancel {
		background-color: gray;
		color: white;
}
</style>
</head>
<body>
	<div class="board">
	<div class="container">
		<div class="header">
			<h1>견적서</h1>

			<div class="main-container">
				<form action="/doc/writeVacation.do" method="post" enctype="multipart/form-data">
					<div class="doc-title">
						 <input id="title" type="text"name="title" placeholder="제목 입력" />
					</div>
					<div class="ref">
						<button type="button" onclick="searchMan('sign')">결재자 검색</button>
						<%--결재자 목록 --%>
						<div id="sign" class="sign">
						
						</div>
					</div>
					<div class="ref">
						<button type="button" onclick="searchMan('ref')">참조자 검색</button>
						<div id="ref" class="reference">
						
						</div>
					</div>

			<div class="spending">
             
             	<div class="work-days">
					<label>총 진행일 수</label>
                	<input type="number" id="days"onchange="selectprice(event)" placeholder="총 작업일수를 먼저 입력하시오.">
               	</div>
               	
				<div class="content-title">
                	<label>참여인원</label>
               	</div>
                <div class="form-content">
						<div class="column-title">
							<label>팀</label>
						
							<label>직급</label>
						
							<label>금액</label>

                            <label>인원수</label>
                            
                            <label>삭제</label>
                            
						</div>
                    <div id="projectMem" class="form-column">
						<div  class="column-row">	
                            <div>
                               <select class="team"  onchange="selectprice(event)">
                               		<option value="${team.teamCode }">선택</option>
                               		<c:forEach var="team" items="${teamList }">
                               			<option value="${team.teamCode }">${team.teamName }</option>
                               		</c:forEach>
                               </select>
                            </div>
                            <div>
                               <select class="rank"  onchange="selectprice(event)">
                               		<option value="${team.teamCode }">선택</option>
                               		<c:forEach var="rank" items="${rankList }">
                               			<option value="${rank.rankCode }">${rank.rankName}</option>
                              		</c:forEach>
                               </select>
                            </div>
                           <div class="price">
                           		<input  type="text" name="price" readonly>
                           </div>
                            <div class="days">
                                <input  type="number" name="people" onchange="selectprice(event)">
                            </div>
                           <div></div>
						</div>
                    </div>
						<div class="column-result">
							<div class="result-label">합계</div>
							<div >
								<span id="totalPrice"></span>
							</div>
						</div>
                </div>
				<div>
					<button type="button" class="add-btn" onclick="addInput()">추가</button>
				</div>
				
            </div>

					<div>
						<label for="vac-content" class="content-title">내용</label>
						<textarea  id="summernote" class="vac-content">
							
						</textarea>
					</div>
					<div class="insert-file">
						<input type="file" name="files" multiple>
					</div>
				</form>
				<div class="buttons">
					<button class="submit" type="button" onclick="writeDocument()">작성</button>
					<button class="cancel" type="button" onclick="cancel()">취소</button>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<script>
const priceList = [
    <c:forEach var="price" items="${priceList}" varStatus="status">
        {
            teamCode: "${price.teamCode}",
            rankCode: "${price.rankCode}",
            price: ${price.price},
            teamName: "${price.teamName}",
            rankName: "${price.rankName}"
        }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

	const total=$('#totalPrice');
//가격 출력
function selectprice(event) {
        const row = event.target.closest('.column-row');
        if (!row) return;

        const team = row.querySelector('.team');
        const rank = row.querySelector('.rank');
        const priceInput = row.querySelector('input[name="price"]');
        const daysInput = document.getElementById('days');
		const peopleInput=row.querySelector('input[name="people"]');
				
        if (!team || !rank || !priceInput || !daysInput||!peopleInput) return;

        const selectedTeam = team.value;
        const selectedRank = rank.value;
        const days = parseInt(daysInput.value);
		const people=parseInt(peopleInput.value);
        const matchedPrice = priceList.find(
            price => price.teamCode === selectedTeam && price.rankCode === selectedRank
        );

        if (matchedPrice) {
            
            priceInput.value = (matchedPrice.price*1.1).toFixed(0);
        } else {
            
            priceInput.value = '해당하는 인원이 없습니다..';
        }

        // 합계 계산
        calculateTotal();
    }

    // 합계 계산
    function calculateTotal() {
        let total = 0;

        // 모든 .column-row를 순회하여 가격과 일수를 계산
        document.querySelectorAll('.column-row').forEach(row => {
            const priceInput = row.querySelector('input[name="price"]');
            const peopleInput = row.querySelector('input[name="people"]');
            const daysInput = document.getElementById('days');
            const price = parseFloat(priceInput.value);
            const days = parseInt(daysInput.value);
            const people=parseInt(peopleInput.value);
            console.log(days);
    		console.log(people);
    		console.log(priceInput);
            if (!isNaN(price) && !isNaN(days)) {
                total += price * people * days;
            }
        });

        // 합계 표시
        document.getElementById('totalPrice').textContent = total.toFixed(0); 
    }

    function deleteInput(event) {
        // 삭제 버튼이 클릭된 이벤트 객체를 통해 버튼이 속한 .column-row 요소를 찾기
        const row = event.target.closest('.column-row'); // .column-row 부모 요소 찾기
        if (!row) return;

        const priceInput = row.querySelector('input[name="price"]');
        const peopleInput = row.querySelector('input[name="people"]');
        const price = parseFloat(priceInput.value);
        const people = parseInt(peopleInput.value);
        const daysInput = document.getElementById('days');
        if (!isNaN(price) && !isNaN(days)&&!isNaN(people)) {
            const valueToSubtract = price * people * days;
            // 총합에서 해당 값을 빼기
            updateTotal(valueToSubtract);
        }

        // 해당 행 삭제
        row.remove();

        // 삭제 후 총합 계산
        calculateTotal();
    }

    // 총합 갱신 함수
    function updateTotal(valueToSubtract) {
        const totalElement = document.getElementById('totalPrice');
        let currentTotal = parseFloat(totalElement.textContent);
        if (isNaN(currentTotal)) currentTotal = 0; 

        currentTotal -= valueToSubtract;  // 값 빼기
        totalElement.textContent = currentTotal.toFixed(0); 
    }




function addInput() {
    const column = document.querySelector('.form-column');
    const newRow = document.createElement('div');
    newRow.className = 'column-row';
    newRow.innerHTML = `
        <div>
    	<select class="team" onchange="selectprice(event)">
    		<option value="${team.teamCode }">선택</option>
       		<c:forEach var="team" items="${teamList }">
       			<option value="${team.teamCode }" >${team.teamName }</option>
       		</c:forEach>
     	</select>
        </div>
        <div>
        <select class="rank"onchange="selectprice(event)">
        	<option value="${team.teamCode }">선택</option>
       		<c:forEach var="rank" items="${rankList }">
       			<option value="${rank.rankCode}" >${rank.rankName}</option>
      		</c:forEach>
	     </select>
        </div>
        <div>
        <input  type="text" name="price" readonly>
        </div>
        <div>
        <input  type="number" name="people" onchange="selectprice(event)">
        </div>
        <button type="button" class="add-btn" onclick="deleteInput(event)">삭제</button>
    `;
    column.appendChild(newRow);
}

var checkDocument={
		"docTitle":	false,
		"sign":		false,
		"workDate": false,
		"list":		true
};




var signList = [];
var refList = [];

//결재자
var sign=$('#sign');
function chkSignList(){
signList.length=0;
sign.children().each(function() {
    const signValue = $(this).val();
   
        signList.push(signValue);
    
});
}

//참조자 확인
var ref=$('#ref');
function chkRefList(){
refList.length=0;
ref.children().each(function() {
    const refValue = $(this).val();
  
        refList.push(refValue);
    
});
}


function msg(title, text, icon, callback){
	swal({
		title : title,
		text : text,
		icon : icon
	}).then(function(){
		if(callback != "0"){
			location.href = "/";
		}
	});
	
}




//     function deleteInput(event) {
//         // 삭제 버튼이 클릭된 이벤트 객체를 통해 버튼이 속한 div 요소를 찾아서 삭제
//         const row = event.target.closest('.column-row'); // .column-row 부모 요소 찾기
//         if (row) {
//             row.remove(); // 해당 div 삭제
//         }
//     }
    
    




//const checkDocument=null;

//섬머노트 테스트
//     $(document).ready(function() {
        $('#summernote').summernote(   {
            codeviewFilter : false, // 코드 보기 필터 비활성화
            codeviewIframeFilter : true, // 코드 보기 iframe 필터 비활성화
            height : '300', // 에디터 높이
            width : '100%',
            minHeight : null, // 최소 높이
            maxHeight : null, // 최대 높이
            focus : false, // 에디터 로딩 후 포커스 설정
            lang : 'ko-KR', // 언어 설정 (한국어)
            disableDragAndDrop : false,
            tabDisable : true,
            
            disableResizeEditor : true, // Does not work either   
            
            toolbar : [ [ 'style', [ 'style' ] ], // 글자 스타일 설정 옵션
            [ 'fontsize', [ 'fontsize' ] ], // 글꼴 크기 설정 옵션
            [ 'font', [ 'bold', 'underline', 'clear' ] ], // 글자 굵게, 밑줄, 포맷 제거 옵션
            [ 'color', [ 'color' ] ], // 글자 색상 설정 옵션
            [ 'table', [ 'table' ] ], // 테이블 삽입 옵션
            [ 'para', [ 'ul', 'ol', 'paragraph' ] ], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
            [ 'height', [ 'height' ] ], // 에디터 높이 조절 옵션
            [ 'insert', [ 'picture', 'link', 'video' ] ], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
            [ 'view', [  'fullscreen', 'help' ] ], // 코드 보기, 전체 화면, 도움말 옵션
            ],

            fontSizes : [ '8', '9', '10', '11', '12', '14', '16', '18',
                  '20', '22', '24', '28', '30', '36', '50', '72', ], // 글꼴 크기 옵션

            styleTags : [ 'p', // 일반 문단 스타일 옵션
            {
               title : 'Blockquote',
               tag : 'blockquote',
               className : 'blockquote',
               value : 'blockquote',
            }, // 인용구 스타일 옵션
            'pre', // 코드 단락 스타일 옵션
            {
               title : 'code_light',
               tag : 'pre',
               className : 'code_light',
               value : 'pre',
            }, // 밝은 코드 스타일 옵션
            {
               title : 'code_dark',
               tag : 'pre',
               className : 'code_dark',
               value : 'pre',
            }, // 어두운 코드 스타일 옵션
            'h1', 'h2', 'h3', 'h4', 'h5', 'h6', // 제목 스타일 옵션
            ],
            
            callbacks : {                                                    
               onImageUpload : function(files, editor, welEditable) {   
                      // 다중 이미지 처리를 위해 for문을 사용했습니다.
                  for (var i = 0; i < files.length; i++) {
                     uploadImage(files[i], this);
                  }
               }
            }
        });
//     });
        $('input[name="files"]').on('change', function() {
            const files = $(this)[0].files;
           
        });
    
    function uploadImage(file, editor){
        const form = new FormData(); //<form> 태그
        form.append("uploadFile", file); //<input type="file" name="uploadFile">
        
        $.ajax ({
           url : "/doc/documentImage.do",
           type : "post", //post 필수
           data : form,  //전송 데이터
           processData : false, //기본 문자열 전송 세팅 해제
           contentType : false, //기본 form enctype 해제
           cache:false,
           success : function(savePath){
              //savePath : 파일 업로드 경로
              $(editor).summernote("insertImage", savePath); //에디터 본문에 이미지 표기
              
              //게시글 작성 시, 이미지 중복 등록 방지
            //  $("input[id*=note-dialog]").remove();
           },
           error : function(){
              console.log("오류");
           }
        });
     }

	


$('#title').on('input',function(){
	let title=$('#title').val();
	if(title.length>0){
		checkDocument.docTitle=true;
	}else{
		checkDocument.docTitle=false;
	}
});





	function searchMan(e) {
		
		let popupWidth = 800;
		let popupHeight = 800;

		let left = (window.innerWidth - popupWidth) / 2;
		let top = (window.innerHeight - popupHeight) / 2;

		let popup = window
				.open("", "searchMan", "width=" + popupWidth + ", height="
						+ popupHeight + ", top=" + top + ", left=" + left);

		let form = document.createElement('form');
		form.setAttribute("action", "/doc/searchMan.do");
		form.setAttribute("method", "post");
		//form.setAttribute("data":e);
		let inputType = document.createElement('input');
		    inputType.setAttribute("type", "hidden"); 
		    inputType.setAttribute("name", "type");
		    inputType.setAttribute("value", e);
		    form.appendChild(inputType);
		   
		  
		    
		    
		popup.document.body.appendChild(form);

		form.submit();

	}
	
	function deleteEmp(obj){
		$(obj).remove();
	}
	

	
	//파일상태(고른것 저장용)지정
	var selectedFiles = []; 

	$('input[name="files"]').on('change', function() {
		selectedFiles = []
	   
	    selectedFiles = $(this)[0].files;
	    
	});
	
	
	function writeDocument() {
		checkDocuemnt.list=true;
	    const sign = $('#sign');
	    const ref=$('#ref');
	    const days = $('#days').val();
	    if(days.length>0){
			checkDocument.days=true;
		}else{
			checkDocument.days=false;
		}
	    
	    const list = sign.children().length;
	    if (list > 0) {
	        checkDocument.sign = true;
	    } else {
	        checkDocument.sign = false;
	    }
	    
	   
	    
	    
	    const projectMem=$('#projectMem');
	    const estimateList=[];
	    
	    $('#projectMem .column-row').each(function (){
	    	let estimate='';
	    	 const price = $(this).find('input[name="price"]').val();
	         const people = $(this).find('input[name="people"]').val();
	        
	         const team = $(this).find('.team').val();
	         const rank = $(this).find('.rank').val();
	         if(price.length==0||team.length==0||price.length==0||people.length==0){
	        	 checkDocument.list=false;
	         }
	         estimate+= team +' '+rank+' '+price+' '+people+' '+days;
	         
	         estimateList.push(estimate);
	    });
	    
	    

	    // 제목, 결재자, 날짜 검증
	    for (let check in checkDocument) {
	        if (!checkDocument[check]) {
	            switch (check) {
	                case "docTitle": msg("알림","제목을 작성하시오.","error","0"); break;
	                case "sign": msg("알림","최소1명의 결재자가 필요합니다.","error","0"); break;
	                case "days": msg("알림","날짜가 입력되지 않았습니다.","error","0");break;
	                case "list": msg("알림","인원의 팀과직급,투입인원수를 넣어주세요.","0");break;
	                //중복체크는 확인시 다시 값 초기화
	                
	               
	            }
	            return;
	        }
	    }
	    
	    const formData = new FormData();
	    formData.append("documentTitle", $('#title').val());
	    formData.append("documentTypeCode","es");//견적서
	    formData.append("estimateList",estimateList);
	    formData.append("documentContent",$('#summernote').val());
	   
	    //현재 작성자
		formData.append("empCode",${loginEmp.empCode});
		
		 
		
	    
	    const signsList = [];
	    $('#sign button').each(function() {
	        signsList.push($(this).val()); 
	    });
	    formData.append("signEmpList", signsList);
			
			
	    const refsList = [];
	    $('#ref button').each(function() {
	        refsList.push($(this).val());
	    });
	    formData.append("refEmpList", refsList);
	   
	   
	    // 파일 처리
// 	    const files = $('input[name="files"]')[0].files;
// 	    console.log(files);
// 		for (let i = 0; i < files.length; i++) {
// 		    formData.append("files", files[i]);
// 		    console.log(files[i]);
// 		}
		
		//파일 전송
		if (selectedFiles.length > 0) {
		        for (let i = 0; i < selectedFiles.length; i++) {
		            formData.append("files", selectedFiles[i]);
		            console.log('파일 전송:', selectedFiles[i]);
		        }
		    }
		
	
	    
	    $.ajax({
	        url: "/doc/writeEstimate.do",
	        type: "post",
	        enctype: 'multipart/form-data',
	        data: formData,
	        processData: false,  // 파일 업로드 시 필수
	        contentType: false,  // 파일 업로드 시 필수
	        success: function(res) {
	            if(res>3){
	            	msg("알림","문서작성이 왼료되었습니다.","success","1")
	            }else if(res==3){
	            	msg("알림","견적 목록 적용중 문제가 발생했습니다.","error","0")
	            }
	            else if(res==2){
	            	msg("알림","결재자,참조자 적용중 문제가 발생했습니다.","error","0")
	            }
	            else if(res==1){
	            	msg("알림","첨부파일 적용중에 문제가 발생했습니다.","error","0")
	            }
	            else{
	            	msg("알림","문서내용 적용중 문제가 발생했습니다.","error","0")	
	            }
	        },
	        error: function() {
	            console.log("오류");
	        }
	    });
	}

	function cancel(){
		location.href="/";
	}
	
	
</script>
</html>