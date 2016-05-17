package com.yf.dao;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.yf.annotation.Column;
import com.yf.annotation.Table;

/**
 * 查询工具类
 * 
 * @author duanzhifei
 * @date 2014-12-3
 */
public class SearchEntity {
	private Class<?> modelClass;

	//自定义sql语句
	private String optionSql = "";
	
	
	public Class<?> getModelClass() {
		return modelClass;
	}

	public void setModelClass(Class<?> modelClass) {
		this.modelClass = modelClass;
	}

	public SearchEntity(Class<?> clazz) {
		modelClass = clazz;
	}
	
	//存放自定sql语句需要用到的参数
	private List<Object> optionSqlValues = new ArrayList<Object>();

	// 查询列名称
	private List<String> resultColumns = new ArrayList<String>();

	private List<String> searchColumns = new ArrayList<String>();
	
	private List<Object> searchValues = new ArrayList<Object>();
	
	private List<Integer> searchValueTypes = new ArrayList<Integer>();
	
	
	private String limit;//设置limit 语句
	
	private String orderBy;//orderby 语句
	
	private int total;//分页的总数
	
	private List<Object> pageTotalSearchValues = new ArrayList<Object>();
	
	private List<Integer> pageTotalSearchValueTypes = new ArrayList<Integer>();

	/**
	 * 清理内容
	 * 
	 * 2015-1-21
	 *
	 */
	/*public void clean(){
		resultColumns.clear();
	}*/
	/**
	 * 设置自定义语句
	 */
	public void setOptionSql(String sql,Object value,boolean isor){
		
		if(isor){
			if(this.optionSql == ""){
				this.optionSql = " where "+sql;
			}else {
				this.optionSql += " or "+sql;
			}
		}else{
			if(this.optionSql == ""){
				this.optionSql = " where "+sql;
			}else {
				this.optionSql += " and "+sql;
			}
			
		}
		//this.optionSqlValues.add(value);
		this.searchValues.add(value);
		this.pageTotalSearchValues.add(value);
	}
	
	/**
	 * 获取自定义的sql语句
	 */
	public String getOptionSql(){
		return this.optionSql;
	}
	
	/**
	 * 获取自定义sql语句需要的参数
	 */
	public List<Object> getOptionSqlValues(){
		return this.optionSqlValues;
	}
	/**
	 * 添加查询结果的列
	 * @param resuleColumn
	 * 2014-12-3
	 *
	 */
	public void addResultColumn(String resuleColumn){
		if(resuleColumn=="*"){
			resultColumns.add(" * ");
		}else{
			String columName = getColumnName(resuleColumn);
			resultColumns.add(columName);	
		}	
	}
	
	/**
	 * 添加搜索条件
	 * @param searchColumn
	 * @param value
	 * @param condition 条件eg. and or > < >= <= 
	 * @param isor 是否是or
	 * 2014-12-3
	 *
	 */
	public void addSearchColumn(String searchColumn,Object value,String condition,boolean isor){
		String columName = getColumnName(searchColumn);
		if(searchColumns.size()==0){//第一条语句
			searchColumns.add(" "+columName+condition+"? ");
		}else{
			if(isor){
				searchColumns.add(" or "+columName+condition+"? ");
			}else{
				searchColumns.add(" and "+columName+condition+"? ");
			}
		}
		searchValues.add(value);
		pageTotalSearchValues.add(value);
		Integer valueType = getValueTypes(value);
		searchValueTypes.add(valueType);
		pageTotalSearchValueTypes.add(valueType);
		
	}
	
	public void setLimit(Integer start,Integer rows){
		limit = " limit ? , ? ";
		searchValues.add(start);
		searchValueTypes.add(getValueTypes(start));
		searchValues.add(rows);
		searchValueTypes.add(getValueTypes(rows));
	}
	
	/**
	 * 设置分页条件
	 * @param page 页数
	 * @param rows 行数
	 * 2014-12-3
	 *
	 */
	public void setPage(Integer page, Integer rows){
		setLimit((page-1)*rows,rows);
	}
	// 获取表名称
	private String getTableName() {
		if (modelClass == null) {
			return null;
		} else {
			Table table = modelClass.getAnnotation(Table.class);
			return table.name();
		}

	}
	
	private Integer getValueTypes(Object value){
		if(value instanceof String){
			return Types.VARCHAR;
		}else if(value instanceof Integer){
			return Types.INTEGER;
		}
		return -1;
	}

	
	public void setOrderBy(String orderBy){
		//String columName = getColumnName(orderBy);
		this.orderBy = orderBy;
	}
	/**
	 * 获得Model中变量对应的列名称
	 * 
	 * @param field
	 *            变量名称
	 * @return 2014-12-3
	 * 
	 */
	private String getColumnName(String fieldName) {
		String firstChar = fieldName.substring(0, 1);
		firstChar = firstChar.toUpperCase();
		String methodName = "get"+firstChar+fieldName.substring(1);
		Method method = null;
		try {
			method = modelClass.getMethod(methodName);
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(method!=null){
			Column column = method.getAnnotation(Column.class);
			return column.name();
		}else{
			return null;	
		}
	}
	
	public String toSql(){
		String tableName = getTableName();
		StringBuffer sb = new StringBuffer("select ");
		for(int i=0;i<resultColumns.size();i++){
			if(i==(resultColumns.size()-1)){
				sb.append(resultColumns.get(i));
			}else{
				sb.append(resultColumns.get(i)).append(",");
			}
		}
		sb.append(" from ");
		sb.append(tableName);
		if(searchColumns!=null && searchColumns.size()!=0){
			sb.append(" where ");
			for(String searchColumn : searchColumns){
				sb.append(searchColumn);
			}
		}
		
		if(orderBy!=null){
			sb.append(orderBy);
		}
		if(limit!=null){
			sb.append(" ").append(limit);
		}
		
		return formatSql(sb.toString());
	}
	
	public String toPageTotalSql(){
		String tableName = getTableName();
		StringBuffer sb = new StringBuffer("select count(*) ");
		
		sb.append(" from ");
		sb.append(tableName);
		if(searchColumns!=null && searchColumns.size()!=0){
			sb.append(" where ");
			for(String searchColumn : searchColumns){
				sb.append(searchColumn);
			}
		}else{
			pageTotalSearchValues.clear();
			pageTotalSearchValueTypes.clear();
		}

		return formatSql(sb.toString());
	}
	
	/**
	 * 格式化ｓｑｌ
	 * @param sql
	 * @return
	 * 2014-12-23
	 *
	 */
	private String formatSql(String sql){
		int first = sql.indexOf(" or ");
		if(first > -1){//有 or
			int last = sql.lastIndexOf(" or ");
			String lastSub = sql.substring(last+4);
			lastSub = lastSub.substring(0, lastSub.indexOf(" "))+" ) "+ lastSub.substring(lastSub.indexOf(" "));
			sql = sql.substring(0, sql.indexOf(" where ")+7)+" ( " +sql.substring(sql.indexOf(" where ")+7, last)+" or "+lastSub;
		}
		return sql;
		
	}

	public List<Object> getSearchValues() {
		return searchValues;
	}

	public List<Integer> getSearchValueTypes() {
		return searchValueTypes;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	
	public List<String> getSearchColumns() {
		return searchColumns;
	}

	public void setSearchColumns(List<String> searchColumns) {
		this.searchColumns = searchColumns;
	}

	public List<Integer> getPageTotalSearchValueTypes() {
		return pageTotalSearchValueTypes;
	}

	public void setPageTotalSearchValueTypes(List<Integer> pageTotalSearchValueTypes) {
		this.pageTotalSearchValueTypes = pageTotalSearchValueTypes;
	}

	public List<Object> getPageTotalSearchValues() {
		return pageTotalSearchValues;
	}

	public void setPageTotalSearchValues(List<Object> pageTotalSearchValues) {
		this.pageTotalSearchValues = pageTotalSearchValues;
	}

	public String getLimit() {
		return limit;
	}

	public void setLimit(String limit) {
		this.limit = limit;
	}
	
	

}
