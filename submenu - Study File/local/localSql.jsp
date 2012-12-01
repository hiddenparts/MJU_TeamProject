<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>


<%
        request.setCharacterEncoding("UTF-8");

		String savePath="c:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\test\\images";
		int sizeLimit = 5*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"UTF-8", new DefaultFileRenamePolicy());
        
		String local = multi.getParameter("local");
		String district = multi.getParameter("district");
		String organ_name = multi.getParameter("organ_name");
		String organ_decribe = multi.getParameter("organ_decribe");
		String organ_page = multi.getParameter("organ_page");
		
		String fileName = multi.getFilesystemName("organ_photo");
		int size = (int)(new File(savePath + "/" + fileName).length());

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
		 pstmt.setString(4, organ_decribe);
		 pstmt.setString(5, fileName);
		 pstmt.setString(6, organ_page);

		 int affectedRow = pstmt.executeUpdate();

        } catch(Exception e) {
			out.println(e);
        } finally {
			if(rs != null) {try {rs.close();} catch(SQLException sqle) {}}
			if(pstmt != null) {try {pstmt.close();} catch(SQLException sqle) {}}
			if(con != null) {try {con.close();} catch(SQLException sqle) {}}
        }

%>

<script type="text/javascript">

alert("반영되었습니다.");

location.replace("localMod.jsp");
</script>