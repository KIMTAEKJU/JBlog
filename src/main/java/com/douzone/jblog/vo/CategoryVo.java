package com.douzone.jblog.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class CategoryVo 
{
	private Long no;
	
	@NotEmpty
	private String name;
	
	@NotEmpty
	private String description;

	private Long postCount;
	
	
	
	public Long getPostCount() {
		return postCount;
	}

	public void setPostCount(Long postCount) {
		this.postCount = postCount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "CategoryVo [no=" + no + ", name=" + name + ", description=" + description + ", postCount=" + postCount
				+ "]";
	}

	
}
