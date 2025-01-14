<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<style>
* {
   margin: 0;
   padding: 0;
   box-sizing: border-box;
}

.complete-wrap {
   width: 100%;
   height: calc(100vh - 50px);
   display: flex;
   justify-content: center;
   align-items: center;
}

.voteList-box {
   width: 70%;
   max-width: 800px;
   height: 72%;
   background: white;
   padding: 18px;
   border-radius: 10px;
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
   overflow-y: auto;
}

/* 애니메이션 효과 */
.item-box {
   background: white;
   border-radius: 8px;
   padding: 15px;
   margin-bottom: 15px;
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
   transition: transform 0.4s;
   opacity: 0;
   transform: translateX(-50px);
   animation: slide-in 0.8s ease-out forwards;
}

/* 순차적으로 애니메이션 딜레이 적용 */
.item-box:nth-child(1) { animation-delay: 0.2s; }
.item-box:nth-child(2) { animation-delay: 0.3s; }
.item-box:nth-child(3) { animation-delay: 0.4s; }
.item-box:nth-child(4) { animation-delay: 0.5s; }
.item-box:nth-child(5) { animation-delay: 0.6s; }

/* 애니메이션 키프레임 */
@keyframes slide-in {
   from {
      opacity: 0;
      transform: translateX(-50px);
   }
   to {
      opacity: 1;
      transform: translateX(0);
   }
}

.item-box:hover {
   transform: translateY(-50px);
}

.item-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   background: #007bff;
   color: white;
   padding: 10px;
   border-radius: 6px;
   font-weight: bold;
   font-size: 16px;
}

.item-body {
   padding: 10px;
}

.emp-name {
   display: inline-block;
   background: #e9ecef;
   color: #333;
   padding: 5px 10px;
   margin: 5px;
   border-radius: 15px;
   font-size: 14px;
}

/* @media screen and (max-width: 768px) { */
/*    .voteList-box { */
/*       width: 90%; */
/*    } */
/*    .item-header { */
/*       font-size: 14px; */
/*    } */
/*    .emp-name { */
/*       font-size: 12px; */
/*    } */
/* } */
.vote-top {
	text-align: center;
	margin: 0 auto;
}

.vote-top>span {
	font-size: 25px;
	font-weight: bold;
}

</style>
</head>
<body>
	<div class="complete-wrap">
		<div class="voteList-box">
			<div class="vote-top">
				<span>${vote.voteTitle}</span>
			</div>
			<c:forEach var="voteList" items="${vote.voteList}">
				<div class="item-box">
					<div class="item-header">
						<span>${voteList.voteName}</span><span>${voteList.voteCount}명</span>
					</div>
					<div class="item-body">
						<c:forEach var="empList" items="${vote.voteEmpList}">
							<c:if test="${voteList.voteListNo eq empList.voteListNo}">
								<span class="emp-name">${empList.empName}</span>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
			<div class="item-box">
				<div class="item-header">
					<span>미참여</span>
				</div>
				<div class="item-body">
					<c:forEach var="empList" items="${vote.voteEmpList}">
						<c:if test="${empty empList.voteListNo}">
							<span class="emp-name">${empList.empName}</span>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>