package com.yf.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import com.yf.dao.RelSearchDao;
import com.yf.model.RelSearch;

@Controller
@RequestMapping("/relsearch")
public class RelSearchController {

	@Resource(name="relSearchDao")
	private RelSearchDao relSearchDao;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@ResponseBody
	public ModelMap getRelSearchs(String keywords){
		
		ModelMap modelMap = new ModelMap();
		
		List<RelSearch> list = relSearchDao.getAllRel();
		
		List<RelSearch> resList = new ArrayList<RelSearch>();
		if(list != null){
			
			for(RelSearch relSearch : list){
				
				if(relSearch.getKeywords().length() > keywords.length()){
					if((relSearch.getKeywords()).contains(keywords)){
						resList.add(relSearch);
					}
				}else{
					if(keywords.contains(relSearch.getKeywords())){
						resList.add(relSearch);
					}
				}
				
				
			}
			
			if(resList.size() != 0){
				modelMap.put("success", true);
				modelMap.put("list", resList);
			}else {
				modelMap.put("success", false);
			}
			
		}else{
			modelMap.put("success", false);
		}
		
		return modelMap;
		
	}
	
}
