package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.yf.model.Websitconfig;

@Repository("websiteConfigDao")
public class WebsiteconfigDao extends DaoAdapter{

	private static RowMapper<Websitconfig> websiteRowMapper;
	
	static {
		websiteRowMapper = new RowMapper<Websitconfig>() {
			
			public Websitconfig mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Websitconfig websitconfig = new Websitconfig();
				websitconfig.setId(rs.getString("id"));
				websitconfig.setLogourl(rs.getString("logourl"));
				websitconfig.setTitle(rs.getString("title"));
				return websitconfig;
			}
		};
	}
	
	/**
	 * ±£¥ÊÕ¯’æ≈‰÷√–≈œ¢
	 * @param websitconfig
	 * @return
	 */
	public int saveWebSiteConfigInfo(Websitconfig websitconfig){
		
		try {
			
			String sql = "insert into websitconfig values(?,?,?)";
			
			return super.getJdbcTemplate().update(sql,websitconfig.getId(),websitconfig.getTitle(),websitconfig.getLogourl());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
}
