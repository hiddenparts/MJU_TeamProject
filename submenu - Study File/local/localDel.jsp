<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
        request.setCharacterEncoding("UTF-8");
		String organ_name =request.getParameter("organ_name");

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
        String sql = "select * from location";
        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();

		while(rs.next()){
		
			String readOrgan = rs.getString("organ");

			if(readOrgan.equals(organ_name)){
				sql = "delete from location where organ = '"+readOrgan+"'";
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
			}
		
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
alert("삭제되었습니다.");
location.replace("localMod.jsp");
</script>
