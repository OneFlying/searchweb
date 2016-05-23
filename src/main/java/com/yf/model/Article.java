package com.yf.model;

import java.io.Serializable;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

/**
 * 文章
 * @author 812934389@qq.com
 * 2016-5-16
 * 
 */
@Table(name="article")
public class Article implements Serializable{

	
	private static final long serialVersionUID = 1L;
	private String id;//id
	private String imgids;//上传图片Id管理
	private String title;//标题
	private String keywords;//关键字 以逗号隔开最多5个
	private String content;//内容
	private String website;//网址
	private int count;//搜索次数
	
	@Column(name="count")
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	@Column(name="keywords")
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	
	@Column(name="id")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Column(name="title")
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Column(name="website")
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	
	@Column(name="imgids")
	public String getImgids() {
		return imgids;
	}
	public void setImgids(String imgids) {
		this.imgids = imgids;
	}
	
	
	



	
}
