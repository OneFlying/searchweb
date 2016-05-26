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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.*;
import javax.servlet.http.HttpServletResponse;

import com.yf.dao.ArticleDao;
import com.yf.dao.MessageDao;
import com.yf.model.Article;
import com.yf.model.Message;
import com.yf.utils.StringUtils;

@Controller
@RequestMapping("/message")
public class MessageController {

	@Resource(name="messageDao")
	private MessageDao messageDao;
	
	@Resource(name="articleDao")
	private ArticleDao articleDao;
	
	/**
	 * 添加留言信息
	 * @param message
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> saveMessage(HttpServletResponse response,Message message){
		
		ModelMap modelMap = new ModelMap();
		message.setId(StringUtils.generateUuid());
		message.setDate(StringUtils.getCurTimeFormat());
		
		int res = messageDao.save(message);
		
		if(res != 0){
			Article article = articleDao.getArticleById(message.getArticleId());
			articleDao.updateArticleCount(article.getId(), article.getCount()+3);
			
			modelMap.put("success", true);
		}else{
			modelMap.put("success", false);
		}
		
		HttpHeaders headers = new HttpHeaders();
		response.setContentType("text/html;charset=UTF-8"); 
		headers.setContentType(MediaType.TEXT_PLAIN);
		return new ResponseEntity<Map<String,Object>>(modelMap, headers, HttpStatus.OK);
	}
	
	/**
	 * 根据文章id获取留言信息
	 * @param articleId
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap getMessages(String articleId){
		ModelMap modelMap = new ModelMap();
		
		List<Message> list = messageDao.getMessages(articleId);
		
		if(list != null){
			modelMap.put("list", list);
			modelMap.put("success", true);
		}else{
			modelMap.put("success", false);
		}
		
		return modelMap;
	}
	
}
