package com.yf.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import com.yf.dao.ArticleDao;
import com.yf.dao.SearchEntity;
import com.yf.model.Article;
import com.yf.utils.StringUtils;

@Controller
@RequestMapping("/article")
public class ArticleController {

	@Resource(name="articleDao")
	private ArticleDao articleDao;
	
	/** 
	 * 分页获取文章信息
	 * @param rows 
	 * @param page 
	 * @param title 
	 * @param content 
	 * @return
	 */
	@RequestMapping(value="/page",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap pageArticle(int rows,int page,String title,String content){
		
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(Article.class);
		searchEntity.addResultColumn("*");
		if(title != null){
			searchEntity.addSearchColumn("title", "%"+title+"%", " like ", false);
		}
		if(content != null){
			searchEntity.addSearchColumn("content", "%"+content+"%", " like ", false);
		}
		searchEntity.setPage(page, rows);
		
		List<Article> list = articleDao.pageArticle(searchEntity);
		
		if(list != null){
			modelMap.put("list", list);
			modelMap.put("rows", searchEntity.getTotal());
		}
		
		return modelMap;
		
	}
	
	/**
	 * 搜索文章
	 * @param page
	 * @param rows
	 * @param keywords 
	 * @return
	 */
	@RequestMapping(value="/search",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap searchAriticle(int page,int rows,String keywords){
		
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(Article.class);
		searchEntity.addResultColumn("*");
		searchEntity.setPage(page, rows);
		
		if(keywords != null){
			searchEntity.addSearchColumn("keywords", "%"+keywords+"%", " like ", false);
			
			List<Article> list = articleDao.pageArticle(searchEntity);
			
			if(list != null){
				modelMap.put("rows", list);
				modelMap.put("total", searchEntity.getTotal());
			}else{
				searchEntity.getSearchColumns().clear();
				searchEntity.addSearchColumn("content", "%"+keywords+"%", " like ", false);
				List<Article> res =  articleDao.pageArticle(searchEntity);
				
				if(res != null){
					modelMap.put("rows", res);
					modelMap.put("total", searchEntity.getTotal());
				}
			}
		}
		
		return modelMap;
		
	}
	
	/**
	 * 根据id删除文章信息
	 * @param ids
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public ModelMap deleteArticle(@RequestParam(value="ids[]")String []ids){
		
		ModelMap modelMap = new ModelMap();
		
		int res = articleDao.deleteAriticle(ids);
		
		if(res == ids.length){
			modelMap.put("success",true);
			modelMap.put("msg", "共删除"+res+"条数据");
		}else if(res == 0){
			modelMap.put("success", false);
			modelMap.put("msg", "删除失败");
		}
		
		return modelMap;
	}
	
	/**
	 * 保存上传的文章信息
	 * @param title
	 * @param content
	 * @param website
	 * @param keywords
	 * @param imageurl
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public String saveArticle(String title,String content,String website,String keywords,String imageurl){
		
		ModelMap modelMap = new ModelMap();
		Article article = new Article();
		
		article.setId(StringUtils.generateUuid());
		article.setContent(content);
		article.setWebsite(website);
		article.setImgids(imageurl);
		article.setKeywords(keywords);
		article.setTitle(title);
		
		int res = articleDao.saveArticle(article);
		
		if(res != 0){
			return "index";
		}else{
			return "index";
		}
		
		
	}
	
	@RequestMapping("/index")
	public String skipToArticle(){
		return "article";
	}
	
	@RequestMapping("/list")
	public ModelAndView skipToListArticle(String keywords){
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("keywords", keywords);
		modelAndView.setViewName("listArticle");
		return modelAndView;
	}
}
