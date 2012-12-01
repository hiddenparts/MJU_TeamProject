<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
	<head>
		<title> 과학문화 탐방 </title>
</head>
<body>
    <div id="contents">
        <%
        request.setCharacterEncoding("UTF-8");
		String district_name=request.getParameter("loc");
        %>
        <table id = "title"><tr><td><%=district_name%></td></tr></table>
        <table  id = "title" border="1">
		<tr>
            <td>기관이름</td>
            <td>기관사진</td>
            <td>기관링크</td>
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
        String organ_page = rs.getString("link");

		if(organ_photo==null){
			organ_photo = "123.jpg";
		}
        %>
        <tr>
            <td> <%=organ_name%> </td>
            <td> <img src="../../../images/<%=organ_photo%>" width="50	" height="50"/> </td>
            <td> <a href="<%=organ_page%>"><%=organ_page%></a></td>	
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
</body>
</html>