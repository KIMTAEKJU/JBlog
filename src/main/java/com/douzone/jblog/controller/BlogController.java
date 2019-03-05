package com.douzone.jblog.controller;

import java.util.List;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.douzone.dto.JSONResult;
import com.douzone.jblog.service.BlogService;
import com.douzone.jblog.service.FileuploadService;
import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;
import com.douzone.jblog.vo.UserVo;
import com.douzone.security.AuthUser;

@Controller
@RequestMapping("/{id:(?!assets).*}")
public class BlogController 
{
	@Autowired
	private BlogService blogService;

	@Autowired
	private FileuploadService fileuploadService;

	@RequestMapping({"", "/{pathNo1}", "/{pathNo1}/{pathNo2}" })
	public String blog(@AuthUser UserVo userVo, 
					   Model model, 
					   @PathVariable String id,
					   @PathVariable Optional<Long> pathNo1, 
					   @PathVariable Optional<Long> pathNo2) 
	{
		List<PostVo> postList = null;
		
		model.addAttribute("blogVo", blogService.getBlogTitleLogo(userVo.getNo()));
		
		List<CategoryVo> categoryList = blogService.getCategoryName(userVo.getNo());
		
		model.addAttribute("categoryNameList", categoryList);
		
		if( pathNo1.isPresent()) // 카테고리를 눌러서 온거라면
		{	
			System.out.println("pathNo1 : " + pathNo1);
			postList = blogService.getPostList(pathNo1.get());
			
			System.out.println("postList : " + postList);
			System.out.println("postList size : " + postList.size());
		}
		else
		{
			postList = blogService.getPostList(1);
			model.addAttribute("mainPost", postList.get(0) ); // 아니면 미분류 내용
		}
		
		if( pathNo2.isPresent()) // 글까지 눌렀다면
		{	
			System.out.println("pathNo2 : " + pathNo2);
	
			model.addAttribute("mainPost", postList.get( pathNo2.get().intValue() - 1) );

			postList.remove(pathNo2.get().intValue() - 1);
			
			model.addAttribute("postList", postList);
		}
		else
		{
			model.addAttribute("mainPost", postList.get(0) );
			if( postList.size() != 0)
			{
				postList.remove(0);
			}
			model.addAttribute("postList", postList);
		}
		
		return "/blog/blog-main";
	}

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admin(Model model, @AuthUser UserVo userVo, @ModelAttribute BlogVo blogVo) 
	{
		blogVo = blogService.getBlogTitleLogo(userVo.getNo());

		System.out.println("blogVo : " + blogVo);
		model.addAttribute("blogVo", blogVo);
		return "/blog/blog-admin-basic";
	}

	@RequestMapping(value = "/admin", method = RequestMethod.POST)
	public String admin(@RequestParam(value = "logo-file", required = false) MultipartFile logo, 
						@AuthUser UserVo userVo, Model model,
						@ModelAttribute @Valid BlogVo blogVo, 
						BindingResult result) 
	{
		System.out.println("여긴?");
		
		String imgUrl = fileuploadService.restore(logo);

		if (result.hasErrors()) {
			model.addAllAttributes(result.getModel());

			model.addAttribute("blogVo", blogService.getBlogTitleLogo(userVo.getNo()));
			return "/blog/blog-admin-basic";
		}


		System.out.println("imgUrl : " + imgUrl);
		
		if( imgUrl.equals("") == true) 
		{
			System.out.println("널 셋팅");
			imgUrl = null;
		}
		
		blogVo.setLogo(imgUrl);

		int results = blogService.updateAdminBasicInfo(blogVo, userVo.getNo());

		model.addAttribute("blogVo", blogVo);
		

		return "redirect:/" + userVo.getId();
	}

	@RequestMapping(value = "/admin/write", method = RequestMethod.GET)
	public String adminWrite(@ModelAttribute BlogVo blogVo,
							 Model model,
							 @AuthUser UserVo userVo) 
	{
		blogVo = blogService.getBlogTitleLogo(userVo.getNo());

		model.addAttribute("blogVo", blogVo);
		return "/blog/blog-admin-write";
	}

	@RequestMapping(value = "/admin/write", method = RequestMethod.POST)
	public String adminWrite(Model model, 
							@AuthUser UserVo userVo, 
							@RequestParam("category") String categoryName,
							@ModelAttribute @Valid BlogVo blogVo, 
							BindingResult result) 
	{
		if (result.hasErrors()) {
			System.out.println("여기");
			model.addAllAttributes(result.getModel());
			blogVo = blogService.getBlogTitleLogo(userVo.getNo());

			model.addAttribute("blogVo", blogVo);
			return "/blog/blog-admin-write";
		} 
		else 
		{
			int results = blogService.postWrite(categoryName, blogVo);
			System.out.println("results : " + results);
		}

		return "redirect:/" + userVo.getId() + "/admin/write";
	}
	
	@RequestMapping(value = "/admin/category", method = RequestMethod.GET)
	public String adminCategory(@AuthUser UserVo userVo,
								Model model) 
	{
		BlogVo blogVo = blogService.getBlogTitleLogo(userVo.getNo());
		
		System.out.println("blogVo : " + blogVo);
		model.addAttribute("blogVo", blogVo);
		model.addAttribute("categoryList", blogService.getCategoryList(userVo.getNo()));
		return "/blog/blog-admin-category";
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/category", method = RequestMethod.POST)
	public JSONResult adminCategory(@ModelAttribute @Valid CategoryVo categoryVo,
								 @AuthUser UserVo userVo,
								 BindingResult result,
								 Model model)
	{
		System.out.println("categoryVo : " + categoryVo);
		
		if( result.hasErrors())
		{
			model.addAllAttributes( result.getModel());
			return JSONResult.fail("실패");
		}
		
		long results = blogService.setCategory(categoryVo, userVo.getNo());
		System.out.println("results : " + results);
		
		categoryVo.setNo(results);
		return JSONResult.success(categoryVo);
	}
}
