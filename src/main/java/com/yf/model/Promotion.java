package com.yf.model;

import java.io.Serializable;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

/**
 * @description 商业推广
 * @author gaoqijun
 *	@date 2016-05-23
 */
@Table(name="promotion")
public class Promotion implements Serializable{
	//id
	private String id;
	//上传图片Id管理
	private String imgids;
	//内容
	private String content;
	//价格
	private String price;
	//链接地址
	private String url;
	//点击量
	private int usecount;
	
	//标题
	private String title;
	
	private int mescount;
	
	
	
	public int getMescount() {
		return mescount;
	}
	public void setMescount(int mescount) {
		this.mescount = mescount;
	}
	@Column(name="title")
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Column(name="id")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name="imgIds")
	public String getImgids() {
		return imgids;
	}
	public void setImgids(String imgids) {
		this.imgids = imgids;
	}
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(name="price")
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	@Column(name="url")
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Column(name="usecount")
	public int getUsecount() {
		return usecount;
	}
	public void setUsecount(int usecount) {
		this.usecount = usecount;
	}
}
