<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
* {
	padding: 0px;
	margin: 0px;
	
}

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

.main-container #title {
	width: 450px;
	font-size: 17px;
}

.doc-title {
	display: flex;
	justify-content: space-between;
	margin: 0px;
	margin-bottom: 10px;
}

.ref {
	display: flex;
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

.half-time {
	display: none;
	gap: 10px;
}

.set-date {
	display: flex;
}

.set-date div {
	height: 100%;
}

.set-date label {
	height: 100%;
}

.set-date input {
	height: 100%;
}

.set-date .result {
	background-color: white;
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
			<h1>휴가 신청서</h1>

			<div class="main-container">
				<form action="/doc/writeVacation.do" method="post" enctype="multipart/form-data">
					<div class="doc-title">
						<div>
							<label for="title">제목</label> <input id="title" type="text"
								name="title" placeholder="제목 입력" />
						</div>

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

					<div>
						<label for="half">반차 신청 여부</label> <input type="checkbox"
							id="half" name="halfDay">
					</div>

					<div class="half-time">

						<div>
							<label for="am" style="background-color: white; border: none;">
								오전</label><input type="radio" name="select" value="a">
						</div>
						<div>
							<label for="pm" style="background-color: white; border: none;">
								오후</label><input type="radio" name="select" value="p">
						</div>
					</div>

					<div class="set-date">
						<div class="date">
							<label for="vac-start">시작일자</label> <input type="date"
								id="vacStart" name="start" max="9999-12-31"
								onchange="onDateChange()">
						</div>
						<div class="date" id="endDate">
							<label for="vac-end">종료일자</label> <input type="date" id="vacEnd"
								name="end" max="9999-12-31" onchange="totalDays()">
						</div>
						<div class="result">
							<span class="result">총 0일</span>
						</div>
					</div>

					<div>
						<label for="vac-content">내용</label>
						<div class="vac-content">
							<textarea name="docContent" maxlength="600"
								placeholder="최대 600자까지 입력 가능합니다."></textarea>
						</div>
					</div>
					<div class="insert-file">
						<input type="file" name="files" multiple>
					</div>
				</form>
				<div class="buttons">
					<button class="submit" type="button" onclick="writeDocument()">작성</button>
					<button class="cancel" type="button">취소</button>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
<script>

//작성조건이 맞는가?
const checkDocument={
		"docTitle":	false,
		"sign":		false,
		"date":		false,
		"sameSign":	true,
		"sameRef":	true,
		"ovarlap":	true
		
};


$('#title').on('input',function(){
	let title=$('#title').val();
	if(title.length>0){
		checkDocument.docTitle=true;
	}else{
		checkDocument.docTitle=false;
	}
});


//날짜계산
function totalDays() {
    const startDate =$('#vacStart').val();
    const endDate = $('#vacEnd').val();
    const result = document.querySelector('.result span');

    if (!startDate || !endDate) {
        result.textContent = "날짜를 전부 입력하라.";
        checkDocument.date=false;
        return;
    }

    const start = new Date(startDate);
    const end = new Date(endDate);

    if (start > end) {
        result.textContent = "적절한 방식으로 입력하시오.";
        checkDocument.date=false;
        return;
       
    }

    const time = end - start; 
    const days = time / (1000 * 60 * 60 * 24);
	console.log(days);
    result.textContent = "총"+ (days + 1)+"일";
    checkDocument.date=true;
}

// $('#half').change(function(){
// 	console.log('gdgdg');
// });

$('#half').change(function() {
const halfChecked = $('#half').is(":checked");
const endDate = $('#endDate');
const halfTime = $('.half-time');
const result = $('.result');

console.log(halfChecked);
console.log(endDate);
console.log(halfTime);
console.log(result);

if (halfChecked) {
	 $('#vacEnd').val($('#vacStart').val());
	   checkDocument.date=true;
//     endDate.style.display = 'none';
//     halfTime.style.display = 'flex';
//     result.style.display = 'none';
	    endDate.css('display','none');
	    halfTime.css('display','flex');
	    result.css('display','none');
} else {
		endDate.css('display','block');
		halfTime.css('display','none');
		result.css('display','block');
//     endDate.style.display = 'block';
//     halfTime.style.display = 'none';
//     result.style.display = 'block';
    clear();
}
});

function clear(){
let am=$("input[name='select']")[0];
let pm= $("input[name='select']")[1];
if(am||pm==true){
    $("input[name='select']").prop("checked",false);
    }

}


function onDateChange() {
    const halfChecked = document.getElementById('half').checked;
    const start = document.getElementById('vacStart').value;
    const endDate = document.querySelector('#endDate');
   
    if (halfChecked) {
        //날짜 세팅
        document.getElementById('vacEnd').value = start;
        

       

    } else {
        
        totalDays();
    }
}

	function searchMan(e) {
		console.log(e);
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
	

	
	
	
	
	
	function writeDocument() {
	    const sign = $('#sign');
	    const ref=$('#ref');
	    const list = sign.children().length;
	    if (list > 0) {
	        checkDocument.sign = true;
	    } else {
	        checkDocument.sign = false;
	    }
	    
	    const signList = [];
	    signList.length=0;
	    sign.children().each(function() {
	        const signValue = $(this).val();
	        if (signList.includes(signValue)) {
	            checkDocument.sameSign = false; 
	           
	        } else {
	            signList.push(signValue);
	        }
	    });
	   

	    // 참조자 확인
	    const refList = [];
	    refList.length=0;
	    ref.children().each(function() {
	        const refValue = $(this).val();
	        if (refList.includes(refValue)) {
	            checkDocument.sameRef = false;
	            
	        } else {
	            refList.push(refValue);
	        }
	    });
		
	    const overlapList=[];
	    checkDocument.overlap=true;
	    overlapList.length=0;
	    sign.children().each(function() {
	    	const signOverLap=$(this).val();
	    	ref.children().each(function(){
   				 refOverLap=$(this).val();
   				
   					overlapList.push(refOverLap);
   				
	    			
	    	});
	    	if(overlapList.includes(signOverLap)){
					checkDocument.overlap=false;
				}
	    	
	    });
	    

	    // 제목, 결재자, 날짜 검증
	    for (let check in checkDocument) {
	        if (!checkDocument[check]) {
	            switch (check) {
	                case "docTitle": alert("제목을 작성하시오."); break;
	                case "sign": alert("최소 1명 이상의 결재자가 필요합니다"); break;
	                case "date": alert("날짜형식이 잘못되었습니다."); break;
	                case "sameSign": alert("중복된 결재자가 있습니다."); checkDocument.sameSign=true; break;  
	                case "sameRef": alert("중복된 참조자가 있습니다.");  checkDocument.sameRef=true; break;
	                case "overlap":	alert("한명의 사원은 결재자 혹은 참조자중 하나만 가능합니다."); checkDocument.overlap=true; break;
	                //중복체크는 확인시 다시 값 초기화
	                
	               
	            }
	            return;
	        }
	    }

	    const formData = new FormData();
	    formData.append("documentTitle", $('#title').val());
	    formData.append("documentTypeCode","va");
	    formData.append("half", $('#half').is(':checked') ? "true" : "false");
	    formData.append("halfTime", $('input[name="select"]:checked').val());
	    formData.append("start", $('#vacStart').val());
	    formData.append("end", $('#vacEnd').val());
	    formData.append("documentContent", $('textarea[name="docContent"]').val());
		formData.append("empCode",${loginEmp.empCode});
	    
	    const signsList = [];
	    $('#sign button').each(function() {
	        signsList.push($(this).val()); 
	    });
	    formData.append("signEmpList", signsList);
			console.log(signsList);
			
	    const refsList = [];
	    $('#ref button').each(function() {
	        refsList.push($(this).val());
	    });
	    formData.append("refEmpList", refsList);
	    console.log(refsList);
	    
	    // 파일 처리
	    const files = $('input[name="files"]')[0].files;
	    for (let i = 0; i < files.length; i++) {
	        formData.append("files", files[i]);
	    }

	    
	    $.ajax({
	        url: "/doc/writeVacation.do",
	        type: "post",
	        enctype: 'multipart/form-data',
	        data: formData,
	        processData: false,  // 파일 업로드 시 필수
	        contentType: false,  // 파일 업로드 시 필수
	        success: function(res) {
	            console.log("연결성공");
	        },
	        error: function() {
	            console.log("오류");
	        }
	    });
	}

	
	
</script>
</html>