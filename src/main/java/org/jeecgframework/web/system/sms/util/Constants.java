package org.jeecgframework.web.system.sms.util;
/**
 * 
 * @author skycc
 * 短信和邮箱发送的常量类
 *
 */
public class Constants {
	//邮件发送配置
		public static final String SMTP_HOST = "mail.qq.com";
		public static final String MAIL_SENDER = "819164014@qq.com";
		public static final String SENDER_USER = "819164014@qq.com";
		public static final String SENDER_PASSWD = "*****"; //密码
		//短信发送配置
		public static final String SPID = "f8510a293f61c826013f61d2abb50005";
		public static final String OSPID = "f8510a283f645140013f646cfe690014";
		/**
		 * 未发送
		 */
		public static final String SMS_SEND_STATUS_1 = "1";
		/**
		 * 已发送
		 */
		public static final String SMS_SEND_STATUS_2 = "2";
		/**
		 * 发送失败
		 */
		public static final String SMS_SEND_STATUS_3 = "3";
		/**
		 * 短信提醒 1
		 */
		public static final String SMS_SEND_TYPE_1 = "1";
		/**
		 * 邮件提醒2
		 */
		public static final String SMS_SEND_TYPE_2 = "2";
		/**
		 * 系统提醒3
		 */
		public static final String SMS_SEND_TYPE_3 = "3";
		/**
		 * 微信提醒4
		 */
		public static final String SMS_SEND_TYPE_4 = "4";
		
}
