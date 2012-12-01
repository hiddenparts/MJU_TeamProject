<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>D_2조 팀프로젝트</title>
	<link href="css/style.css" rel="stylesheet">
	<link href="css/photo.css" rel="stylesheet">		
	<script src="js/jquery-1.8.2.js"></script>
</head>

<body>

	<jsp:include page="mainheader.jsp" />

	<nav id="menubar">메뉴바</nav>

	<div id="list">
		<ul id="tiles">
			<!-- These are our grid blocks -->
			<c:forEach var="post" items="${posts }">
				<li>
					<!-- Start of Article -->
					<section class="item" id="${post.article.postid }"> 
						<header>
							<!-- 작성자 정보 -->
							<p>
								<span> 
									<img src="images/profile/sm${post.member.profilephoto }" width="35px" height="35px"> 
								</span> 
								<span> 
									<b>${post.member.nickname }</b>
								</span>
							</p>
						</header>
						<!-- 작성자 정보 -->

						<article id="itemcontents">
							<!-- 글 사진 및 내용 -->
							<a href="#${post.article.postid }" class="popupTrigger">
							<img src="images/photo/sm${post.article.photo }">
							<p>${post.article.content }</p>
							</a>
						</article>
						<!-- 글 사진 및 내용 -->

						<article id="itemcomment">
							<!-- 코멘트 리스트 -->
							<c:if test="${post.comment != null}">
								<c:forEach var="comment" items="${post.comment }">
									<p>
										<span> <img
											src="images/profile/sm${comment.userphoto }" width="35px"
											height="35px"></span> <span> <b>${comment.usernick
												}</b> ${comment.commentcontent }
										</span>
									</p>
								</c:forEach>
							</c:if>
						</article>
						<!-- 코멘트 리스트 -->

						<article id="itemform">
							<!-- 댓글 입력창 -->
							<c:if test="${sessionScope.user.userid != null}">
								<span><img class="media-object"
									src="images/profile/sm${sessionScope.user.profilephoto}" width="35px" height="35px" /></span>
								<form method="post" action="Comment">
									<input type="hidden" name="postid" value="${post.article.postid }" /> 
									<input type="text" name="comment"> 
									<!-- <input type="submit" value="댓글"> -->
								</form>
							</c:if>
						</article> 
						<!-- 댓글 입력창  -->
					</section> <!-- End of Article -->
				</li>
			</c:forEach>
			<!-- End of grid blocks -->
		</ul>

	</div>

		<div class="popup">
			<div class="bg"></div>
			<div id="photopage">
				<div id="name"></div>
					
				<div id="photo"><div id="photodetail"></div></div>
				
				<c:if test="${sessionScope.user.userid != null}">
				<div id="form">
					<form method="post" action="Comment">
						<input type="text"name="comment"/>
						<input type="submit" value="댓글"/> 
					</form>
				</div>
				</c:if>
				
				<div id="comment"></div>
			</div>
		</div>



</body>

</html>

<!-- Include the plug-in -->
<script src="js/jquery.wookmark.js"></script>

<!-- Include the imagesLoaded plug-in -->
<script src="js/jquery.imagesloaded.js"></script>

<!-- Once the page is loaded, initialize the plug-in. -->
<script type="text/javascript">
$(function($){

	$('#tiles').imagesLoaded(function() {
		// Prepare layout options.
		var options = {
			autoResize : true, // This will auto-update the layout when the browser window is resized.
			container : $('#list'), // Optional, used for some extra CSS styling
			offset : 2, // Optional, the distance between grid items
			itemWidth : 210
		// Optional, the width of a grid item
		};

		// Get a reference to your grid items.
		var handler = $('#tiles li');

		// Call the layout function.
		handler.wookmark(options);
	});
	
	var id;
	// show pop-up -----------------
	var PopupWindow = $('.popup');
	// Show Hide

	$('.popupTrigger').click(
			function() {
				PopupWindow.addClass('open');
				$('.bg').css('height', $(document).height());
				
				// GET article ID 
				// 왜 그동안 누른 수만큼 반복이 되는거지..? -> 그건 계속 같은 페이지에 있어서였음.. 주소창에 떠있는 #숫자때문에...
				$("section.item").click(function() {
					id = $(this).attr('id');
					// AJAX 요청
					$.ajax({
							url : "AjaxServlet",
							data : { postid : id },
							type : "GET",
							dataType : "json",
							success : function(data) {
								// name 부분 처리
								$("<img src=\"images/profile/" + data.user.profilephoto + "\">").appendTo('#name');
								$("<p id=\"name_name\">" + data.user.nickname + "</p>").appendTo('#name');
								$("<p id=\"name_time\">" + data.post.postdate + "</p>").appendTo('#name');
								
								// photo 부분 처리
								$("<a href=\"images/photo/" + data.post.photo + "\" target=\"_blank\"> <img id=\"photo_picture\" src=\"images/photo/" + data.post.photo + "\"></a>").appendTo('#photodetail');
								$("<p id=\"photo_content\">" + data.post.content + "</p>").appendTo('#photo');
								
								// form 부분 처리
								$("<img src=\"images/profile/" + data.loginphoto + "\">").prependTo('#form');
								$("<input type=\"hidden\" name=\"postid\" value="+ id +" />").prependTo('#form form');
								
								// comment 부분 처리
								$(data.comment).each(function(i, comm) {
									$("<img src=\"images/profile/" + comm.userphoto + "\">").appendTo('#comment');
									$("<p>" + comm.usernick + "</p>").appendTo('#comment');
									$("<p>" + comm.commentcontent + "</p>").appendTo('#comment');
									$("<p>" + comm.commentdate + "</p>").appendTo('#comment');
								});
							},
							complete : function(xhr, status) { }
					});
				});
			});
	
		// ESC Event
		$(document).keydown(function(event) {
			if (event.keyCode != 27)
				return true;
			if (PopupWindow.hasClass('open')) {
				PopupWindow.removeClass('open');
				parent.document.location.href = ""; 
			}
			return false;
		});
		// Hide Window
		PopupWindow.find('>.bg').mousedown(function(event) {
			PopupWindow.removeClass('open');
			parent.document.location.href = ""; 
			return false;
		});

	});
</script>

