package com.yf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.*;
import javax.servlet.http.HttpServletResponse;

import com.yf.dao.SearchEntity;
import com.yf.dao.UserDao;
import com.yf.model.User;

@Controller
@RequestMapping("/user")
public class UserControleller {

	@Resource(name="userDao")
	private UserDao userDao;
	
	
	@RequestMapping("/update")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateUser(User user,HttpServletResponse response){
		ModelMap modelMap = new ModelMap();
		
		int res = userDao.updateUser(user);
		if(res != 0){
			
			modelMap.put("success", true);
			modelMap.put("msg", "修改成功");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "修改失败");
		}


		HttpHeaders headers = new HttpHeaders();
		response.setContentType("text/html;charset=UTF-8"); 
		headers.setContentType(MediaType.TEXT_PLAIN);
		return new ResponseEntity<Map<String,Object>>(modelMap, headers, HttpStatus.OK);
		
	}
	
	@RequestMapping("/page")
	@ResponseBody
	public ModelMap page(int rows,int page){
		
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(User.class);
		searchEntity.addResultColumn("*");
		searchEntity.setPage(page, rows);
		
		List<User> users = userDao.pageUser(searchEntity);
		
		if(users != null){
			
			modelMap.put("rows", users);
			modelMap.put("total", searchEntity.getTotal());
			
		}
		
		return modelMap;
		
	}
}
