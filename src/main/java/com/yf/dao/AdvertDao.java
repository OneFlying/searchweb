package com.yf.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Advert;
import com.yf.utils.RowMapperUtil;

@Repository("advertDao")
public class AdvertDao extends DaoAdapter{

	private static RowMapper<Advert> advertRowMapper;
	
	static {
		
		advertRowMapper = new RowMapper<Advert>() {
			
			public Advert mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				return (Advert)RowMapperUtil.getRowMapper(Advert.class, rs, "");		
			}
		};		
	}
	
	/**
	 * 保存广告信息
	 * @param advert
	 */
	public int saveAdvert(Advert advert){
		
		try {
			
			String sql = "insert into advert values(?,?,?,?,?,?)";
			
			return super.getJdbcTemplate().update(sql,advert.getId(),advert.getTitle(),advert.getDesc(),advert.getPrice(),advert.getLogourl(),advert.getAdurl());
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
		
		
	}
	
	public int update(Advert advert){
		
		try {
			
			String sql = "update advert set title=?,desc=?,price=?,logourl=?,adurl=? where id=?";
			return super.getJdbcTemplate().update(sql,advert.getTitle(),advert.getDesc(),advert.getPrice(),advert.getLogourl(),advert.getAdurl(),advert.getId());
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
		
		
	}
	
	public int delete(final String []ids){
		String sql = "delete from advert where id=?";
		
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
	}
	
	public List<Advert> pageAdvert(SearchEntity searchEntity){
		
		
		try {
			
			String sql = searchEntity.toSql();
			String totalSql = searchEntity.toPageTotalSql();
			
			int total = 0;
			
			if(searchEntity.getPageTotalSearchValues().size() <=0){
				total = super.getJdbcTemplate().queryForInt(totalSql);
			}else{
				total = super.getJdbcTemplate().queryForInt(totalSql,searchEntity.getPageTotalSearchValues().toArray());
			}
			searchEntity.setTotal(total);
			
			return super.getJdbcTemplate().query(sql, searchEntity.getSearchValues().toArray(),advertRowMapper);
			
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
	}
	
	public List<Advert> getAdvertsByTitle(String title){
		
		try {
			
			String sql = "select * from advert where title like ? order by price desc";
			
			return super.getJdbcTemplate().query(sql,advertRowMapper,"%"+title+"%");
			
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
		
	}
	
	
}
