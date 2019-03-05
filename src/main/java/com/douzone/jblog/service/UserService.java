package com.douzone.jblog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.jblog.repository.UserDao;
import com.douzone.jblog.vo.UserVo;

@Service
public class UserService 
{
	@Autowired
	private UserDao userDao;
		
	public String idCheck(String id)
	{
		return userDao.idCheck(id);
	}
	
	public void join(UserVo userVo, String logo)
	{
		userDao.join(userVo, logo);
	}
	
	public UserVo login(UserVo userVo)
	{
		return userDao.login(userVo);
	}
}
