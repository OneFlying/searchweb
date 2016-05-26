package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

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
	public List<Message> getMessages(String articleId){
		try {
			
			String sql = "select  id,content,date_format(date,'%Y-%m-%d %H:%i:%s') date,articleId from message where articleId = ? order by date desc";
			
			return super.getJdbcTemplate().query(sql, messageRowMapper,articleId);
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
}
