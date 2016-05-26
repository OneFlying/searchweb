package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Article;
import com.yf.model.Message;
import com.yf.utils.RowMapperUtil;

@Repository("messageDao")
public class MessageDao extends DaoAdapter{

	private static RowMapper<Message> messageRowMapper;
	
	static{
		messageRowMapper = new RowMapper<Message>() {

			public Message mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				return (Message)RowMapperUtil.getRowMapper(Message.class, rs, "");
			}
		};
	}
	
	/**
	 * 添加留言
	 * @param message
	 * @return
	 */
	public int save(Message message){
		try {
			
			String sql = "insert into message(id,content,date,articleId) values(?,?,?,?)";
			
			return super.getJdbcTemplate().update(sql,message.getId(),message.getContent(),message.getDate(),message.getArticleId());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	/**
	 * 根据文章id获取所有的留言
	 * @param articleId
	 * @return
	 */
	public Map<String,Object> getMessages(String articleId){
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			int total = 0;
			String totalSql = "select count(*) from message where articleId = ?";
			
			total = super.getJdbcTemplate().queryForInt(totalSql,articleId);
			map.put("total", total);
			String sql = "select  id,content,date_format(date,'%Y-%m-%d %H:%i:%s') date,articleId from message where articleId = ? order by date desc";
			
			List<Message> list = super.getJdbcTemplate().query(sql, messageRowMapper,articleId);
			
			map.put("list", list);
			
			return map;
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
}
