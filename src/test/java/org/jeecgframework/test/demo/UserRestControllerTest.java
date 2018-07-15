package org.jeecgframework.test.demo;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import java.util.HashMap;
import org.hamcrest.Matchers;
import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.PasswordUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.system.pojo.base.Client;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.junit.Before;
import org.junit.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.web.util.WebUtils;
/**
 * Controller UserRest单元测试Demo
 * @author 于庚午
 */
public class UserRestControllerTest  extends AbstractUnitTest{
	
	private MockMvc mockMvc;
	private MockHttpSession session; //为模拟登录时，所有请求使用同一个session
	@Before
	public void setup() throws Exception {
		MockHttpServletRequestBuilder requestBuilder = post("/");
		MockHttpServletRequest request = requestBuilder.buildRequest(this.wac.getServletContext());
		session = (MockHttpSession) request.getSession();

		Client c = new Client();
		TSUser u = new TSUser();
		u.setUserName("admin");
		c.setUser(u);
		session.setAttribute(session.getId(), c);

		this.mockMvc = webAppContextSetup(this.wac).build();
		this.testLogin();
	}
	//测试登录
	@Test
	public void testLogin() throws Exception {
		session.setAttribute("randCode", "1234"); //设置登录验证码
		this.mockMvc.perform(MockMvcRequestBuilders.post("/loginController.do?checkuser=1")
				.characterEncoding("UTF-8")
				.param("userName","admin")
				.param("password", "123456")
				.param("randCode", "1234")
				.header("USER-AGENT", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")  // 设置USER-AGENT： 浏览器 
				.session(session))  //关键 每个测试都要设置session 。以保证是使用的同一个session
				.andDo(print())
				.andExpect(jsonPath("$.success").value(Matchers.equalTo(true)));
		//避免testGetAll()中admin用户的currentDepart属性循环嵌套导致json不正确
		((Client)session.getAttribute(session.getId())).getUser().setCurrentDepart(new TSDepart());
	}
	
	//测试get全部用户
	@Test
	public void testGetAll() throws Exception {
		this.mockMvc.perform(MockMvcRequestBuilders.get("/rest/user")
				//org.springframework.web.util.UrlPathHelper.getServletPath(HttpServletRequest request) 获取servletPath
				.requestAttr(WebUtils.INCLUDE_SERVLET_PATH_ATTRIBUTE, "/rest")
				.contentType(MediaType.TEXT_HTML)
				.characterEncoding("UTF-8")
				.header("USER-AGENT", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")  // 设置USER-AGENT： 浏览器 
				//关键 每个测试都要设置session 。以保证是使用的同一个session
				.session(session))
				.andDo(print())
				//第一个用户demo的id为402880e74d75c4dd014d75d44af30005
				.andExpect(jsonPath("$[0].departid").value("402880e6487e661a01487e6b504e0001"))
				.andReturn();
	}
	
	//测试get单个用户
	@Test
	public void testGet() throws Exception {
		this.mockMvc.perform(MockMvcRequestBuilders.get("/rest/user/402880e74d75c4dd014d75d44af30005")
				.requestAttr(WebUtils.INCLUDE_SERVLET_PATH_ATTRIBUTE, "/rest")
				.contentType(MediaType.TEXT_HTML)
				.characterEncoding("UTF-8")
				.header("USER-AGENT", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")  // 设置USER-AGENT： 浏览器 
				.session(session))
				.andDo(print())
				.andExpect(jsonPath("$.userName").value("demo"))
				.andReturn();
	}
	
	//测试create
	@Test
	public void testCreate() throws Exception {
		//整理请求参数
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mobilePhone", "mobilePhone");
		map.put("officePhone", "officePhone");
		map.put("email", "email");
		map.put("createBy", ((Client)session.getAttribute(session.getId())).getUser().getId());
		map.put("createName", ((Client)session.getAttribute(session.getId())).getUser().getUserName());
		map.put("updateBy", ((Client)session.getAttribute(session.getId())).getUser().getId());
		map.put("updateName", ((Client)session.getAttribute(session.getId())).getUser().getUserName());
		map.put("devFlag", "1");
		map.put("mobilePhone", "mobilePhone");
		map.put("realName", "realName");
		map.put("status", Globals.User_Normal+"");
		map.put("activitiSync", "1");
		map.put("userName", "testRestMockMvc");
		map.put("password", PasswordUtil.encrypt("testRestMockMvc", "123456", PasswordUtil.getStaticSalt()));
		//发送请求
		this.mockMvc.perform(MockMvcRequestBuilders.post("/rest/user")
				.requestAttr(WebUtils.INCLUDE_SERVLET_PATH_ATTRIBUTE, "/rest")
				.content(StringUtil.HashMapToJsonContent(map))
				.contentType(MediaType.APPLICATION_JSON)
				.characterEncoding("UTF-8")
				.header("USER-AGENT", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")  // 设置USER-AGENT： 浏览器 
				.session(session))
				.andDo(print())
				//实际未成功，@Transactional自动回滚
				.andExpect(status().is(HttpStatus.CREATED.value()))
				.andReturn();
	}
	
	//测试update
	@Test
	public void testUpdate() throws Exception {
		//整理请求参数
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mobilePhone", "mobilePhone");
		map.put("officePhone", "officePhone");
		map.put("email", "email");
		map.put("createBy", ((Client)session.getAttribute(session.getId())).getUser().getId());
		map.put("createName", ((Client)session.getAttribute(session.getId())).getUser().getUserName());
		map.put("updateBy", ((Client)session.getAttribute(session.getId())).getUser().getId());
		map.put("updateName", ((Client)session.getAttribute(session.getId())).getUser().getUserName());
		map.put("devFlag", "1");
		map.put("mobilePhone", "mobilePhone");
		map.put("realName", "realName");
		map.put("status", Globals.User_Normal+"");
		map.put("activitiSync", "1");
		map.put("userName", "testRestMockMvc");
		map.put("password", PasswordUtil.encrypt("testRestMockMvc", "123456", PasswordUtil.getStaticSalt()));
		//发送请求
		this.mockMvc.perform(MockMvcRequestBuilders.put("/rest/user/402881e45e47a162015e47be6fb8002b")
				.requestAttr(WebUtils.INCLUDE_SERVLET_PATH_ATTRIBUTE, "/rest")
				.content(StringUtil.HashMapToJsonContent(map))
				.contentType(MediaType.APPLICATION_JSON)
				.characterEncoding("UTF-8")
				.header("USER-AGENT", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")  // 设置USER-AGENT： 浏览器 
				.session(session))
				.andDo(print())
				.andExpect(status().is(HttpStatus.NO_CONTENT.value()))
				.andReturn();
	}
	
	//测试del
	@Test
	public void testDelete() throws Exception {
		this.mockMvc.perform(MockMvcRequestBuilders.delete("/rest/user/402880e74d75c4dd014d75d44af30005")
				.requestAttr(WebUtils.INCLUDE_SERVLET_PATH_ATTRIBUTE, "/rest")
				.contentType(MediaType.TEXT_HTML)
				.characterEncoding("UTF-8")
				.header("USER-AGENT", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36")  // 设置USER-AGENT： 浏览器 
				.session(session))
				.andDo(print())
				.andExpect(status().is(HttpStatus.NO_CONTENT.value()))
				.andReturn();
	}
	
}
