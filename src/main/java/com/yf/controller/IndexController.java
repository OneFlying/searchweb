package com.yf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class IndexController {

	@RequestMapping("/")
	public String skipToIndex(){
		return "index";
	}
	
	@RequestMapping("/aboutus")
	public String aboutUs(){
		return "aboutus";
	}
	
	@RequestMapping("/law")
	public ModelAndView noticeLaw(String param){
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("param", param);
		modelAndView.setViewName("law");
		return modelAndView;
	}
	
	@RequestMapping("/agreement")
	public String Agreement(){
		return "agreement";
	}
}
