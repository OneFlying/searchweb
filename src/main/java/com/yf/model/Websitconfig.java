package com.yf.model;

import javax.swing.text.AbstractDocument.Content;

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
	private String keywords;//关键字
	private String beianhao;//备案号
	private String qitalogo;
	
	private String content;//网站cotent
	
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(name="qitalogo")
	public String getQitalogo() {
		return qitalogo;
	}
	public void setQitalogo(String qitalogo) {
		this.qitalogo = qitalogo;
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
	@Column(name="logourl")
	public String getLogourl() {
		return logourl;
	}
	public void setLogourl(String logourl) {
		this.logourl = logourl;
	}
	@Column(name="keywords")
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	@Column(name="beianhao")
	public String getBeianhao() {
		return beianhao;
	}
	public void setBeianhao(String beianhao) {
		this.beianhao = beianhao;
	}
}
