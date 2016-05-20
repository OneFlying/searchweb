package com.yf.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sun.tools.internal.ws.processor.model.Model;
import com.yf.dao.WebsiteconfigDao;
import com.yf.model.Websitconfig;

@Controller
@RequestMapping("/")
public class AdminController {
	
	@Resource
	private WebsiteconfigDao websiteconfigDao;
	@RequestMapping(value="/",method=RequestMethod.GET)
	public ModelAndView manager(){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("logourl",websitconfig.getLogourl());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.setViewName("admin");
		return modelAndView;
	}
}
