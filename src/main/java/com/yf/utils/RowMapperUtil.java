package com.yf.utils;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.AnnotatedBeanDefinition;

import com.yf.annotation.Column;


/**
 * 自动映射rowmapper
 * 结合searchentiry使用
 * @ClassName: ObjRowMapperUtil 
 * @Description: TODO 
 * @author guolejian
 * @date 2016年4月8日 下午1:44:07
 */
public class RowMapperUtil {

	/**
	 * 获取rowMapper
	 * @Description: TODO 
	 * @param @param clazz 需要进行映射的类
	 * @param @param rs 结果集
	 * @param @param delField 不需要映射的属性名
	 * @param @return    
	 * @return Object
	 */
	public static Object getRowMapper(Class<?> clazz,ResultSet rs,String delField){
		
		//创建一个对象
		Object obj = null;
		try {
			
			obj = clazz.newInstance();
						
			//获取对象所有的方法
			Method []methods = clazz.getMethods();
			
			//获取所有get方法
			List<Method> getMethods = RowMapperUtil.getMethodsGet(methods);
			
			for(Method method : getMethods){
				//获取对应的属性
				String methodName = method.getName();
				String fieldName = methodName.substring(3).trim();
				String prefix = fieldName.substring(0,1);
				String suffix = fieldName.substring(1);
				
				//真正的属性值
				String realFildName = prefix.toLowerCase()+suffix;
				
				//判断是否有不需要获取数据的字段
				if(!realFildName.equals(delField)){
								
					Field []fields = clazz.getDeclaredFields();
					//获取属性
					Field field = clazz.getDeclaredField(realFildName);

					//设置暴力访问
					field.setAccessible(true);
					
					//获取该方法对应的注解
					Column column = method.getAnnotation(Column.class);
					
					//获取对应数据库的列明
					String columnName = column.name();
		
					//获取值
					Object fieldValue = rs.getObject(columnName);
					//为属性赋值
					field.set(obj, fieldValue);	
				}
			}
						
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 		
		return obj;
	}
	
	public static List<Method> getMethodsGet(Method []methods){
		
		//盛放所有get方法
		List<Method> newMethods = new ArrayList<Method>();
		
		for(Method method : methods){
			
			//因为会获取很多隐藏的方法  
			//用于判断是否是真正的get方法
			Column column = method.getAnnotation(Column.class);
			
			if(column != null){
				String methodName = method.getName();
				
				if(methodName.contains("get")){
					newMethods.add(method);
				}
			}
					
		}		
		return newMethods;		
	}
	
}
