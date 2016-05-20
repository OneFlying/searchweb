package com.yf.utils;
/**
 * 文件操作
 * @author gaoqijun
 * @date 2016-05-18
 */
public class FileUtils {

	public static String getFileNameByFilePath(String filePath){
		String[] arr = filePath.split("\\");
		return arr[arr.length-1];
 	}
}
