package com.yf.model;

import java.io.Serializable;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

/**
 * 举报
 * @author 812934389@qq.com
 * 2016-5-16
 */
@Table(name="jubao")
public class Jubao implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String articleid;//文章id
	private String content;//举报内容
	private String datetime;//举报时间
	@Column(name="id")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name="articleid")
	public String getArticleid() {
		return articleid;
	}
	public void setArticleid(String articleid) {
		this.articleid = articleid;
	}
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(name="datetime")
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
	
	
}
