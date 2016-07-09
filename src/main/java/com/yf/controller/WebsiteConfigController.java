package com.yf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * 修改网页配置信息
	 * @param id
	 * @param title
	 * @param logourl
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateWebsiteConfig(HttpServletResponse response,Websitconfig websitconfig){
		
		ModelMap modelMap = new ModelMap();
		
		Websitconfig websitconfig1 = websiteConfigDao.getWebsitconfig();
		//websitconfig.setId(StringUtils.generateUuid());
		websitconfig1.setTitle(websitconfig.getTitle());
		websitconfig1.setKeywords(websitconfig.getKeywords());
		websitconfig1.setBeianhao(websitconfig.getBeianhao());
		websitconfig1.setContent(websitconfig.getContent());
		int res = websiteConfigDao.updateWebsiteConfig(websitconfig1);
		if(res != 0){
			modelMap.put("success", true);
			modelMap.put("msg", "修改信息成功");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "修改配置失败");
		}
		HttpHeaders headers = new HttpHeaders();
		response.setContentType("text/html;charset=UTF-8"); 
		headers.setContentType(MediaType.TEXT_PLAIN);
		return new ResponseEntity<Map<String,Object>>(modelMap, headers, HttpStatus.OK);
	}
	
	@RequestMapping(value="/getinfo",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap getWebsiteInfo(HttpServletRequest request){
		
		ModelMap modelMap = new ModelMap();
		
		Websitconfig wc = websiteConfigDao.getWebsitconfig();
		
		modelMap.put("wc", wc);
		
		return modelMap;
		
	}
	
}
