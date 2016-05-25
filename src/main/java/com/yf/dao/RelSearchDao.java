package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.RelSearch;
import com.yf.utils.RowMapperUtil;

@Repository("relSearchDao")
public class RelSearchDao extends DaoAdapter{

	private static RowMapper<RelSearch> relSearchRowMapper;
	
	static{
		relSearchRowMapper = new RowMapper<RelSearch>() {

			public RelSearch mapRow(ResultSet rs, int rowNum)
					throws SQLException {
				// TODO Auto-generated method stub
				return (RelSearch)RowMapperUtil.getRowMapper(RelSearch.class, rs, "");
			}
		};
	}
	
	/**
	 * 保存搜索关键字
	 * @param relSearch
	 * @return
	 */
	public int saveKeyWords(RelSearch relSearch){
		try {
			String sql = "insert into relsearch values(?,?,?)";
			return super.getJdbcTemplate().update(sql,relSearch.getId(),relSearch.getKeywords(),relSearch.getCount());
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	/**
	 * 根据搜索关键字查询信息
	 * @param keyword
	 * @return
	 */
	public RelSearch getRelSearchByKey(String keyword){
		
		try {
			
			String sql = "select * from relsearch where keywords=?";
			
			return super.getJdbcTemplate().queryForObject(sql, relSearchRowMapper,keyword);
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	 * 返回
	 * @param keyword
	 * @return
	 */
	public List<RelSearch> getRelSearchs(String keyword){
		
		try {
			String sql = "select * from relsearch where keywords like ? order by count desc";
			
			return super.getJdbcTemplate().query(sql, relSearchRowMapper,"%"+keyword+"%");
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
	}
	/**
	 * 修改关键字频率
	 * @param keyword
	 * @param count
	 * @return
	 */
	public int updateRel(String keyword,int count){
		
		try {
			
			String sql = "update relsearch set count=? where keywords=?";
			return super.getJdbcTemplate().update(sql,keyword,count);
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
}
