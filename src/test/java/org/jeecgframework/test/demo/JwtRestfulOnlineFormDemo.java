package org.jeecgframework.test.demo;

import org.jeecgframework.jwt.util.JwtHttpUtil;

import com.alibaba.fastjson.JSONObject;

/**
 * jeecg jwt
 * -online表单接口客户端 调用demo
 */
public class JwtRestfulOnlineFormDemo {
	
	public static String getToken(String userName,String password){
		String url = "http://localhost:8080/jeecg/rest/tokens?username="+userName+"&password="+password;
		String token= JwtHttpUtil.httpRequest(url, "POST", null);
		return token;
	}
	//online表单查询
	public static JSONObject getOnlineForm(String token,String tableName,String id){
		String url = "http://localhost:8080/jeecg/rest/cgFormDataController/get/"+tableName+"/"+id;
		JSONObject resp= JwtHttpUtil.httpRequest(url, "GET", null,token);
		return resp;
	}
	//online表单 删除
	public static JSONObject deleteOnlineForm(String token,String tableName,String id){
		String url = "http://localhost:8080/jeecg/rest/cgFormDataController/delete/"+tableName+"/"+id;
		JSONObject resp= JwtHttpUtil.httpRequest(url, "DELETE", null,token);
		return resp;
	}
	//online表单 新增
	public static JSONObject addOnlineForm(String token,String body){
		String url = "http://localhost:8080/jeecg/rest/cgFormDataController/add";
		JSONObject resp= JwtHttpUtil.httpRequest(url, "POST", body,token);
		return resp;
	}
	//online表单 修改
	public static JSONObject updateOnlineForm(String token,String body){
		String url = "http://localhost:8080/jeecg/rest/cgFormDataController/update";
		JSONObject resp= JwtHttpUtil.httpRequest(url, "POST", body,token);
		return resp;
	}
	
	public static void main(String[] args) {
		String token = getToken("admin","123456");
//		String token = "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJhZG1pbiIsInN1YiI6ImFkbWluIiwiaWF0IjoxNTExODU5NjM2fQ.Emfe8VZKA_L33jaW8ZUtVFVDEin83Np_d3gKlPIZryE";
//		System.out.println(token);
		
		//获取online表单
		//System.out.println("======获取online表单======="+getOnlineForm(token, "jeecg_demo", "4028f6815dd04a04015dd04d4f3e0002"));
		//删除online表单
		//System.out.println("======删除online表单======="+deleteOnlineForm(token, "jeecg_demo", "4028f6815bd637f1015bd63b3ce60005"));
		//新增online表单
		System.out.println("======新增online表单======="+addOnlineForm(token, "{\"tableName\":\"jeecg_demo\",\"id\":\"222w2\",\"data\":{\"name\":\"测试vc\"}}"));
		//修改online表单
		//System.out.println("======修改online表单======="+updateOnlineForm(token, "{\"tableName\":\"jeecg_demo\",\"id\":\"2222\",\"data\":{\"name\":\"测试实现vvc\"}}"));
		
	}

}
