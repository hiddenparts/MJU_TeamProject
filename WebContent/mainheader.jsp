<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="titlebar">
	<div class="LiquidContainer" style="width: 1170px;">
		<div id="Search">
			<form method="get" action="article">
				<span> <input name="search" type="text" value="검색"/>
					<a id="query_button" href="#" class="lg"><img src="images/search.gif" alt=""></a>
				</span>
			</form>
		</div>
		<span><a href="main.jsp" id="logo"><img src="images/logo1.gif" alt="logo"></a></span>
		<div id="Navigation">
			<c:choose>
				<c:when test="${sessionScope.user.userid != null}">
					<span> <a href="article?op=write">글쓰기</a>
					</span>
					<span> [ <img class="profile-size1"
						src="images/profile/sm${sessionScope.user.profilephoto}"
						width="35px" height="35px" /> <a
						href="login?op=update&id=${sessionScope.user.nickname}">${sessionScope.user.nickname}님</a>
						]
					</span>
					<span><a href="login?op=logout">로그아웃</a></span>
				</c:when>
				<c:otherwise>
					<!-- <span><a href="#login" id="loginAnchor" class="loginTrigger">로그인</a></span> -->
					<a href="#modallogin" role="button" data-toggle="modal" accesskey="L" title="로그인">Login</a>
					<span><a href="login?op=signup">가입</a></span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

	<div id="modallogin" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<form class="form-horizontal" method="post" action="login" enctype="multipart/form-data">
			<input type="hidden" name="_method" value="login">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<blockquote>
					<p>Log-in</p>
					<small>명터레스트의 모든 서비스를 이용하기 위해서는 로그인이 필요합니다.</small>
				</blockquote>
			</div>
			<div class="modal-body">
				<div class="control-group">
					<label class="control-label" for="idform">ID</label>
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-user"></i></span>
							<input class="span3" name="userid" type="text" id="idform">
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="pwform">Password</label>
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-lock"></i></span>
							<input class="span3" name="pwd" type="password" type="text" id="pwform">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
				<input type="submit" class="btn btn-primary"  value="로그인">
			</div>
		</form>
	</div>