package com.yf.dao;

import org.springframework.stereotype.Repository;

import com.yf.model.Article;

/**
 * 文章
 * @author 812934389@qq.com
 * 2016-5-16
 */
@Repository
public class ArticleDao extends DaoAdapter{
	
	public boolean save(Article article){
		String sql = "insert into article (id, title,content,website)";
//		super.getJdbcTemplate().update(sql, args)
		return false;
	}
	
	

}
