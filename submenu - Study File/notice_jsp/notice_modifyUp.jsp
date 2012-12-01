<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
	String savePath="c:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\test\\images";
	int sizeLimit = 5*1024*1024;
	
	
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"utf-8", new DefaultFileRenamePolicy());
	
	
	int num=Integer.parseInt(multi.getParameter("num"));
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content_notice");
	content = content.replaceAll("\r\n","<br>");
	content = content.replaceAll("\u0020","&nbsp;");
	
	
	boolean selectFlag = false;
	String selectQuery = "select ";
	String updateQuery = "update notice set ";
	Enumeration e = multi.getFileNames();
	while( e.hasMoreElements()){
		String formName = (String)e.nextElement();
		if(multi.getFilesystemName(formName) != null){
			selectQuery += formName + ",";
			updateQuery += formName + "='" + multi.getFilesystemName(formName) + "',";
			selectFlag = true;
		}
	}
	
	if(selectQuery.trim().endsWith(",")){
		selectQuery = selectQuery.substring(0,selectQuery.length()-1);
	}
	selectQuery += " from notice where num=" + num;
	updateQuery += " subject='"+ subject +"', content_notice='"+ content +"'where num=" + num;	
	
	
	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project5", "admin", "admin");
	Statement stmt = conn.createStatement();
	
	if(selectFlag){
		ResultSet rs = stmt.executeQuery(selectQuery);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columnCount = rsmd.getColumnCount();
		if( rs.next()){
			for(int i=1 ;i<=columnCount ;i++ ){
				new File(savePath +"/"+ rs.getString(i)).delete();
			}
		}
		rs.close();
	}
	
	
	stmt.executeUpdate(updateQuery);
	stmt.close();
	conn.close();
	response.sendRedirect("notice_upList.jsp");
		
%>


