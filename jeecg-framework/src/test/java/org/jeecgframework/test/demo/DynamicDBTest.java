package org.jeecgframework.test.demo;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.core.util.DynamicDBUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.junit.Before;
import org.junit.Test;

public class DynamicDBTest extends AbstractUnitTest {
	static String dbKey = "JEECG_LOCAL";

	static {
		DynamicDataSourceEntity dynamicSourceEntity = new DynamicDataSourceEntity();
		String driverClassName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jeecg";
		String dbUser = "root";
		String dbPassword = "ea3d519525358e00";

		dynamicSourceEntity.setDbKey(dbKey);
		dynamicSourceEntity.setDriverClass(driverClassName);
		dynamicSourceEntity.setUrl(url);
		dynamicSourceEntity.setDbUser(dbUser);
		dynamicSourceEntity.setDbPassword(dbPassword);
		ResourceUtil.dynamicDataSourceMap.put(dbKey, dynamicSourceEntity);
	}

	@Test
	public void testInsert() throws Exception {
		String id = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
		// 测试查询列表
		String sql = "insert jeecg_demo (id,name)values(?,'DynamicDBTest-insert') ";
		DynamicDBUtil.update(dbKey,sql,id);
		System.out.println("-----------testInsert---------");
	}
	
	@Test
	public void testUpdate() throws Exception {
		// 测试查询列表
		String sql = "update jeecg_demo set name='动态数据库源测试' where id = '402881f3633e483e01633e56ebed0009'";
		DynamicDBUtil.update(dbKey,sql);
		System.out.println("-----------testUpdate---------");
	}
	
	
	@Test
	public void testSelectList() throws Exception {
		// 测试查询列表
		String sql = "select * from jeecg_demo";
		List<Map<String, Object>> list = DynamicDBUtil.findList(dbKey, sql);
		System.out.println("---------------testSelectList------listSize--------"+ list.size());
		for (Map<String, Object> mp : list) {
			System.out.println(mp.toString());
		}
	}


}
