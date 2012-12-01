﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
	<head>
		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../../stylesheets/style.css" type="text/css" />
		<link href="../../stylesheets/006.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="./local.css" type="text/css" />
		
		<script type="text/javascript" src="../../script.js"></script>

		<body>
	<div id="warp">
		<div id="header">
			
			<div id="headerLeft">
				<a href="../../index.jsp" alt = "Logo"  >
					<img src="../../images/mainlogo2.jpg" border="0">
				</a>
			</div><!--headerLeft end-->
			
			<div id="headerRight"><!--로그인 폼-->
<%	
int userT=0;
String uid = (String)session.getAttribute("sid"); //세션 존재 여부 확인
	
if(uid != null){
		
	userT = (Integer)session.getAttribute("userType");
		
	if(userT==2){
%>
<table>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="250" align="center" style="font-size:10pt; font-weight: bold;"><%=uid%>님이 로그인 되었습니다.<br/></td>
	</tr>
	<tr>
		<td  align="center"><a href = "../../SessionDelete.jsp">로그아웃</a></td>
	</tr>
	<tr>
		<td  align="center"><a href ="../../selectadmin.jsp">관리자페이지</a></td>
	</tr>
</table>
<%
	}else{

%>
<table>
	<tr height="20">
		<td width="250" >&nbsp;</td>
	</tr>
	<tr>
		<td align="center" style="font-size:10pt; font-weight: bold; "><%=uid%>님이 로그인 되었습니다.<br/></td>
	</tr>
	<tr>
		<td align="right"><a href = "../../SessionDelete.jsp">로그아웃</a></td>
	</tr>
	<tr>
		<td align="center">
			<form action = "../../selectuser.jsp" method = "post">
				<input type="hidden" name="userid" value="<%=uid%>">
				<input type="submit" name = "Submit" value="회원정보수정">
			</form>
		</td>
	</tr>
</table>
<%
	}
}else{
%>
				<form name ="slogin" action="../../sessionCreate.jsp" method = "post">
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
								<input type="text" name="inputUserID" size="15">
							</td>
							<td width="90px">
								  <input type="checkbox" name="checkID" id="checkID">&nbsp;ID저장
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px">
								<input type="password" name="inputUserPW"size="16">
							</td>
							<td width="90px">
								<input name="imageField" type="image" class="mb" id="imageField" tabindex="3" src="../../images/login_btn.gif">
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px" colspan="2">
								<a href="../../submenu/join.jsp" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="../../submenu/member_find.jsp" class="logtxt">이메일/비밀번호찾기</a>
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
<%
}
%>
			</div><!--headerRight end-->
			
<!--------------------------------------------------------------------------------------------------------------->			
					<div id="navi_drop">
						<ul class="menu" id="menu">
							<li><a href="../../submenu/notice_jsp/notice_upList.jsp" class="menulink">공지사항</a></li>
							<li><a href="../../submenu/recomend/recomend.html" class="menulink">가이드</a>
								<ul>
									<li><a href="../../submenu/recomend/recomend.html">추천 경로</a></li>
									<li><a href="../../submenu/local/local.jsp">지역 정보</a></li>
								</ul>
							</li>
							<li><a href="../../bbs/free/freeBoard.jsp" class="menulink">커뮤니티</a>
								<ul>
									<li><a href="../../bbs/free/freeBoard.jsp">자유 게시판</a></li>
									<li><a href="../../bbs/review/reviewBoard.jsp">후기</a></li>
									<li><a href="../../bbs/qna/qnaBoard.jsp">QnA</a></li>
								</ul>
							</li>
							<li>
								<a href="../../submenu/cart.jsp" class="menulink">담아두기</a>
							</li>
						</ul>
					</div>
<!--------------------------------------------------------------------------------------------------------------->


		</div><!--header end-->
		
		
    <div id="contents">
        <%
        request.setCharacterEncoding("UTF-8");
		String district_name=request.getParameter("district_name");

		%>
        <table id = "title"><tr><td><%=district_name%></td></tr></table>
        <table  id = "title" class="table" width="550" border="1">
        <script type ="text/javascript" >	
			function idcheck(){
				if(<%=userT%>==1||<%=userT%>==2){
					location.replace("./localMod.jsp");
				}
				else{
					alert("관리자만이 가능합니다.");
				}
			}
		</script>
		<tr><th colspan="5"><input type="button" onclick="idcheck()" value="관리페이지"></th></tr>
		<tr>
            <th width="100">기관이름</td>
            <th width="100">기관사진</td>
            <th width="100">기관설명</td>
            <th width="100">기관링크</td>
			<th width="100">담기</td>
        </tr>
        <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        String DB_SERVER = "localhost:3306";
        String DB_SERVER_USERNAME = "admin";
        String DB_SERVER_PASSWORD = "admin";
        String DB_DATABASE = "project5";
        String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
        String sql = "select * from location where district = '"+district_name+"'";
        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while(rs.next()) {
        String organ_name = rs.getString("organ");
        String organ_photo = rs.getString("img");
        String organ_decribe = rs.getString("explan");
        String organ_page = rs.getString("link");

		if(organ_photo==null){
			organ_photo = "없습니다.";
		}
        %>
        <tr>
            <td width="100"> <%=organ_name%> </td>
            <td width="100"> <img src="../../../images/<%=organ_photo%>" width="50	" height="50"/> </td>
            <td width="100"> <%=organ_decribe%> </td>
            <td width="100"> <a href="<%=organ_page%>"><%=organ_page%></a></td>
			 <form action="./inputCart.jsp" method="get" onsubmit="return login()">
				<td width="100">
				<input type="hidden" name="organ" id="organ" value="<%=organ_name%>">		
				<input type="submit" value="담기">
				</td>
			 </form>
			 
        </tr>
        <%
        }
        } catch(Exception e) {
        out.println(e);
        } finally {
        if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
        if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
        if(con != null) {try {con.close();} catch(SQLException sqle) {}}
        }
        %>
        </table>
    </div>
    <div id="footer">
        <img src="../../images/copyright.jpg">
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