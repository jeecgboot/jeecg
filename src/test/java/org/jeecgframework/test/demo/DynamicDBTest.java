package org.jeecgframework.test.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.jeecgframework.AbstractUnitTest;
import org.jeecgframework.core.util.DynamicDBUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.test.demo.entity.GwyuTest;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.jeecgframework.web.system.service.CacheServiceI;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class DynamicDBTest extends AbstractUnitTest {
	static String dbKey = "JEECG_LOCAL";
	@Autowired
	private CacheServiceI cacheService;

	/**
	 * 定义多数据源配置
	 */
	@Before
	public void initDB(){
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
		
		Map<String, DynamicDataSourceEntity> dynamicDataSourceMap = new HashMap<String, DynamicDataSourceEntity>();
		dynamicDataSourceMap.put(dbKey, dynamicSourceEntity);
		//缓存数据
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.DYNAMIC_DB_CONFIGS_FOREVER_CACHE_KEY,dynamicDataSourceMap);
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

	@Test
	public void testActionEntity(){
		String sql = "<#if nlevel gt 2> insert into GWYUTEST003(id, sname, nlevel) values ((select maxid from (select ifnull(max(id)+1,1) maxid from GWYUTEST003) a),"
				+ " :sname, :nlevel)</#if>";
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("sname", "aaa");
		data.put("nlevel", 3);
		DynamicDBUtil.updateByHash(dbKey, sql, data);
		
		sql = "SELECT * FROM GWYUTEST003 WHERE id = :id";data = new HashMap<String, Object>();
		data.put("id", 1);
		Map<String, Object> aaa = (Map<String, Object>) DynamicDBUtil.findOneByHash(dbKey, sql, data);
		System.out.println(aaa.get("sname"));
		
		sql = "SELECT * FROM GWYUTEST003 WHERE id >= '${id}'";data = new HashMap<String, Object>();
		data.put("id", 2);
		List<GwyuTest> bbb = DynamicDBUtil.findListEntrysByHash(dbKey, sql, GwyuTest.class, data);
		System.out.println(bbb);
	}

}
