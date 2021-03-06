package com.douzone.jblog.vo;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class UserVo 
{
	private Long no;
	
	@NotEmpty
	@Length(min = 2, max = 8)
	private String name;
	
	@NotEmpty
	private String id;
	
	private String password;
	private String gender;
	private String joinDate;
	
	
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

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	@Override
	public String toString() {
		return "UserVo [no=" + no + ", name=" + name + ", id=" + id + ", password=" + password + ", gender=" + gender
				+ ", joinDate=" + joinDate + "]";
	}
	
	
	
	
}
