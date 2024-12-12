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
</head>

	<style>
       * {
        margin: 0;
        padding: 0;
    }

    .menubar{
        display: flex;
        position:fixed;
        margin-top: 50px;
            }


    .side {
        background-color: gray;
        position: fixed;
        width: 40px;
        height: 100%;
        padding: 3px;
        
        
    }
    #main {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }
    #main li {
        padding: 0px;
        font-weight: bold;
    }

    .side ul li:hover {
        background: #333;
        color: #fff;
    }

    
    #header {
        display: flex;
        gap: 30px;
        list-style: none;
        margin-top: 0;
        margin-bottom: 0;
        padding: 0;
        height: 50px;
        background: linear-gradient(#99CCFF, #CCCCFF);
    }
    #header:first-child {
        justify-content: space-between;
        
    }
    
    .sub li{
        
        flex-wrap: wrap;
        margin: 10px;
        
    }
    .searchvar {
        display: flex;
        
    }
    .searchvar {
        gap: 5px;
    }
    #inputInIcon {
        width: 150px;
        height: 50px;
        position: relative;
        display: flex;
    }
    #inputInIcon input {
        width: 100%;
        height: 50%;
        border-radius: 15px;

    }

    #searchIcon {
        position: absolute;
        
        top: 2px;
        bottom: 0;
        right: 5px;
    }
    
    

</style>
<header>
<div class="head">
        <div class="head">
            <ul id="header">
                <div class="sub" style="display: flex;">
                <li id="click"><button onclick="btn()">토글</button></li>
                    <li>로고</li>
                    <li>회사명</li>
                </div>
                <div class="searchvar">
                    <div id="inputInIcon">
                        <li>
                            <input type="text" value="검색어"  onkeypress="return runScript(event)">
                            <label type="submit" class="material-icons" id="searchIcon">search</label>
                        </li>
                    </div>
                    <li class="material-icons">person</li>
                </div>
            </ul>
            
        </div>
</div>
        <%--
    <div class="menubar">
        <div class="side">
          <ul id="main">
          	<div>
            	<li>
                	<div style="height: 50px;">
                    	<p class="material-icons" style="padding-left: 6px;">diversity_3</p>
                    	<p style="font-size: 10px; margin-top: 0; ">프로젝트</p>
                 	</div>
             	</li>
          </div>
            <li>문서</li>
            <li>문서</li>
            <li>문서</li>
            <li>문서</li>
            <li>문서</li>
            <li>문서</li>
            <li>문서</li>
            <li>문서</li>
          </ul>
        </div>
    </div>
    
    --%>
   
    


</header>
<script>
    function btn(){
   if($(".side").css('display') == "block"){
            $('.side').css('display','none');
         }else{
            $('.side').css('display','block');
         }
    }
    
    //<input type="password" onkeypress="return runScript(event)" />
    
    /*//function runScript(e) 
    {if(e.keyCode == 13) { 
        alert('dsadsa');
        return false; // 추가적인 이벤트 실행을 방지하기 위해 false 리턴    
        } 
        else {return true;}}
        */
    
    
     
    
</script>

</html>