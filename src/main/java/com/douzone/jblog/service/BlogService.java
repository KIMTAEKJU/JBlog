package com.douzone.jblog.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.jblog.repository.BlogDao;
import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;

@Service
public class BlogService 
{
	@Autowired
	private BlogDao blogDao;
	
	public BlogVo getBlogTitleLogo(long userNo)
	{
		return blogDao.getBlogTitleLogo(userNo);
	}
	
	public int updateAdminBasicInfo(BlogVo blogVo, long userNo)
	{
		Map<String, Object> map = new HashMap<>();
		map.put("blogVo", blogVo);
		map.put("userNo", userNo);
		
		return blogDao.updateAdminBasicInfo(map);
	}
	
	public int postWrite(String categoryName, BlogVo blogVo)
	{
		Map<String, Object> map = new HashMap<>();
		map.put("blogVo", blogVo);
		map.put("categoryName", categoryName);
				
		return blogDao.postWrite(map);
	}
	
	public List<CategoryVo> getCategoryName(long userNo)
	{
		return blogDao.getCategoryName(userNo);
	}
	
	public List<PostVo> getPostList(long categoryNo)
	{
		return blogDao.getPostList(categoryNo);
	}
	
	public long setCategory(CategoryVo categoryVo, long userNo)
	{
		Map<String, Object> map = new HashMap<>();
		map.put("categoryVo", categoryVo);
		map.put("userNo", userNo);
		
		return blogDao.setCategory(map);
	}
	
	public List<CategoryVo> getCategoryList(long userNo)
	{
		return blogDao.getCategoryList(userNo);
	}

}