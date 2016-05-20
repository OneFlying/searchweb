package com.yf.model;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

/**
 * 网站配置
 * @author 812934389@qq.com
 * 2016-5-16
 */
@Table(name="websitconfig")
public class Websitconfig {
	
	private String id;//
	private String title;//网站名称
	private String logourl;//logo路径
	
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
	@Column(name="logourl")
	public String getLogourl() {
		return logourl;
	}
	public void setLogourl(String logourl) {
		this.logourl = logourl;
	}
}
