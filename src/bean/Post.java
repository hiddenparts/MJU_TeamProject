package bean;

import java.io.Serializable;
import java.util.ArrayList;

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
	// 댓그림 빈
	
	public Post() {		
	}

	public Post(Member member, Article article, ArrayList<Comment> comment) {
		super();
		this.article = article;
		this.member = member;
		this.comment = comment;
	}
	
	public Article getArticle() { return article; }
	public Member getMember() { return member; }
	public ArrayList<Comment> getComment() { return comment; }
	
	public void setArticle(Article article) { this.article = article; }
	public void setMember(Member member) { this.member = member; }
	public void setComment(ArrayList<Comment> comment) { this.comment = comment; }
}
