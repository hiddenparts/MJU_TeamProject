<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<html>
	<head>

		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../stylesheets/style.css" type="text/css" />
		<link href="../stylesheets/006.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../script.js"></script>
	
<script type ="text/javascript" >  
 function checkAll(all){
    var val = true;
    if( all.checked == false ) {    
        val = false;     
    }
 var obj = document.getElementsByName("all");
 for(var i = 0; i<obj.length ; i++){
  obj[i].checked = val;
 }
}

</script>
	
	</head>


	<body>
	<div id="warp">
		<div id="header">
			
			<div id="headerLeft">
				<a href="../index.jsp" alt = "Logo"  >
					<img src="../images/mainlogo2.jpg" border="0">
				</a>
			</div><!--headerLeft end-->
			
			<div id="headerRight"><!--로그인 폼-->
<%	

String uid = (String)session.getAttribute("sid"); //세션 존재 여부 확인
	
if(uid != null){
		
	int userT = (Integer)session.getAttribute("userType");
		
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
		<td  align="center"><a href = "../SessionDelete.jsp">로그아웃</a></td>
	</tr>
	<tr>
		<td  align="center"><a href ="../selectadmin.jsp">관리자페이지</a></td>
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
		<td align="right"><a href = "../SessionDelete.jsp">로그아웃</a></td>
	</tr>
	<tr>
		<td align="center">
			<form action = "../selectuser.jsp" method = "post">
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
				<form name ="slogin" action="../sessionCreate.jsp" method = "post">
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
								<input name="imageField" type="image" class="mb" id="imageField" tabindex="3" src="../images/login_btn.gif">
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px" colspan="2">
								<a href="../submenu/join.jsp" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="../submenu/member_find.jsp" class="logtxt">이메일/비밀번호찾기</a>
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
							<li><a href="../submenu/notice_jsp/notice_upList.jsp" class="menulink">공지사항</a></li>
							<li><a href="../submenu/recomend/recomend.html" class="menulink">가이드</a>
								<ul>
									<li><a href="../submenu/recomend/recomend.html">추천 경로</a></li>
									<li><a href="../submenu/local/local.jsp">지역 정보</a></li>
								</ul>
							</li>
							<li><a href="../bbs/free/freeBoard.jsp" class="menulink">커뮤니티</a>
								<ul>
									<li><a href="../bbs/free/freeBoard.jsp">자유 게시판</a></li>
									<li><a href="../bbs/review/reviewBoard.jsp">후기</a></li>
									<li><a href="../bbs/qna/qnaBoard.jsp">QnA</a></li>
								</ul>
							</li>
							<li>
								<a href="../submenu/cart.jsp" class="menulink">담아두기</a>
							</li>
						</ul>
					</div>
<!--------------------------------------------------------------------------------------------------------------->


		</div><!--header end-->
		<DIV id="contents">
		<DIV id="index_main">
<%

	if(uid != null){

%>
		<INPUT name="allck" type="checkbox" onclick="checkAll(this)">전체선택</input><SPAN>담아두기</SPAN> 
		<form method="post" action="cart.jsp_files/cart_delete.jsp">
		<table id="cart" class="table" border="1">
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
//String id2 = "'"+"akak"+"'";
String sql = "select *from cart,location where cart.organ = location.organ and id = '"+uid+"'";
pstmt = con.prepareStatement(sql);
rs = pstmt.executeQuery();
while(rs.next()) {
String id = rs.getString("id");
String organ = rs.getString("organ");
String direction = rs.getString("direction");
String district = rs.getString("district");
String explan = rs.getString("explan");
String img = rs.getString("img");
String link = rs.getString("link");
%>
  <TR>
    <td><input type="checkbox" value="<%=id%>,<%=organ%>" name="all"></td>
	<td><a href="<%=link%>"><img src ="../../images/<%=img%>" width="50	" height="50"/></a></td>
	<td><%=direction%></td>
	<td><%=district%></td>
	<td><%=organ%></td>
	<td><%=explan%></TD>
 </TR>
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
<input type="submit" value="선택삭제">
</form>
<%
if (session.getAttribute("sid") != null) {
%>
<input type="button" value="후기작성" onclick="javascript:location.replace('../bbs/review/reviewBoardWright.jsp')">
<%
	}
}else{
%>
로그인을 하세요!
<%
}
%>
</DIV>
</div>
		<div id="footer">
		<img src ="../images/copyright.jpg">
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
