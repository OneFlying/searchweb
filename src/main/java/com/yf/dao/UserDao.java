package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.User;

@Repository("userDao")
public class UserDao extends DaoAdapter{

	private static RowMapper<User> userRowMapper;
	
	static{
		
		userRowMapper = new RowMapper<User>() {

			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				User user = new User();
				user.setId(rs.getString("id"));
				user.setPassword(rs.getString("password"));
				user.setUsername(rs.getString("username"));
				user.setRole(rs.getInt("role"));
				return user;
			}
		};
	}
	
	/**
	 * 保存用户信息
	 * @param user
	 * @return
	 */
	public int saveUser(User user){
		
		try {
			String sql = "insert into user values(?,?,?,?)";
			return super.getJdbcTemplate().update(sql,user.getId(),user.getUsername(),user.getPassword(),user.getRole());
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	/**
	 * 根据id号删除用户
	 * @param id
	 * @return
	 */
	public int deleteUser(String id){
		try {
			
			String sql = "delete from user where id = ?";
			return super.getJdbcTemplate().update(sql,id);
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	public int updateUser(User user){
		
		try {
			String sql = "update user set username=?,password=?,role=? where id=?";
			return super.getJdbcTemplate().update(sql,user.getUsername(),user.getPassword(),user.getRole(),user.getId());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	/**
	 * 查询用户
	 * @return
	 */
	public List<User> pageUser(SearchEntity searchEntity){
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
			return super.getJdbcTemplate().query(sql, searchEntity.getSearchValues().toArray(),userRowMapper);
			
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	 * 获取登录用户信息
	 * @param username 用户名
	 * @param password 密码
	 * @return
	 */
	public User checkLogin(String username,String password){
		
		try {
			
			String sql = "select * from user where username=? and password=?";
			return super.getJdbcTemplate().queryForObject(sql, userRowMapper,username,password);
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
	}
}
