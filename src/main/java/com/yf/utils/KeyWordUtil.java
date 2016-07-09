package com.yf.utils;

import com.yf.dao.WebsiteconfigDao;
import com.yf.model.Websitconfig;
import javax.annotation.Resource;

public class KeyWordUtil {

	
	private static KeyWordUtil keyWordUtil = new KeyWordUtil();
	
	public static KeyWordUtil getInstance(){
		return keyWordUtil;
	}
	
	public Websitconfig getContent(){
		WebsiteconfigDao websiteconfigDao = (WebsiteconfigDao)SpringBeanUtils.getObject("websiteConfigDao");
		Websitconfig websitconfig = websiteconfigDao.getWebsitconfig();
	
		return websitconfig;
	}
	
	
}
