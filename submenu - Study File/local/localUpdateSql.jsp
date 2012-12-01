<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
        request.setCharacterEncoding("UTF-8");
		String local =request.getParameter("local");
		String district =request.getParameter("district");
		String organ_name =request.getParameter("organ_name");
		String organ_photo = request.getParameter("organ_photo");
		String organ_decribe = request.getParameter("organ_decribe");
		String organ_page = request.getParameter("organ_page");
        
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
		 String sql = "insert into location (organ,direction,district,explan,img,link) values(?,?,?,?,?,?)";
		     
		 pstmt = con.prepareStatement(sql);
		
		 pstmt.setString(1, organ_name);
		 pstmt.setString(2, local);
		 pstmt.setString(3, district);
		 pstmt.setString(4, organ_photo);
		 pstmt.setString(5, organ_decribe);
		 pstmt.setString(6, organ_page);

		 pstmt.executeUpdate();

        } catch(Exception e) {
			out.println(e);
        } finally {
			if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
			if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
			if(con != null) {try {con.close();} catch(SQLException sqle) {}}
        }
%>

<script type="text/javascript">

alert("수정 되었습니다.");

location.replace("localMod.jsp");
</script>