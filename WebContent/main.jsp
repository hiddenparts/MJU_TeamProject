<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
    <head>
    	<meta charset="utf-8">
	    <title>D_2조 팀프로젝트</title>
	    <script src="js/jquery-1.8.2.js"></script>
	    <link rel="stylesheet" type="text/css" href="css/main.css">
      <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
    <% RequestDispatcher dispatcher = request.getRequestDispatcher("/article?op=list");
			 dispatcher.forward(request, response); %>
    </body>
</html>

  
  