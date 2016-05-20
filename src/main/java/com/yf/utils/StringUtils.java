package com.yf.utils;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 字符串工具类
 */
public class StringUtils {

	/**
	 * 生成32位唯一的uuid
	 * @return
	 */
	public static String generateUuid() {

		String uuid = UUID.randomUUID().toString();
		String uuidString = uuid.substring(0, 8) + uuid.substring(9, 13) + uuid.substring(14, 18)
				+ uuid.substring(19, 23) + uuid.substring(24, 36);
		return uuidString;
	}

	/**
	 * 判断字符串是否不为空 (用一句话描述方法的主要功能)
	 * @param str
	 * @return
	 */
	public static boolean isNotBlank(String str) {

		return !isBlank(str);
	}

	/**
	 * 判断字符串是否为空
	 * @param str
	 * @return
	 */
	public static boolean isBlank(String str) {

		int strLen;
		if (str == null || (strLen = str.length()) == 0) {
			return true;
		}
		for (int i = 0; i < strLen; i++) {
			if ((Character.isWhitespace(str.charAt(i)) == false)) {
				return false;
			}
		}
		return true;
	}

	public static String getChildId(String parentId) {

		// 计算节点的基数,如用两位表示就是100，三位表示就是1000等
		int baseNumber = (int) Math.pow(10, 2);
		int numberToAdd = (int) Math.pow(baseNumber, 1);
		return parentId;
	}

	public static String getCurTimeStamp() {

		return String.valueOf(System.currentTimeMillis());
	}

	/**
	 * 数组 转化成 逗号隔开的字符串 aaa,bbb,ccc
	 * @param arrstring
	 * @return
	 */
	public static String arrToDotstring(String[] arrstring){
		String dotString = "";
		for(int i=0 ; i<arrstring.length; i++){
			dotString += arrstring[i];
			if((i+1)<arrstring.length){
				dotString+=",";
			}
		}
		return dotString;
	}
	
	/**
	 * "a,b,c,d" -> 数组
	 * @param dotstring
	 * @return
	 */
	public static String[] dotStringToArr(String dotstring){
		return dotstring.split(",");
	}
	/**
	 * 如果为空 返回 ”“
	 * @param s
	 * @return
	 * 2015-12-3
	 *
	 */
	public static String IS_NUll(String s){
		if(s==null)return "";
		return s;
	}
	public static void main(String[] args) {

		String[] arrString = dotStringToArr("a,b,c");
		for(String s : arrString){
			System.out.println(s);
		}
		
		
		
	}
	/**
	 * 获取当前时间格式为 yyyy-MM-dd HH:mm
	 * */
	public static String getCurTimeFormat(){
		SimpleDateFormat formatTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");		
		return formatTime.format(new Date());		
	}

}
