// ~ CopyRight © 2012 USTC SINOVATE  SOFTWARE CO.LTD All Rights Reserved.
package org.jeecgframework.web.system.sms.util;

import java.io.IOException;
import java.net.URLEncoder;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.jeecgframework.web.system.sms.util.msg.util.MsgContainer;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
/**
 *   描述：CMPPSenderUtil CMPP3.0协议发送短信所有前台调用的短信发送方法在此 <br />
 *         版本:1.0.0 <br /
 * @author skycc
 *
 */
public class CMPPSenderUtil {

	private static Logger logger = LoggerFactory
			.getLogger(CMPPSenderUtil.class);

	/**
	 * 向单个号码发送短信.
	 * 
	 * @param phone
	 *            手机号码
	 * @param content
	 *            短信内容
	 * @return String 返回类型：String
	 */
	public static String sendMsg(String phone, String content) {
		try {
			String msg = URLEncoder.encode(content, "utf-8");
			// String msg = "测试短信发送内容";
			String url = "";//csp0短信地址
			HttpClient httpClient = new HttpClient();

			httpClient.getParams().setAuthenticationPreemptive(true);
			// 创建POST方法的实例
			PostMethod postMethod = new PostMethod(url);
			// 使用系统提供的默认的恢复策略
			postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
					new DefaultHttpMethodRetryHandler());
			String result = null;// 初始化返回结果（String类型）
			byte[] responseBody = null;// 初始化返回结果（byte[]类型）
			try {
				// 执行getMethod
				int statusCode = httpClient.executeMethod(postMethod);
				if (statusCode != HttpStatus.SC_OK) {
					System.err.println("Method failed: "
							+ postMethod.getStatusLine());
				}
				// 返回结果（byte[]类型）
				responseBody = postMethod.getResponseBody();
				// 返回结果（String类型，GBK格式）
				result = new String(responseBody, "GBK");
			} catch (IOException e) {
				logger.error(e.toString());
				//e.printStackTrace();
			} finally {
				// 释放连接
				postMethod.releaseConnection();
			}

			logger.debug("#调用短信发送接口返回数据\n{}", result);
			JSONObject jsonObject = (JSONObject) JSON.parse(result);
			String code = jsonObject.getString("code");
			if ("R0".equals(code)) {
				// 发送成功
				return "0";
			} else {
				// 发送失败
				return "1";
			}
		} catch (Exception e) {
			//e.printStackTrace();
			logger.error(e.toString());
			// 系统故障
			return "2";
		}
	}

	/**
	 * 短信群发.
	 * 
	 * @param phone
	 *            手机号码,多个号码以“,”分隔
	 * @param content
	 *            消息内容
	 * @return 发送失败 返回"false";部分号码失败,返回发送失败的号码;全部成功,返回"" 返回类型：String
	 */
	public static String sendTMsgs(String phone, String content) {
		String[] phoneAddress = phone.split(",");
		String sendResult = "";
		try {
			for (int i = 0; i < phoneAddress.length; i++) {
				boolean result = MsgContainer.sendMsg(content, phoneAddress[i]);
				if (!result) {
					sendResult += "-号码" + phoneAddress[i] + "发送失败";
					continue;
				}
			}
			return sendResult;
		} catch (Exception e) {
			e.printStackTrace();
			return "fasle";
		}
	}

	/**
	 * 异网的短信网关.
	 * 
	 * @param phone
	 *            手机号码
	 * @param content
	 *            短信内容
	 * @return String
	 */
	public static String sendDifferenceNetMsg(String phone, String content) {
		try {
			String msg = URLEncoder.encode(content, "utf-8");
			// String msg = "测试短信发送内容";
			String url = "";//csp0短信地址
			HttpClient httpClient = new HttpClient();

			httpClient.getParams().setAuthenticationPreemptive(true);
			// 创建POST方法的实例
			PostMethod postMethod = new PostMethod(url);
			// 使用系统提供的默认的恢复策略
			postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
					new DefaultHttpMethodRetryHandler());
			String result = null;// 初始化返回结果（String类型）
			byte[] responseBody = null;// 初始化返回结果（byte[]类型）
			try {
				// 执行getMethod
				int statusCode = httpClient.executeMethod(postMethod);
				if (statusCode != HttpStatus.SC_OK) {
					System.err.println("Method failed: "
							+ postMethod.getStatusLine());
				}
				// 返回结果（byte[]类型）
				responseBody = postMethod.getResponseBody();
				// 返回结果（String类型，GBK格式）
				result = new String(responseBody, "GBK");
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				// 释放连接
				postMethod.releaseConnection();
			}

			logger.debug("#调用短信发送接口返回数据\n{}", result);
			JSONObject jsonObject = (JSONObject) JSON.parse(result);
			String code = jsonObject.getString("code");
			if ("R0".equals(code)) {
				// 发送成功
				return "0";
			} else {
				// 发送失败
				return "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 系统故障
			return "2";
		}
	}

	/**
	 * 异网的短信网关带扩展码.
	 * 
	 * @param phone
	 *            手机号码
	 * @param content
	 *            短信内容
	 * @param exCode
	 *            扩展码
	 * @return String
	 */
	public static String sendMessage(String phone, String content, String exCode) {
		try {
			String msg = URLEncoder.encode(content, "utf-8");
		
			String url = "";//csp0短信地址
			HttpClient httpClient = new HttpClient();

			httpClient.getParams().setAuthenticationPreemptive(true);
			// 创建POST方法的实例
			PostMethod postMethod = new PostMethod(url);
			// 使用系统提供的默认的恢复策略
			postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
					new DefaultHttpMethodRetryHandler());
			String result = null;// 初始化返回结果（String类型）
			byte[] responseBody = null;// 初始化返回结果（byte[]类型）
			try {
				// 执行getMethod
				int statusCode = httpClient.executeMethod(postMethod);
				if (statusCode != HttpStatus.SC_OK) {
					System.err.println("Method failed: "
							+ postMethod.getStatusLine());
				}
				// 返回结果（byte[]类型）
				responseBody = postMethod.getResponseBody();
				// 返回结果（String类型，GBK格式）
				result = new String(responseBody, "GBK");
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				// 释放连接
				postMethod.releaseConnection();
			}
			logger.debug("#调用短信发送接口返回数据\n{}", result);
			JSONObject jsonObject = (JSONObject) JSON.parse(result);
			String code = jsonObject.getString("code");
			if ("R0".equals(code)) {
				// 发送成功
				return "0";
			} else {
				// 发送失败
				return "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 系统故障
			return "2";
		}
	}

}
