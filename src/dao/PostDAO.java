package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

import javax.naming.*;
import javax.sql.*;

import bean.*;

public class PostDAO {
	
	public static DataSource getDataSource() throws NamingException {
		Context initCtx = null;
		Context envCtx = null;

		// Obtain our environment naming context
		initCtx = new InitialContext();
		envCtx = (Context) initCtx.lookup("java:comp/env");

		// Look up our data source
		return (DataSource) envCtx.lookup("jdbc/WebDB");
	}
	
	public static PageResult<Post> getPage(int page, int numItemsInPage) throws SQLException, NamingException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;		
		ArrayList<Comment> comment = new ArrayList<Comment>();
		
		if (page <= 0) {
			page = 1;
		}
		
		DataSource ds = getDataSource();
		PageResult<Post> result = new PageResult<Post>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;
		
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			
			// 총 게시물 수 조사
	 		rs = stmt.executeQuery("SELECT COUNT(*) FROM article");
			rs.next();
			result.setNumItems(rs.getInt(1));
			
			rs.close(); 
			rs = null;
			stmt.close(); 
			stmt = null;
			
	 		// 전체 글  테이블 SELECT.. startPos부터 numItems까지
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from member,article where member.userid = article.userid limit " + startPos + ", " + numItemsInPage);
			
			// 먼저 글의 목록을 받아온다
			while(rs.next()) { 
				result.getList().add(new Post(new Member( rs.getString("userid"),
														rs.getString("userpassword"),
														rs.getTimestamp("registerdate"),
														rs.getString("lastname"),
														rs.getString("firstname"),
														rs.getString("nickname"),
														rs.getString("profilephoto"),
														rs.getString("gender"),
														rs.getString("email"),
														rs.getString("introduce"),
														rs.getString("website"),
														rs.getString("info"),
														rs.getInt("level")),
											  new Article(rs.getInt("postid"),
														rs.getString("userid"),
														rs.getInt("albumid"),
														rs.getString("photo"),
														rs.getString("content"),
														rs.getTimestamp("postdate"),
														rs.getString("category"),
														rs.getInt("hits"),
														rs.getInt("likehits"),
														rs.getInt("postip")),
												new ArrayList<Comment>()));
			}
			// 글의 목록에 코멘트 리스트를 채워준다.
			for(int i=0; i < result.getList().size(); i++) {
				comment = CommentDAO.getCommentList(result.getList().get(i).getArticle().getPostid());			
				result.getList().get(i).setComment(comment);
			}
			
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return result;		
	}	
}
