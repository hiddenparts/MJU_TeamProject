package servlet;

import bean.*;
import dao.*;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


/**
 * Servlet implementation class User
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
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
		String 	op 			= request.getParameter("op");
		String userid = request.getParameter("id");
		String 	actionUrl 	= "";
		boolean ret;

		try {
			if (op == null || op.equals("index")) {
				int page = getIntFromParameter(request.getParameter("page"), 1);
				
				PageResult<Member> users = MemberDAO.getPage(page, 10);
				request.setAttribute("users", users);
				request.setAttribute("page", page);
				actionUrl = "admin/index.jsp";
			} else if (op.equals("show")) {
				Member user = MemberDAO.findById(userid);
				request.setAttribute("user", user);

				actionUrl = "admin/show.jsp";
			} else if (op.equals("update")) {
				Member user = MemberDAO.findById(userid);
				request.setAttribute("user", user);
				request.setAttribute("method", "PUT");
				
				actionUrl = "admin/signup.jsp";
			} else if (op.equals("delete")) {
				ret = MemberDAO.remove(userid);
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


	private boolean isRegisterMode(MultipartRequest request) {
		String method = request.getParameter("_method");
		return method == null || method.equals("POST");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean ret 		= false;
		boolean res = true;
		String 	actionUrl = "admin";
		String 	msg;
		Member 	user 		= new Member();
		MultipartRequest multi = null;
		
		request.setCharacterEncoding("utf-8");
		List<String> errorMsgs = new ArrayList<String>();
				
		/* MultipartRequest를 사용하면 이미 request의 값은 소멸함.. 아오 빡쳐...*/
		String imagePath = getServletContext().getRealPath("image"); //실제로 업로드 될 폴더의 경로 설정
		int size = 2 * 1024 * 1024; //업로드 사이즈 제한. 2MB로 설정
		
		multi = new MultipartRequest(request, imagePath, size, "utf-8", new DefaultFileRenamePolicy());		
		
		/* POST로 설정된 form에서 값을 받아와서 임시로 저장함 */
		String profilephoto = UploadPhoto(multi, response, imagePath);
		String userid 		= multi.getParameter("userid");
		String pwd 			= multi.getParameter("pwd");
		String pwd_confirm 	= multi.getParameter("pwd_confirm");
		String lastname 	= multi.getParameter("lastname");
		String firstname 	= multi.getParameter("firstname");
		String nickname 	= multi.getParameter("nickname");
		String email 		= multi.getParameter("email");
		String gender 		= multi.getParameter("gender");
		String website		= multi.getParameter("website");
		String introduce 	= multi.getParameter("introduce");
		String info 		= multi.getParameter("info");

		if (pwd.length() < 6 || pwd == null ) {
			errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
			res = false;
		} 
		if (!pwd.equals(pwd_confirm)) {
			errorMsgs.add("비밀번호가 일치하지 않습니다.");
			res = false;
		}

		if (userid == null || userid.trim().length() == 0) {
			errorMsgs.add("ID를 반드시 입력해주세요.");
			res = false;
		}
		
		if (lastname == null || lastname.trim().length() == 0) {
			errorMsgs.add("성을 반드시 입력해주세요.");
			res = false;
		}
		
		if (firstname == null || firstname.trim().length() == 0) {
			errorMsgs.add("이름을 반드시 입력해주세요.");
			res = false;
		}
		
		if (nickname == null || nickname.trim().length() == 0) {
			errorMsgs.add("별명을 반드시 입력해주세요.");
			res = false;
		}
		
		if (profilephoto == null && isRegisterMode(multi)) {
			errorMsgs.add("사진 업로드에 문제가 발생하여 사진이 업로드 되지 않았습니다");
		}
		
		if (gender == null || !(gender.equals("M") || gender.equals("F") )) {
			errorMsgs.add("성별에 적합하지 않은 값이 입력되었습니다.");
			res = false;
		}
		
		if (info == null || !(info.equals("Y") || info.equals("N") )) {
			errorMsgs.add("정보 공개여부를 선택해주세요");
			res = false;
		}
		
		/* sign.jsp에서 입력받은 데이터를  javabean인 Member 클래스의 인스턴스 user에 등록 */
		user.setUserid(userid);
		user.setPwd(pwd); 
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
			/* bean인 user를 가지고 DAO의 함수를 호출하여 DB처리를 함 */
			if(res) {
				if (isRegisterMode(multi)) {
					ret = MemberDAO.create(user);
					msg = "<b>" + lastname + firstname + "</b>님의 사용자 정보가 등록되었습니다.";
				} else {
					ret = MemberDAO.update(user);
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
			}
		} catch (Exception e) {
			errorMsgs.add(e.getMessage());
			System.out.println(e.getMessage());
			actionUrl = "admin/error.jsp";
		}
		
		request.setAttribute("errorMsgs", errorMsgs);
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
	}

	private String UploadPhoto(MultipartRequest multi, HttpServletResponse response, String imagePath) {
		String userid 		= null;	
		String profilephoto = null;	
		String 	curTimeStr 	= Long.toString(System.currentTimeMillis()); //use Unix Time
	
		try {
			// 이미지 업로드
			// 실제 저장은 다른 경로에 저장되니 조심..여기서는 imagePath에 저장되니 이 경로를 추적하면 된다.			
			userid 		= multi.getParameter("userid");
			profilephoto = multi.getParameter("profilephoto");
			
			// 업로드 된 이미지 이름 얻어옴!
			Enumeration files 	= multi.getFileNames();
			String 		file 	= (String) files.nextElement();
			
			/* 파일을 업로드 했다면 썸네일을 만든다 */
			if((multi.getOriginalFileName(file)) != null) {
				// 파일을 업로드 했으면 파일명을 얻음
				profilephoto = multi.getOriginalFileName(file);
				// 파일명 변경준비
				String changephoto 	= profilephoto;
				String fileExt 		= "";
				int i = -1;
				if ((i = changephoto.lastIndexOf(".")) != -1) {
					fileExt = changephoto.substring(i); // 확장자만 추출
					changephoto = changephoto.substring(0, i); // 파일명만 추출
				}
				// 사진명을 UNIXTIME_USERID로 설정
				changephoto = curTimeStr + "_" + userid;
				// 파일명 변경
				File oldFile = new File(imagePath + System.getProperty("file.separator") + profilephoto);
				File newFile = new File(imagePath + System.getProperty("file.separator") + changephoto + fileExt);	
			    oldFile.renameTo(newFile);			
				// 썸네일 파일명 준비용
				profilephoto = curTimeStr + "_" + userid + fileExt;
				// 이 클래스에 변환할 이미지를 담는다.(이미지는 ParameterBlock을 통해서만 담을수 있다.)
				ParameterBlock pb = new ParameterBlock();
				pb.add(imagePath + System.getProperty("file.separator") + profilephoto);
				
				RenderedOp rOp = JAI.create("fileload", pb);
		
				// 불러온 이미지를 BuffedImage에 담는다.
				BufferedImage bi = rOp.getAsBufferedImage();
				// thumb라는 이미지 버퍼를 생성, 버퍼의 사이즈는 100*100으로 설정.
				BufferedImage thumb = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
		
				// 버퍼사이즈 100*100으로  맞춰  썸네일을 그림
				Graphics2D g = thumb.createGraphics();
				g.drawImage(bi, 0, 0, 100, 100, null);
		
				/* 출력할 위치와 파일이름을 설정하고 섬네일 이미지를 생성한다. 저장하는 타입을 jpg로 설정.*/
				File file1 = new File(imagePath + "/sm" + profilephoto);
				ImageIO.write(thumb, "jpg", file1);
			}
		} catch (Exception e) {
			// 저장에 실패하면 경로를 얻지못했기때문에 null을 리턴
			return null;
		}		
		return profilephoto;
	}
	
}
