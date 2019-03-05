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
	
	public void join(UserVo userVo, String logo)
	{
		sqlSession.insert("user.insert", userVo); // 유저등록
		String id = sqlSession.selectOne("user.getId", userVo.getNo()) + "님의 블로그 입니다.";
		
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userVo.getNo());
		map.put("title", id);
		map.put("logo", logo);
		map.put("defaultCategoryName", "미분류");
		map.put("defaultCategoryDescription", "기본 카테고리입니다.");
		
		sqlSession.insert("user.makeBlog", map); // 기본 블로그 제목, 로고 등록
		sqlSession.insert("user.makeDefaultCategory", map); // 기본 카테고리 등록
		
		
	}
	
	public UserVo login(UserVo userVo)
	{
		return sqlSession.selectOne("user.getByIdAndPassword", userVo);
	}
}
