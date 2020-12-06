package dto;

import java.text.SimpleDateFormat;
import java.util.*;

public class Post {

	private String postId;
	private String title;
	private String userId;
	private String userOid;
	private String postDate;
	private String text;
	private String imageName;
	private String category;
	private int hit;
	
	public Post() {}
	
	public Post(String postId, String userId, Date postDate) {
		this.postId = postId;
		this.userId = userId;
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = fm.format(postDate);
		this.postDate = to;
	}
	
	public String getUserOid() {
		return userOid;
	}

	public void setUserOid(String userOid) {
		this.userOid = userOid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = fm.format(postDate);
		this.postDate = to;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
	
}
