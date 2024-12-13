<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
            background-color: white;
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
            <img class="header-img" src="/resources/images/logo.jpg">
        </div>        
    </div>
</header>


</html>