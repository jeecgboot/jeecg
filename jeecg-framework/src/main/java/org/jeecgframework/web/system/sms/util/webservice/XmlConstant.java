package org.jeecgframework.web.system.sms.util.webservice;
/**
 * 
 * @author skycc 
 * @desc xml报文常量类
 *
 */
public class XmlConstant {
	
	public static final String ACCOUNT="";
	public static final String PASSWORD="";
	
	/**
	 * 短信下发接口
	 */
public static final String SMS_SEND="<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
		"<message>" +
		"<account>%s</account>" +
		"<password>%s</password>" +
		"<msgid></msgid>" +
		"<phones>%s</phones>" +
		"<content>%s</content>" +
		"<sign>【签名内容】</sign>  "+//签名需要用“【】”标记" 
		"<subcode></subcode>     "+ //扩展号码"
		"<sendtime>%s</sendtime>//定时下发时间" +
		"</message>";
}
