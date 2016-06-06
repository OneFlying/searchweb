package com.yf.controller;

import java.util.ArrayList;
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
import com.yf.dao.MessageDao;
import com.yf.dao.PromotionDao;
import com.yf.dao.RelSearchDao;
import com.yf.dao.SearchEntity;
import com.yf.dao.WebsiteconfigDao;
import com.yf.model.Article;
import com.yf.model.Promotion;
import com.yf.model.RelSearch;
import com.yf.model.Websitconfig;
import com.yf.utils.StringUtils;

@Controller
@RequestMapping("/article")
public class ArticleController {

	@Resource(name="articleDao")
	private ArticleDao articleDao;
	
	@Resource(name="promotionDao")
	private PromotionDao promotionDao;
	
	@Resource(name="relSearchDao")
	private RelSearchDao relSearchDao;
	
	@Resource
	private WebsiteconfigDao websiteconfigDao;
	
	@Resource(name="messageDao")
	private MessageDao messageDao;
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
	public ModelMap pageArticle(int rows,int page,String title,String keywords){
		
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(Article.class);
		searchEntity.addResultColumn("*");
		if(title != null){
			searchEntity.addSearchColumn("title", "%"+title+"%", " like ", false);
		}
		if(keywords != null){
			searchEntity.addSearchColumn("keywords", "%"+keywords+"%", " like ", false);
		}
		searchEntity.setPage(page, rows);
		
		List<Article> list = articleDao.pageArticle(searchEntity);
		
		if(list != null){
			modelMap.put("rows", list);
			modelMap.put("total", searchEntity.getTotal());
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
		
		RelSearch relSearch = relSearchDao.getRelSearchByKey(keywords);
		//如果是第一次则添加
		if(relSearch == null){
			RelSearch rels = new RelSearch();
			rels.setId(StringUtils.generateUuid());
			rels.setKeywords(keywords);
			rels.setCount(0);
			
			relSearchDao.saveKeyWords(rels);
		}else{
			
			relSearchDao.updateRel(keywords, relSearch.getCount()+1);
		}
		
		if(StringUtils.isNotBlank(keywords)){
			searchEntity.addSearchColumn("content", "%"+keywords+"%", " like ", false);
			searchEntity.setPage(page, rows);
			searchEntity.setOrderBy(" ORDER BY count DESC,date DESC");
			List<Article> list = articleDao.pageArticle(searchEntity);
			
			//添加文章的评价数
			for(Article article : list){
				
				int mescount = messageDao.getCount(article.getId());
				
				if(mescount != 0){
					article.setMescount(mescount);
				}
			}
			
			List<Promotion> plist = promotionDao.getPromotionsByContent(keywords);
			
			for(Promotion promotion : plist){
				int mescount = messageDao.getCount(promotion.getId());
			
				if(mescount != 0){
					promotion.setMescount(mescount);
				}
			
			}
			
			if(((plist != null)&&(plist.size()!=0))&&((list != null)&&(list.size()!=0))){
				List<Article> newList = this.warpList(plist, list);
				modelMap.put("list", newList);
				modelMap.put("rows", searchEntity.getTotal());
				modelMap.put("promotion", true);
				modelMap.put("size", plist.size());
				
				return modelMap;
			}else if((list != null)&&(list.size()!=0)){
				 
				modelMap.put("list", list);
				modelMap.put("rows", searchEntity.getTotal());
				modelMap.put("promotion", false);
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
	@ResponseBody
	public ModelMap saveArticle(String title,String content,String website,String imageurl){
		
		ModelMap modelMap = new ModelMap();
		Article article = new Article();
		
		article.setId(StringUtils.generateUuid());
		article.setContent(content);
		article.setWebsite(website);
		article.setImgids(imageurl);
		article.setTitle(title);
		article.setCount(0);
		article.setDate(StringUtils.getCurTimeFormat());
		
		int res = articleDao.saveArticle(article);
		if(res > 0) {
			modelMap.put("success",true);
		}
		//modelAndView.setViewName("article");
		return modelMap;
		
		
	}
	
	/**
	 * 跳转到编写文章也
	 */
	@RequestMapping("/index")
	public ModelAndView skipToArticle(){
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("logourl",websitconfig.getLogourl());
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.setViewName("article");
		return modelAndView;
	}
	
	/**
	 * 跳转到文章详情页
	 * @param keywords
	 * @return
	 */
	
	@RequestMapping("/list")
	public ModelAndView skipToListArticle(String keywords){
		
		ModelAndView modelAndView = new ModelAndView();
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("logourl",websitconfig.getLogourl());
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		modelAndView.addObject("keywords", keywords);
		modelAndView.setViewName("listArticle");
		return modelAndView;
	}
	
	/**
	 * 跳转到文章详情页
	 * @param id
	 * @return
	 */
	@RequestMapping("/info")
	public ModelAndView skipAricitleInfo(String id){
		
		ModelAndView modelAndView = new ModelAndView();
		Article article = articleDao.getArticleById(id);
		Promotion promotion = promotionDao.getPromotionById(id);
		if(promotion != null){
			
			Article article2 = new Article();
			article2.setId(promotion.getId());
			article2.setContent(promotion.getContent());
			article2.setTitle(promotion.getTitle());
			article2.setImgids(promotion.getImgids());
			article2.setWebsite(promotion.getUrl());
			
			modelAndView.addObject("article", article2);
			modelAndView.setViewName("articleinfo");
			
			return modelAndView;			
		}else if(article != null){
			modelAndView.addObject("article", article);
			modelAndView.setViewName("articleinfo");
			int count = article.getCount()+1;		
			articleDao.updateArticleCount(id, count);		
		}
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
		modelAndView.addObject("logourl",websitconfig.getLogourl());
		modelAndView.addObject("qitalogourl",websitconfig.getQitalogo());
		modelAndView.addObject("title",websitconfig.getTitle());
		return modelAndView;
	
	}
	
	/**
	 * 包装list
	 * @param plist
	 * @param list
	 * @return
	 */
	private List<Article> warpList(List<Promotion> plist,List<Article> list){
		
		List<Article> newList = new ArrayList<Article>();
		
		for(int i = 0;i<plist.size();i++){
			Promotion p = plist.get(i);
			Article article = new Article();
			article.setId(p.getId());
			article.setContent(p.getContent());
			article.setImgids(p.getImgids());
			article.setTitle(p.getTitle());
			article.setWebsite(p.getUrl());
			
			newList.add(article);
		}
		newList.addAll(list);
		
		return newList;
	}
}