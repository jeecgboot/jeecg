package org.jeecgframework.core.util;

import java.util.List;
import java.util.Map;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Spring JDBC 实时数据库访问
 * 
 * @author chenguobin
 * @date 2014-09-05
 * @version 1.0
 */
public class DynamicDBUtil {
	private static final Logger logger = Logger.getLogger(DynamicDBUtil.class);
	
	private static BasicDataSource getDataSource(final DynamicDataSourceEntity dynamicSourceEntity) {
		BasicDataSource dataSource = new BasicDataSource();
		
		String driverClassName = dynamicSourceEntity.getDriverClass();
		String url = dynamicSourceEntity.getUrl();
		String dbUser = dynamicSourceEntity.getDbUser();

		//设置数据源的时候，要重新解密
		//String dbPassword = dynamicSourceEntity.getDbPassword();
		String dbPassword  = PasswordUtil.decrypt(dynamicSourceEntity.getDbPassword(), dynamicSourceEntity.getDbUser(), PasswordUtil.getStaticSalt());//解密字符串；

		
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(url);
		dataSource.setUsername(dbUser);
		dataSource.setPassword(dbPassword);
		return dataSource;
	}
	
	private static JdbcTemplate getJdbcTemplate(String dbKey) {
		DynamicDataSourceEntity dynamicSourceEntity = ResourceUtil.dynamicDataSourceMap.get(dbKey);
		
		BasicDataSource dataSource = getDataSource(dynamicSourceEntity);
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource); 
		return jdbcTemplate;
	}
	
    /**
	 * 该方法只是方便用于main方法测试调用
	 * @param dynamicSourceEntity
	 * @return JdbcTemplate
	 */
	private static JdbcTemplate getJdbcTemplate(DynamicDataSourceEntity dynamicSourceEntity) {
		BasicDataSource dataSource = getDataSource(dynamicSourceEntity);
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource); 
		return jdbcTemplate;
	}
	
	/**
     * Executes the SQL statement in this <code>PreparedStatement</code> object,
     * which must be an SQL Data Manipulation Language (DML) statement, such as <code>INSERT</code>, <code>UPDATE</code> or
     * <code>DELETE</code>; or an SQL statement that returns nothing,
     * such as a DDL statement.
     */
	public static int update(final String dbKey, String sql, Object... param)
	{
		int effectCount = 0;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);

		if (ArrayUtils.isEmpty(param)) {
			effectCount = jdbcTemplate.update(sql);
		} else {
			effectCount = jdbcTemplate.update(sql, param);
		}
		
		return effectCount;
	}
	
	public static Object findOne(final String dbKey, String sql, Object... param) {
		List<Map<String, Object>> list;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);
		
		if (ArrayUtils.isEmpty(param)) {
			list = jdbcTemplate.queryForList(sql);
		} else {
			list = jdbcTemplate.queryForList(sql, param);
		}
		
		if(ListUtils.isNullOrEmpty(list))
		{
			logger.error("Except one, but not find actually");
		}
		
		if(list.size() > 1)
		{
			logger.error("Except one, but more than one actually");
		}
		
		return list.get(0);
	}
	
	public static List<Map<String, Object>> findList(final String dbKey, String sql, Object... param) {
		List<Map<String, Object>> list;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);
		
		if (ArrayUtils.isEmpty(param)) {
			list = jdbcTemplate.queryForList(sql);
		} else {
			list = jdbcTemplate.queryForList(sql, param);
		}
		return list;
	}

	public static <T> List<T> findList(final String dbKey, String sql, Class<T> clazz,Object... param) {
		List<T> list;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);
		
		if (ArrayUtils.isEmpty(param)) {
			list = jdbcTemplate.queryForList(sql,clazz);
		} else {
			list = jdbcTemplate.queryForList(sql,clazz,param);
		}
		return list;
	}

		
	public static void main(String[] args) {
		DynamicDataSourceEntity dynamicSourceEntity = new DynamicDataSourceEntity();
		
		String dbKey = "SAP_DB";
		String driverClassName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@10.10.0.59:1521:mid";
		String dbUser = "CRM";
		String dbPassword = "CRM2013";
		
		dynamicSourceEntity.setDbKey(dbKey);
		dynamicSourceEntity.setDriverClass(driverClassName);
		dynamicSourceEntity.setUrl(url);
		dynamicSourceEntity.setDbUser(dbUser);
		dynamicSourceEntity.setDbPassword(dbPassword);
		
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dynamicSourceEntity);
		
		String sql = "select ak.VKBUR, ak.KUNNR, ak.BSTNK, ak.VBELN, ak.MAHDT, ak.BSTDK from VBAK ak where ak.VKORG = '6002'";
		//List<Map<String, Object>> list = DynamicDBUtil.getList(jdbcTemplate, sql);
		//System.out.println(list.size());
	}
	
}
