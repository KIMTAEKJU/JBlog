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
import com.douzone.jblog.vo.UserVo;

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
	
	public int postWrite(String categoryName, BlogVo blogVo, long userNo)
	{
		Map<String, Object> map = new HashMap<>();
		map.put("blogVo", blogVo);
		map.put("categoryName", categoryName);
		map.put("userNo", userNo);
				
		return blogDao.postWrite(map);
	}
	
	public List<CategoryVo> getCategoryName(long userNo)
	{
		return blogDao.getCategoryName(userNo);
	}
	
	public List<PostVo> getPostList(long categoryNo, long postNo, long userNo)
	{
		Map<String, Object> map = new HashMap<>();
		map.put("categoryNo", categoryNo);
		map.put("userNo", userNo);
		
		Long maxPostNo = blogDao.getMaxPostNo(map);
		
		if( maxPostNo == null)
		{
			return null;
		}	
		
		long firstQueryValue = 4;
		long secondQueryValue = 4;
		
		List<PostVo> list = null;
		int showPostCount = 3;
		
		if( postNo == -1) // 카테고리만 눌러서 왔을때
		{
			firstQueryValue = 0;
			secondQueryValue = ( showPostCount * 2 );
			
			if( showPostCount % 2 == 1)
			{
				secondQueryValue++;
			}
			
			System.out.println("--------------------");
			System.out.println("포스트번호가 없을때");
			System.out.println("----------------------");
			
			System.out.println("firstQueryValue : " + firstQueryValue);
			System.out.println("secondQueryValue : " + secondQueryValue);
			System.out.println("maxPostNo : " + maxPostNo);
			System.out.println();
			
			map.put("postNo", maxPostNo);
			map.put("firstQueryValue", firstQueryValue);
			map.put("secondQueryValue", secondQueryValue);
		}
		else // 포스트를 누르고 왔을때
		{
			
			System.out.println("--------------------");
			System.out.println("포스트번호가 있을때");
			System.out.println("----------------------");
			
			map.put("postNo", postNo);
			map.put("firstQueryValue", firstQueryValue);
			map.put("secondQueryValue", secondQueryValue);
			
			int firstGetPostListSize = blogDao.getPostList(map).size();
			int secondGetPostListSize = blogDao.getPostListSecond(map).size();
			
			if( firstGetPostListSize < showPostCount) // 글번호와 최대글번호의 차이가 4가 안될때 
			{
				secondQueryValue += showPostCount - firstGetPostListSize;
			}
			else if( secondGetPostListSize < showPostCount)
			{
				firstQueryValue += showPostCount - secondGetPostListSize;
			}
			
			System.out.println("firstQueryValue : " + firstQueryValue);
			System.out.println("secondQueryValue : " + secondQueryValue);
			System.out.println("maxPostNo : " + maxPostNo);
			System.out.println();
			
			map.put("categoryNo", categoryNo);
			map.put("postNo", postNo);
			map.put("firstQueryValue", firstQueryValue);
			map.put("secondQueryValue", secondQueryValue);
			
		}
		
		list = blogDao.getPostList(map);
		list.addAll(blogDao.getPostListSecond(map));
		return list;
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
	
	public PostVo getMainPost(long pathNo2)
	{
		return blogDao.getMainPost(pathNo2);
	}
	
	public UserVo getUserNo(String id)
	{
		return blogDao.getUserNo(id);
	}
	
	public void categoryDelete(long userNo, long categoryNo)
	{
		Map<String, Object> map = new HashMap<>();
		map.put("categoryNo", categoryNo);
		map.put("userNo", userNo);
		
		blogDao.categoryDelete(map);
	}
	
	public long getMaxPostNo(Map<String, Object> map)
	{
		return blogDao.getMaxPostNo(map);
	}

}
