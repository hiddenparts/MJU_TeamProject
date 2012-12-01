<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="./stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="./stylesheets/style.css" type="text/css" />
		<script type="text/javascript" src="script.js"></script>
	</head>
<body>
	<div id="warp">
		<div id="header">
			<div id="headerLeft">
				<a href="../../index.jsp" alt = "Logo"  >
					<img src="../../images/mainlogo2.jpg" border="0" >
				</a>
			</div>
			<div id="headerRight"><!--로그인 폼-->
				<form method="post" action="">
					<table width="288px" height="120px">
						<tr width="288px" height="15px">
							<td width="30px"></td>
							<td width="140px"></td>
							<td width="90px"></td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px">
								<input type="text" name="userID" size="15">
							</td>
							<td width="90px">
								  <input type="checkbox" name="checkID" id="checkID">&nbsp;ID저장
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px">
								<input type="password" name="userPW"size="16">
							</td>
							<td width="90px">
								<input name="imageField" type="image" class="mb" id="imageField" tabindex="3" src="../../images/login_btn.gif">
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px" colspan="2">
								<a href="./join.html" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="./member_infor.html" class="logtxt">이메일/비밀번호찾기</a>
							</td>
							<td width="28px"></td>
						</tr>
							<tr width="288px" height="11px">
							<td width="30px"></td>
							<td width="140px"></td>
							<td width="90px"></td>
							<td width="28px"></td>
						</tr>
						</table>
				</form>
			</div>
			<div id="headerNav_remake">
				<ul class="dropdown dropdown-horizontal">
					<li><a href="../notice_upList.jsp" >공지사항</a></li>
					<li><a herf="./" >가이드</a>
						<ul>
							<li><a herf="./">추천경로</a></li>
							<li><a herf="./">지역정보</a></li>
						</ul>
					</li>
					<li><a herf="./">커뮤니티</a>
						<ul>
							<li><a herf="./">자유게시판</a></li>
							<li><a herf="./">후기</a></li>
							<li><a herf="./">QnA</a></li>
						</ul>
					</li>
					<li><a herf="./" >담아두기</a></li>
				</ul>
				<form method="post" action="">
				</form>
			</div>
		</div>
		<div id="contents_notice_write">
		
			<div id="noticepage_list_form">

			
<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	
	String savePath="c:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\test\\images";
	String query1 = "select upfile from notice where num="+ num;
	
	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project5", "admin", "admin");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(query1);
	ResultSetMetaData rsmd = rs.getMetaData();
	int columnCount = rsmd.getColumnCount();
	
	if(rs.next()){
		for(int i=1 ;i<=columnCount ;i++ ){
			if(rs.getString(i) == null || rs.getString(i).length() > 0){
				new File(savePath + "/" + rs.getString(i)).delete();
			}
		}
	}
	
	String query2 = "delete from notice where num="+num;
	stmt.executeUpdate(query2);
	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect("notice_upList.jsp");
	
%>
	
	
			
			
			
			</div>
		
		</div>
		<div id="footer">
		<img src ="../../images/copyright.jpg">
		</div>
	</div>
	<!---------------------------------------------->
	<script type="text/javascript">
		var menu=new menu.dd("menu");
		menu.init("menu","menuhover");
	</script>
	<!---------------------------------------------->
</body>
</html>
