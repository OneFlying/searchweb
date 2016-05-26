package com.yf.model;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

@Table(name="message")
public class Message {

	private String id;
	
	private String content;
	
	private String date;

	private String articleId;
		
	@Column(name="articleId")
	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	@Column(name="id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name="content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name="date")
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
}
