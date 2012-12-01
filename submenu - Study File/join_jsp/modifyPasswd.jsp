<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>비밀번호 수정</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	

	PreparedStatement pstmt = null;
	Connection con = null;
	ResultSet rs = null;
	request.setCharacterEncoding("utf-8");
	try {
		String userId = request.getParameter("userId");
		String passwd_a = request.getParameter("passwd_a");
		String passwd = request.getParameter("newPasswd");
	

		String DB_SERVER = "localhost:3306";
		String DB_SERVER_USERNAME = "admin";
		String DB_SERVER_PASSWORD = "admin";
		String DB_DATABASE = "project5";
		String JDBC_URL = "jdbc:mysql://" + DB_SERVER + "/" + DB_DATABASE;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);
		String sql = "update join_infor set passwd = ? where id=? and passwd_a=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,passwd);
		pstmt.setString(2,userId);
		pstmt.setString(3,passwd_a);

		if( pstmt.executeUpdate() == 1){
	%>
		<script>
			alert("<%=userId%>님 수정되었습니다.");
			history.back();
		</script>
		
	<%
		}else{
	%>
		<script>
			alert("비밀번호답이틀립니다.");
			history.back();
		</script>
		
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
</body>
</html>