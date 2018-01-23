package org.jeecgframework.test.demo;

import java.util.List;
import java.util.UUID;

import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.core.util.PasswordUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.UserService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * UserRestful单元测试Demo
 * 
 * @author scott
 */
public class UserRestfulTest extends AbstractUnitTest {
	@Autowired
	private UserService userService;

	@Autowired
	private RestTemplate template;

	// 测试get单个用户
	// @Test
	public void testGet() throws Exception {
		TSUser user = template.getForObject("http://localhost:8080/jeecg/rest/user/{id}", TSUser.class, "402880e74d75c4dd014d75d44af30005");

		// getForEntity与getForObject的区别是可以获取返回值和状态、头等信息
		ResponseEntity<TSUser> re = template.getForEntity("http://localhost:8080/jeecg/rest/user/{id}", TSUser.class, "402880e74d75c4dd014d75d44af30005");
		System.out.println(re.getStatusCode());
		System.out.println(re.getBody().getRealName());
	}

	// 测试get全部用户
	//@Test
	public void testGetAll() throws Exception {
		String str = template.getForObject("http://localhost:8080/jeecg/rest/user", String.class);
		
		Gson gson = new Gson();
		List<TSUser> list =gson.fromJson(str, new TypeToken<List<TSUser>>() {}.getType());
		for (TSUser r : list) {
			System.out.println("-----restful------" + r.getUserName());
			System.out.println("-----restful------" + r.getRealName());
		}
	}

	// 测试create
	 @Test
	public void testCreate() throws Exception {
		 HttpHeaders headers = new HttpHeaders();
		//  请勿轻易改变此提交方式，大部分的情况下，提交方式都是表单提交
		 headers.setContentType(MediaType.APPLICATION_JSON);
		 TSUser user = new TSUser();
		 user.setUserName("zhangsan");
		 user.setPassword(PasswordUtil.encrypt("zhangsan", "123456", PasswordUtil.getStaticSalt()));
		 user.setRealName("junit demo");
		 user.setStatus(Short.valueOf("1"));
		 user.setDeleteFlag(Short.valueOf("1"));
		 user.setDevFlag("1");
		 //  执行HTTP请求
//		 template.postForLocation("http://localhost:8080/jeecg/rest/user", user);
		 ResponseEntity<String> response = template.postForEntity("http://localhost:8080/jeecg/rest/user", user, String.class);
		 //  输出结果
		 System.out.println(response.getBody());
	}

	// 测试update
	// @Test
	public void testUpdate() throws Exception {
		TSUser user = userService.get(TSUser.class, "402880e74d75c4dd014d75d44af30005");
		user.setRealName("real demo");
		template.put("http://localhost:8080/jeecg/rest/user/{id}", user, "402880e74d75c4dd014d75d44af30005");
	}
	
	//测试del
	//@Test
	public void testDelete() throws Exception {
		HttpHeaders headers = new HttpHeaders();
		headers.add("X-Auth-Token", UUID.randomUUID().toString());
		headers.setContentType(MediaType.APPLICATION_JSON);
		template.delete("http://localhost:8080/jeecg/rest/user/{id}","111111");
	}
}
