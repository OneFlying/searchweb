package com.yf.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Article;
import com.yf.utils.RowMapperUtil;

/**
 * 文章
 * @author 812934389@qq.com
 * 2016-5-16
 */
@Repository("articleDao")
public class ArticleDao extends DaoAdapter{
	
	
	
	private static RowMapper<Article> articleRowMapper;
	
	static {
		
		articleRowMapper = new RowMapper<Article>() {

			public Article mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
//				Article article = new Article();
//				article.setId(rs.getString("id"));
//				article.setTitle(rs.getString("title"));
//				article.setContent(rs.getString("content"));
//				article.setWebsite(rs.getString("website"));
//				article.setImgids(rs.getString("imgids"));
//				article.setKeywords(rs.getString("keywords"));
//				return article;
				
				Article article = (Article)RowMapperUtil.getRowMapper(Article.class, rs, "");
			
				return article;
			}
		};
	}

	/**
	 * 添加文章信息
	 * guolejian
	 * @param article
	 * @return
	 */
	public int saveArticle(Article article){
		try {
			
			String sql = "insert into article(id,title,content,website,imgids,count,date) values(?,?,?,?,?,?,?)";
			
			return super.getJdbcTemplate().update(sql,article.getId(),article.getTitle(),article.getContent(),article.getWebsite(),article.getImgids(),article.getCount(),article.getDate());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	

	/**
	 * 删除文章信息
	 * @param id 
	 * @return
	 */
	public int deleteArticle(String id){
		
		try {
			String sql = "delete from article where id = ?";
			
			return super.getJdbcTemplate().update(sql,id);
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
		
	}
	
	/**
	 * 批量删除文章信息
	 * @param ids
	 * @return
	 */
	public int deleteAriticle(final String []ids){
		try {
			String sql = "delete from article where id = ?";
			return super.getJdbcTemplate().batchUpdate(sql,new BatchPreparedStatementSetter() {
				
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					// TODO Auto-generated method stub
					ps.setString(1, ids[i]);
				}
				
				public int getBatchSize() {
					// TODO Auto-generated method stub
					return ids.length;
				}
			}).length;
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	/**
	 * 通过keywords查询文章信息
	 * @param keywords 
	 * @return
	 */
	public List<Article> searchArticleByKeys(String keywords){
		
		try {
			if(keywords != null){
				keywords = "%"+keywords+"%";
			}
			String sql = "select * from article where keywords like ?";
			
			return super.getJdbcTemplate().query(sql, articleRowMapper,keywords);
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	 * 通过文章内容查询文章
	 * @param content 
	 * @return
	 */
	public List<Article> searchByContent(String content){
		
		try {
			
			if(content != null){
				content = "%"+content+"%";
			}
			
			String sql = "select * from article where content like ?";
			return super.getJdbcTemplate().query(sql, articleRowMapper,content);
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	 * 分页获取文章信息
	 * @param <E>
	 * @param searchEntity
	 * @return
	 */
	public List<Article> pageArticle(SearchEntity searchEntity){
		
		try {
			
			String sql = searchEntity.toSql();
			String totleSql = searchEntity.toPageTotalSql();
			int total = 0;
			if(searchEntity.getPageTotalSearchValues().size()<= 0){
				total = super.getJdbcTemplate().queryForInt(totleSql);
			}else{
				
				total = super.getJdbcTemplate().queryForInt(totleSql,searchEntity.getPageTotalSearchValues().toArray());
			}
			searchEntity.setTotal(total);
			return super.getJdbcTemplate().query(sql, searchEntity.getSearchValues().toArray(),articleRowMapper);
			
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
	}
	
	/**
	 * 根据id号获取文章信息
	 * @param id
	 * @return
	 */
	public Article getArticleById(String id){
		try {
			
			String sql = "select * from article where id = ?";
			return super.getJdbcTemplate().queryForObject(sql,articleRowMapper,id);
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	 * 修改文章的搜索次数
	 * @param id
	 * @param count
	 */
	public void updateArticleCount(String id,int count){
		
		String sql = "update article set count=? where id = ?";
		
		super.getJdbcTemplate().update(sql,count,id);
		
	}

}
