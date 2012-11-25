package servlet;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CommentDAO;

import bean.Article;
import bean.Comment;
import bean.Member;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/Comment")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		boolean ret 		= false;;
		Comment comment = new Comment();

		request.setCharacterEncoding("utf-8");
		int postid = Integer.parseInt(request.getParameter("postid"));
		Member user = (Member) session.getAttribute("user"); 		
		String userid = user.getUserid();
		String commentcontent = request.getParameter("comment");
		//int commentip = request.getParameter("");
			
		/* 빈 코멘트를 입력할때 발생하는 에러는 js로 막을 예정 */
		
		comment.setCommentcontent(commentcontent);
		comment.setCommentdate(new Timestamp(System.currentTimeMillis()));
		comment.setCommentip(123456789);
		comment.setPostid(postid);
		comment.setUserid(userid);		
		
		try {
			ret = CommentDAO.create(comment);
			if(ret) {
				System.out.println(userid + "님의 코멘트 성공");
			} else {
				System.out.println(userid + "님의 코멘트 실패");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		response.sendRedirect("");
	}

}
