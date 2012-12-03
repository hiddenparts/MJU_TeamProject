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
				<c:choose>
	        <c:when test="${cate_num == status.index + 1}">
						<li><b><a href="article?op=category&cate=${status.index + 1}">${cate}</a></b></li>
					</c:when>
					<c:otherwise>
						<li><a href="article?op=category&cate=${status.index + 1}">${cate}</a></li>
					</c:otherwise>
				</c:choose>
				
			</c:forEach>
		</ul>	
	</nav>

	<div id="list">
		<ul id="tiles">
			<!-- 이 위치에 게시물들이 ajax로 채워집니다 -->
		</ul>
	</div>

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
  var cate_num = 0;
  
  //get category id..
  <% int num=-1;
  	 try {
		  num = Integer.parseInt(request.getParameter("cate")); 
		} catch(NumberFormatException e) {}	 %>
		cate_num = <%=num %>;
 	
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
         data: {page: page, cate: cate_num, op : "category"}, // Page parameter to make sure we load new data
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
	   
	   for(; i<length; i++) {
		   postitem = data.post[i];
		   html += '<li>'; 
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
				var sessionID = null;
				<% Member user = (Member) session.getAttribute("user");
						if(user != null) { %>
						sessionID = "<%=user.getUserid() %>"; 
				<% }	%>
					//console.log(sessionID);
				
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
						curheight += (data.comment.length + 1) * 100;
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
</script>

