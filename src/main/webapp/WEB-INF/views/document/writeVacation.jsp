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
	box-sizing: border-box;
}

.container {
	width : calc(100vw - 55px);
	height: calc(100vh - 50px);
	display: flex;
	justify-content: center;
	align-items: center;
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
	padding: 3px 4px;
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
	<div class="container">
		<div class="header">
			<h1>휴가 신청서</h1>

			<div class="main-container">
				<form action="" method="post" enctype="multipart/form-data">
					<div class="doc-title">
						<div>
							<label for="title">제목</label> <input id="title" type="text"
								name="title" placeholder="제목 입력" />
						</div>

					</div>
					<div class="ref">
						<button type="button" onclick="searchMan('sign')">결제자 검색</button>
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
								오전</label><input type="radio" name="select" value="am">
						</div>
						<div>
							<label for="pm" style="background-color: white; border: none;">
								오후</label><input type="radio" name="select" value="pm">
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
							<span>총 0일</span>
						</div>
					</div>

					<div>
						<label for="vac-content">내용</label>
						<div class="vac-content">
							<textarea name="docContent" maxlength="600"
								placeholder="최대 600자까지 입력 가능합니다."></textarea>
						</div>
					</div>

				</form>
				<div class="buttons">
					<button class="submit" type="submit">작성</button>
					<button class="cancel" type="button">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	function totalDays() {
		const startDate = document.getElementById('vacStart').value;
		const endDate = document.getElementById('vacEnd').value;
		const result = document.querySelector('.result span');

		if (!startDate || !endDate) {
			result.textContent = "날짜를 전부 입력하라.";
			return;
		}

		const start = new Date(startDate);
		const end = new Date(endDate);

		if (start > end) {
			result.textContent = "적절한 방식으로 입력하시오.";
			return;
		}

		const time = end - start;
		const days = time / (1000 * 60 * 60 * 24);

		result.textContent = `총 ${days + 1}일`;
	}

	$('#half').change(
			function() {
				const halfChecked = document.getElementById('half').checked;
				const endDate = document.querySelector('#endDate');
				const halfTime = document.querySelector('.half-time');
				const result = document.querySelector('.result span');

				if (halfChecked) {
					document.getElementById('vacEnd').value = document
							.getElementById('vacStart').value;

					endDate.style.display = 'none';
					halfTime.style.display = 'flex';

					result.style.display = 'none';
				} else {
					endDate.style.display = 'block';
					halfTime.style.display = 'none';
					result.style.display = 'block';
					clear();
				}
			});

	function clear() {
		let am = $("input[name='select']")[0];
		let pm = $("input[name='select']")[1];
		if (am || pm == true) {
			$("input[name='select']").prop("checked", false);
		}

	}

	function onDateChange() {
		const halfChecked = document.getElementById('half').checked;
		const start = document.getElementById('vacStart').value;
		const endDate = document.querySelector('#endDate');

		if (halfChecked) {
			//날짜 세팅
			document.getElementById('vacEnd').value = start;
			//여기까지만 실행됨

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
		form.setAttribute("action", "/doc/searchMan");
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
</script>
</html>