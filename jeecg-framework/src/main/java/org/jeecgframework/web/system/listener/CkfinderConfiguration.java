package org.jeecgframework.web.system.listener;

import javax.servlet.ServletConfig;

import org.jeecgframework.core.util.ResourceUtil;

import com.ckfinder.connector.configuration.Configuration;

/**
 * @Title: listener
 * @Description: ckfinder监听器
 * @author Alexander
 * @date 2013-09-19 23:01:20
 * @version V1.0
 * 
 */
public class CkfinderConfiguration extends Configuration {

	String path = "";

	public CkfinderConfiguration(ServletConfig servletConfig) {
		super(servletConfig);
		path = servletConfig.getServletContext().getContextPath();
	}

	
	public void init() throws Exception {
		super.init();
		String files = ResourceUtil.getConfigByName("ck.userfiles");
		if (files.contains("http://"))
			this.baseURL = files;
		else
			this.baseURL = path + "/" + files + "/";
		this.baseDir = ResourceUtil.getConfigByName("ck.baseDir");
	}

}
