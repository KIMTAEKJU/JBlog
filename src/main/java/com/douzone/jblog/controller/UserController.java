package com.douzone.jblog.controller;

import java.util.HashMap;
import java.util.Map;

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

import com.douzone.dto.JSONResult;
import com.douzone.jblog.service.UserService;
import com.douzone.jblog.vo.UserVo;
import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
@RequestMapping("/user")
public class UserController 
{
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@ModelAttribute UserVo userVo)
	{
		return "/user/login";
	}
	
	@ResponseBody
	@RequestMapping("/idcheck")
	public JSONResult idCheck(@RequestParam(value = "id") String id)
	{
		return JSONResult.success(userService.idCheck(id));
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(@ModelAttribute UserVo userVo)
	{
		return "/user/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@ModelAttribute @Valid UserVo userVo, 
					   BindingResult result,
					   Model model)
	{
		if( result.hasErrors())
		{
			model.addAllAttributes( result.getModel() );
			return "/user/join";
		}
		
		userService.join(userVo, "/assets/images/logo.jpg");
		return "redirect:/user/joinsuccess";
	}
	
	@RequestMapping("/joinsuccess")
	public String joinSuccess()
	{
		return "/user/joinsuccess";

	}
	
	
}
