package jeecg.system.service.impl;

import java.util.List;

import jeecg.system.pojo.base.TSDepart;
import jeecg.system.pojo.base.TSRoleUser;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;

import org.jeecgframework.core.util.JeecgSqlUtil;
import org.jeecgframework.core.util.LogUtil;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import spring.SpringTxTestCase;

/**
 * 单元测试
 * @author yanping.shi
 *
 */
public class UserServiceImplTest extends SpringTxTestCase {

	@Autowired
	private UserService userService;
	
	/**
	 * Test method for {@link jeecg.system.service.impl.UserServiceImpl#checkUserExits(jeecg.system.pojo.base.TSUser)}.
	 */
	@Test
	public void testCheckUserExits() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testGetListByCriteriaQuery----------");
		TSUser user = new TSUser();
		user.setUserName("admin");
		user.setPassword("admin");
		user = userService.checkUserExits(user);
		System.out.println("user:" +user);
	}

	/**
	 * Test method for {@link jeecg.system.service.impl.UserServiceImpl#getUserRole(jeecg.system.pojo.base.TSUser)}.
	 */
	@Test
	public void testGetUserRole() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testGetUserRole----------");
		String userRole = "";
		TSUser user = new TSUser();
		user.setId("40");
		List<TSRoleUser> sRoleUser = userService.findByProperty(TSRoleUser.class, "TSUser.id", user.getId());
		userRole = userService.getUserRole(user);
		System.out.println("userRole:" + userRole);
	}

	

	

	

	/**
	 * Test method for {@link org.jeecgframework.core.common.service.impl.CommonServiceImpl#save(java.lang.Object)}.
	 */
	@Test
	//如果你需要真正插入数据库,将Rollback设为false
	//@Rollback(false)
	public void testSave() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testSave----------");
		TSUser user = new TSUser();
		user.setRealName("施艳平1");
		user.setUserName("shiyp1");
		TSDepart dep = null;
		dep = userService.getEntity(TSDepart.class, "150");
		user.setTSDepart(dep);
		user.setPassword("shiyp1");
		userService.save(user);
	}

	/**
	 * Test method for {@link org.jeecgframework.core.common.service.impl.CommonServiceImpl#saveOrUpdate(java.lang.Object)}.
	 */
	@Test
	//如果你需要真正插入数据库,将Rollback设为false
	//@Rollback(false)
	public void testSaveOrUpdate() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testSaveOrUpdate----------");
		TSUser user = new TSUser();
		user = userService.getEntity(TSUser.class, "40");
		user.setRealName("管理员1");
		userService.saveOrUpdate(user);
	}

	/**
	 * Test method for {@link org.jeecgframework.core.common.service.impl.CommonServiceImpl#delete(java.lang.Object)}.
	 */
	@Test
	//如果你需要真正插入数据库,将Rollback设为false
	//@Rollback(false) 
	public void testDelete() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testDelete----------");
		TSUser user = new TSUser();
		user = userService.getEntity(TSUser.class, "40");
		userService.delete(user);
	}

	

	

	/**
	 * Test method for {@link org.jeecgframework.core.common.service.impl.CommonServiceImpl#getList(java.lang.Class)}.
	 */
	@Test
	public void testGetList() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testGetList----------");
		List<TSUser> users = userService.getList(TSUser.class);
		System.out.println("list.size():" + users.size());
	}

	/**
	 * Test method for {@link org.jeecgframework.core.common.service.impl.CommonServiceImpl#getEntity(java.lang.Class, java.io.Serializable)}.
	 */
	@Test
	public void testGetEntity() {
		LogUtil.info("-------junit4----------UserServiceImplTest.testGetEntity----------");
		TSUser user = new TSUser();
		user = userService.getEntity(TSUser.class, "40");
		System.out.println("user.username:" + user.getUserName());
	}

	@Test
	public void testGetCountForJdbc(){
		String sql = JeecgSqlUtil.getMethodSql(JeecgSqlUtil.getMethodUrl());
		Long count = userService.getCountForJdbc(sql);
		System.out.println("count:" + count);
	}

}
