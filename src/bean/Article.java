package bean;

import java.io.Serializable;
import java.sql.Timestamp;

public class Article implements Serializable{
	private static final long serialVersionUID = 1L;

	private int postid;
	private String userid;
	private int albumid;
	private String photo;
	private String content;
	private Timestamp postdate;
	private String category;
	private int hits;
	private int likehit;
	private int ipaddress;
	
	// No-arg constructor 가 있어야 한다.
	public Article() {
	}

	public Article(int postid, String userid, int albumid, String photo, String content, Timestamp postdate, String category, 
			int hits, int likehit, int ipaddress) {
		super();
		this.postid = postid;
		this.userid = userid;
		this.albumid = albumid;
		this.photo = photo;
		this.content = content;
		this.postdate = postdate;
		this.category = category;
		this.hits = hits;
		this.likehit = likehit;
		this.ipaddress = ipaddress;
	}

	public int getPostid() { return postid; }
	public String getUserid() { return userid; }
	public int getAlbumid() { return albumid; }
	public String getPhoto() { return photo; }
	public String getContent() { return content; }
	public Timestamp getPostdate() { return postdate; }
	public String getCategory() { return category; }
	public int getHits() { return hits; }
	public int getLikehit() { return likehit; }
	public int getIpaddress() { return ipaddress; }

	public void setPostid(int postid) { this.postid = postid; }
	public void setUserid(String userid) { this.userid = userid; }
	public void setAlbumid(int albumid) { this.albumid = albumid; }
	public void setPhoto(String photo) { this.photo = photo; }
	public void setContent(String content) { this.content = content; }
	public void setPostdate(Timestamp postdate) {  this.postdate = postdate; }
	public void setCategory(String category) { this.category = category; }
	public void setHits(int hits) { this.hits = hits; }
	public void setLikehit(int likehit) { this.likehit = likehit; }
	public void setIpaddress(int ipaddress) { this.ipaddress = ipaddress; }
	
}
