package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import sun.org.mozilla.javascript.internal.json.JsonParser;

import bean.*;

import dao.*;

/**
 * Servlet implementation class AjaxServlet
 */
@WebServlet("/AjaxServlet")
public class AjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		JSONObject rsobj = new JSONObject();
		Post post = new Post();
		ArrayList<Post> list = new ArrayList<Post>();
		
		// 어떤 명령인지 확인
		String op = request.getParameter("op");
		
		int op_num = -1;
		int op_num1 = -1;
		try {
			if(op.equals("popup")) {
				//get Post id
				op_num = Integer.parseInt(request.getParameter("postid"));
				//System.out.println("post : " + op_num); 
			} else if(op.equals("page")) {
				//get Page num
				op_num = Integer.parseInt(request.getParameter("page"));
				//System.out.println("page : " + op_num);
			} else if(op.equals("category")) {
				//get category
				op_num = Integer.parseInt(request.getParameter("page"));
				//System.out.println("page : " + op_num);
				op_num1 = Integer.parseInt(request.getParameter("cate"));
				//System.out.println("cate : " + op_num1);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			op_num = -1;
		}
		
		// 로그인 상태이면 사용자의 정보를 받아온다
		String loginphoto = "";
		if(session != null) {
			Member user = (Member) session.getAttribute("user");
			if(user != null) {
				loginphoto = user.getProfilephoto();
				rsobj.put("loginphoto", loginphoto);
			}
		}
		
		try {
			if(op.equals("popup")) {
				post = PostDAO.findByPostID(op_num);
				JSONArray comjsar = new JSONArray();
				JSONArray grajsar = new JSONArray();
				
				rsobj.put("user", post.getMember().UsertoJson());
				rsobj.put("article", post.getArticle().ArtitoJson());
			
				for(int i=0; i<post.getComment().size(); i++) {
					comjsar.add(post.getComment().get(i).CommenttoJson());
				}
				for(int i=0; i<post.getGraffiti().size(); i++) {
					grajsar.add(post.getGraffiti().get(i).GraffititoJson());
				}
				rsobj.put("comment", comjsar);
				rsobj.put("graffiti", grajsar);
			} else if(op.equals("page")) {
				list = PostDAO.getPage(op_num);
				
				JSONArray postjsar = new JSONArray();
				for(int i=0; i<list.size(); i++) {
					JSONObject subjsobj = new JSONObject();
					JSONArray comjsar = new JSONArray();
					subjsobj.put("user", list.get(i).getMember().UsertoJson());
					subjsobj.put("article", list.get(i).getArticle().ArtitoJson());
					
					for(int j=0; j<list.get(i).getComment().size(); j++) {
						comjsar.add(list.get(i).getComment().get(j).CommenttoJson());
					}
					subjsobj.put("comment", comjsar);
					postjsar.add(subjsobj);
				}
				rsobj.put("post", postjsar);
			} else if(op.equals("category")) {
				list = PostDAO.getCategoryPage(op_num, op_num1);
				
				JSONArray postjsar = new JSONArray();
				for(int i=0; i<list.size(); i++) {
					JSONObject subjsobj = new JSONObject();
					JSONArray comjsar = new JSONArray();
					subjsobj.put("user", list.get(i).getMember().UsertoJson());
					subjsobj.put("article", list.get(i).getArticle().ArtitoJson());
					
					for(int j=0; j<list.get(i).getComment().size(); j++) {
						comjsar.add(list.get(i).getComment().get(j).CommenttoJson());
					}
					subjsobj.put("comment", comjsar);
					postjsar.add(subjsobj);
				}
				rsobj.put("post", postjsar);
			}
		} catch (Exception e) {
			System.out.println(e);
			rsobj.put("ERROR", e.getMessage());
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(rsobj.toJSONString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		boolean ret 		= false;
		JSONObject rsobj = new JSONObject();
		
		Object obj = null;
		JSONObject shape = new JSONObject();
		Graffiti graffiti = new Graffiti();
		
		// Get Graffiti items 
		request.setCharacterEncoding("utf-8");
		 
		int postid = Integer.parseInt(request.getParameter("Postid"));
		String userid = request.getParameter("userid");
		// Get DrawPoints
		String shapes = request.getParameter("Shapes");		
		
		// Set Graffiti items
		graffiti.setPostid(postid);
		graffiti.setUserid(userid);
		graffiti.setGraffitipath(shapes);
		graffiti.setGraffititdate(new Timestamp(System.currentTimeMillis()));
		graffiti.setGraffitiip(123456789);		
		
		try {
			ret = GraffitiDAO.create(graffiti);
			if(ret) {
				System.out.println(userid + "님의 그림저장 성공");
				rsobj.put("result", "ok");
			} else {
				System.out.println(userid + "님의 그림저장 실패");
				rsobj.put("result", "no");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(rsobj.toJSONString());
	}

}
