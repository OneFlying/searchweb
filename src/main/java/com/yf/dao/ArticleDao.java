package com.yf.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Article;

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
				Article article = new Article();
				article.setId(rs.getString("id"));
				article.setTitle(rs.getString("title"));
				article.setContent(rs.getString("content"));
				article.setWebsite(rs.getString("website"));
				article.setImgids(rs.getString("imgids"));
				article.setKeywords(rs.getString("keywords"));
				return article;
			}
		};
	}
	

/*	public Article getArticleById(String id){
		String sql = "select * form article where id = ?";
		
	}*/

	/**
	 * ��������
	 * guolejian
	 * @param article
	 * @return
	 */
	public int saveArticle(Article article){
		try {
			
			String sql = "insert into article values(?,?,?,?,?,?)";
			
			return super.getJdbcTemplate().update(sql,article.getId(),article.getTitle(),article.getContent(),article.getWebsite(),article.getImgids(),article.getKeywords());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	

	/**
	 * ɾ������
	 * @param id �������idɾ��
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
	 * ����ɾ��
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
	 * ��ݹؼ�����Ѱ����
	 * @param keywords �ؼ��� �ؼ����Զ��Ÿ��� a,b,c
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
	 * �������ȥ����
	 * @param content Ҫ����������
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
	 * ��ҳ��ȡ������Ϣ
	 * @param searchEntity
	 * @return
	 */
	public List<Article> pageArticle(SearchEntity searchEntity){
		
		try {
			
			String sql = searchEntity.toSql();
			String totleSql = searchEntity.toPageTotalSql();
			int total = 0;
			if(searchEntity.getPageTotalSearchValues().size()<0){
				total = super.getJdbcTemplate().queryForInt(totleSql);
			}else{
				total = super.getJdbcTemplate().queryForInt(sql,searchEntity.getPageTotalSearchValues().toArray());
			}
			
			searchEntity.setTotal(total);
			
			return super.getJdbcTemplate().query(sql, searchEntity.getPageTotalSearchValues().toArray(),articleRowMapper);
			
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
	}

}
