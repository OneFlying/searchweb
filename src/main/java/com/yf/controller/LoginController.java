package com.yf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import com.yf.dao.UserDao;
import com.yf.model.User;

@Controller
@RequestMapping("/")
public class LoginController {

	@Resource(name="userDao")
	private UserDao userDao;
	
	/**
	 * 检测用户登录
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/admin/login",method=RequestMethod.POST)
	@ResponseBody
	public ModelMap checkLogin(String username,String password){
		ModelMap modelMap = new ModelMap();
		
		User user = userDao.checkLogin(username, password);
		
		if(user != null){
			modelMap.put("success", true);
			modelMap.put("url", "/admin/index");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "用户名或密码错误");
		}
		
		return modelMap;
	}
	
	/**
	 * 跳转到管理员页面
	 * @return
	 */
	@RequestMapping(value="/admin/index")
	public String skipToAdmin(){
		return "admin";
	}
}
