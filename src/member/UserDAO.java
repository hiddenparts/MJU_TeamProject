package member;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;


public class UserDAO {
	public static DataSource getDataSource() throws NamingException {
		Context initCtx = null;
		Context envCtx = null;

		// Obtain our environment naming context
		initCtx = new InitialContext();
		envCtx = (Context) initCtx.lookup("java:comp/env");

		// Look up our data source
		return (DataSource) envCtx.lookup("jdbc/WebDB");
	}
	
	public static PageResult<Member> getPage(int page, int numItemsInPage) 
			throws SQLException, NamingException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;		

		if (page <= 0) {
			page = 1;
		}
		
		DataSource ds = getDataSource();
		PageResult<Member> result = new PageResult<Member>(numItemsInPage, page);
		
		
		int startPos = (page - 1) * numItemsInPage;
		
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			
			// users 테이블: user 수 페이지수 개산
	 		rs = stmt.executeQuery("SELECT COUNT(*) FROM member");
			rs.next();
			
			result.setNumItems(rs.getInt(1));
			
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			
	 		// users 테이블 SELECT
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM member LIMIT " + startPos + ", " + numItemsInPage);
			
			while(rs.next()) {
				result.getList().add(new Member(
											rs.getString("userid"),
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
											rs.getInt("level")));
			}
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return result;		
	}
	
	public static Member findById(String userid) throws NamingException, SQLException{
		Member user = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM member WHERE userid = ?");
			stmt.setString(1, userid);
			
			// 수행
			rs = stmt.executeQuery();

			if (rs.next()) {
				user = new Member(
						rs.getString("userid"),
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
						rs.getInt("level"));
			}	
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return user;
	}
	
	public static boolean create(Member user) throws SQLException, NamingException {
		int result;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement(
					"INSERT INTO member(userid, userpassword, registerdate, lastname, firstname, nickname, profilephoto, gender, email, introduce, website, info) " +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1,  user.getUserid());
			stmt.setString(2,  user.getPwd());
			stmt.setTimestamp(3,  user.getRegisterdate());
			stmt.setString(4,  user.getLastname());
			stmt.setString(5,  user.getFirstname());
			stmt.setString(6,  user.getNickname());
			stmt.setString(7,  user.getProfilephoto());
			stmt.setString(8,  user.getGender()); //?
			stmt.setString(9,  user.getEmail());
			stmt.setString(10,  user.getIntroduce());
			stmt.setString(11,  user.getWebsite());
			stmt.setString(12,  user.getInfo());
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);
	}
	
	public static boolean update(Member user) throws SQLException, NamingException {
		int result;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement(
					"UPDATE member " +
					"SET  lastname=?, firstname=?, nickname=?, profilephoto=?, gender=?, email=?, introduce=?, website=?, info=?" +
					"WHERE userid=?"
					);
			stmt.setString(1,  user.getLastname());
			stmt.setString(2,  user.getFirstname());
			stmt.setString(3,  user.getNickname());
			stmt.setString(4,  user.getProfilephoto());
			stmt.setString(5,  user.getGender()); //?
			stmt.setString(6,  user.getEmail());
			stmt.setString(7,  user.getIntroduce());
			stmt.setString(8,  user.getWebsite());
			stmt.setString(9,  user.getInfo());
			//stmt.setInt(11,  user.getLevel()); 질의문에 level=? 추가
			stmt.setString(10,  user.getUserid());
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static boolean remove(String userid) throws NamingException, SQLException {
		int result;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("DELETE FROM member WHERE userid=?");
			stmt.setString(1,  userid);
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
}