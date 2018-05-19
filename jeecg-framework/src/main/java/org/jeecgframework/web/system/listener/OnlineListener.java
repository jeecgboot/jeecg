package org.jeecgframework.web.system.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.web.system.manager.ClientManager;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


/**
 * 监听在线用户上线下线  add by duanql 2013-06-07
 */
public class OnlineListener implements ServletContextListener,HttpSessionListener {

	private static ApplicationContext ctx = null;

	public OnlineListener() {
	}

	
	public void sessionCreated(HttpSessionEvent httpSessionEvent) {
	}

	
	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
		try {
			ClientManager.getInstance().removeClinet(httpSessionEvent.getSession().getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 服务器初始化
	 */
	
	public void contextInitialized(ServletContextEvent evt) {
		ctx = WebApplicationContextUtils.getWebApplicationContext(evt.getServletContext());
	}

	public static ApplicationContext getCtx() {
		return ctx;
	}
	
	
	public void contextDestroyed(ServletContextEvent paramServletContextEvent) {
		
	}

}
