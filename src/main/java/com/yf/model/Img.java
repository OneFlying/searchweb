package com.yf.model;

import java.io.Serializable;

/**
 * 上传图片
 * @author 812934389@qq.com
 * 2016-5-16
 */
public class Img implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	
	private String url;//上传路径
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	

}
