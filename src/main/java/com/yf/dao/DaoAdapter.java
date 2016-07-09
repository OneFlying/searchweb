package com.yf.dao;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.swing.text.TabExpander;

import org.codehaus.jackson.map.ser.std.StdJdkSerializers.ClassSerializer;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.yf.annotation.Table;

public class DaoAdapter extends JdbcDaoSupport {

	@Resource(name = "yfJdbcTemplate")
	private JdbcTemplate yfJdbcTemplate;

	@PostConstruct
	public void initJdbcTemplate() {
		super.setJdbcTemplate(yfJdbcTemplate);
	}
}
