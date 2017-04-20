package test;

import com.alibaba.fastjson.JSONObject;
import org.jeecgframework.web.cgform.util.SignatureUtil;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class HttpUtil {

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
	public static JSONObject httpRequest(String requestUrl,
			String requestMethod, String outputStr,String sign) {
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
			httpUrlConn.setRequestProperty("X-JEECG-SIGN",sign);
//			httpUrlConn.setRequestProperty("content-type", "text/html");
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
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);

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
			jsonObject = JSONObject.parseObject(buffer.toString());
			// jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			org.jeecgframework.core.util.LogUtil
					.info("Weixin server connection timed out.");
		} catch (Exception e) {
			//e.printStackTrace();
			org.jeecgframework.core.util.LogUtil.info("https request error:{}"
					+ e.getMessage());
		}finally{
			try {
			httpUrlConn.disconnect();
			}catch (Exception e) {
				e.printStackTrace();
				org.jeecgframework.core.util.LogUtil.info("http close error:{}"+ e.getMessage());
			}
		}
		return jsonObject;
	}
	
	public static void main(String args[]){
		String key="26F72780372E84B6CFAED6F7B19139CC47B1912B6CAED753";
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("id","40281381537e969401537eb9902d0006");
		jsonObject.put("tableName","jform_contact");
		String body=jsonObject.toJSONString();
		Map param=new HashMap();
		param.put("body",body);
		String sign=SignatureUtil.sign(param,key);
		System.out.println("  -- sign   -- "+ sign);
		JSONObject resp=HttpUtil.httpRequest("http://localhost:8080/jeecg/api/cgFormDataController.do?getFormInfo","POST","body="+body,sign);
		System.out.println(resp.toJSONString());
	}
	
	public static void main2(String args[]){
		String key="26F72780372E84B6CFAED6F7B19139CC47B1912B6CAED753";
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("id","40281381537e969401537eb9902d0006");
		jsonObject.put("tableName","jform_contact");
		JSONObject data=new JSONObject();
		data.put("name","张山丰");
		data.put("sex","0");
		jsonObject.put("data",data);
		String body=jsonObject.toJSONString();
		Map param=new HashMap();
		param.put("body",body);

		String sign=SignatureUtil.sign(param,key);
		System.out.println("  -- sign   -- "+ sign);
		JSONObject resp=HttpUtil.httpRequest("http://localhost:8080/jeecg/api/cgFormDataController.do?addFormInfo","POST","body="+body,sign);
		System.out.println(resp.toJSONString());
	}
}
