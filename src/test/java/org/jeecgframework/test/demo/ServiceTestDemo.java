package org.jeecgframework.test.demo;

import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.UserService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * Service 单元测试Demo
 * @author  许国杰
 */
public class ServiceTestDemo extends AbstractUnitTest{
	@Autowired
	private UserService userService;
	
	@Test
	public void testCheckUserExits() {
		TSUser user = new TSUser();
		user.setUserName("admin");
		user.setPassword("c44b01947c9e6e3f");
		TSUser u = userService.checkUserExits(user);
		assert(u.getUserName().equals(user.getUserName()));
	}

	@Test
	public void testGetUserRole() {
		TSUser user = new TSUser();
		user.setId("8a8ab0b246dc81120146dc8181950052");
		String roles = userService.getUserRole(user);
		assert(roles.equals("admin,"));
	}

}
