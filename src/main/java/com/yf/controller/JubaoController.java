package com.yf.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.yf.dao.JubaoDao;
import com.yf.dao.SearchEntity;
import com.yf.model.Jubao;


@Controller
@RequestMapping("/jubao")
public class JubaoController {
	@Resource
	private JubaoDao jubaoDao;
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> add(HttpServletRequest request,HttpServletResponse response,Jubao jubao){
		ModelMap modelMap = new ModelMap();
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
	/*public ModelMap getPage(HttpServletRequest request,int page,int rows){
		ModelMap modelMap = new ModelMap();
		SearchEntity searchEntity = new SearchEntity(Jubao.class);
		searchEntity.addResultColumn("*");
		//searchEntity.addSearchColumn(searchColumn, value, condition, isor)
		searchEntity.setPage(page, rows);
		List<Jubao> list = jubaoDao.getPageJubao(searchEntity);
		List<Jubao> listJson = new ArrayList<Jubao>();
		for(Jubao jubao :list){
			
		}
		
		
	}*/
}
