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

	<nav id="menubar">
		<ul>
			<li>전체</li>
			<c:forEach var="cate" items="${category.list}">
			<li>${cate}</li>
			</c:forEach>
		</ul>	
	</nav>

	<div id="list">
		<ul id="tiles">
			<!-- These are our grid blocks -->
			<c:forEach var="post" items="${posts }">
				<li>
					<!-- Start of Article -->
					<section class="item" id="${post.article.postid }"> 
						<!--  <header class="itemauthor"> 12/02 일단 작성자를 메인리스트에서는 표시하지 않기로 함..
							<!-- 작성자 정보 -- >
							<p>
								<span> 
									<img src="images/profile/sm${post.member.profilephoto }" width="35px" height="35px"> 
								</span> 
								<span> 
									<b>${post.member.nickname }</b>
								</span>
							</p>
						</header> -->
						<!-- 작성자 정보 -->

						<article class="itemcontents">
							<!-- 글 사진 및 내용 -->
							<img class="popupTrigger" src="images/photo/sm${post.article.photo }" >
							<p> ${post.article.content }</p>
						</article>
						<!-- 글 사진 및 내용 -->

						<article class="itemcomment"> 
							<!-- 코멘트 리스트 -->
							<c:if test="${post.comment != null}">
								<c:forEach var="comment" items="${post.comment }">
									<p>
										<span> <img src="images/profile/sm${comment.userphoto }" width="35px" height="35px"></span> 
										<span> <b>${comment.usernick }</b> ${comment.commentcontent } </span>
									</p>
								</c:forEach>
							</c:if>
						</article>
						<!-- 코멘트 리스트 -->

						<article class="itemform">
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
			<div class="pbg"></div>
			<div id="photopage">
				<div id="name"></div>
				<div id="photo"><div id="photodetail"></div></div>	
				<c:if test="${sessionScope.user.userid != null}">
				<div id="form"><form method="post" action="Comment"></form></div>
				</c:if>
				<div id="comment"></div>
			</div>
		</div>
		
</body>

</html>

<script src="js/jquery.wookmark.js"></script>
<script src="js/jquery.imagesloaded.js"></script>
<script type="text/javascript">
$(function($){
	var isLoading = false;
	var handler = null;
  var page = 1;
	
  $(document).bind('scroll', onScroll);
  
	$('#tiles').imagesLoaded(function() {
		// Prepare layout options.
		var options = {
			autoResize : true, // This will auto-update the layout when the browser window is resized.
			container : $('#list'), // Optional, used for some extra CSS styling
			offset : 5, // Optional, the distance between grid items
			itemWidth : 222
		// Optional, the width of a grid item
		};

		// Get a reference to your grid items.
		handler = $('#tiles li');

		// Call the layout function.
		handler.wookmark(options);
	});
	
	// 스크롤이 밑에 도착했을때 체크하는 함수
	function onScroll(event) {
	    // Only check when we're not still waiting for data.
	    if(!isLoading) {
	      // Check if we're within 100 pixels of the bottom edge of the broser window.
	      var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
	      if(closeToBottom) {
	    	  alert("바닥도착");
	        //loadData();
	      }
	    }
	  };
	
      
  // 아이템을 클릭했을때 뜨는 상세뷰 준비 =======================================================================================
	var id;
	var PopupWindow = $('.popup');
	var SelectItem;

	// 아이템을 클릭했을때 뜨는 상세뷰
	$('.popupTrigger').click(
			function() {
				document.body.style.overflow = 'hidden'; // 부모의 스크롤바는 제거한다.
				PopupWindow.addClass('open');
				PopupWindow.css("top", $(window).scrollTop());
				 
				// GET article ID 
				// 왜 그동안 누른 수만큼 반복이 되는거지..? -> 그건 계속 같은 페이지에 있어서였음.. 주소창에 떠있는 #숫자때문에... 인줄 알았는데 여전히 반복됨...
				$("section.item").click(function() {
					SelectItem = $(this);
					id = SelectItem.attr('id');
					SelectItem.css("visibility", "hidden");
					
					// AJAX 요청
					$.ajax
					({
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
								$("<img src=\"images/profile/" + data.loginphoto + "\">").appendTo('#form form');
								$("<input type=\"hidden\" name=\"postid\" value="+ id +" />").appendTo('#form form');
								$("<input type=\"text\"name=\"comment\"/>").appendTo('#form form');
								$("<input type=\"submit\" value=\"댓글\"/>").appendTo('#form form');

								// comment 부분 처리
								$(data.comment).each(function(i, comm) {
									$("<img src=\"images/profile/" + comm.userphoto + "\">").appendTo('#comment');
									$("<p>" + comm.usernick + "</p>").appendTo('#comment');
									$("<p>" + comm.commentcontent + "</p>").appendTo('#comment');
									$("<p>" + comm.commentdate + "</p>").appendTo('#comment');
								});								
								
								$('#photo_picture').attr('src','images/photo/' + data.post.photo).load(function(){ 
									var curheight = ($(this).height() > $(window).height()) ? $('#photopage').height() : $(window).height()-50;
										$('.pbg').css('height', curheight); //console.log('width: ', $(this).width(), ' height: ', $(this).height());
								}); 
							},
							complete : function(xhr, status) {  }
					});
				});

			}); //$('.popupTrigger')

		// ESC Event
		$(document).keydown(function(event) {
			if (event.keyCode != 27)
				return true;
			if (PopupWindow.hasClass('open')) {
				PopupWindow.removeClass('open');
				//parent.document.location.href = "";
 				$('.popup #name').empty();
				$('#photodetail').empty();
				$('p#photo_content').remove();
				$('.popup #form form').empty();
				$('.popup #comment').empty();
				
				$("section.item").unbind(); // id 가져온 값을 여기서 해제시켜서 값 반복을 막는다.
				
				SelectItem.css("visibility", "visible");
				document.body.style.overflow = 'visible';
			}
			return false;
		});
			
		// Hide Window
		PopupWindow.find('>.pbg').mousedown(function(event) {
			PopupWindow.removeClass('open');
			//parent.document.location.href = "";
				
			// ajax로 받아온 data를 해제하고 원상복귀 시키는 부분.
					$('.popup #name').empty();
					$('#photodetail').empty();
					$('p#photo_content').remove();
					$('.popup #form form').empty();
					$('.popup #comment').empty();
					
					$("section.item").unbind(); // id 가져온 값을 여기서 해제시켜서 값 반복을 막는다.
					
					SelectItem.css("visibility", "visible");
					document.body.style.overflow = 'visible';
			return false;
		});

	});
</script>

