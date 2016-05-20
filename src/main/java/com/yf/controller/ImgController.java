package com.yf.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.yf.dao.ImgDao;
import com.yf.model.Img;
import com.yf.utils.StringUtils;

@Controller
@RequestMapping("/img")
public class ImgController {

	@Resource(name="imgDao")
	private ImgDao imgDao;
	/**
	 * 上传文件
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/upload")
	public ModelMap uploadImg(HttpServletRequest request) throws Exception
	{
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
		
		String realPath = path+"/upload/"+fileName+suffix;
		
		//url访问的路径
		String urlPath = "${RESOUCE_SYSTEM_URL}/upload/"+fileName+suffix;
		
		OutputStream out = new FileOutputStream(new File(realPath));
		
		//开始写出
		out.write(bfile);
		out.flush();
		out.close();
		
		/**
		 * 将上传的图片信息进行保存
		 */
		Img img = new Img();
		img.setId(StringUtils.generateUuid());
		img.setUrl(urlPath);
		
		int ret = imgDao.saveImg(img);
		
		if(ret != 0){
			modelMap.put("success", true);
			modelMap.put("msg", "上传成功");
		}else{
			modelMap.put("success", false);
			modelMap.put("msg", "上传失败");
		}
		return modelMap;
	}
	
	@RequestMapping("/index")
	public String testUpload(){
		return "test";
	}
}
