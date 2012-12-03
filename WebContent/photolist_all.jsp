<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
				 import="bean.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>D_2조 팀프로젝트</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="css/mwLogin.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/photo.css" rel="stylesheet">	
	
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/mwLogin.js"></script>
</head>

<body>

	<jsp:include page="mainheader.jsp" />

	<!-- 카테고리 -->
	<nav id="menubar">
		<ul>
			<li><a href="article">전체</a></li>
			<c:forEach var="cate" items="${category.list}" varStatus="status">
			<li><a href="article?op=category&cate=${status.index + 1}">${cate}</a></li>
			</c:forEach>
		</ul>	
	</nav>

	<div id="list">
		<ul id="tiles">
			<!-- 이 위치에 게시물들이 ajax로 채워집니다 -->
		</ul>
	</div>

<%-- 			<!-- These are our grid blocks -->
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
			</c:forEach> --%>
			<!-- End of grid blocks -->

	<div id="loader">
		<div id="loaderCircle"></div>
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
  
	// Prepare layout options.
	var options = {
		autoResize : true, // This will auto-update the layout when the browser window is resized.
		container : $('#list'), // Optional, used for some extra CSS styling
		offset : 5, // Optional, the distance between grid items
		itemWidth : 222
	// Optional, the width of a grid item
	};
  
  //최초의 한번 실행
  loadData();
  
  //스크롤되었을때 함수결합
  $(document).bind('scroll', onScroll);
	
	// 스크롤이 밑에 도착했을때 체크하는 함수
	function onScroll(event) {
	    // Only check when we're not still waiting for data.
	    if(!isLoading) {
	      // Check if we're within 100 pixels of the bottom edge of the broser window.
	      var closeToBottom = ($(window).scrollTop() + $(window).height() > $(document).height() - 100);
	      if(closeToBottom) {
	        loadData();
	      }
	    }
	  };
	  
   function loadData() {
       isLoading = true;
       $('#loaderCircle').show();
       
       $.ajax({
         url: "AjaxServlet",
         dataType: 'json',
         data: {page: page, op : "page"}, // Page parameter to make sure we load new data
         success: onLoadData
       });
     };	
     
   function onLoadData(data) {
	   isLoading = false;
	   $('#loaderCircle').hide();
	   // Increment page index for future calls.
	   page++;

	   // Create HTML for the images.
	   var html = '';
	   var i=0, length=data.post.length, postitem;
	   
		var sessionID = null;
			<% Member user = (Member) session.getAttribute("user");
					String userid= null;
					if(user != null) { %>
					sessionID = "<%=user.getUserid() %>"; 
			<% }	%>
				//console.log(sessionID);
	   
	   for(; i<length; i++) {
		   postitem = data.post[i];
		   html += '<li>'; 
		   if(sessionID != null && sessionID == postitem.article.userid) {
			   	html += '<img class="deleteon" src="images/delete.png">';
			 }
		   html += '<section class="item" id="' + postitem.article.postid + '">';
		   
		    // photo
				html += '<article class="itemcontents">'; 
				html += '<img class="popupTrigger" src="images/photo/sm' + postitem.article.photo + '">'; 
				html += '<p>' + postitem.article.content + '</p>'; 
				html += '</article>';

				// comment
				if(postitem.comment != null) {
					html += '<article class="itemcomment">'; 
					$(postitem.comment).each(function(i, comm) {
						html += '<p><span> <img src="images/profile/sm' + comm.userphoto + '" width="35px" height="35px"></span>';
						html += '<span> <b>' + comm.usernick + '</b>' + comm.commentcontent + '</span></p>'; 
					});
					html += '</article>'; 
				}
				
				// form
 				if(sessionID != null) {
					html += '<article class="itemform">'; 
					html += '<span><img src="images/profile/sm${sessionScope.user.profilephoto}" width="35px" height="35px" /></span>'; 
					html += '<form method="post" action="Comment">'; 
					html += '<input type="hidden" name="postid" value="' + postitem.article.postid +'"/>'; 
					html += '<input type="text" name="comment">'; 
					html += '</form>'; 
					html += '</article>'; 
				}
 
				html += '</section>'; 
				html += '</li>'; 
	   } 
	   
	   // Add image HTML to the page.
	   $('#tiles').append(html);
	   
	   //Apply layout.
		 $('#tiles').imagesLoaded(function() {
		      // Get a reference to your grid items.
		      var handler = $('#tiles li');
		      
		      // Call the layout function.
		      handler.wookmark(options);
		 });
   };  
});
	
$(document).on('click', '.popupTrigger', function(event){
	  // 아이템을 클릭했을때 뜨는 상세뷰 준비 =======================================================================================
	var PopupWindow = $('.popup');
	var SelectItem = $(this.parentNode.parentNode);
	var id;
	id = SelectItem.attr('id');
	SelectItem.css("visibility", "hidden");
	
	document.body.style.overflow = 'hidden'; // 부모의 스크롤바는 제거한다.
	PopupWindow.addClass('open');
	PopupWindow.css("top", $(window).scrollTop());
	
	// AJAX 요청
	$.ajax({
			url : "AjaxServlet",
			data : { postid : id , op : "popup"},
			type : "GET",
			dataType : "json",
			success : function(data) {
					// name 부분 처리
					$("<img src=\"images/profile/" + data.user.profilephoto + "\">").appendTo('#name');
					$("<p id=\"name_name\">" + data.user.nickname + "</p>").appendTo('#name');
					$("<p id=\"name_time\">" + data.article.postdate + "</p>").appendTo('#name');
					
					// photo 부분 처리
					$("<a href=\"images/photo/" + data.article.photo + "\" target=\"_blank\"> <img id=\"photo_picture\" src=\"images/photo/" + data.article.photo + "\"></a>").appendTo('#photodetail');
					$("<p id=\"photo_content\">" + data.article.content + "</p>").appendTo('#photo');
					
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
				
					$('#photo_picture').attr('src','images/photo/' + data.article.photo).load(function(){ 
						var curheight = ($(this).height() > $(window).height()-100) ? $('#photopage').height() : $(window).height()-100;
						
						//세션이 있는지 확인해서 로그인일때랑 아닐때, 코멘트가 있을때 또 있다면 몇개가 있는지 받아와서 길이를 적절하게 구해줘야한다
						curheight += (data.comment.length + 1) * 50;
						console.log(data.comment.length);
						$('.pbg').css('height', curheight); //console.log('width: ', $(this).width(), ' height: ', $(this).height());
				}); 
			},
			complete : function(xhr, status) {  }
	});
	
	// ESC Event
	$(document).keydown(function(event) {
		if (event.keyCode != 27)
			return true;
		if (PopupWindow.hasClass('open')) {
			PopupWindow.removeClass('open');
			
			// ajax로 받아온 data를 해제하고 원상복귀 시키는 부분.
			$('.popup #name').empty();
			$('#photodetail').empty();
			$('p#photo_content').remove();
			$('.popup #form form').empty();
			$('.popup #comment').empty();
			
			SelectItem.css("visibility", "visible");
			document.body.style.overflow = 'visible';
		}
		return false;
	});
		
	// Hide Window
	PopupWindow.find('>.pbg').mousedown(function(event) {
		PopupWindow.removeClass('open');
			
		// ajax로 받아온 data를 해제하고 원상복귀 시키는 부분.
				$('.popup #name').empty();
				$('#photodetail').empty();
				$('p#photo_content').remove();
				$('.popup #form form').empty();
				$('.popup #comment').empty();
				
				SelectItem.css("visibility", "visible");
				document.body.style.overflow = 'visible';
		return false;
	});
});

// 글을 지우기 위해 icon을 띄우는 부분 
// 마우스오버, 엔터, 리브, 아웃 모두에 걸어주고, 깜빡임을 방지하기 위해 icon자체에도 마우스 이벤트를 걸어줘야한다.
$(document).on('mouseover', '.popupTrigger', function(event){
	var SelectItem = $(this.parentNode.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').addClass('on');
});

$(document).on('mouseenter', '.popupTrigger', function(event){
	var SelectItem = $(this.parentNode.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').addClass('on');
	//console.log($(SelectItem).find('>.deleteon'));
});

$(document).on('mouseleave', '.popupTrigger', function(event){
	var SelectItem = $(this.parentNode.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').removeClass('on');
});

$(document).on('mouseout', '.popupTrigger', function(event){
	var SelectItem = $(this.parentNode.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').removeClass('on');
});

$(document).on('mouseenter', '.deleteon', function(event){
	var SelectItem = $(this);
	SelectItem.addClass('on');
});

$(document).on('mouseover', '.deleteon', function(event){
	var SelectItem = $(this);
	SelectItem.addClass('on');
});

$(document).on('mouseleave', '.deleteon', function(event){
	var SelectItem = $(this);
	SelectItem.removeClass('on');
});

$(document).on('mouseout', '.deleteon', function(event){
	var SelectItem = $(this);
	SelectItem.removeClass('on');
});

// 삭제처리
$(document).on('click', '.deleteon', function(event){
	var SelectItem = this.nextSibling;
	var id = $(SelectItem).attr('id');
	if (confirm("정말로 삭제하시겠습니까?")) {
		location = 'article?op=delete&id=' + id;
	}
	return false;
});

</script>

<!-- /* 	$("section.item").bind('click', function() {
		SelectItem = $(this);
		console.log(SelectItem);
		id = SelectItem.attr('id');
		alert(id);
	}); */

	/* 	// 아이템을 클릭했을때 뜨는 상세뷰
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
							data : { postid : id , op : "popup"},
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
		}); */ -->

