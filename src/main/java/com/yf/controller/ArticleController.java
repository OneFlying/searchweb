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
	 * ��ҳ��ȡ������Ϣ
	 * @param rows ��ȡ����
	 * @param page ��ǰҳ
	 * @param title ���ݱ����ѯ����
	 * @param content �������ݲ�ѯ����
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
	 * ǰ̨ҳ������
	 * @param page
	 * @param rows
	 * @param keywords �����ؼ���
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
	 * ����ɾ������
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
			modelMap.put("msg", "��ɾ��"+res+"������");
		}else if(res == 0){
			modelMap.put("success", false);
			modelMap.put("msg", "ɾ��ʧ��");
		}
		
		return modelMap;
	}
}
