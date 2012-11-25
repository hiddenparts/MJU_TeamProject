<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
    <head>
    	<meta charset="utf-8">
	    <title>D_2조 팀프로젝트</title>
	    <script src="js/jquery-1.8.2.js"></script>
      <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <jsp:include page="mainheader.jsp"/>

        <nav id="menubar">
            메뉴바
        </nav>

        <div id="list">
            <ul id="tiles">
            <!-- These are our grid blocks -->
            	<c:forEach var="post" items="${posts.list }">
                <li>
                <!-- Start of Article -->
                <section id="item">
                	<header> <!-- 작성자 정보 -->
                		<p>
                			<span> <img src="images/profile/sm${post.member.profilephoto }" width="35px" height="35px"> </span> 
                			<span> <b>${post.member.nickname }</b> </span>
                		</p>
                	</header> <!-- 작성자 정보 -->
                	
                	<article id="itemcontents"> <!-- 글 사진 및 내용 -->
	                	<img src="images/photo/${post.article.photo }">
	                	<p>${post.article.content }</p>
                	</article> <!-- 글 사진 및 내용 -->
                	
                	<article id="itemcomment"> <!-- 코멘트 리스트 -->
                	<c:if test="${post.comment != null}">
                		<c:forEach var="comment" items="${post.comment }"> 
                			<p> 
	                			<span> <img src="images/profile/sm${comment.userphoto }" width="35px" height="35px"></span>
	                			<span> <b>${comment.usernick }</b> ${comment.commentcontent } </span>
                			</p>
                		 </c:forEach>
                	</c:if>
                	</article> <!-- 코멘트 리스트 -->
                	
                	<article id="itemform"> <!-- 댓글 입력창 -->
                		<c:if test="${sessionScope.user.userid != null}">
		            			<span><img class="media-object" src="images/profile/sm${sessionScope.user.profilephoto}" width="35px" height="35px"/></span>
		            			<form method="post" action="Comment"> 
		            				<input type="hidden" name="postid" value="${post.article.postid }"/>
		            				<input type="text" name="comment"> 
		            				<input type="submit" value="댓글">
		            			</form>
            				</c:if>
            			</article> <!-- 댓글 입력창  -->
            			</section> 
            			<!-- End of Article -->
                </li>
            	</c:forEach>
            <!-- End of grid blocks -->
            </ul>

        </div>


    </body>

</html>

  <!-- Include the plug-in -->
  <script src="js/jquery.wookmark.js"></script>

  <!-- Include the imagesLoaded plug-in -->
  <script src="js/jquery.imagesloaded.js"></script>
  
  <!-- Once the page is loaded, initialize the plug-in. -->
  <script type="text/javascript">
    $('#tiles').imagesLoaded(function() {
      // Prepare layout options.
      var options = {
        autoResize: true, // This will auto-update the layout when the browser window is resized.
        container: $('#list'), // Optional, used for some extra CSS styling
        offset: 15, // Optional, the distance between grid items
        itemWidth: 220// Optional, the width of a grid item
      };
      
      // Get a reference to your grid items.
      var handler = $('#tiles li');
      
      // Call the layout function.
      handler.wookmark(options);
    });
    
  </script>
  
  