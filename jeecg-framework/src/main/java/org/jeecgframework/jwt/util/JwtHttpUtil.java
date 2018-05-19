package org.jeecgframework.jwt.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import org.jeecgframework.core.util.LogUtil;
import com.alibaba.fastjson.JSONObject;

/**
 * JWT 客户端
 * @author qinfeng
 *
 */
public class JwtHttpUtil {

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr, String sign) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		HttpURLConnection httpUrlConn = null;
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			URL url = new URL(requestUrl);
			httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestProperty("X-AUTH-TOKEN", sign);
			httpUrlConn.setRequestProperty("Accept", "*/*");
			httpUrlConn.setRequestProperty("Content-Type", "application/json");
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			System.out.println(buffer.toString());
			jsonObject = JSONObject.parseObject(buffer.toString());
			// jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			LogUtil.info("Weixin server connection timed out.");
		} catch (Exception e) {
			e.printStackTrace();
			org.jeecgframework.core.util.LogUtil.info("https request error:{}" + e.getMessage());
		} finally {
			try {
				httpUrlConn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
				org.jeecgframework.core.util.LogUtil.info("http close error:{}" + e.getMessage());
			}
		}
		return jsonObject;
	}
	
	
	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static String httpRequest(String requestUrl, String requestMethod, String outputStr) {
		String res = "";
		StringBuffer buffer = new StringBuffer();
		HttpURLConnection httpUrlConn = null;
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			URL url = new URL(requestUrl);
			httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestProperty("Accept", "text/plain");
			 httpUrlConn.setRequestProperty("Content-Type", "application/json");
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			res = buffer.toString();
			System.out.println(res);
//			jsonObject = JSONObject.parseObject(buffer.toString());
			// jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			LogUtil.info("Weixin server connection timed out.");
		} catch (Exception e) {
			e.printStackTrace();
			org.jeecgframework.core.util.LogUtil.info("https request error:{}" + e.getMessage());
		} finally {
			try {
				httpUrlConn.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
				org.jeecgframework.core.util.LogUtil.info("http close error:{}" + e.getMessage());
			}
		}
		return res;
	}

}
