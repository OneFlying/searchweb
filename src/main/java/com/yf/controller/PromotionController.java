package com.yf.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yf.dao.PromotionDao;
import com.yf.dao.SearchEntity;
import com.yf.dao.WebsiteconfigDao;
import com.yf.model.Article;
import com.yf.model.Jubao;
import com.yf.model.Promotion;
import com.yf.model.Websitconfig;
import com.yf.utils.StringUtils;

@Controller
@RequestMapping("/promotion")
public class PromotionController {

	@Resource
	private PromotionDao promotionDao;
	@Resource
	private WebsiteconfigDao websiteconfigDao;
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public ModelAndView add(HttpServletResponse response,String price,String content,String imageurl,String url){
		ModelAndView modelAndView = new ModelAndView();
		Promotion promotin = new Promotion();
		promotin.setContent(content);
		promotin.setImgids(imageurl);
		promotin.setUrl(url);
		promotin.setPrice(price);
		//初始默认浏览量为0
		promotin.setUsecount(0);
		promotin.setId(StringUtils.generateUuid());
		boolean ret = promotionDao.add(promotin);
		//if(ret){
			Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
			/*modelAndView.addObject("msg", "新增成功");
			modelAndView.addObject("success", ret);*/
			modelAndView.addObject("logourl",websitconfig.getLogourl());
			modelAndView.addObject("title",websitconfig.getTitle());
			modelAndView.setViewName("redirect:/admin");
//			modelAndView.addObject("url", "/admin");
		/*}else{
			modelAndView.addObject("success", ret);
			modelAndView.addObject("msg", "新增失败");
		}*/
		return modelAndView;
	}
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> update(HttpServletResponse response,Promotion promotin){
		ModelMap modelMap = new ModelMap();
		boolean ret = promotionDao.update(promotin);
		if(ret){
			modelMap.put("success", ret);
			modelMap.put("msg", "修改成功");

		}else{
			modelMap.put("success", ret);
			modelMap.put("msg", "修改失败，请联系管理员");
		}
		HttpHeaders headers = new HttpHeaders();
		response.setContentType("text/html;charset=UTF-8"); 
		headers.setContentType(MediaType.TEXT_PLAIN);
		return new ResponseEntity<Map<String,Object>>(modelMap, headers, HttpStatus.OK);
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
		
		int res = promotionDao.delete(ids);
		
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
	 * 获取分页
	 * @param request
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping(value="/page",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap getPage(HttpServletRequest request,int page,int rows,String price){
		ModelMap modelMap = new ModelMap();
		SearchEntity searchEntity = new SearchEntity(Promotion.class);
		searchEntity.addResultColumn("*");
		if(!price.equals("")){
			searchEntity.addSearchColumn("price", price, " LIKE ", false);
		}
		searchEntity.setPage(page, rows);
		List<Promotion> list = promotionDao.page(searchEntity);		
		int total = searchEntity.getTotal();
		modelMap.put("rows",list);
		modelMap.put("total", total);
		return modelMap;
	}
	@RequestMapping("/index")
	public String toPromotion(){
		return "promotion";
	}
}
