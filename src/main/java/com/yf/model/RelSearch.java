package com.yf.model;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

/**
 * 相关搜索表
 * @author abc
 *
 */
@Table(name="relsearch")
public class RelSearch {

	//id
	private String id;
	//搜索关键字
	private String keywords;
	//搜索频率
	private int count;

	@Column(name="id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name="keywords")
	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	@Column(name="count")
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
	
}
