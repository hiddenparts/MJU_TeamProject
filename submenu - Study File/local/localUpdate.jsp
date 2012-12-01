<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>

<html>
	<head>
		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../../stylesheets/style.css" type="text/css" />
		<script type="text/javascript" src="../../script.js"></script>
	</head>

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
		String organ_name = request.getParameter("organ_name");
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
        String sql = "select * from location where organ = '"+organ_name+"'";
        
		pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while(rs.next()) {
        
		String local = rs.getString("direction");
        String district = rs.getString("district");
        String organ_photo = rs.getString("img");
        String organ_decribe = rs.getString("explan");
        String organ_page = rs.getString("link");

		%>
		
		<form action="localSql.jsp" method="post" enctype="multipart/form-data">
        <table width="550" border="1" id="title">
  
		<tr>
			<td width="100">기관명</td>
			<td width="100"><input type="text" name="organ_name" value="<%=organ_name%>"></td>
		</tr>
		<tr>
			<td width="100">기관사진</td>
			<td width="100"><input type="file" name="organ_photo" id="organ_photo" value="<%=organ_photo%>"></td>
        <tr>    
			<td width="100">기관링크</td>
			<td width="100"><input type="text" name="organ_page" value="<%=organ_page%>"></td>
		</tr>
		<tr>
			<td width="100" colspan="2">기관설명</td>
		</tr>
		<tr>
			<td width="100" colspan="2"><textarea rows="30" cols="70" name="organ_decribe" id="organ_decribe" ><%=organ_decribe%></textarea></td>
        </tr>
		<tr>
			<td width="100">지역</td>
			<td width="100">구</td>            
        </tr>
		 <tr>
			<td width="100">
				<select name="local">
				<option value="<%=local%>"><%=local%></option>
				<option value="중부지역">중부지역</option>
				<option value="동부지역">동부지역</option>
				<option value="남부지역">남부지역</option>
				<option value="서부지역">서부지역</option>
				<option value="북서지역">북서지역</option>
				<option value="북동지역">북동지역</option>
				</select>			
			</td>
			<td width="100">
				<select name="district">
				<option value="<%=district%>" selected><%=district%></option>
				<option value="동대문구">동대문구</option>
				<option value="성동구">성동구</option>
				<option value="용산구">용산구</option>
				<option value="중구">중구</option>
				<option value="강동구">강동구</option>
				<option value="광진구">광진구</option>
				<option value="송파구">송파구</option>
				<option value="중랑구">중랑구</option>
				<option value="강남구">강남구</option>
				<option value="관악구">관악구</option>
				<option value="금천구">금천구</option>
				<option value="동작구">동작구</option>
				<option value="서초구">서초구</option>
				<option value="강서구">강서구</option>
				<option value="구로구">구로구</option>
				<option value="양천구">양천구</option>
				<option value="영등포구">영등포구</option>
				<option value="마포구">마포구</option>
				<option value="서대문구">서대문구</option>
				<option value="은평구">은평구</option>
				<option value="종로구">종로구</option>
				<option value="강북구">강북구</option>
				<option value="노원구">노원구</option>
				<option value="도봉구">도봉구</option>
				<option value="성북구">성북구</option>
				</select>						
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			<input type="submit" value="추가">
			<input type="button" value="취소" onclick="javascript:location('./local.jsp')">
			</td>
		</tr>
		</table>	
		<%
		}
		sql = "delete from location where organ = '"+organ_name+"'";
		pstmt = con.prepareStatement(sql);
		pstmt.executeUpdate();
        } catch(Exception e) {
        out.println(e);
        } finally {
        if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
        if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
        if(con != null) {try {con.close();} catch(SQLException sqle) {}}
        }
        %>
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
