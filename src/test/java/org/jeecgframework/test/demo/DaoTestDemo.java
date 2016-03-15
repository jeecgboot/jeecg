package org.jeecgframework.test.demo;

import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.core.common.dao.impl.CommonDao;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * DAO 测试DEMO
 * @author 许国杰
 *
 */
public class DaoTestDemo extends AbstractUnitTest{
	@Autowired
	private CommonDao commonDao ;
	@Test
	public void testGetUserRole() {
		TSUser user = new TSUser();
		user.setUserName("admin");
		user.setPassword("c44b01947c9e6e3f");
		TSUser user2 = commonDao.getUserByUserIdAndUserNameExits(user);
		assert(user2.getUserName().equals(user.getUserName()));
	}
}
