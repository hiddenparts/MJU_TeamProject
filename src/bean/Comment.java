package bean;

import java.io.Serializable;
import java.sql.Timestamp;

public class Comment implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int commentid;
	private int postid;
	private String userid;
	private String commentcontent;
	private Timestamp commentdate;
	private int commentip;
	
	/* 유저 정보가 필요한 부분.. */
	private String 	usernick;
	private String 	userphoto;
	
	public Comment() {
	}


	public Comment(int commentid, int postid, String userid, String commentcontent, Timestamp commentdate, int commentip,
			String usernick, String userphoto) {
		super();
		this.commentid = commentid;
		this.postid = postid;
		this.userid = userid;
		this.commentcontent = commentcontent;
		this.commentdate = commentdate;
		this.commentip = commentip;
		
		this.usernick = usernick;
		this.userphoto = userphoto;
	}


	public int getCommentid() { return commentid; }
	public void setCommentid(int commentid) { this.commentid = commentid; }

	public int getPostid() { return postid; }
	public void setPostid(int postid) { this.postid = postid; }

	public String getUserid() { return userid; }
	public void setUserid(String userid) { this.userid = userid; }

	public String getCommentcontent() { return commentcontent; }
	public void setCommentcontent(String commentcontent) { this.commentcontent = commentcontent; }

	public Timestamp getCommentdate() { return commentdate; } 
	public void setCommentdate(Timestamp commentdate) { this.commentdate = commentdate; }

	public int getCommentip() { return commentip; }
	public void setCommentip(int commentip) { this.commentip = commentip; }

	public String getUsernick() { return usernick; }
	public void setUsernick(String usernick) { this.usernick = usernick; }

	public String getUserphoto() { return userphoto; }
	public void setUserphoto(String userphoto) { this.userphoto = userphoto;	}

}
