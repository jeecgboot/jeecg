package org.jeecgframework.web.system.sms.util.msg.util;

import org.jeecgframework.core.util.LogUtil;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * 做激活测试用的判断是否在连接如果不在进行链路连接.
 * @author 程川
 * <br />邮箱： cmzcheng@gmail.com
 * <br />描述：
 * <br />@version:1.0.0
 * <br />日期： 2013-4-24 下午2:36:25
 * <br />CopyRight © 2012 chinaMobile.ahcmcc
 */
public class MsgActivityTimer extends QuartzJobBean {
	/**
	 * 短信接口长链接，定时进行链路检查.
	 * @param arg0 JobExecutionContext
	 * @exception JobExecutionException JobExecutionException
	 */ 
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		LogUtil.info("×××××××××××××开始链路检查××××××××××××××");
		int count = 0;
		boolean result = MsgContainer.activityTestISMG();
		while (!result) {
			count++;
			result = MsgContainer.activityTestISMG();
			if (count >= (MsgConfig.getConnectCount() - 1)) {// 如果再次链路检查次数超过两次则终止连接
			break;
			}
		}
		LogUtil.info("×××××××××××××链路检查结束××××××××××××××");
	}
}
