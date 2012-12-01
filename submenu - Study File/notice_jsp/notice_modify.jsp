﻿<%@ page contentType="text/html; charset=utf-8"  %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


	<%
		int num = Integer.parseInt(request.getParameter("num"));
	%>


<html xmlns = "http://www.w3.org/1999/xhtml">
<head>
	
		
		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../../stylesheets/style.css" type="text/css" />
		<script type="text/javascript" src="../../script.js"></script>
	
	
	
	
	
	

</head>
<body>
	<div id="warp">
		<div id="header">
			<div id="headerLeft">
				<a href="../../index.jsp" alt = "Logo"  >
					<img src="../../images/mainlogo2.jpg" border="0" >
				</a>
			</div>
			<div id="headerRight"><!--로그인 폼-->
			
			<%	

			String uid = (String)session.getAttribute("sid"); //세션 존재 여부 확인
				
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
								<a href="../../submenu/join.jsp" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="../submenu/member_infor.html" class="logtxt">이메일/비밀번호찾기</a>
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
			</div>
			
				
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
			
			
			
			
			
			
			
			
			
		</div>
		<div id="contents_notice_modify">
		
			<form name="frm" method="post" action="notice_modifyUp.jsp" enctype="multipart/form-data" >
				<table border="1">
					<tr>
						<td>글쓴이</td>
						<td><input type="hidden" name="userName" id="userName" value = "<%=uid%>"/><%=uid%></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" size=40></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="content_notice" rows="30" cols="60" style="resize:none" maxlength="1200byte"></textarea></td>
					</tr>
					<tr>
						<td>파일</td>
						<td><input type="file" name="upfile"></td>
					</tr>
					<tr>
						<td colspan=2 align="center"><input type="submit" value="수 정"></td>
					</tr>
					
				</table>
				<input type="hidden" name="num" value=<%=num%>>
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




