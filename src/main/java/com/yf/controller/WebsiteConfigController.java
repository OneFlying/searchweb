package com.yf.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import com.yf.dao.SearchEntity;
import com.yf.dao.WebsiteconfigDao;
import com.yf.model.Websitconfig;
import com.yf.utils.StringUtils;

@Controller
@RequestMapping("/websiteconfig")
public class WebsiteConfigController {

	@Resource(name="websiteConfigDao")
	private WebsiteconfigDao websiteConfigDao;
	
	/**
	 * 分页获取网页信息
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value="/page",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap pageWebsitConfig(int page,int rows){
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(Websitconfig.class);
		searchEntity.addResultColumn("*");
		searchEntity.setPage(page, rows);
		
		List<Websitconfig> list = websiteConfigDao.pageWebsitconfig(searchEntity);
		
		if(list != null){
			modelMap.put("rows", list);
			modelMap.put("total", searchEntity.getTotal());
		}
		
		return modelMap;
	}
	
	/**
	 * 保存网页配置信息
	 * @param id
	 * @param title
	 * @param logourl
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public ModelMap saveWebsiteConfig(String title,String logourl){
		
		ModelMap modelMap = new ModelMap();
		
		Websitconfig websitconfig = new Websitconfig();
		websitconfig.setId(StringUtils.generateUuid());
		websitconfig.setTitle(title);
		websitconfig.setLogourl(logourl);
		
		int res = websiteConfigDao.saveWebSiteConfigInfo(websitconfig);
		
		if(res != 0){
			modelMap.put("success", true);
			modelMap.put("msg", "保存配置信息成功");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "保存配置失败");
		}
		
		return modelMap;
	}
}
