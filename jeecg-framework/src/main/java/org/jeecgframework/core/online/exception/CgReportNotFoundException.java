package org.jeecgframework.core.online.exception;
/**
 * 
 * @Title:CgReportNotFoundException
 * @description:动态报表配置没有找到异常
 * @author 赵俊夫
 * @date Jul 30, 2013 9:56:12 AM
 * @version V1.0
 */
public class CgReportNotFoundException extends RuntimeException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CgReportNotFoundException(String msg) {
		 super(msg);
	}
}
