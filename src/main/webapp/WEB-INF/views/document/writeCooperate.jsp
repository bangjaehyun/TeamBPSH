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

.board{
	
	display: flex;
	justify-content: center;
	align-items: center;
	
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
	font-size: 26px;
   color: #333;
   margin-bottom: 20px;
   text-align: center;
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

/* 결재자 및 참조자 버튼 스타일 */
.ref {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 15px;
}

.ref > button {
	padding: 8px 12px;
	border-radius: 6px;
	background-color: #007bff;
	color: white;
	border: none;
	cursor: pointer;
	transition: all 0.3s;
}

.ref > button:hover {
	background-color: #0056b3;
	transform: scale(1.05);
}

.ref > button:active {
	background-color: #003f80;
	transform: scale(1);
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
	
	span {
		font-weight: bold;
		
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
           grid-template-columns: 32% 32% 32%;  
           justify-items: center;
           box-sizing:border-box;
           align-items: center;
	}
	
	.column-title span{
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
           grid-template-columns:32% 32% 32%;  
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
           width: 40%; 
           margin-left:25%; 
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
	
	.insert-file input {
	   padding: 10px;
	   cursor: pointer;
	  }
	
	
/* 버튼 스타일 */
.buttons {
	display: flex;
	justify-content: flex-end;
	gap: 15px;
	margin-top: 20px;
}

.buttons button {
	padding: 10px 20px;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	transition: all 0.3s;
}

.buttons .submit {
	background-color: #28a745;
	color: white;
}

.buttons .submit:hover {
	background-color: #218838;
	transform: scale(1.05);
}

.buttons .cancel {
	background-color: #dc3545;
	color: white;
}

.buttons .cancel:hover {
	background-color: #c82333;
	transform: scale(1.05);
}
</style>
</head>
<body>
	<div class="board">
	<div class="container">
		<div class="header">
			<h1>협조전</h1>

			<div class="main-container">
				
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

			<div class="cooperate">
         
                <div class="form-content">
						<div class="column-title">
							<span>부서선택</span>
						
							<span>협조 대상 팀</span>
						
                            <span>삭제</span>
                            
						</div>
                    <div id="projectMem" class="form-column">
						<div  class="column-row">	
                            <div>
                               <select class="scope"  onchange="selectScope(this)">
                               		<option value="">선택</option>
                               		<c:forEach var="dept" items="${deptList }">
                               			<option value="${dept.deptCode}">${ dept.deptName}</option>
                               		</c:forEach>
                               </select>
                            </div>
                            <div>
                            	<select class="selectOption">	
	                             	
	                            
                             	</select> 
                            </div>
                           
                           <div></div>
						</div>
                    </div>
						
                </div>
				<div>
					<button type="button" class="add-btn" onclick="addInput()">추가</button>
				</div>
				
            </div>

					<div>
						<span  class="content-title">내용</span>
						<textarea  id="summernote" class="vac-content">
							
						</textarea>
					</div>
					<div class="insert-file">
						<input type="file" name="files" multiple>
					</div>
				
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

var checkDocument={
		"docTitle":	false,
		"sign":		false,
		"list":		true
};



function selectScope(event){
    var selectOptList = [];
    const select = $(event).val(); // select box의 값
    const scope = $(event).parent().next().children('select'); // 부모 요소 다음의 select box

    console.log(scope);

    // select 옵션 초기화
    scope.empty(); // jQuery의 empty() 메서드를 사용하여 기존 항목을 지움

	    const defaultOption = document.createElement('option');
	    defaultOption.className = "selectOption";
	    defaultOption.value = ""; 
	    defaultOption.textContent = "선택";
	    scope.append(defaultOption);
        // deptList를 순회하여 데이터 추가
        <c:forEach var="selectOpt" items="${teamList}">
            var Data = {
                "teamCode": '${selectOpt.teamCode}',
                "teamName": '${selectOpt.teamName}',
                "deptCode": '${selectOpt.deptCode}'
            };
            selectOptList.push(Data);
			</c:forEach>
        for (let i = 0; i < selectOptList.length; i++) {
            
            if(select == selectOptList[i].deptCode){

           	const newRow = document.createElement('option');
           	newRow.className="selectOption";
            newRow.value = selectOptList[i].teamCode;  
            newRow.textContent = selectOptList[i].teamName;  
            scope.append(newRow);
        }
            
        }

    console.log(selectOptList);  // 리스트 출력 (디버깅용)
}
//새 항목 추가
function addInput() {
	 var selectOptList = [];
	 <c:forEach var="selectOpt" items="${deptList}">
     var Data = {
         "deptCode": '${selectOpt.deptCode}',
         "deptName": '${selectOpt.deptName}'
     };
     selectOptList.push(Data);
 </c:forEach>
	 
 	
    const column = document.querySelector('.form-column');
    const newRow = document.createElement('div');
    newRow.className = 'column-row';
    newRow.innerHTML = `
        <div>
    	<select class="scope" onchange="selectScope(this)">
    	 
     	</select>
        </div>
        <div>
       		<select class="selectOption">
       		
       		</select>
        </div>
       
        <button type="button" class="add-btn" onclick="deleteInput(event)">삭제</button>
    `;
    	const selectScope=newRow.querySelector('.scope');
    	 const selectOption = newRow.querySelector('.selectOption');
	    const option1 = document.createElement('option');
	    option1.value = "";
	    option1.textContent = "선택";
	    selectScope.appendChild(option1);
    
    for (let i = 0; i < selectOptList.length; i++) {
        const option = document.createElement('option');
        option.value = selectOptList[i].deptCode;
        option.textContent = selectOptList[i].deptName;
        selectScope.appendChild(option);
    }
    
    selectOption.addEventListener('change', function() {
       checkTeam(this);
    });
    
    column.appendChild(newRow);
    
}

function checkTeam(event){
    const teamList = [];

    const teamCode = event.value; 
    const currentRow = event.closest('.column-row'); 

    let isDuplicate = false; // 중복 체크 변수

    // 모든 row를 순회하여 중복된 팀 코드가 있는지 확인
    document.querySelectorAll('.column-row').forEach(row => {
        const teamInput = row.querySelector('.selectOption');
        const team = teamInput.value;

        if (team === teamCode && row !== currentRow) {
          
            isDuplicate = true;
        } else {
           
            if (!teamList.includes(team)) {
                teamList.push(team);
            }
        }
    });

    
    if (isDuplicate) {
        currentRow.remove();
       
    }
}




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


function deleteInput(event) {
    // 삭제 버튼이 클릭된 이벤트 객체를 통해 버튼이 속한 div 요소를 찾아서 삭제
    const row = event.target.closest('.column-row'); // .column-row 부모 요소 찾기
    if (row) {
        row.remove(); // 해당 div 삭제
    }
}


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
		checkDocument.list=true;
	    const sign = $('#sign');
	    const ref=$('#ref');
	   
	    
	    const list = sign.children().length;
	    if (list > 0) {
	        checkDocument.sign = true;
	    } else {
	        checkDocument.sign = false;
	    }
	    
	   
	    
	    
	    
	    
	    const projectMem=$('#projectMem');
	    const cooperateList=[];
	    
	    $('#projectMem .column-row').each(function (){
	    	let coop='';
	    	 const scope= $(this).find('.scope').val();
	         const selectOption = $(this).find('.selectOption').val();
	        
	        
	         if(scope.length==0||selectOption.length==0){
	        	 checkDocument.list=false;
	         }
	         coop+= scope+' '+selectOption;
	         
	         cooperateList.push(coop);
	    });
	    
	    

	    // 제목, 결재자, 날짜 검증
	    for (let check in checkDocument) {
	        if (!checkDocument[check]) {
	            switch (check) {
	                case "docTitle": msg("알림","제목을 작성하시오.","error","0"); break;
	                case "sign": msg("알림","최소1명의 결재자가 필요합니다.","error","0"); break;
	                case "list": msg("알림","협조 대상을 올바르게 입력해 주세요","error","0"); break;
	                
	                //중복체크는 확인시 다시 값 초기화
	                
	               
	            }
	            return;
	        }
	    }
	    
	    console.log(cooperateList);
	    const formData = new FormData();
	    formData.append("documentTitle", $('#title').val());
	    formData.append("documentTypeCode","co");//협조전
	    formData.append("cooperateList",cooperateList);
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
	        url: "/doc/writeCooperate.do",
	        type: "post",
	        enctype: 'multipart/form-data',
	        data: formData,
	        processData: false,  // 파일 업로드 시 필수
	        contentType: false,  // 파일 업로드 시 필수
	        success: function(res) {
	            if(res>3){
	            	msg("알림","문서작성이 왼료되었습니다.","success","1")
	            }else if(res==3){
	            	msg("알림","협조대상 적용중 문제가 발생했습니다.","error","0")
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