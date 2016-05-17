package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import com.yf.model.Jubao;
/**
 * @description 举报
 * @author gaoqijun
 * @date 2016-5-17
 */
@Repository
public class JubaoDao extends DaoAdapter{

	private static RowMapper<Jubao> jubaoRowMapper = null;
	static
	{
		jubaoRowMapper = new RowMapper<Jubao>() {

			public Jubao mapRow(ResultSet rs, int rowNum) throws SQLException {
				Jubao jubao = new Jubao();
				jubao.setId(rs.getString("id"));
				jubao.setArticleid(rs.getString("articleid"));
				jubao.setContent(rs.getString("content"));
				jubao.setDatetime(rs.getString("datetime"));
				return jubao;
			}
		};
	}
	/**
	 * 添加举报
	 * @param jubao
	 * @return
	 */
	public boolean add(Jubao jubao){
		String sql = "insert into jubao(id,articleid,content,datetime) values(?,?,?,?)";
		int num = super.getJdbcTemplate().update(sql, jubao.getId(),jubao.getArticleid(),jubao.getContent(),jubao.getDatetime());
		if(num >0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 更新举报
	 * @param jubao
	 * @return
	 */
	public boolean update(Jubao jubao){
		String sql = "update jubao set id = ?,articleid = ?,content = ?,datetime = ? where id = ?";
		int num = super.getJdbcTemplate().update(sql,  jubao.getId(),jubao.getArticleid(),jubao.getContent(),jubao.getDatetime(),jubao.getId());
		if(num >0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 批量删除举报信息
	 * @param ids
	 * @return
	 */
	public int delete(final String[] ids){
		String sql = "delete from jkzx_fayuan where jkzx_id = ? ";
		return super.getJdbcTemplate().batchUpdate(sql,  new BatchPreparedStatementSetter() {

			public void setValues(java.sql.PreparedStatement ps, int i)
					throws SQLException {
				ps.setString(1, ids[i]);
			}
			public int getBatchSize() {
				return ids.length;
			}
		}).length;
	}
	/**
	 * 获取分页
	 * @param searchEntity
	 * @return
	 */
	public List<Jubao> getPageJubao(SearchEntity searchEntity){
		//获取total的sql获取
		String toPagetotal = searchEntity.toPageTotalSql();
		String sql = searchEntity.toSql();
		int total = 0 ;
		if(searchEntity.getPageTotalSearchValues().size()<=0){
			total = super.getJdbcTemplate().queryForInt(toPagetotal);
		}else{
			total = super.getJdbcTemplate().queryForInt(toPagetotal,searchEntity.getPageTotalSearchValues().toArray());
		}
		searchEntity.setTotal(total);
		return super.getJdbcTemplate().query(sql, searchEntity.getSearchValues().toArray(),jubaoRowMapper);
	}
}
