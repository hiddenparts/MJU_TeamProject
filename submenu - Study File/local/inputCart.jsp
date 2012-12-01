<%@ page language = "java" contentType="text/html; charset = utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>

<%
 
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("sid");
		String organ =request.getParameter("organ");

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
		 
		 String sql = "select * from cart where id = '"+id+"' and organ = '"+organ+"'";
		 pstmt = con.prepareStatement(sql);
		 rs = pstmt.executeQuery();
		 
		 if(rs.next()){
			%><script>alert("이미 담겨있습니다!"); history.back();</script><%
		 }
		 else{
		 sql = "insert into cart (id, organ) values(?,?)";
		     
		 pstmt = con.prepareStatement(sql);
		
		 pstmt.setString(1, id);
		 pstmt.setString(2, organ);

		 pstmt.executeUpdate();
		 }

        } catch(Exception e) {
			out.println(e);
        } finally {
			if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
			if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
			if(con != null) {try {con.close();} catch(SQLException sqle) {}}
        }
%>

<script type="text/javascript">
	if(confirm("장바구니 담겼습니다. 가보시겠습니까?")){
	location.replace("../cart.jsp")	
	}else{
	history.back();
	}
</script>