package com.yf.controller;

import java.io.File;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.java.swing.plaf.motif.resources.motif;
import com.yf.dao.ArticleDao;
import com.yf.dao.JubaoDao;
import com.yf.dao.SearchEntity;
import com.yf.model.Article;
import com.yf.model.Jubao;
import com.yf.utils.StringUtils;
import com.yf.utils.FileUtils;



@Controller
@RequestMapping("/jubao")
public class JubaoController {
	@Resource
	private JubaoDao jubaoDao;
	@Resource
	private ArticleDao articleDao;
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> add(HttpServletRequest request,HttpServletResponse response,Jubao jubao){
		ModelMap modelMap = new ModelMap();
		jubao.setId(StringUtils.generateUuid());
		jubao.setDatetime(StringUtils.getCurTimeFormat());
		boolean ret = jubaoDao.add(jubao);
		if(ret){
			modelMap.put("success", ret);
			modelMap.put("msg", "举报成功");

		}else{
			modelMap.put("success", ret);
			modelMap.put("msg", "举报失败，请联系管理员");
		}
		HttpHeaders headers = new HttpHeaders();
		response.setContentType("text/html;charset=UTF-8"); 
		headers.setContentType(MediaType.TEXT_PLAIN);
		return new ResponseEntity<Map<String,Object>>(modelMap, headers, HttpStatus.OK);
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
	public ModelMap getPage(HttpServletRequest request,int page,int rows,String operatime,String content){
		ModelMap modelMap = new ModelMap();
		SearchEntity searchEntity = new SearchEntity(Jubao.class);
		searchEntity.addResultColumn("*");
		if(content != null){
			searchEntity.addSearchColumn("content", "%"+content+"%" , " LIKE ", false);
		}
		if(operatime !=null){
			searchEntity.addSearchColumn("datetime", "%"+operatime+"%" , " LIKE ", false);
		}
		searchEntity.setPage(page, rows);
		List<Jubao> list = jubaoDao.getPageJubao(searchEntity);
		List<Jubao> listJson = new ArrayList<Jubao>();
		//将文章ID转化为标题
		for(Jubao jubao :list){
			String articleId = jubao.getArticleid();
			Article article = articleDao.getArticleById(articleId);
			jubao.setArticleid(article.getTitle());
			listJson.add(jubao);
		}
		int total = searchEntity.getTotal();
		modelMap.put("rows",listJson);
		modelMap.put("total", total);
		return modelMap;
	}
	/**
	 * 文件上传
	 * @param request
	 * @param response
	 * @param filepath  C:\Users\gaoqijun\Desktop\error.txt
	 * @return
	 * @throws URISyntaxException 
	 */
	@RequestMapping(value="/upload",method=RequestMethod.POST)
	@ResponseBody
	public ModelMap upload(HttpServletRequest request,HttpServletResponse response,String filepath) {
		//String filename = FileUtils.getFileNameByFilePath(filePath);
		ModelMap modelMap = new ModelMap();
		String path = request.getSession().getServletContext().getRealPath("/");
		/*DiskFileItemFactory factory = new DiskFileItemFactory();
		//最大缓存
		//factory.setSizeThreshold(5*1024); 
		//factory.setRepository(new File("c:/"));  
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8"); 
		try {  
			//获取所有文件列表  
			List<FileItem> items = upload.parseRequest(request);  
			for (FileItem item : items) {  
				if(!item.isFormField()){  
					//文件名  
					String fileName = item.getName();  
					String filePath = path + "\\static\\upload"+fileName;
					//检查文件后缀格式  
					String fileEnd = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();  
					//创建文件唯一名称  
					String uuid = UUID.randomUUID().toString();  
					//真实上传路径  
					StringBuffer sbRealPath = new StringBuffer(); 
					sbRealPath.append(filePath).append(uuid).append(".").append(fileEnd);  
					//写入文件  
					File file = new File(sbRealPath.toString());  
					item.write(file);  
				} 
			}*/
		/*	modelMap.put("success", true);
			modelMap.put("msg", "上传成功");

		}catch (Exception e) {  
			modelMap.put("success", false);
			modelMap.put("msg", "上传失败");
			e.printStackTrace(); 
		}
*/
		return modelMap;

	}
}
