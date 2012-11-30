<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>D_2조 팀프로젝트</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/mwLogin.css" rel="stylesheet">
		<script src="js/jquery-1.8.2.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/mwLogin.js"></script>
   
	</head>

	<body>
		<div id="titlebar pull-right">
            <span>검색</span>
            <span>타이틀로고</span>
            <span>소개</span>
            <c:choose> 
            	<c:when test="${sessionScope.user.userid != null}" >
            		<span> <a href="article?op=write">글쓰기</a> </span>
	            	<span> [
	            	<img class="media-object" src="images/profile/sm${sessionScope.user.profilephoto}" width="35px" height="35px"/> 
	            		<a href="login?op=update&id=${sessionScope.user.nickname}">${sessionScope.user.nickname}님</a> ] 
	            	</span>
	            	<span><a href="login?op=logout">로그아웃</a></span>
            	</c:when>
            	<c:otherwise>
	            	<span><a href="#login" id="loginAnchor" class="loginTrigger" accesskey="L" title="Login">로그인</a></span>
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

		<div class="mwLogin"> <!-- class에 open을 추가하면 css에서 display를 none에서 block으로 변경하여 팝업창이 보이게 됨 -->
			<div class="bg"></div>
			<div id="login" class="gLogin">
				<a href="#loginAnchor" class="close" title="닫기">X</a>
				<form id="gLogin" class="gLogin" method="post" action="login" enctype="multipart/form-data">
					<fieldset>
						<input type="hidden" name="_method" value="login">
						<legend>Login</legend>
						<div class="item">
							<label for="uid" class="iLabel">ID</label><input name="userid" type="text" value="" id="uid" class="iText uid" />
						</div>
						<div class="item">
							<label for="upw" class="iLabel">PASSWORD</label><input name="pwd" type="password" value="" id="upw" class="iText upw" />
						</div>
						<div><input name="접속" type="submit" value="로그인" /></div>
						<ul class="help">
							<li class="first"><a href="#">아이디/비밀번호 찾기</a></li>
							<li><a href="#">회원 가입</a></li>
						</ul>
					</fieldset>
				</form>
			</div>
		</div>

</body>
</html>
<script>
</script>