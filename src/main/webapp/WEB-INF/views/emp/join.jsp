<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

 body {
            width:100%;
            height:100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(#99CCFF, #CCCCFF);
        }
        .container {            
            
            justify-content: center;
            align-content: center;
            width: 800px;
            height:800px;
            margin: 50px auto;
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            padding: 20px;
            border-radius: 20px;
           
        }
        .container *{
            margin-left: 7%;
        }
        .container h1 {
            text-align: center;
            font-size: 40px;
            margin-bottom: 20px;
            color:white;

        }
        .inputs {
            margin-bottom: 15px;
             
        }
        .inputs label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color:#999999;
        }
        .inputs input {
            width:70%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 10px;
           
           
        }
        .inputs p{
            margin:0;
            margin-left:8%;
        }



        .inputs #btnCheckId {
            background-color: #c9a1f5;
            color: white;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-left: 5px;
        }
        .inputs .btnCheckId:hover {
            background-color: #f351d8;
        }
        
        .btnSubmit{
            width: 60%;
            background-color: #c9a1f5;
            color: white;
            padding: 10px;
            font-size: 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-left: 17%;
        }
        .btnSubmit:hover {
            background-color: #f351d8;
            
        }
        .res{
            display: flex;
            margin:0;
        }
</style>
</head>
<body>
	  <div class="container">
        <h1>회원가입</h1>
        <form action="/" method="post" onsubmit="return joinVal()">
            <div class="inputs">
                <label for="empId">아이디 입력</label>
                <div class="res">
                <input type="text" id="empId" name="empId" placeholder="입력한 아이디 기준으로 이메일이 생성됩니다.">
                    <button type="button" id="btnCheckId">중복확인</button> 
                </div>
                    <p id="idMessage" class="input-msg"></p>
            </div>
            <div class="inputs">
                <label for="empPw">비밀번호 입력</label>
                <input type="password" id="empPw" name="empPw" placeholder="비밀번호 입력">
                 <p id="pwMessage" class = "input-msg"></p>
            </div>
            <div class="inputs">
                <label for="empPwConfirm">비밀번호 확인</label>
                <input type="password" id="empPwConfirm" name="empPwConfirm" placeholder="비밀번호 확인">
               
            </div>
            <div class="inputs">
                <label for="name">이름</label>
                <input type="text" id="empName" name="empName" placeholder="이름 입력">
                <p id="nameMessage" class = "input-msg"></p>
            </div>
            <div class="inputs">
                <label for="empPhone">휴대전화 번호 입력</label>
                <input type="text" id="phone" name="phone" placeholder="휴대전화 번호 입력(숫자만)" >
                <p id="phoneMessage" class = "input-msg"></p>
            </div>
            <button type="submit" class="btnSubmit">신청하기</button>
        </form>
       
    </div>
	
	<script>
	//입력한 정보들이 유효한가?
	const checkObj = {
			"empId" 		: false,
			"checkId"		: false, //아이디 중복 체크 결과
			"empPw" 		: false,
			"empPwConfirm" 	: false,
			"empName" 		: false,
			"empPhone" 		: false
	};
	const empId = $('#empId'); 
	const idMessage = $('#idMessage');
	
	//아이디 입력
if(userId.val().length < 1){
		//비었을떄는 출력X
	}
	empId.on('input',function(){
		checkObj.empId=false;
		idMessage.removeClass("valid");
		idMessage.removeClass("invalid");
		const regExp = /^[a-zA-Z0-9]{6,16}$/;
		if(regExp.test($(this).val())){
			idMessage.html("");
			idMessage.addClass("valid");
			checkObj.empId = true;
		}else{
			//일치하지 않을 때
			idMessage.html("영어, 숫자 8~20글자 사이로 입력하세요.");
			idMessage.addClass("invalid");
			checkObj.empId = false;
		}
	});
	
	//아이디 중복체크 요청 이전에, 아이디를 입력했는지 체크
	$('#btnCheckId').on('click', function(){
		if(!checkObj.empId){
			alert("아이디를 먼저 작성해 주세요");
			return false;
		}
		
		
		//ajax는 나중에 적용
	});
	
	//비밀번호 입력
	const empPw = $('#empPw'); //비밀번호 입력 input
	const pwMessage = $('#pwMessage');
	
	empPw.on('input',function(){
		pwMessage.removeClass('valid');
		pwMessage.removeClass('invalid');
		const regExp = /^[a-zA-Z0-9!@#$%^&*]{8,20}$/;
		
		if(regExp.test($(this).val())){
			pwMessage.html("");
			pwMessage.addClass("valid");
			checkObj.empPw = true;
		}else{
			//일치하지 않을 때
			pwMessage.html("영어, 숫자,특수문자 포함 8~20글자 사이로 입력하세요.");
			pwMessage.addClass("invalid");
			checkObj.empPw = false;
		}
	});
	
	//비밀번호 확인
	const empPwConfirm = $('#empPwConfirm');
	empPwConfirm.on('input',checkPw);

	//이벤트 핸들러 함수!
	function checkPw(){
		pwMessage.removeClass('valid');
		pwMessage.removeClass('invalid');
		
		if(empPwConfirm.val()==empPw.val()){
			// 비밀번호 값 == 비밀번호 확인 값
			pwMessage.addClass('valid');
			pwMessage.html("");
			checkObj.empPwConfirm = true;
		}else{
			pwMessage.addClass('invalid');
			pwMessage.html('비밀번호가 일치하지 않습니다.');
			checkObj.empPwConfirm = false;
		}
	};
	//이름 const regExp = /^[가-힣]{2,4}$/;
	const empName=$('#empName');
	const nameMessage=$('#nameMessage');
	
	empName.on('input',function(){
		nameMessage.removeClass('valid');
		nameMessage.removeClass('invalid');
		const regExp = /^[가-힣]{2,4}$/;
		
		if(regExp.test($(this).val())){
			nameMessage.addClass("valid");
			nameMessage.html("");
			checkObj.empName= true;
		}else{
			nameMessage.addClass("invalid");
			nameMessage.html("올바른 이름이 아닙니다");
			checkObj.empName= false;
		}
	});
	
	
	
	//전화번호
	const empPhone=$('#empPhone');
	const phoneMessage = $('#phoneMessage');
	empPhone.on('input',function(){
		phoneMessage.removeClass('valid');
		phoneMessage.removeClass('invalid');
		const regExp = /^[0-9]{11}$/;
		
		if(regExp.test($(this).val())){
			phoneMessage.html("");
			phoneMessage.addClass("valid");
			checkObj.empPhone = true;
		}else{
			//일치하지 않을 때
			phoneMessage.html("올바른 휴대전화번호를 입력해주세요.");
			phoneMessage.addClass("invalid");
			checkObj.empPhone = false;
		}
	});
	
	function joinVal(){
	      
	      for(let key in checkObj){
	    	  
	    	  if(!checkObj[key]){
	              switch(key){//memberId or memberPw or memberName ......
	              case"empId"            : alert("아이디 형식이 다릅니다"); break;
           		 case"idDuplChk"		: alert("아이디 중복체크를 해주세요"); break;
	              case"empPw"            : alert("비밀번호 형식이 다릅니다."); break;
	              case"empPwConfirm"      : alert("비밀번호가 일치하지 않습니다."); break;
	              case"empName"         : alert("올바른 이름이 아닙니다.");     break;
	              case"empPhone"         : alert("전화번호 형식이 다릅니다.");  break;
	              }
	           
	              return false;
	           }
	        }
     	 return true;
	    	  
	      
		
	}
	
		
		
	
	
	
	</script>
</body>
</html>