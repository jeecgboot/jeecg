package jeecg.system.listener;

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

	@Override
	public void init() throws Exception {
		super.init();
		this.baseURL = path + "/" + ResourceUtil.getConfigByName("userfiles")
				+ "/";
	}

}
