package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.*;

import org.apache.commons.lang3.StringUtils;


/**
 * Servlet implementation class User
 */
@WebServlet("/admin")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
    }


	private int getIntFromParameter(String str, int defaultValue) {
		int id;
		
		try {
			id = Integer.parseInt(str);
		} catch (Exception e) {
			id = defaultValue;
		}
		return id;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String op = request.getParameter("op");
		String actionUrl = "";
		boolean ret;
		
		String userid = request.getParameter("id");
		
		try {
			if (op == null || op.equals("index")) {
				int page = getIntFromParameter(request.getParameter("page"), 1);
				
				PageResult<Member> users = UserDAO.getPage(page, 10);
				request.setAttribute("users", users);
				request.setAttribute("page", page);
				actionUrl = "admin/index.jsp";
			} else if (op.equals("show")) {
				Member user = UserDAO.findById(userid);
				request.setAttribute("user", user);

				actionUrl = "admin/show.jsp";
			} else if (op.equals("update")) {
				Member user = UserDAO.findById(userid);
				request.setAttribute("user", user);
				request.setAttribute("method", "PUT");
				
				actionUrl = "admin/signup.jsp";
			} else if (op.equals("delete")) {
				ret = UserDAO.remove(userid);
				request.setAttribute("result", ret);
				
				if (ret) {
					request.setAttribute("msg", "사용자 정보가 삭제되었습니다.");
					actionUrl = "admin/success.jsp";
				} else {
					request.setAttribute("error", "사용자 정보 삭제에 실패했습니다.");
					actionUrl = "admin/error.jsp";
				}
					
			} else if (op.equals("signup")) {
				request.setAttribute("method", "POST");
				request.setAttribute("user", new Member());
				actionUrl = "admin/signup.jsp";
			} else {
				request.setAttribute("error", "알 수 없는 명령입니다");
				actionUrl = "admin/error.jsp";
			}
		} catch (SQLException | NamingException e) {
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
			actionUrl = "admin/error.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request, response);
		
	}


	private boolean isRegisterMode(HttpServletRequest request) {
		String method = request.getParameter("_method");
		return method == null || method.equals("POST");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean ret = false;
		String actionUrl;
		String msg;
		Member user = new Member();

		request.setCharacterEncoding("utf-8");
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String pwd_confirm = request.getParameter("pwd_confirm");
		String lastname = request.getParameter("lastname");
		String firstname = request.getParameter("firstname");
		String nickname = request.getParameter("nickname");
		String profilephoto = request.getParameter("profilephoto");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String website = request.getParameter("website");
		String introduce = request.getParameter("introduce");
		String info = request.getParameter("info");
		
		List<String> errorMsgs = new ArrayList<String>();
		
		
	/* sign.jsp에서 입력받은 데이타를  Member클래스의 인스턴스 user에 등록 */
		//가입이면
		if (isRegisterMode(request)) {
			if (pwd == null || pwd.length() < 6) {
				errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
			} 
			
			if (!pwd.equals(pwd_confirm)) {
				errorMsgs.add("비밀번호가 일치하지 않습니다.");
			}
			user.setPwd(pwd);
		} 

		if (userid == null || userid.trim().length() == 0) {
			errorMsgs.add("ID를 반드시 입력해주세요.");
		}
		
		if (lastname == null || lastname.trim().length() == 0) {
			errorMsgs.add("성을 반드시 입력해주세요.");
		}
		
		if (firstname == null || firstname.trim().length() == 0) {
			errorMsgs.add("이름을 반드시 입력해주세요.");
		}
		
		if (nickname == null || nickname.trim().length() == 0) {
			errorMsgs.add("별명을 반드시 입력해주세요.");
		}
		
		if (gender == null || !(gender.equals("M") || gender.equals("F") )) {
			errorMsgs.add("성별에 적합하지 않은 값이 입력되었습니다.");
		}
		
		if (info == null || !(info.equals("Y") || info.equals("N") )) {
			errorMsgs.add("정보 공개여부를 선택해주세요");
		}
		user.setUserid(userid);
		user.setRegisterdate(new Timestamp(System.currentTimeMillis()));
		user.setLastname(lastname);
		user.setFirstname(firstname);
		user.setNickname(nickname);
		user.setProfilephoto(profilephoto);
		user.setEmail(email);
		user.setGender(gender);
		user.setIntroduce(introduce);
		user.setWebsite(website);
		user.setInfo(info);

		try {
			/* user를 가지고 DAO의 함수를 호출하여 DB처리를 함 */
			if (isRegisterMode(request)) {
				ret = UserDAO.create(user);
				msg = "<b>" + lastname + firstname + "</b>님의 사용자 정보가 등록되었습니다.";
			} else {
				ret = UserDAO.update(user);
				actionUrl = "admin/success.jsp";
				msg = "<b>" + lastname + firstname + "</b>님의 사용자 정보가 수정되었습니다.";
			}
			if (ret != true) {
				errorMsgs.add("변경에 실패했습니다.");
				actionUrl = "admin/error.jsp";
			} else {
				request.setAttribute("msg", msg);
				actionUrl = "admin/success.jsp";
			}
		} catch (SQLException | NamingException e) {
			errorMsgs.add(e.getMessage());
			System.out.println(e.getMessage());
			actionUrl = "admin/error.jsp";
		}
		
		request.setAttribute("errorMsgs", errorMsgs);
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
	}

}
