package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Img;


@Repository("imgDao")
public class ImgDao extends DaoAdapter{

	private static RowMapper<Img> imgRowMapper;
	
	static {
		imgRowMapper = new RowMapper<Img>() {

			public Img mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Img img = new Img();
				
				img.setId(rs.getString("id"));
				img.setUrl(rs.getString("url"));
				return img;
			}
		};
	}
	
	/**
	 * 通过id获取图片信息
	 * @param id
	 * @return
	 */
	public Img getImgById(String id){
		try {
			String sql = "select * from img where id=?";
			return super.getJdbcTemplate().queryForObject(sql, imgRowMapper,id);
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	 * 保存图片信息
	 * @param img
	 * @return
	 */
	public int saveImg(Img img){
		try {
			String sql = "insert into img values(?,?)";
			return super.getJdbcTemplate().update(sql,img.getId(),img.getUrl());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
}
