package com.yf.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Article;
import com.yf.model.Promotion;
@Repository("promotionDao")
public class PromotionDao extends DaoAdapter{

	private static RowMapper<Promotion> promotionMapper;
	static
	{
		promotionMapper = new RowMapper<Promotion>() {

			public Promotion mapRow(ResultSet rs, int rowNum)
					throws SQLException {
				Promotion promotion = new Promotion();
				promotion.setId(rs.getString("id"));
				promotion.setImgids(rs.getString("imgids"));
				promotion.setContent(rs.getString("content"));
				promotion.setPrice(rs.getString("price"));
				promotion.setUrl(rs.getString("url"));
				promotion.setUsecount(rs.getInt("usecount"));
				return promotion;
			}
		};
	}
	/**
	 * 添加推广
	 * @param promotion
	 * @return
	 */
	public boolean add(Promotion promotion){
		String sql = "insert into promotion (id,content,usecount,imgids,price,url) values(?,?,?,?,?,?)";
		int num = super.getJdbcTemplate().update(sql, promotion.getId(),promotion.getContent(),promotion.getUsecount(),promotion.getImgids(),promotion.getPrice(),promotion.getUrl());
		if(num>0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 更新推广
	 * @param promotion
	 * @return
	 */
	public boolean update(Promotion promotion){
		String sql = "update promotion set id =?,content=?,usecount=?,imgids=?,price=?,url=? where id=?";
		int num = super.getJdbcTemplate().update(sql,promotion.getId(),promotion.getContent(),promotion.getUsecount(),promotion.getImgids(),promotion.getPrice(),promotion.getUrl(),promotion.getId());
		if(num>0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 批量删除文章信息
	 * @param ids
	 * @return
	 */
	public int delete(final String []ids){
		try {
			String sql = "delete from promotion where id = ?";
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
	 * 分页获取文章信息
	 * @param <E>
	 * @param searchEntity
	 * @return
	 */
	public List<Promotion> page(SearchEntity searchEntity){
		
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
			return super.getJdbcTemplate().query(sql, searchEntity.getSearchValues().toArray(),promotionMapper);
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * 根据id获取
	 * @param id
	 * @return
	 */
	public Promotion getPromotionById(String id){
		String sql = "select * from promotion where id = ?";
		try {
			return super.getJdbcTemplate().queryForObject(sql, promotionMapper,id);
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * 更新点击量
	 * @param id
	 * @return
	 */
	public boolean updateUseCountById(String id){
		Promotion promotion = getPromotionById(id);
		int count = promotion.getUsecount()+1;
		String sql = "update promotion set usecount =?";
		int num = super.getJdbcTemplate().update(sql,count);
		if(num>0){
			return true;
		}else{
			return false;
		}
	}
}
