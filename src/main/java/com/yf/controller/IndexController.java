package com.yf.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yf.dao.ArticleDao;
import com.yf.dao.SearchEntity;
import com.yf.dao.WebsiteconfigDao;
import com.yf.model.Article;
import com.yf.model.Websitconfig;

@Controller
@RequestMapping("/")
public class IndexController {

	@Resource
	private WebsiteconfigDao websiteconfigDao;
	
	@Resource
	private ArticleDao articleDao;
	
	
	@RequestMapping("/")
	@ResponseBody
	public ModelAndView skipToIndex(HttpServletResponse response){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("logourl",websitconfig.getLogourl());
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.setViewName("index");
		
		return modelAndView;
	}
	
	@RequestMapping(value="/indexinfo",method=RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getIndexInfo(int rows,int page,HttpServletResponse response){
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(Article.class);
		searchEntity.addResultColumn("*");
		searchEntity.setOrderBy(" ORDER BY date DESC");
		searchEntity.setPage(page, rows);
		
		List<Article> list = articleDao.pageArticle(searchEntity);
		
		if(list != null){
			modelMap.put("rows", list);
			modelMap.put("total", searchEntity.getTotal());
		}
		
		HttpHeaders headers = new HttpHeaders();
		response.setContentType("text/html;charset=UTF-8"); 
		headers.setContentType(MediaType.TEXT_PLAIN);
		return new ResponseEntity<Map<String,Object>>(modelMap, headers, HttpStatus.OK);
		
	}
	
	@RequestMapping("/aboutus")
	public ModelAndView aboutUs(){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.setViewName("aboutus");
		return modelAndView;
	}
	
	@RequestMapping("/law")
	public ModelAndView noticeLaw(String param){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.addObject("param", param);
		modelAndView.setViewName("law");
		return modelAndView;
	}
	
	@RequestMapping("/agreement")
	public ModelAndView Agreement(){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.setViewName("agreement");
		return modelAndView;
	}
}
