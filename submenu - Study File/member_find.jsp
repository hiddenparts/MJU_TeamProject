<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
	<head>
		<title> 비밀번호 찾기 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../stylesheets/style.css" type="text/css" />
		<script type="text/javascript" src="../script.js"></script>
	</head>
	<script type ="text/javascript" >
				//비밀번호 검사
	function checkPassward(){
		
		var userPsw = document.getElementById("newPasswd");
		var checkPsw = document.getElementById("checkPasswd");

		if(userPsw.value.length >=8){
		}else{
		alert("길이가 짧습니다");
		return false;}
		var numbercount = 0;
		var numberalpha =0;
		for (var i= 0; i <userPsw.value.length ; i++ ){
		if(userPsw.value.charAt(i) >= 0 || userPsw.value.charAt(i) <= 9 ){
		numbercount++;
		}else if (userPsw.value.charAt(i).toString()){
		numberalpha++;
		}
		}
		if(numbercount == 0 && numberalpha == 0){
		alert("영문자와 숫자 모두 포함되어있어야함");
		return false;
		}else if(userPsw.value !== checkPsw.value){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
		}else{
		return true;
		}
		}
</script>
<body>
	<div id="warp">
		<div id="header">
			<div id="headerLeft">
				<a href="../index.jsp" alt = "Logo"  >
					<img src="../images/mainlogo2.jpg" border="0" >
				</a>
			</div>
			<div id="headerRight"><!--로그인 폼-->
				<form method="post" action="">
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
								<input type="text" name="userID" size="15">
							</td>
							<td width="90px">
								  <input type="checkbox" name="checkID" id="checkID">&nbsp;ID저장
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px">
								<input type="password" name="userPW" size="16">
							</td>
							<td width="90px">
								<input name="imageField" type="image" class="mb" id="imageField" tabindex="3" src="../images/login_btn.gif">
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px" colspan="2">
								<a href="./join.jsp" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="./member_find.jsp" class="logtxt">이메일/비밀번호찾기</a>
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
			</div>
<!--------------------------------------------------------------------------------------------------------------->			
					<div id="navi_drop">
						<ul class="menu" id="menu">
							<li><a href="../submenu/notice_jsp/notice_upList.jsp" class="menulink">공지사항</a></li>
							<li><a href="../submenu/recomend/recomend.html" class="menulink">가이드</a>
								<ul>
									<li><a href="../submenu/recomend/recomend.html">추천 경로</a></li>
									<li><a href="../submenu/local/local.jsp">지역 정보</a></li>
								</ul>
							</li>
							<li><a href="../bbs/free/freeBoard.jsp" class="menulink">커뮤니티</a>
								<ul>
									<li><a href="../bbs/free/freeBoard.jsp">자유 게시판</a></li>
									<li><a href="../bbs/review/reviewBoard.jsp">후기</a></li>
									<li><a href="../bbs/qna/qnaBoard.jsp">QnA</a></li>
								</ul>
							</li>
							<li>
								<a href="../submenu/cart.jsp" class="menulink">담아두기</a>
							</li>
						</ul>
					</div>
<!--------------------------------------------------------------------------------------------------------------->

		</div>
		<div id="contents_join">
		
				<form action="./join_jsp/modifyPasswd.jsp" method = "post" onsubmit = "return checkPassward()" >
					<table id="join_table" border="0px">
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2" align="center" id="join_option2"></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
							<tr>
							<td>아이디</td>
							<td><input type="text" name="userId" size="30"id="join_box" maxlength="24"/></td>
						</tr>
						<tr>
							<td>비밀번호 질문</td>
							<td>
								<select name="location">
									<option value="1" width="500px">전종훈 교수님의 생신은?</option>
									<option value="2"> 보물 1호는? </option>
									<option value="3"> 좌우명은? </option>
									<option value="4"> 생각나는 명언? </option>
									<option value="5"> 여자친구 이름은? </option>
									<option value="6"> 좋아하는 음식은? </option>
									<option value="7"> 간호사 vs 여경 </option>
									<option value="8"> 아이유 vs 김태희 </option>
									<option value="9"> 안드로이드 vs 애플 </option>
									<option value="10"> 삼성 vs 애플 </option>
									<option value="11"> 바퀴벌레 vs 곱등이 </option>
								</select>
							</td>
						</tr>
						<tr>
							<td>비밀번호 답</td>
							<td><input type="text" name="passwd_a"size="30"  maxlength="50"/></td>
						</tr>
						<tr>
							<td>새비밀번호</td>
							<td><input type="password" name="newPasswd" size="30" maxlength="24"/></td>
						</tr>
						<tr>
							<td>새비밀번호확인</td>
							<td><input type="password" name="checkPasswd" size="30"  maxlength="20"/></td>
						</tr>
						
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input  type="submit" value="수정"  id="button_img1" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
						</tr>
					</table>
				</form>
		
		</div>
		<div id="footer">
		<img src ="../images/copyright.jpg">
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
