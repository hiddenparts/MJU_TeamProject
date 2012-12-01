<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title> Check ID^^</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");


String id = request.getParameter("value_id");

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
	String sql2 = "select id from join_infor where id = ?";
	pstmt = con.prepareStatement(sql2);
	pstmt.setString(1,id);
	rs = pstmt.executeQuery();
if(rs.next()){
	%>
	
	<table style="font:14px/18px '맑은 고딕', 'Margun Gothic', '굴림','Gulim', Verdan, Arial, Tahoma; margin:70px 0 0 50px;">
	<tr>
		<td width="150">아이디가 중복됩니다.</td>
	</tr>
	</table>
	
	
	<%
}else{

pstmt.setString(1, id);

	
	%>
	<table style="font:14px/18px '맑은 고딕', 'Margun Gothic', '굴림','Gulim', Verdan, Arial, Tahoma; margin:70px 0 0 50px;">
	<tr>
		<td width="250">사용가능한 아이디 입니다.</td>
	</tr>
	</table>
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


</body>
</html>