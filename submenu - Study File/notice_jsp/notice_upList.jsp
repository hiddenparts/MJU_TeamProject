<%@ page language = "java" contentType="text/html; charset = utf-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">
	<head>
		
		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../../stylesheets/style.css" type="text/css" />
		<script type="text/javascript" src="../../script.js"></script>
	
	
	

			<script type="text/javascript">
				function wright(){	
					var temp = document.frm;
					if(temp.chkId.value == "null")
						alert("로그인 해 주십시오");
					else if( temp.chkId.value != "admin" )
						alert("관리자만 작성할 수 있습니다.");
					else
					location.href="../notice_write.jsp";
				}
				
			</script>

<%
	String uid = (String)session.getAttribute("sid"); //세션 존재 여부 확인
	
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try{
		String DB_SERVER = "localhost:3306";
		String DB_SERVER_USERNAME = "admin";
		String DB_SERVER_PASSWORD = "admin";
		String DB_DATABASE = "project5";
		String JDBC_URL = "jdbc:mysql://"+ DB_SERVER+"/"+DB_DATABASE;
		String sql;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(JDBC_URL, DB_SERVER_USERNAME, DB_SERVER_PASSWORD);

		sql = "select count(num) from notice";
		stmt = con.prepareStatement(sql);
		rs = stmt.executeQuery();
		String group_index;
		int list_index;
		group_index = request.getParameter("group_index");
		if(group_index != null){
			list_index = Integer.parseInt(group_index);
		}else{
			list_index = 0;
		}
		rs.next();
		int cnt=rs.getInt(1);
		int cntList = cnt/10;
		int remainder = cnt%10;
		int cntList_1;
		
		if(cntList !=0){
			if(remainder == 0){
				cntList_1 = cntList;
			}else {
				cntList_1 = cntList+1;
			}
		}else{
			cntList_1 = cntList+1;
		}
		rs.close();
		sql = "select num, subject, name from notice order by num desc";
		stmt = con.prepareStatement(sql);
		rs = stmt.executeQuery();

%>	

	</head>
	<body>
	<div id="warp">
		<div id="header">
			
			<div id="headerLeft">
				<a href="../../index.jsp" alt = "Logo"  >
					<img src="../../images/mainlogo2.jpg" border="0">
				</a>
			</div><!--headerLeft end-->
			
			<div id="headerRight"><!--로그인 폼-->
			
			<%	

			
				
			if(uid != null){
					
				int userT = (Integer)session.getAttribute("userType");
					
				if(userT==2){
			%>
			<table>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td width=250 align="center" style="font-size:10pt; font-weight: bold;"><%=uid%>님이 로그인 되었습니다.<br/></td>
				</tr>
				<tr>
					<td  align="center"><a href = "../../SessionDelete.jsp">로그아웃</a></td>
				</tr>
				<tr>
					<td  align="center"><a href ="../../selectadmin.jsp">관리자페이지</a></td>
				</tr>
			</table>
			<%
				}else{

			%>
			<table>
				<tr height=20>
					<td width=250 >&nbsp;</td>
				</tr>
				<tr>
					<td align="center" style="font-size:10pt; font-weight: bold; "><%=uid%>님이 로그인 되었습니다.<br/></td>
				</tr>
				<tr>
					<td align="right"><a href = "../../SessionDelete.jsp">로그아웃</a></td>
				</tr>
				<tr>
					<td align="center">
						<form action = "../../selectuser.jsp" method = "post">
							<input type="hidden" name="userid" value="<%=uid%>">
							<input type="submit" name = "Submit" value="회원정보수정">
						</form>
					</td>
				</tr>
			</table>
			<%
				}
			}else{
			%>
			
			
			
			
				<form name ="slogin" action="../../sessionCreate.jsp" method = "post">
					<table width="288px" height="120px">
						<tr width="288px" height="15px">
							<td width="30px"></td>
							<td width="140px"></td>
							<td width="90px"></td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px">
								<input type="text" name="inputUserID" size="15">
							</td>
							<td width="90px">
								  <input type="checkbox" name="checkID" id="checkID">&nbsp;ID저장
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px">
								<input type="password" name="inputUserPW"size="16">
							</td>
							<td width="90px">
								<input name="imageField" type="image" class="mb" id="imageField" tabindex="3" src="../../images/login_btn.gif">
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px" colspan="2">
								<a href="../../submenu/join.html" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="../../submenu/member_find.jsp" class="logtxt">이메일/비밀번호찾기</a>
							</td>
							<td width="28px"></td>
						</tr>
							<tr width="288px" height="11px">
							<td width="30px"></td>
							<td width="140px"></td>
							<td width="90px"></td>
							<td width="28px"></td>
						</tr>
						</table>
				</form>
<%
}
%>				
			</div><!--headerRight end-->
			
<!--------------------------------------------------------------------------------------------------------------->			
					<div id="navi_drop">
						<ul class="menu" id="menu">
							<li><a href="../../submenu/notice_jsp/notice_upList.jsp" class="menulink">공지사항</a></li>
							<li><a href="../../submenu/recomend/recomend.html" class="menulink">가이드</a>
								<ul>
									<li><a href="../../submenu/recomend/recomend.html">추천 경로</a></li>
									<li><a href="../../submenu/local/local.jsp">지역 정보</a></li>
								</ul>
							</li>
							<li><a href="../../bbs/free/freeBoard.jsp" class="menulink">커뮤니티</a>
								<ul>
									<li><a href="../../bbs/free/freeBoard.jsp">자유 게시판</a></li>
									<li><a href="../../bbs/review/reviewBoard.jsp">후기</a></li>
									<li><a href="../../bbs/qna/qnaBoard.jsp">QnA</a></li>
								</ul>
							</li>
							<li>
								<a href="../../submenu/cart.jsp" class="menulink">담아두기</a>
							</li>
						</ul>
					</div>
<!--------------------------------------------------------------------------------------------------------------->
	

		</div><!--header end-->
		<div id="contents">
				<table  width = "960px" height = "700px">
					<tr height = "22px">
						<td></td>
					</tr>
					<tr valign="top">
						<td>
							<table width = "954px" height="637px" style="text-decoration:none;">
								<tr height = "635px"valign="top">
									<td width="96px"></td>
									<td width ="764px">
										<table	 id="boardList" width="762px">
											<tr height="25px" width ="762px" valign="top">
												<td height="25px" width ="762px" colspan="5">
													<img src="../../images/notice_logo.jpg">
												</td>
											</tr>
											<tr height="26px" width ="762px"  align="center">
												<td height="26px" width ="70px" bgcolor="#000000" style="color:#ffffff;">번호</td>
												<td height="26px" width ="390px" bgcolor="#000000" style="color:#ffffff;">제목</td>
												<td height="26px" width ="120px" bgcolor="#000000" style="color:#ffffff;">이름</td>
											</tr>
<%
		if(!rs.wasNull()){
					for (int i = 0; i< list_index*10 ; i++)
						rs.next();
					int cursor = 0;
					while(rs.next()){
						int no = rs.getInt(1);
						String title = rs.getString(2);
						String userId = rs.getString(3);

	%>
											<tr height="26px" width ="762px"  align="center">
												<td height="26px" width ="30px" bgcolor="#E8E3E2" style="color:#000000;"><%=no%></td>
												<td height="26px" width ="480px" bgcolor="#ffffff" style="color:#ffffff; border-bottom:1px solid #000000;">
												<%
												out.print("<a href = notice_upView.jsp?num="+rs.getInt("num")+">"+rs.getString("subject")+"</a>");
												%>
												
												
												</td>
												<td height="26px" width ="80px" bgcolor="#E8E3E2">운영자</td>
											</tr>
<%
						cursor ++;
						if(cursor>=10) break;
					}
				}
%>
											<tr height="26px" width ="762px"  align="center">
												<td height="26px" colspan="5">
												<%if (cnt>10){%>
													<a href = "notice_upList.jsp?group_index=0">[ 처음 ]</a>
													<%}%>
	<%
		int startpage = 1, maxpage = cntList_1, endpage = startpage + maxpage -1;
		for (int j = startpage; j <=endpage; j++){
			if(j==list_index+1){
	%> [<%=j%>]
	<%
			} else {
	%>
		<a href="notice_upList.jsp?group_index=<%= j-1%>"> [<%= j%>] </a>
		<%
			}		
		}

	%><%if (cnt>10){%><a href = "notice_upList.jsp?group_index=<%=cntList_1-1%>">[ 마지막 ]</ a><%}%>
												</td>
											</tr>
<%}catch(Exception e){
		out.println(e);
	}finally {
		if(rs != null) {try {rs.close();} catch(SQLException sqle){}}
		if(stmt != null) {try {stmt.close();} catch(SQLException sqle){}}
		if(con != null) {try {con.close();} catch(SQLException sqle){}}
	}
	%>
											<tr height="26px" width ="762px"  align="center">
												<td height="26px" colspan="5"align = "right">
													<form method="post" name = "frm" >
														<input type = "hidden" name = "chkId" value = "<%=uid%>" >
														<input type="button" value = "글쓰기" onclick="wright()"/>&nbsp;&nbsp;
													</form>
												</td>
											</tr>
										</table>
									</td>
									<td width="96px"></td>
								</tr>					
							</table>
						</td>	
					</tr>
					<tr height = "40px"></tr>
				</table>
			</form>
		</div>
		<div id="footer">
			<img src ="../../images/copyright.jpg">
		</div>
	</div>
		<!---------------------------------------------->
	<script type="text/javascript">
		var menu=new menu.dd("menu");
		menu.init("menu","menuhover");
	</script>
	<!---------------------------------------------->
</body>

</html>
