package com.yf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String noticeLaw(){
		return "law";
	}
	
	@RequestMapping("/agreement")
	public String Agreement(){
		return "agreement";
	}
}
