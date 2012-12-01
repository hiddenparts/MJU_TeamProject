﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		 
		<title> 과학문화 탐방 </title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
		<link href="../stylesheets/index.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../stylesheets/style.css" type="text/css" />
		<script type="text/javascript" src="../script.js"></script>
		<script type="text/javascript">
				var total=0;
				
				//이메일 유효성 검사.
				function fun_checkEmail(form){ 
					var ch_email = /[a-z0-9]{2,}@[a-z0-9]{2,}\.[a-z0-9]{2,}/i; 
					if(!ch_email.test(form.e_mail.value)) 
						alert("E-mail error!! 바르게 입력해 주십시오."); 
					else 
						alert("확인되었습니다!"); 
	
				} 
				
				
				//모든 항목 검사 - 원클릭
				function test_form(){
					
					//alert("test start");
					
					//이메일 
					var domain = document.getElementById("domainname").value;  
					var email = document.getElementById("email").value;  
					if( domain == "title" ||  email == ""){
						alert("이메일 주소를 정확히 입력하여 주세요.");
						return false;
					}
					else{
						//alert("email , domain OK");
						total=total+1;
					}
					
					
					//비밀번호
					var test_passwd=fun_passwordcheck();;
					
					
					if( test_passwd != 1){
						//alert("password error");
						return false;
					}
					else{
						//alert("password OK");
						total=total+1;
					}
					
					//비밀번호 답 확인
					var passwd_ans = document.getElementById("passwd_a").value;
					if( passwd_ans == "" ){
						alert("비밀번호 답을 입력하여 주십시오.");
						return false;
					}
					else{
						//alert("password answer OK");
						total=total+1;
					}
					
					
					
					//이름 공란 확인
					var name = document.getElementById("inputname").value;
					if( name == "" ){
						alert("이름을 입력하여 주십시오");
						return false;
					}
					else{
						//alert("name OK");
						total=total+1;
					}
					
					
					
					//폰번호 확인
					var pho1 = document.getElementById("pho1").value;
					var pho2 = document.getElementById("pho2").value;
					var pho3 = document.getElementById("pho3").value;
					if( pho1=="" || pho2=="" || pho3=="" ){
						alert("핸드폰 번호를 입력하여 주십시오.");
						return false;
					}
					else{
						//alert("phone num OK");
						total=total+1;
					}
					
					
					
					
					//공란부분 확인 
					if(total >= 5){        ///확인한 부분이 기대값에 못 미칠 경우 에러
						//alert(" 모든항목 입력되었습니다.");
						return true; //continue..
					}
					else{
						alert("모든 항목을 채워주십시오.");
						return false;
					}
				}
				
				
				//ID 검사 아스키코드 65~90 97~122
				function fun_idencheck(){
					var value_id = document.getElementById("inputid").value;
					
					var check=0;
					
					var return_str="";
					var str=value_id;
					for(var i =0;i<=0;i++){
						return_str += str.charCodeAt(i);
					}
					if( return_str >= 65 && return_str <= 90 ){
						//alert("OK");				
					}			
					else if(return_str >= 97 && return_str <= 122){
						//alert("OK");							
					}
					else{ 
						alert("ID 첫 글자는 영문자로 시작해야 합니다."); 
						check = check + 1;
					}

					if( value_id.length >= 6 && value_id.length <= 15 ){ 
						//alert("length ok");
					}
					else{ 
						alert("ID는 6자리 이상 15자리 이하로 입력해주십시오.");	
						check = check + 1;
					}
					
					if( check == 0 ){
						alert(" 아이디 중복 검사를 시작합니다. ");
						//window.open("http://localhost:8080/test/assign4_id_check.jsp" , "new" , "width=300, height=200, left=100, top=30, scrollbars=no,titlebar=no,status=no,resizable=no,fullscreen=no" );
						//document.write(value_id);
						window.open('./join_jsp/join_id_check.jsp?value_id=' + value_id ,"new", "width=300, height=200, left=100, top=30, scrollbars=no,titlebar=no,status=no,resizable=no,fullscreen=no" );
						
					}
					
				}
				
				
				//비밀번호 검사
				function fun_passwordcheck(){
					var value_password1 = document.getElementById("passwd").value;
					var value_password2 = document.getElementById("passwd_check").value;
					
					var password_a=[];		
					password_a = value_password1;
					var password_b=[];
					password_b = value_password2;
					
					
					
					if( value_password1.length >= 8 ){
						
						var int_pass=0;
						var char_pass=0;
						for(var i=0 ;i< password_a.length ;i++ ){
							
							var return_str="";
							var str=value_password1;
							return_str = str.charCodeAt(i);
							
							if( return_str >= 48 && return_str <= 57)
								int_pass++;
							else if(return_str >= 97 && return_str <= 122)
								char_pass++;
						}
						if( int_pass==0 || char_pass==0 )
							alert("비밀번호는 숫자, 문자를 혼합하여 작성하십시오. ");
						else{
							var check_pass_samed=0;
							for(var i=0 ;i<=password_a.length ;i++ ){
								if(password_b[i] != password_a[i])
									check_pass_samed++;
							}
							if(check_pass_samed != 0)
								alert("같은 비밀번호를 입력하여 주십시오.");
							else
								//alert("올바른 형식입니다.");
								return 1;
						}
					}
					else
						alert("비밀번호는 8자 이상 입력해주십시오.");
				}
				
				
		</script>
	</head>
	<body>
	<div id="warp">
		<div id="header">
			
			<div id="headerLeft">
				<a href="../index.jsp" alt = "Logo"  >
					<img src="../images/mainlogo2.jpg" border="0">
				</a>
			</div><!--headerLeft end-->
			
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
		<td width="250" align="center" style="font-size:10pt; font-weight: bold;"><%=uid%>님이 로그인 되었습니다.<br/></td>
	</tr>
	<tr>
		<td  align="center"><a href = "../SessionDelete.jsp">로그아웃</a></td>
	</tr>
	<tr>
		<td  align="center"><a href ="../selectadmin.jsp">관리자페이지</a></td>
	</tr>
</table>
<%
	}else{

%>
<table>
	<tr height="20">
		<td width="250" >&nbsp;</td>
	</tr>
	<tr>
		<td align="center" style="font-size:10pt; font-weight: bold; "><%=uid%>님이 로그인 되었습니다.<br/></td>
	</tr>
	<tr>
		<td align="right"><a href = "../SessionDelete.jsp">로그아웃</a></td>
	</tr>
	<tr>
		<td align="center">
			<form action = "../selectuser.jsp" method = "post">
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
				<form name ="slogin" action="../sessionCreate.jsp" method = "post">
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
								<input name="imageField" type="image" class="mb" id="imageField" tabindex="3" src="../images/login_btn.gif">
							</td>
							<td width="28px"></td>
						</tr>
						<tr width="288px" height="26px">
							<td width="30px"></td>
							<td width="140px" colspan="2">
								<a href="../submenu/join.jsp" class="logtxt">회원가입</a>
								<span class="mLR">|</span>
								<a href="../submenu/member_find.jsp" class="logtxt">이메일/비밀번호찾기</a>
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
		
			<div id="joinpage_form">
				<form action="./join_jsp/join_insert.jsp" >
					<table id="join_table" border="0px">
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
							<td><input type="text" name="inputid" ize="30" id="inputid" maxlength="15"/><input type="button" value="중복확인" name="아이디확인" id="button_img1" onclick="fun_idencheck()" /></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" name="passwd"size="30"id="passwd" maxlength="16"/>8~16자 영문자 혼합. </td>
						</tr>
						<tr>
							<td>비밀번호 확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td><input type="password" name="비밀번호 확인"size="30" id="passwd_check" maxlength="16"/></td>
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
							<td><input type="text" name="passwd_a"size="30" id="passwd_a" maxlength="50"/></td>
						</tr>
						<tr>
							<td>닉네임</td>
							<td><input type="text" name="nickname" size="30"id="join_box" maxlength="24"/><input type="button" value="중복확인" name="닉네임확인" id="button_img1"/></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" name="inputname" size="30" id="inputname" maxlength="20"/></td>
						</tr>
						<tr>
							<td>E-mail</td>
							<td><input type="text" name="email" size="15"id="email" maxlength="16"/>@
								<select name="domainname" id="domainname">
									<option value="title">::주소선택::</option>
									<option value="naver.com">naver.com(네이버)</option>
									<option value="paran.com">paran.com(파란)</option>
									<option value="empal.com">empal.com(엠팔)</option>
									<option value="nate.com">nate.com(네이트)</option>
									<option value="yahoo.co.kr">yahoo.co.kr(야후)</option>
									<option value="google.com">google.com(구글)</option>
									<option value="mju.ac.kr">mju.ac.kr(명지대)</option>
								</select>
								<input type="checkbox" name="e-mail_agreement"/>메일 수신 동의
							</td>
						</tr>
						<tr>
							<td></td>
							<td>다음(한메일) 사용 시 메일이 차단 될 수 있습니다.</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td id="join_option1"><input type="text" name="pho1" size="2" id="pho1" maxlength="3"/>&nbsp;-&nbsp;<input type="text" name="pho2" size="3" id="pho2" maxlength="4"/>&nbsp;-&nbsp;<input type="text" name="pho3" size="3" id="pho3" maxlength="4"/></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input onclick="return test_form()"; type="submit" value="가입" name="submit" id="button_img1" onclick="test_form()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="취소" name="cancel" id="button_img1"/></td>
						</tr>
					</table>
				</form>
			</div>
		
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
