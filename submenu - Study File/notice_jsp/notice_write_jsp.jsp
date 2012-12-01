<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String savePath="c:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\test\\images";
	int sizeLimit = 5*1024*1024;
	
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"utf-8", new DefaultFileRenamePolicy());

	
	
	String userName = multi.getParameter("userName");
	
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content_notice");
	content = content.replaceAll("\r\n","<br>");
	content = content.replaceAll("\u0020","&nbsp;");
	
	String fileName = multi.getFilesystemName("upfile");
	int size = (int)(new File(savePath + "/" + fileName).length());
	
	
	
	
	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project5", "admin", "admin");
	
	
	String query = "insert into notice values(null, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1,userName);
	pstmt.setString(2,subject);
	pstmt.setString(3,content);
	pstmt.setString(4,fileName);
	pstmt.setInt(5,size);
	int affectedRow = pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	if(affectedRow != 1){
		out.print("데이터 베이스 입력 실패");
		
		Enumeration enum1 = multi.getFileNames();
		while(enum1.hasMoreElements()){
			new File(savePath + "/" + multi.getFilesystemName((String)enum1.nextElement())).delete();
		}
	}else{
		response.sendRedirect("notice_upList.jsp");
	}
%>	