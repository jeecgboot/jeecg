package org.jeecgframework.web.system.sms.util.msg.util;

import java.util.ResourceBundle;

/**
 * 用于获取短信接口配置参数.
 * 
 * @author skycc
 * 2014-11-17 11:34 
 */
public class MsgConfig {
	private static final ResourceBundle resourceBundle = ResourceBundle
			.getBundle("MsgConfig");

	/**
	 * .
	 * 
	 * @param key
	 *            String
	 * @return String
	 */
	public static String get(String key) {
		return resourceBundle.getString(key);
	}

	/**
	 * 获取互联网短信网关IP.
	 * 
	 * @return String
	 */
	public static String getIsmgIp() {
		return MsgConfig.get("ismgIp");
	}

	/**
	 * 获取互联网短信网关端口号.
	 * 
	 * @return int
	 */
	public static int getIsmgPort() {
		return Integer.parseInt(MsgConfig.get("ismgPort"));
	}

	/**
	 * 获取sp企业代码.
	 * 
	 * @return String
	 */
	public static String getSpId() {
		return MsgConfig.get("spId");
	}

	/**
	 * 获取sp下发短信号码.
	 * 
	 * @return String
	 */
	public static String getSpCode() {
		return MsgConfig.get("spCode");
	}

	/**
	 * 获取sp sharedSecret.
	 * 
	 * @return String
	 */
	public static String getSpSharedSecret() {
		return MsgConfig.get("sharedSecret");
	}

	/**
	 * 获取链接的次数.
	 * 
	 * @return int
	 */
	public static int getConnectCount() {
		return Integer.parseInt(MsgConfig.get("connectCount"));
	}

	/**
	 * 获取链接的超时时间.
	 * 
	 * @return int
	 */
	public static int getTimeOut() {
		return Integer.parseInt(MsgConfig.get("timeOut"));
	}
}