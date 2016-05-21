package com.yf.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yf.dao.WebsiteconfigDao;
import com.yf.model.User;
import com.yf.model.Websitconfig;

@Controller
@RequestMapping("/")
public class AdminController {
	
	@Resource
	private WebsiteconfigDao websiteconfigDao;
	@RequestMapping(value="/admin",method=RequestMethod.GET)
	public ModelAndView manager(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		
		User user = (User)request.getSession().getAttribute("curUser");
		
		if(user == null){
			modelAndView.setViewName("login");
		}else{
			Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
			modelAndView.addObject("logourl",websitconfig.getLogourl());
			modelAndView.addObject("title",websitconfig.getTitle());
			modelAndView.setViewName("admin");
		}
		
		return modelAndView;
	}
	@RequestMapping(value="/sdedfjukdxflkdj",method=RequestMethod.GET)
	public ModelAndView index(){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("logourl",websitconfig.getLogourl());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.setViewName("login");
		return modelAndView;
	}
}
