package org.jeecgframework.test.demo;

import static org.hamcrest.Matchers.containsString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import org.hamcrest.Matchers;
import org.jeecgframework.AbstractUnitTest;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
/**
 * Controller 单元测试Demo
 * @author  许国杰
 */
public class ControllerTestDemo  extends AbstractUnitTest{
	
	private MockMvc mockMvc;
	private MockHttpSession session; //为模拟登录时，所有请求使用同一个session
	@Before
	public void setup() throws Exception {
		MockHttpServletRequestBuilder requestBuilder = post("/");
		MockHttpServletRequest request = requestBuilder.buildRequest(this.wac.getServletContext());
		session = (MockHttpSession) request.getSession();
		this.mockMvc = webAppContextSetup(this.wac).alwaysExpect(status().isOk()).build();
		this.testLogin(); //先调用登录
	}
	//测试登录
	@Test
	public void testLogin() throws Exception {
		session.setAttribute("randCode", "1234"); //设置登录验证码
		this.mockMvc.perform(post("/loginController.do?checkuser=")
				.param("userName","admin")
				.param("password", "c44b01947c9e6e3f")
				.param("randCode", "1234")
				.header("USER-AGENT", "")  // 设置USER-AGENT： 浏览器 
				.session(session))  //关键 每个测试都要设置session 。以保证是使用的同一个session
				.andDo(print())
				.andExpect(jsonPath("$.success").value(Matchers.equalTo(true)));
	}
	//验证返回view 是否正确
	@Test
	public void testAorudemo() throws Exception {
		MockHttpServletRequestBuilder requestBuilder = post("/demoController.do?aorudemo=")
			.param("type","table")
			.header("USER-AGENT", "")  // 设置USER-AGENT： 浏览器 
			.session(session);  
		
		this.mockMvc.perform(requestBuilder)
				.andDo(print()) //打印报文
				.andExpect(view().name(containsString("jeecg/demo/base/tabledemo"))); //验证返回view 是否不正确
	}
	
	//使用jsonPath 验证返回json 的属性
	@Test
	public void testPDemoList() throws Exception{
		//-- update-begin author： xugj date:20160105  for:修改测试demo使用action,修复数据为空报错的问题
		MockHttpServletRequestBuilder requestBuilder = post("/userController.do?datagrid=")
	    .param("field", "id")
		.header("USER-AGENT", "")  // 设置USER-AGENT： 浏览器 
		.session(session); 
		
		this.mockMvc.perform(requestBuilder)
		.andDo(print()) //打印报文
		.andExpect(jsonPath("$.rows[0].id").exists()); // 验证id 属性是否存在
		//-- update-end author： xugj date:20160105  for:修改测试demo使用action,修复数据为空报错的问题

	}
}
