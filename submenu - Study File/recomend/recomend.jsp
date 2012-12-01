<%@ page contentType="text/html; charset=euc-kr"  %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">





<html xmlns = "http://www.w3.org/1999/xhtml">
<head>
	
		
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title> °úÇÐ¹®È­ Å½¹æ </title>
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
			<div id="headerRight"><!--·Î±×ÀÎ Æû-->
			
			<%	

			String uid = (String)session.getAttribute("sid"); //¼¼¼Ç Á¸Àç ¿©ºÎ È®ÀÎ
				
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
					<td width=250 align="center" style="font-size:10pt; font-weight: bold;"><%=uid%>´ÔÀÌ ·Î±×ÀÎ µÇ¾ú½À´Ï´Ù.<br/></td>
				</tr>
				<tr>
					<td  align="center"><a href = "../../SessionDelete.jsp">·Î±×¾Æ¿ô</a></td>
				</tr>
				<tr>
					<td  align="center"><a href ="../../selectadmin.jsp">°ü¸®ÀÚÆäÀÌÁö</a></td>
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
					<td align="center" style="font-size:10pt; font-weight: bold; "><%=uid%>´ÔÀÌ ·Î±×ÀÎ µÇ¾ú½À´Ï´Ù.<br/></td>
				</tr>
				<tr>
					<td align="right"><a href = "../../SessionDelete.jsp">·Î±×¾Æ¿ô</a></td>
				</tr>
				<tr>
					<td align="center">
						<form action = "../../selectuser.jsp" method = "post">
							<input type="hidden" name="userid" value="<%=uid%>">
							<input type="submit" name = "Submit" value="È¸¿øÁ¤º¸¼öÁ¤">
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
								  <input type="checkbox" name="checkID" id="checkID">&nbsp;IDÀúÀå
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
								<a href="../../submenu/join.jsp" class="logtxt">È¸¿ø°¡ÀÔ</a>
								<span class="mLR">|</span>
								<a href="../submenu/member_infor.html" class="logtxt">ÀÌ¸ÞÀÏ/ºñ¹Ð¹øÈ£Ã£±â</a>
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
							<li><a href="../../submenu/notice_jsp/notice_upList.jsp" class="menulink">°øÁö»çÇ×</a></li>
							<li><a href="../../submenu/recomend/recomend.html" class="menulink">°¡ÀÌµå</a>
								<ul>
									<li><a href="../../submenu/recomend/recomend.html">ÃßÃµ °æ·Î</a></li>
									<li><a href="../../submenu/local/local.jsp">Áö¿ª Á¤º¸</a></li>
								</ul>
							</li>
							<li><a href="../../bbs/free/freeBoard.jsp" class="menulink">Ä¿¹Â´ÏÆ¼</a>
								<ul>
									<li><a href="../../bbs/free/freeBoard.jsp">ÀÚÀ¯ °Ô½ÃÆÇ</a></li>
									<li><a href="../../bbs/review/reviewBoard.jsp">ÈÄ±â</a></li>
									<li><a href="../../bbs/qna/qnaBoard.jsp">QnA</a></li>
								</ul>
							</li>
							<li>
								<a href="../../submenu/cart.jsp" class="menulink">´ã¾ÆµÎ±â</a>
							</li>
						</ul>
					</div>
<!--------------------------------------------------------------------------------------------------------------->
			
			
			
			
			
			
			
			
			
		</div>
		<div id="contents_notice_modify">
		
			<img src="../../images/recomend_img.jpg" />

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




