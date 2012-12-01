<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %><%@ page import="java.util.*" %>
<HTML><HEAD><TITLE>과학문화 탐방</TITLE>
<META content="text/html; charset=utf-8" http-equiv=content-type>
<META name=GENERATOR content="MSHTML 9.00.8112.16434">
</head>
<body>
<% 
String	ck[] = request.getParameterValues("all");

if(ck != null){
String sp[];
ArrayList<String> array_id = new ArrayList<String>();
ArrayList<String> array_organ = new ArrayList<String>();
	for(int i = 0; i<ck.length; i++){
		String aa = new String(ck[i].getBytes("8859_1"), "UTF-8");
		sp = aa.split(",");
		array_id.add(sp[0]);
		array_organ.add(sp[1]);
	}	
out.println("아이디 "+array_id+"<br>");
out.println("기관명 "+array_organ+"<br>");
try {
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/project5?useUnicode=true&characterEncoding=utf-8";
out.println("url에 제대로 연결되었습니다."+"<br>");
Connection con = DriverManager.getConnection(url,"admin","admin");
out.println("Connection에 제대로 연결되었습니다."+"<br>");
Statement stat = con.createStatement();
out.println("Statement에 제대로 연결되었습니다."+"<br>");
for(int i=0; i<array_id.size(); i++){
	String id = array_id.get(i);
	String organ = array_organ.get(i);
	String query = "DELETE FROM cart where id='" + id +"'" + " and organ ='" + organ + "'";
	out.println("DELETE 반복 "+i+"<br>");
	stat.executeUpdate(query);
	out.println("DELETE 반복"+i+"<br>");

}
}catch(Exception e){
  out.println( e );
}
}
response.sendRedirect("../cart.jsp");
%>

</body>
</html>
