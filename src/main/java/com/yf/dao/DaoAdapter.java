package com.yf.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

public class DaoAdapter extends JdbcDaoSupport {

	@Resource(name = "yfJdbcTemplate")
	private JdbcTemplate yfJdbcTemplate;

	@PostConstruct
	public void initJdbcTemplate() {
		super.setJdbcTemplate(yfJdbcTemplate);
	}

	

}
