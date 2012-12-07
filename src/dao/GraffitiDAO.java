package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

import javax.naming.*;
import javax.sql.*;

import bean.*;

public class GraffitiDAO {

	public static DataSource getDataSource() throws NamingException {
		Context initCtx = null;
		Context envCtx = null;

		// Obtain our environment naming context
		initCtx = new InitialContext();
		envCtx = (Context) initCtx.lookup("java:comp/env");

		// Look up our data source
		return (DataSource) envCtx.lookup("jdbc/WebDB");
	}
	
	public static ArrayList<Graffiti> getGraffitiList(int postid) throws SQLException, NamingException {
		ArrayList<Graffiti> list = new ArrayList<Graffiti>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		try {
			conn = ds.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select DISTINCT	graffiti.*, member.nickname, member.profilephoto " 
								 + "from  graffiti join article, member "
								 + "where graffiti.postid = " + postid 
								 + " and graffiti.userid = member.userid order by graffiti.graffititdate ");

			while(rs.next()) {
				list.add(new Graffiti(rs.getInt("graffitiid"), 
									rs.getInt("postid"), 
									rs.getString("userid"), 
									rs.getString("graffitipath"), 
									rs.getTimestamp("graffititdate"), 
									rs.getInt("graffitiip"), 
									rs.getString("nickname"), 
									rs.getString("profilephoto")));
			}
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return list;
	}
	
	public static boolean create(Graffiti graffiti) throws SQLException, NamingException {
		int result;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement(
					"INSERT INTO graffiti(postid, userid, graffitipath, graffititdate, graffitiip) " +
					"VALUES( ?, ?, ?, ?, ?)"
					);

			stmt.setInt(1, graffiti.getPostid());
			stmt.setString(2, graffiti.getUserid());
			stmt.setString(3, graffiti.getGraffitipath());
			stmt.setTimestamp(4, graffiti.getGraffititdate());
			stmt.setInt(5,  graffiti.getGraffitiip());

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