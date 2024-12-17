<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/default.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet"
   href="https://fonts.googleapis.com/icon?family=Material+Icons"
   type="text/css;" />
    <style>
        *{
            padding: 0px;
            margin: 0px;
        }
        .header-wrap{
            width: 100%;
            height: 50px;
            background: linear-gradient(#99CCFF, #CCCCFF);
        }
        
        .header-img{
            height: 50px;
            background-color:transparent;
        }
        .header-toogle{
            height: 50px;
        }
        .header-left{
        }
    </style>
</head>

<header>
    <div class="header-wrap">
        <div class="header-left">
            <img onclick="toggle()" class="header-toogle"  src="/resources/images/exchange.png">
            <img class="header-img" src="/resources/images/logo.png">
        </div>        
    </div>
</header>
<script>

	function msg(title,text,icon){
		console.log(title);	
	}
</script>

</html>