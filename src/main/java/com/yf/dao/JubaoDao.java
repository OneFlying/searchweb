package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.yf.model.Jubao;
/**
 * @description 举报
 * @author gaoqijun
 * @date 2016-5-17
 */
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
	public boolean update(Jubao jubao){
		String sql = "update jubao set id = ?,articleid = ?,content = ?,datetime = ? where id = ?";
		int num = super.getJdbcTemplate().update(sql,  jubao.getId(),jubao.getArticleid(),jubao.getContent(),jubao.getDatetime(),jubao.getId());
		if(num >0){
			return true;
		}else{
			return false;
		}
	}
}
