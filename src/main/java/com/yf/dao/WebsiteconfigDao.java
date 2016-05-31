package com.yf.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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
				websitconfig.setQitalogo(rs.getString("qitalogo"));
				websitconfig.setTitle(rs.getString("title"));
				websitconfig.setBeianhao(rs.getString("beianhao"));
				websitconfig.setKeywords(rs.getString("keywords"));
				return websitconfig;
			}
		};
	}
	
	/**
	 * 保存网站配置信息
	 * @param websitconfig
	 * @return
	 */
	public int saveWebSiteConfigInfo(Websitconfig websitconfig){
		
		try {
			
			String sql = "insert into websitconfig values(?,?,?,?,?,?)";
			
			return super.getJdbcTemplate().update(sql,websitconfig.getId(),websitconfig.getTitle(),websitconfig.getLogourl(),websitconfig.getKeywords(),websitconfig.getBeianhao(),websitconfig.getQitalogo());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	/**
	 * 修改网页配置信息
	 * @param websitconfig
	 * @return
	 */
	public int updateWebsiteConfig(Websitconfig websitconfig){
		
		try {
			
			String sql = "update websitconfig set title=?,logourl=?,keywords=?,beianhao=?,qitalogo=? where id=?";
			return super.getJdbcTemplate().update(sql,websitconfig.getTitle(),websitconfig.getLogourl(),websitconfig.getKeywords(),websitconfig.getBeianhao(),websitconfig.getQitalogo(),websitconfig.getId());
			
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	/**
	 * 分页获取网页配置信息
	 * @param searchEntity
	 * @return
	 */
	public List<Websitconfig> pageWebsitconfig(SearchEntity searchEntity){
		try {
			String sql = searchEntity.toSql();
			String totalSql = searchEntity.toPageTotalSql();
			int total = 0;
			if(searchEntity.getSearchValues().size() < 0){
				total = super.getJdbcTemplate().queryForInt(totalSql);
			}else{
				//total = super.getJdbcTemplate().queryForInt(totalSql,searchEntity.getSearchValues().toArray());
				total = super.getJdbcTemplate().queryForInt(totalSql,searchEntity.getPageTotalSearchValues().toArray());
			}
			
			searchEntity.setTotal(total);
			
			return super.getJdbcTemplate().query(sql, searchEntity.getSearchValues().toArray(),websiteRowMapper);
			
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	public Websitconfig getWebsitconfig(){
		String sql = "select * from websitconfig";
		try {
			return super.getJdbcTemplate().queryForObject(sql, websiteRowMapper);
		} catch (Exception e) {
			return null;
		}
		
	}
}
