<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/base.css" rel="stylesheet">
		<script src="js/jquery-1.8.2.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
	</head>

	<body>
		<div id="titlebar pull-right">
            <span>검색</span>
            <span>타이틀로고</span>
            <span>소개</span>
            <c:choose> 
            	<c:when test="${sessionScope.userid != null}" >
            		<span>글쓰기</span>
	            	<span> [<img class="media-object" src="image/sm${sessionScope.profilephoto}" width="35px" height="35px"/> 
	            		<a href="login?op=update&id=${sessionScope.usernickname}">${sessionScope.usernickname}님</a>] 
	            	</span>
	            	<span><a href="login?op=logout">로그아웃</a></span>
            	</c:when>
            	<c:otherwise>
	            	<span><a href="login">로그인</a></span>
            		<span><a href="login?op=signup">가입</a></span>
            	</c:otherwise>
            </c:choose>
            <!--<c:if test="${sessionScope.userid != null}" >
						<span> 로그인 ID : <c:out value="${sessionScope.userid}"/> </span>
						</c:if>
						<c:if test="${sessionScope.userid == null}" >
						<span> 로그인 아님 </span>
						</c:if> -->
			</div>
	</body>
</html>
<script>
</script>