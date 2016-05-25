package com.yf.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.yf.dao.AdvertDao;
import com.yf.dao.SearchEntity;
import com.yf.model.Advert;
import com.yf.utils.StringUtils;


@Controller
@RequestMapping("/advert")
public class AdvertController {

	@Resource(name="advertDao")
	private AdvertDao advertDao;
	
	
	@RequestMapping(value="/page",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap pageAdvert(int rows,int page,String title,String desc){
		
		ModelMap modelMap = new ModelMap();
		
		SearchEntity searchEntity = new SearchEntity(Advert.class);
		searchEntity.addResultColumn("*");
		
		if(StringUtils.isNotBlank(title)){
			searchEntity.addSearchColumn("title", "%"+title+"%", " like ", false);
		}
		if(StringUtils.isNotBlank(desc)){
			searchEntity.addSearchColumn("desc", "%"+desc+"%", " like ", false);
		}
		
		searchEntity.setPage(page, rows);
		searchEntity.setOrderBy(" order by price desc");
		List<Advert> list = advertDao.pageAdvert(searchEntity);
		
		if(list != null){
			
			modelMap.put("rows", list);
			modelMap.put("total", searchEntity.getTotal());
			
		}
		
		return modelMap;
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public ModelMap deleteAdvert(@RequestParam(value="ids[]")String []ids){
		
		ModelMap modelMap = new ModelMap();
		
		int res = advertDao.delete(ids);
		
		if(res == ids.length){
			modelMap.put("success", true);
			modelMap.put("msg", "成功删除"+res+"条数据");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "删除数据失败");
		}
		
		return modelMap;
	}
	
	
	@RequestMapping("/update")
	@ResponseBody
	public ModelMap updateAdvert(Advert advert){
		ModelMap modelMap = new ModelMap();
		
		int res = advertDao.update(advert);
		
		if(res != 0){
			modelMap.put("success", true);
			modelMap.put("msg", "修改成功");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "修改失败");
		}
		
		return modelMap;
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ModelMap addAdvert(Advert advert){
		ModelMap modelMap = new ModelMap();
		advert.setId(StringUtils.generateUuid());
		int res = advertDao.saveAdvert(advert);
		
		if(res != 0){
			modelMap.put("success", true);
			modelMap.put("msg", "添加成功");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "添加失败");
		}
		
		return modelMap;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public ModelMap getAdverts(String keywords){
		
		ModelMap modelMap = new ModelMap();
		
		List<Advert> list = advertDao.getAdvertsByTitle(keywords);
	
		if(list != null){
			modelMap.put("list", list);
		}
		
		return modelMap;
	}
	
	@RequestMapping("/upload")
	@ResponseBody
	public ModelMap uploadImg(HttpServletRequest request) throws Exception{
		
		//ModelAndView modelAndView = new ModelAndView();
		ModelMap modelMap = new ModelMap();
		//第一步转换request
		MultipartHttpServletRequest mtr = (MultipartHttpServletRequest)request;
		//接受文件
		//这里的pic是表单中的name="pic"
		CommonsMultipartFile cmf = (CommonsMultipartFile) mtr.getFile("pic");
		//获得字节数组
		byte[] bfile = cmf.getBytes();
		
		//设置文件名
		String fileName = "";
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		fileName = format.format(new Date());
		//获得3为随机数
		Random random = new Random();
		
		for(int i = 0 ; i < 3 ; i++)
		{
			fileName = fileName + random.nextInt(9);
		}
		
		//获取原始文件名
		String original = cmf.getOriginalFilename();
		//获取后缀
		String suffix = original.substring(original.lastIndexOf("."));
		
		//拿到项目的部署路径
		String path = request.getSession().getServletContext().getRealPath("/");
		
		String realPath = path+"/static/upload/"+fileName+suffix;
		
		//url访问的路径
		String urlPath = "/upload/"+fileName+suffix;
		
		OutputStream out = new FileOutputStream(new File(realPath));
		
		//开始写出
		out.write(bfile);
		out.flush();
		out.close();
		
//		modelAndView.addObject("logourl", urlPath);
//		modelAndView.setViewName("admin");
		modelMap.put("success", true);
		modelMap.put("logourl", urlPath);
		
		return modelMap;
		
	}
}
