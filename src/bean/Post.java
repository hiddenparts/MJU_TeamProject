package bean;

import java.io.Serializable;
import java.util.ArrayList;

import org.json.simple.JSONObject;

public class Post implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/**
	 *  게시글 처리를 위한 Bean
	 *  이 Bean은 글 자체를 나타낸다. 
	 *   
	 *  */
	private Member member;
	private Article article;
	private ArrayList<Comment> comment;
	private ArrayList<Graffiti> graffiti;
	// 댓그림 빈
	
	public Post() {		
	}

	public Post(Member member, Article article, ArrayList<Comment> comment, ArrayList<Graffiti> graffiti) {
		super();
		this.article = article;
		this.member = member;
		this.comment = comment;
		this.graffiti = graffiti;
	}
	
	public Article getArticle() { return article; }
	public Member getMember() { return member; }
	public ArrayList<Comment> getComment() { return comment; }
	public ArrayList<Graffiti> getGraffiti() { return graffiti; }
	
	public void setArticle(Article article) { this.article = article; }
	public void setMember(Member member) { this.member = member; }
	public void setComment(ArrayList<Comment> comment) { this.comment = comment; }
	public void setGraffiti(ArrayList<Graffiti> graffiti) { this.graffiti = graffiti; }
	
	//json 형태로 출력
	public JSONObject PosttoJson() {
		JSONObject js = new JSONObject();
		js.put("name", member.getNickname());
		return js;
	}
}
