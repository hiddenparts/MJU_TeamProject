package bean;

import java.io.Serializable;
import java.sql.Timestamp;

import org.json.simple.JSONObject;

public class Graffiti implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int graffitiid;
	private int postid;
	private String userid;
	private String graffitipath;
	private Timestamp graffititdate;
	private int graffitiip;
	
	/* 유저 정보가 필요한 부분.. */
	private String 	usernick;
	private String 	userphoto;
	
	public Graffiti() {
	}


	public Graffiti(int graffitiid, int postid, String userid, String graffitipath, Timestamp graffititdate, int graffitiip,
			String usernick, String userphoto) {
		super();
		this.graffitiid = graffitiid;
		this.postid = postid;
		this.userid = userid;
		this.graffitipath = graffitipath;
		this.graffititdate = graffititdate;
		this.graffitiip = graffitiip;
		
		this.usernick = usernick;
		this.userphoto = userphoto;
	}

	public int getGraffitiid() { return graffitiid; }
	public void setGraffitiid(int graffitiid) { this.graffitiid = graffitiid; }

	public int getPostid() { return postid; }
	public void setPostid(int postid) { this.postid = postid; }

	public String getUserid() { return userid; }
	public void setUserid(String userid) { this.userid = userid; }

	public String getGraffitipath() { return graffitipath; }
	public void setGraffitipath(String graffitipath) { this.graffitipath = graffitipath; }

	public Timestamp getGraffititdate() {  return graffititdate; }
	public void setGraffititdate(Timestamp graffititdate) { this.graffititdate = graffititdate; }

	public int getGraffitiip() { return graffitiip; }
	public void setGraffitiip(int graffitiip) { this.graffitiip = graffitiip; }

	public String getUsernick() { return usernick; }
	public void setUsernick(String usernick) { this.usernick = usernick; }

	public String getUserphoto() { return userphoto; }
	public void setUserphoto(String userphoto) { this.userphoto = userphoto; }
	
	public JSONObject GraffititoJson() {
		JSONObject js = new JSONObject();
		
		js.put("graffitiid", this.graffitiid);
		js.put("postid", this.postid);
		js.put("userid", this.userid);
		js.put("graffitipath", this.graffitipath);
		js.put("graffititdate", this.graffititdate.toString());
		js.put("graffitiip", this.graffitiip);
		js.put("usernick", this.usernick);
		js.put("userphoto", this.userphoto);
		
		return js;
	}

}
