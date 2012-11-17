<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String[][] menu = { { "./admin", "Main" }, { "./admin", "Member" },
			{ "#", "Article" },

	};

	String currentMenu = request.getParameter("current");
%>
<!-- Navbar
  ================================================== -->
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="brand" href="">TeamProject</a>
			<div class="row-fluid">
				<div class="nav-collapse collapse">
					<ul class="nav">
						<%
								for (String[] menuItem : menu) {
									if (currentMenu != null && currentMenu.equals(menuItem[1])) {
										out.println("<li class='active'>");
									} else {
										out.println("<li class=''>");
									}
	
									out.println("<a href='" + menuItem[0] + "'>" + menuItem[1]
											+ "</a>");
									out.println("</li>");
								}
							%>
					</ul>
				</div>
				<div class="span1">
					<a class="brand pull-right" href="main.html">Home</a>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container" style="padding-top: 50px">
	<h1>Administrator Page</h1>
</div>