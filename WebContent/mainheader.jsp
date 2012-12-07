<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="titlebar">
	<div class="LiquidContainer" style="width: 1170px;">
		<div id="Search">
			<form method="get" action="article">
				<span> <input name="search" type="text" value="검색" />
					<input type="image" id="searchbtn" src="images/search.gif" title="검색버튼"/>
				</span>
			</form>
		</div>
		<span><a href="" id="logo"><img src="images/logo1.gif" alt="logo"></a></span>
		<div id="Navigation">
			<span>소개</span>
			<c:choose>
				<c:when test="${sessionScope.user.userid != null}">
					<span> <a href="article?op=write">글쓰기</a>
					</span>
					<span> [ <img class="media-object"
						src="images/profile/sm${sessionScope.user.profilephoto}"
						width="35px" height="35px" /> <a
						href="login?op=update&id=${sessionScope.user.nickname}">${sessionScope.user.nickname}님</a>
						]
					</span>
					<span><a href="login?op=logout">로그아웃</a></span>
				</c:when>
				<c:otherwise>
					<!-- <span><a href="#login" id="loginAnchor" class="loginTrigger">로그인</a></span> -->
					<span class="loginTrigger" accesskey="L" title="로그인">로그인</span>
					<span><a href="login?op=signup">가입</a></span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<div class="mwLogin">
	<!-- class에 open을 추가하면 css에서 display를 none에서 block으로 변경하여 팝업창이 보이게 됨 -->
	<div class="bg"></div>
	<div id="login" class="gLogin">
		<a href="#loginAnchor" class="close" title="닫기">X</a>
		<form id="gLogin" class="gLogin" method="post" action="login"
			enctype="multipart/form-data">
			<fieldset>
				<input type="hidden" name="_method" value="login">
				<legend>Login</legend>
				<div class="item">
					<label for="uid" class="iLabel">ID</label>
					<input name="userid" type="text" value="" id="uid" class="iText uid" />
				</div>
				<div class="item">
					<label for="upw" class="iLabel">PASSWORD</label>
					<input name="pwd" type="password" value="" id="upw" class="iText upw" />
				</div>
				<div>
					<input name="접속" type="submit" value="로그인" />
				</div>
				<ul class="help">
					<li class="first"><a href="#">아이디/비밀번호 찾기</a></li>
					<li><a href="#">회원 가입</a></li>
				</ul>
			</fieldset>
		</form>
	</div>
</div>