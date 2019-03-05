package com.douzone.jblog.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;

@Repository
public class BlogDao 
{
	@Autowired
	private SqlSession sqlSession;
	
	public BlogVo getBlogTitleLogo(long userNo)
	{
		return sqlSession.selectOne("blog.getBlogTitleLogo", userNo);
	}
	
	public int updateAdminBasicInfo(Map<String, Object> map)
	{
		return sqlSession.update("blog.updateAdminBasicInfo", map);
	}
	
	public int postWrite(Map<String, Object> map)
	{
		return sqlSession.insert("blog.postWrite", map);
	}
	
	public List<CategoryVo> getCategoryName(long userNo)
	{
		return sqlSession.selectList("blog.getCategoryName", userNo);
	}
	
	public List<PostVo> getPostList(long categoryNo)
	{
		return sqlSession.selectList("blog.getPostList", categoryNo);
	}
	
	public long setCategory(Map<String, Object> map)
	{
		sqlSession.insert("blog.setCategory", map);
		
		return (long) map.get("no");
	}
	
	public List<CategoryVo> getCategoryList(long userNo)
	{
		return sqlSession.selectList("blog.getCategoryList", userNo);
	}
}
