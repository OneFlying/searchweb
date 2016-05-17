package com.yf.model;

import java.io.Serializable;

/**
 * 文章
 * @author 812934389@qq.com
 * 2016-5-16
 * 
 */
public class Article implements Serializable{

	private static final long serialVersionUID = 1L;
	private String id;//id
	private String imgids;//上传图片Id管理
	private String title;//标题
	private String content;//内容
	private String website;//网址
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getImgids() {
		return imgids;
	}
	public void setImgids(String imgids) {
		this.imgids = imgids;
	}
	
	
	



	
}
