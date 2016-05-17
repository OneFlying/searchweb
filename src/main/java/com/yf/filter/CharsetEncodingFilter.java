package com.yf.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 字符编码过滤器
 * 
 */
public class CharsetEncodingFilter implements Filter {

	private Logger logger = LoggerFactory.getLogger(getClass());

	private String encording = null;

	
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO 该方法尚未实现
		logger.info("CharsetEncodingFilter init!");
		encording = filterConfig.getInitParameter("endcoding");
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
			ServletException {
		// 设置web.xml中配置的字符集
		request.setCharacterEncoding(encording);
		// 继续执行
		chain.doFilter(request, response);

	}

	
	public void destroy() {
		// TODO 该方法尚未实现

	}

	

}
