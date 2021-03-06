<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
				 import="bean.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>Myoungterest</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="css/mwLogin.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/photo.css" rel="stylesheet">	
	
	<script src="js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="js/common-dev.js"></script>
	<script type="text/javascript" src="js/simplify-min.js"></script>
	<script type="text/javascript" src="js/modernizr.custom.js"></script>
	<script type="text/javascript" src="js/drawing-dev.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/mwLogin.js"></script>
</head>

<body>

	<jsp:include page="mainheader.jsp" />

	<!-- 카테고리 -->
	<nav id="menubar">
		<ul class="LiquidContainer HeaderContainer" style="width: 1170px;">
			<li><a href="article">전체</a></li>
			<c:forEach var="cate" items="${category.list}" varStatus="status">
			<li><a href="article?op=category&cate=${status.index + 1}" class="nav">${cate}</a></li>
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
			<div id="drawtool"></div>
			<div id="photopage">
				<div id="name"></div>
				<div id="photo"><div id="photodetail"></div></div>	
				<c:if test="${sessionScope.user.userid != null}">
				<div id="form"><form method="post" action="Comment"></form></div>
				</c:if>
				<div id="comment"></div>
			</div>
			<div id="drawlist"></div>
		</div>
		
</body>

</html>

<script src="js/jquery.wookmark.js"></script>
<script src="js/jquery.imagesloaded.js"></script>
<script type="text/javascript">

var sessionID = null; // 전역 세션아이디
var sessionNick = null; // 전역 세션아이디
var sessionPhoto = null; // 전역 세션아이디

<% Member user = (Member) session.getAttribute("user");
	if(user != null) { %>
		sessionID = "<%=user.getUserid() %>";
		sessionNick = "<%=user.getNickname() %>";
		sessionPhoto = "<%=user.getProfilephoto() %>";
<% }	%>

$(function($){
	var isLoading = false;
	var handler = null;
  var page = 1;
  
	// Prepare layout options.
	var options = {
		autoResize : true, // This will auto-update the layout when the browser window is resized.
		container : $('#list'), // Optional, used for some extra CSS styling
		offset : 5, // Optional, the distance between grid items
		itemWidth : 222 // Optional, the width of a grid item
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
						html += '<p><span> <img class="profile-size2" src="images/profile/sm' + comm.userphoto + '"></span>';
						html += '<span> <b>' + comm.usernick + '</b>' + comm.commentcontent + '</span></p>'; 
					});
					html += '</article>'; 
				}
				
				// form
 				if(sessionID != null) {
					html += '<article class="itemform">'; 
					html += '<span><img class="profile-size2" src="images/profile/sm${sessionScope.user.profilephoto}"/></span>'; 
					html += '<form method="post" action="Comment">'; 
					html += '<input type="hidden" name="postid" value="' + postitem.article.postid +'"/>'; 
					html += '<input required  type="text" name="comment">'; 
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

var doodler = null;
$(document).on('click', '.popupTrigger', function(event){
	  // 아이템을 클릭했을때 뜨는 상세뷰 준비 =======================================================================================

	var PopupWindow = $('.popup');
	var SelectItem = $(this.parentNode.parentNode);
	var id;
	var toolHtml = '';
	var listHtml = '';
	var graffitilist;
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
				// DrawTool 부분 처리
				toolHtml += '<ul>';
				toolHtml += '<li class="colorpicker" id="type1_10_black"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_white"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_red"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_green"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_blue"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_purple"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_lime"></li>';
				toolHtml += '<li class="colorpicker" id="type1_10_orange"></li>';
				
				toolHtml += '</ul>';
				$('#drawtool').append(toolHtml);

				// name 부분 처리
				$('<img src=\"images/profile/' + data.user.profilephoto + '\">').appendTo('#name');
				$('<b><p style="font-size:12pt" id=\"name_name\">' + data.user.nickname + '</p></b>').appendTo('#name');
				$('<p style="font-size:10pt" id=\"name_time\">' + data.article.postdate + '</p>').appendTo('#name');

				if(sessionID != null) {
					$('<input id=\"savedraw\" class=\"btn btn-primary\" type=\"button\" value=\"댓그림 저장\">').appendTo('#name');
				}
				if(sessionID == data.user.userid) {
					$('<button class="btn btn-mini modify" type="button">수정</button>').appendTo('#name');
				}

				// photo 부분 처리
				$('<canvas id=\"photo_picture\"></canvas>').appendTo('#photodetail');
				var canvas = $('#photo_picture').get(0);
				var context = canvas.getContext('2d');
				var img = new Image();

				$('<p id=\"photo_content\">' + data.article.content + '</p>').appendTo('#photo');

				// form 부분 처리
				if(sessionID != null) {
					$('<img src=\"images/profile/' + data.loginphoto + '\">').appendTo('#form form');
					$('<input type=\"hidden\" name=\"postid\" value=' + id + ' />').appendTo('#form form');
					$('<input required type=\"text\"name=\"comment\"/>').appendTo('#form form');
					$('<input type=\"submit\" class=\"btn btn-primary\" value=\"댓글\"/>').appendTo('#form form');
				}

				// comment 부분 처리
				$(data.comment).each(function(i, comm) {
					$('<div class=\"commentitem'+ i + '\"></div>').appendTo('#comment');
					$('<img src=\"images/profile/' + comm.userphoto + '\">').appendTo('.commentitem' + i);
					$('<b><p>' + comm.usernick + '</p></b>').appendTo('.commentitem' + i);
					$('<p style="font-size:12pt">' + comm.commentcontent + '</p>').appendTo('.commentitem' + i);
					$('<p style="font-size:10pt">' + comm.commentdate + '</p>').appendTo('.commentitem' + i);
					if(sessionID == comm.userid) {
						$('<button class=\"btn btn-mini btn-danger comment\" type=\"button\" value=\"'+ comm.commentid +'\">삭제</button>').appendTo('.commentitem' + i);
					}
				});		

				// List 부분처리
				graffitilist = data.graffiti;
				listHtml += '<ul>';
				$(data.graffiti).each(function(i, grafi) {
					listHtml += '<li id="'+i+'"><input class="viewcheck" type="checkbox" name="view" checked><div>';
					listHtml += '<img src=\"images/profile/' + grafi.userphoto + '\">';
					listHtml += '<b>' + grafi.usernick + '</b>' + grafi.graffititdate;
					if(sessionID == grafi.userid) {
						listHtml += '<button class=\"btn btn-mini btn-danger graffiti\" type=\"button\" value=\"'+ grafi.graffitiid +'\">삭제</button>'
					}
					listHtml += '</div></li>';
				});
				listHtml += '</ul>';
				$('#drawlist').append(listHtml);

					// canvas 생성
					doodler = new DoodleView(canvas, sessionID);
					doodler.setEditable(true);
					doodler.setBrush('type1_10_black');
				
					// 이미지 로딩이 끝나면 하는 처리
					img.onload = function(){ 
						$(canvas).attr('width', 700);
						$(canvas).attr('height', 700 * (img.height / img.width));
						var curheight = ($('#photopage').height() > $(window).height()) ? $('#photopage').height()-50 : $(window).height()-100;
						//var curheight = $('#photopage').height();
						
						//세션이 있는지 확인해서 로그인일때랑 아닐때, 코멘트가 있을때 또 있다면 몇개가 있는지 받아와서 길이를 적절하게 구해줘야한다
						curheight += (data.comment.length + 1) * 50;
						$('.pbg').css('height', curheight); //console.log('width: ', $(this).width(), ' height: ', $(this).height());
						
						doodler.setBackground(img.src);
						
						var arr = [];
						for(var i=0; i < data.graffiti.length; i++) {
								var draw = data.graffiti[i];
								arr = arr.concat(JSON.parse(draw.graffitipath));
						}
						
						if(arr.length != 0) {
							doodler.jsonToShapes(arr);
						}
						
						doodler.rePaint();
					};// 이미지 로딩이 끝나면 하는 처리
					
					$('.btn.btn-mini.modify').bind('click', function() {
						location = 'article?op=update&id=' + id;
					});
					
					// save 버튼을 눌렀을때 댓그림 저장하기
					$('#savedraw').bind('click', function() {	//var shapelist = doodler.getOwnerShapes(sessionID);
						var shapelist = doodler.curShapes();
						if(shapelist == null || shapelist.length == 0) {
							alert("그림이 없습니다");	
							return;
						}
						
						$.ajax({
							url : "AjaxServlet",
							data : { Shapes : JSON.stringify(shapelist), Postid : id, userid : sessionID},
							type : "POST",
							dataType : "json",
							success : function(data) { 
									if(data.result == 'ok') { 
										alert("저장성공"); 
										doodler.curShapesReset();
										doodler.setdrawType();
										
 										var html = "";
										html += '<ul><li><input class="viewcheck" type="checkbox" name="view" checked><div>';
										html += '<img src=\"images/profile/' + sessionPhoto + '\">';
										html += sessionNick + data.graffitidate;
										html += '<button class=\"btn btn-mini btn-danger graffiti\" type=\"button\" value=\"'+ data.graffitiid +'\">삭제</button>'
										html += '</div></li></ul>';
										$('#drawlist').append(html);
									}
									else if(data.result == 'no') {
										alert("저장실패");
									}
							},
							error : function(xhr, status, error) {
								alert("전송실패"); },
							complete : function() { }
						});
					});// save 버튼을 눌렀을때 댓그림 저장하기
					
					// 체크된 그림만 보여주기
					$('.viewcheck').click(function() {
						var list = $(this).parent().parent();
						var listnum = $(list).children().length;
						var arr = [];
						var checked=0;

						for(var i=0; i<listnum; i++) {
							var listitem = $(list).children()[i];
							
							if($(listitem).find('.viewcheck').is(':checked')) {
								var draw = graffitilist[i];
								arr = arr.concat(JSON.parse(draw.graffitipath)); // 체크된 순서의 그림만 가져온다
								checked += 1;
							}	
						}
						
						if(checked != 0) {								
							if(arr.length != 0) {
									doodler.jsonToShapes(arr);
							}
							doodler.rePaint(); // 다시 그리기
						} else {
							doodler.clearscr(); // 하나도 선택된게 없으면 깔끔하게 비우기
						}
					}); // 체크된 그림만 보여주기
					
					// 색바꾸기
					$('.colorpicker').click(function() {
							var color = $(this).attr('id');
							doodler.setBrush(color);
					});
					
					img.src = "images/photo/" + data.article.photo;
			},
			complete : function(xhr, status) {  }
	});
	
	// ESC Event
	$(document).keydown(function(event) {
		if (event.keyCode != 27)
			return true;
		if (PopupWindow.hasClass('open')) {
			SelectItem.css("visibility", "visible");
			PopupWindow.removeClass('open');
			
			// ajax로 받아온 data를 해제하고 원상복귀 시키는 부분.
			$('.popup #name').empty();
			$('#drawtool').empty();
			$('#photodetail').empty();
			$('p#photo_content').remove();
			$('.popup #form form').empty();
			$('.popup #comment').empty();
			$('#drawlist').empty();
			
			document.body.style.overflow = 'visible';
		}
		return false;
	});
		
	// Hide Window
	PopupWindow.find('>.pbg').mousedown(function(event) {
		PopupWindow.removeClass('open');
		SelectItem.css("visibility", "visible");
			
		// ajax로 받아온 data를 해제하고 원상복귀 시키는 부분.
			$('.popup #name').empty();
			$('#drawtool').empty();
			$('#photodetail').empty();
			$('p#photo_content').remove();
			$('.popup #form form').empty();
			$('.popup #comment').empty();
			$('#drawlist').empty();
	
			document.body.style.overflow = 'visible';
		return false;
	});
		
});

// 글을 지우기 위해 icon을 띄우는 부분 
// 마우스오버, 엔터, 리브, 아웃 모두에 걸어주고, 깜빡임을 방지하기 위해 icon자체에도 마우스 이벤트를 걸어줘야한다.
$(document).on('mouseover', '.itemcontents', function(event){
	var SelectItem = $(this.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').addClass('on');
});

$(document).on('mouseenter', '.itemcontents', function(event){
	var SelectItem = $(this.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').addClass('on');
	//console.log($(SelectItem).find('>.deleteon'));
});

$(document).on('mouseleave', '.itemcontents', function(event){
	var SelectItem = $(this.parentNode.parentNode);
	$(SelectItem).find('>.deleteon').removeClass('on');
});

$(document).on('mouseout', '.itemcontents', function(event){
	var SelectItem = $(this.parentNode.parentNode);
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

//엔터쳐서 빈칸 생기는 거 방지
$(document).on('keydown', 'input[type="text"]', function(e) {
	if(e.keyCode == 13) {
		if($(this).val() == null || $(this).val() == "") {
			alert("내용을 입력하세요");
			return false;
		}
	}
	else return;
});

//ajax로 코멘트 삭제
$(document).on('click', '.btn.btn-mini.btn-danger.comment', function(e) {
	var id = $(this).val();

	if (confirm("정말로 삭제하시겠습니까?")) {
		$(this).parent().remove();
 		$.ajax({
			url : "Comment",
			data : { id : id, op : "remove_comment"},
			type : "GET",
			dataType : "json",
			success : function(data) { 
					if(data.result == 'ok') { 
						alert("삭제하였습니다.");
					}
					else if(data.result == 'no') {
						alert("삭제에 실패하였습니다");
					}
			},
			error : function() { alert("삭제실패"); }
		}); 
	}
	return false;
});

 //ajax로 댓그림삭제
$(document).on('click', '.btn.btn-mini.btn-danger.graffiti', function(e) {
	var id = $(this).val();
	var num = $(this).parent().parent().attr('id');
	
	//console.log($(this).parent().parent());
	//console.log(num);
	
	if (confirm("정말로 삭제하시겠습니까?")) {
		$(this).parent().parent().remove();
  		$.ajax({
			url : "Comment",
			data : { id : id, op : "remove_graffiti"},
			type : "GET",
			dataType : "json",
			success : function(data) { 
					if(data.result == 'ok') { 
						alert("삭제하였습니다.");
						parent.document.location.href = "";
/* 						doodler.removeshape(num);
						doodler.rePaint(); */
					}
					else if(data.result == 'no') {
						alert("삭제에 실패하였습니다");
					}
			},
			error : function() { alert("삭제실패"); }
		});  		
	}
	return false;
});	// ajax로 댓그림삭제  

</script>