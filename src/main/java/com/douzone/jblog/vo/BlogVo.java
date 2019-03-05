package com.douzone.jblog.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class BlogVo 
{
	@NotEmpty
	private String title;
	
	private String logo;
	
	@NotEmpty
	private String contents;
	
	@NotEmpty
	private String postTitle;
	
	private String categoryName;
	
	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@Override
	public String toString() {
		return "BlogVo [title=" + title + ", logo=" + logo + ", contents=" + contents + ", postTitle=" + postTitle
				+ ", categoryName=" + categoryName + "]";
	}

	
	
	
}
