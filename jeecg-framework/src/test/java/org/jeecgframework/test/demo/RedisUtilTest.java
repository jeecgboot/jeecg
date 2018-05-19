package org.jeecgframework.test.demo;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.core.util.RedisUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.junit.Before;
import org.junit.Test;
/**
 * RedisUtil的junit测试类
 * @author yugwu
 */
public class RedisUtilTest extends AbstractUnitTest{
	
	@Before
	public void setup() throws Exception {
		RedisUtil.cleanAll();
	}
	//RedisUtil.delete
	@Test
	public void testDelete() throws Exception {
		RedisUtil.StringR.set("aaa", "aaa");
		RedisUtil.StringR.delete("aaa");
		assertTrue(RedisUtil.StringR.get("aaa") == null);
	}
	//RedisUtil.hasKey
	@Test
	public void testHasKey() throws Exception {
		RedisUtil.StringR.set("aaa", "aaa");
		Boolean hasKey = RedisUtil.StringR.hasKey("aaa");
		RedisUtil.StringR.delete("aaa");
		Boolean deleteKey = RedisUtil.StringR.hasKey("aaa");
		assertTrue(hasKey&&!deleteKey);
	}
	//RedisUtil.StringR.setIfAbsent
	@Test
	public void testSsetIfAbsent() throws Exception {
		RedisUtil.StringR.setIfAbsent("aaa", "aaa");
		String aaa = RedisUtil.StringR.get("aaa");
		RedisUtil.StringR.setIfAbsent("aaa", "bbb");
		String bbb = RedisUtil.StringR.get("aaa");
		RedisUtil.StringR.delete("aaa");
		assertTrue("aaa".equals(aaa)&&"aaa".equals(bbb));
	}
	//RedisUtil.StringR.getAndRemove
	@Test
	public void testSgetAndRemove() throws Exception {
		RedisUtil.StringR.setIfAbsent("aaa", "aaa");
		String aaa = RedisUtil.StringR.getAndRemove("aaa");
		String bbb = RedisUtil.StringR.get("aaa");
		RedisUtil.StringR.delete("aaa");
		assertTrue("aaa".equals(aaa)&&null == bbb);
	}
	//RedisUtil.ObjectR.set RedisUtil.ObjectR.getAndRemove
	@Test
	public void testOSetAndGet() throws Exception {
		TSUser user = new TSUser();
		user.setUserName("test");
		user.setEmail("testEmail");
		RedisUtil.ObjectR.set("aaa", user);
		TSUser aaa = (TSUser) RedisUtil.ObjectR.getAndRemove("aaa");
		assertTrue("test".equals(aaa.getUserName())&&"testEmail".equals(aaa.getEmail()));
	}
	//RedisUtil.ListR.size RedisUtil.ListR.add RedisUtil.ListR.get RedisUtil.ListR.getAllAndRemove
	@SuppressWarnings("rawtypes")
	@Test
	public void testList() throws Exception {
		List<TSUser> list = new ArrayList<TSUser>();
		for(int i=0;i<10;i++){
			TSUser user = new TSUser();
			user.setUserName("test"+i);
			user.setEmail("testEmail"+i);
			list.add(user);
		}
		RedisUtil.ListR.set("aaa", list);
		Long size = RedisUtil.ListR.size("aaa");
		Boolean sizeAssert = size == 10;
		TSUser user = new TSUser();
		user.setUserName("test"+10);
		user.setEmail("testEmail"+10);
		list.add(user);
		RedisUtil.ListR.add("aaa", user);
		Long size1 = RedisUtil.ListR.size("aaa");
		Boolean addAssert = size1 == 11;
		TSUser userR = (TSUser) RedisUtil.ListR.get("aaa", 10);
		Boolean getAssert = ("test10".equals(userR.getUserName()))&&("testEmail10".equals(userR.getEmail()));
		ArrayList result = RedisUtil.ListR.getAllAndRemove("aaa");
		Iterator it = result.iterator();
		int index = 0;
		Boolean getAllAssert = true;
		while(it.hasNext()){
			TSUser userI = (TSUser) it.next();
			if(!("test"+index).equals(userI.getUserName())){
				getAllAssert = false;
			}
			if(!("testEmail"+index).equals(userI.getEmail())){
				getAllAssert = false;
			}
			index++;
		}
		assertTrue(sizeAssert && addAssert && getAssert && getAllAssert);
	}
	//测试清理cleanAll
	@Test
	public void testClean() throws Exception {
		List<TSUser> list = new ArrayList<TSUser>();
		for(int i=0;i<10;i++){
			TSUser user = new TSUser();
			user.setUserName("test"+i);
			user.setEmail("testEmail"+i);
			list.add(user);
		}
		RedisUtil.ListR.set("aaa", list);
		RedisUtil.StringR.setIfAbsent("aaa", "aaa");
		TSUser user = new TSUser();
		user.setUserName("test");
		user.setEmail("testEmail");
		RedisUtil.ObjectR.set("aaa", user);
		RedisUtil.cleanAll();
		assertTrue(null == RedisUtil.StringR.get("aaa") && null == RedisUtil.ObjectR.get("aaa") && 0 == RedisUtil.ListR.size("aaa"));
	}
}
