
<%@ page language = "java" contentType="text/html; charset = utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
request.setCharacterEncoding("utf-8");


String id = request.getParameter("inputid");
String passwd = request.getParameter("passwd");
String passwd_q = request.getParameter("location");
String passwd_a = request.getParameter("passwd_a");
String nickname = request.getParameter("nickname");
String name = request.getParameter("inputname");

String email_input = request.getParameter("email");
String email_domain = request.getParameter("domainname");
String email = email_input + "@" + email_domain;

String pho1 = request.getParameter("pho1");
String pho2 = request.getParameter("pho2");
String pho3 = request.getParameter("pho3");
String phone = pho1 + pho2 + pho3;


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

	String sql_id = "select id from join_infor where id = ?";
	pstmt = con.prepareStatement(sql_id);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	if(rs.next()){
%>	
	<script text = "text/javascript">
		alert("아이디 중복 확인을 해주십시오.");
	</script>
	<META http-equiv=refresh content="0; url=../../index.jsp">
<%	
	}else{
	
	String sql = "insert into join_infor (id,passwd,passwd_q,passwd_a,nickname,name,email,phone) values(?,?,?,?,?,?,?,?)";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, passwd);
	pstmt.setString(3, passwd_q);
	pstmt.setString(4, passwd_a);
	pstmt.setString(5, nickname);
	pstmt.setString(6, name);
	pstmt.setString(7, email);
	pstmt.setString(8, phone);

	pstmt.executeUpdate();
	
	%>
	<script text ="text/javascript">
		alert("가입되었습니다.");	
	</script>
	<META http-equiv=refresh content="0; url=../../index.jsp">
	<%
}
}catch(Exception e) {
out.println(e);
} finally {
	if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
	if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
	if(con != null) {try {con.close();} catch(SQLException sqle) {}}
}
%>
