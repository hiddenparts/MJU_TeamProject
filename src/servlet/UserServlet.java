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

//섬네일 이미지를 만들기 위한 JAI클래스, 그래픽 관련 클래스들
import java.awt.Graphics2D;
import java.awt.image.renderable.ParameterBlock;
import java.awt.image.BufferedImage;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.imageio.ImageIO;

//이미지 업로드 관련 클래스들 
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;
import java.io.File;
import java.util.Enumeration;

import member.*;

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
		String userid = "";
		String pwd = "";
		String pwd_confirm = "";
		String lastname = "";
		String firstname = "";
		String nickname = "";
		String profilephoto = "";
		String email = "";
		String gender = "";
		String website = "";
		String introduce = "";
		String info = "";
		List<String> errorMsgs = new ArrayList<String>();
		
	/* image upload ============================================================== */	
		String imagePath = request.getRealPath("image"); //실제로 업로드 될 폴더의 경로 설정
		int size = 1 * 1024 * 1024; //업로드 사이즈 제한
		
		try {
			//이미지 업로드
			MultipartRequest multi = new MultipartRequest(request, imagePath, size, "utf-8", new DefaultFileRenamePolicy());

			/* POST로 설정된 form에서 값을 받아와서 임시로 저장함 */
			/* MultipartRequest를 사용하면 request의 값은 소멸함.. 아오 빡쳐...*/
			userid = multi.getParameter("userid");
			pwd = multi.getParameter("pwd");
			pwd_confirm = multi.getParameter("pwd_confirm");
			lastname = multi.getParameter("lastname");
			firstname = multi.getParameter("firstname");
			nickname = multi.getParameter("nickname");
			email = multi.getParameter("email");
			gender = multi.getParameter("gender");
			website = multi.getParameter("website");
			introduce = multi.getParameter("introduce");
			info = multi.getParameter("info");
			
			System.out.println(userid);
			System.out.println(pwd);
			System.out.println(pwd_confirm);
			System.out.println(lastname);
			System.out.println(firstname);
			System.out.println(nickname);
			System.out.println(email);
			System.out.println(gender);
			System.out.println(website);
			System.out.println(introduce);
			System.out.println(info);
			
			//업로드 된 이미지 이름 얻어옴!
			Enumeration files = multi.getFileNames();
			String file = (String) files.nextElement();
			profilephoto = multi.getFilesystemName(file);
		} catch (Exception e) {
			System.out.println("에러" + e);
			//e.printStackTrace();
		}

		// 이 클래스에 변환할 이미지를 담는다.(이미지는 ParameterBlock을 통해서만 담을수 있다.)
		ParameterBlock pb = new ParameterBlock();
		pb.add(imagePath + "\\" + profilephoto);
		System.out.println(imagePath + "\\" + profilephoto);
		
		RenderedOp rOp = JAI.create("fileload", pb);

		//불러온 이미지를 BuffedImage에 담는다.
		BufferedImage bi = rOp.getAsBufferedImage();
		//thumb라는 이미지 버퍼를 생성, 버퍼의 사이즈는 100*100으로 설정.
		BufferedImage thumb = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);

		//버퍼사이즈 100*100으로  맞춰  썸네일을 그림
		Graphics2D g = thumb.createGraphics();
		g.drawImage(bi, 0, 0, 100, 100, null);

		/*출력할 위치와 파일이름을 설정하고 섬네일 이미지를 생성한다. 저장하는 타입을 jpg로 설정.*/
		File file = new File(imagePath + "/sm_" + profilephoto);
		ImageIO.write(thumb, "jpg", file);
	/* image upload ============================================================== */
		
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
	/* sign.jsp에서 입력받은 데이타를  Member클래스의 인스턴스 user에 등록 */
		
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