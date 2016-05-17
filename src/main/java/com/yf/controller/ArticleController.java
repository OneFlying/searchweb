package com.yf.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import com.yf.dao.ArticleDao;
import com.yf.dao.SearchEntity;
import com.yf.model.Article;

@Controller
@RequestMapping("/article")
public class ArticleController {

	@Resource(name="articleDao")
	private ArticleDao articleDao;
	
	/** 
	 * 分页获取文章信息
	 * @param rows 获取行数
	 * @param page 当前页
	 * @param title 根据标题查询文章
	 * @param content 根据内容查询文章
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
	 * 前台页面搜索
	 * @param page
	 * @param rows
	 * @param keywords 搜索关键字
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
	 * 批量删除文章
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
}
