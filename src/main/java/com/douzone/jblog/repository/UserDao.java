package com.douzone.jblog.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.douzone.jblog.vo.UserVo;

@Repository
public class UserDao 
{
	@Autowired
	private SqlSession sqlSession;
	
	public String idCheck(String id)
	{
		System.out.println("id : " + id);
		return sqlSession.selectOne("user.idCheck", id);
	}
	
	public void join(UserVo userVo)
	{
		sqlSession.insert("user.insert", userVo); // 유저등록
		userVo.setId( userVo.getId() + "님의 블로그입니다.");

		sqlSession.insert("user.makeBlog", userVo); // 기본 블로그 제목, 로고 등록
		sqlSession.insert("user.makeallPostLook", userVo.getNo()); // 전체글보기 카테고리 등록
		sqlSession.insert("user.makeDefaultCategory", userVo.getNo()); // 기본 카테고리 등록
	}
	
	public UserVo login(UserVo userVo)
	{
		return sqlSession.selectOne("user.getByIdAndPassword", userVo);
	}
}
