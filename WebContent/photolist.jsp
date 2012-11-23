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

        <div id="menubar">
            메뉴바
        </div>

        <div id="list">
            <ul id="tiles">
            <!-- These are our grid blocks -->
            	<c:forEach var="post" items="${posts.list }" varStatus="status">
                <li><img src="photo/${post.photo }"><p>${post.content }</p></li>
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
  
  <!-- Once the page is loaded, initalize the plug-in. -->
  <script type="text/javascript">
    $('#tiles').imagesLoaded(function() {
      // Prepare layout options.
      var options = {
        autoResize: true, // This will auto-update the layout when the browser window is resized.
        container: $('#list'), // Optional, used for some extra CSS styling
        offset: 2, // Optional, the distance between grid items
        itemWidth: 210// Optional, the width of a grid item
      };
      
      // Get a reference to your grid items.
      var handler = $('#tiles li');
      
      // Call the layout function.
      handler.wookmark(options);
    });
    
  </script>
  
  