package org.jeecgframework.core.util;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.minidao.util.FreemarkerParseFactory;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

/**
 * Spring JDBC 实时数据库访问
 * 
 * @author chenguobin
 * @date 2014-09-05
 * @version 1.0
 */
public class DynamicDBUtil {
	private static final Logger logger = Logger.getLogger(DynamicDBUtil.class);
	/**
	 * 多数据连接池
	 */
	private static Map<String,BasicDataSource> dbSources = new HashMap<String,BasicDataSource>();
	
	/**
	 * 获取数据源【最底层方法，不要随便调用】
	 * @param dynamicSourceEntity
	 * @return
	 */
	@Deprecated
	private static BasicDataSource getJdbcDataSource(final DynamicDataSourceEntity dynamicSourceEntity) {
		BasicDataSource dataSource = new BasicDataSource();
		
		String driverClassName = dynamicSourceEntity.getDriverClass();
		String url = dynamicSourceEntity.getUrl();
		String dbUser = dynamicSourceEntity.getDbUser();
//	      update-start--Author:chenjin  Date:20160712 for：多数据源目前数据库密码是明文，采用加密方式存储
		//设置数据源的时候，要重新解密
		//String dbPassword = dynamicSourceEntity.getDbPassword();
		String dbPassword  = PasswordUtil.decrypt(dynamicSourceEntity.getDbPassword(), dynamicSourceEntity.getDbUser(), PasswordUtil.getStaticSalt());//解密字符串；
		
//	      update-end--Author:chenjin  Date:20160712 for：多数据源目前数据库密码是明文，采用加密方式存储
		
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(url);
		dataSource.setUsername(dbUser);
		dataSource.setPassword(dbPassword);
		return dataSource;
	}
	
	/**
	 * 通过dbkey,获取数据源
	 * @param dbKey
	 * @return
	 */
	public static BasicDataSource getDbSourceBydbKey(final String dbKey) {
		//获取多数据源配置
		DynamicDataSourceEntity dynamicSourceEntity = ResourceUtil.dynamicDataSourceMap.get(dbKey);
		//先判断缓存中是否存在数据库链接
		BasicDataSource cacheDbSource = dbSources.get(dbKey);
		if(cacheDbSource!=null && !cacheDbSource.isClosed()){
			return cacheDbSource;
		}else{
			BasicDataSource dataSource = getJdbcDataSource(dynamicSourceEntity);
			dbSources.put(dbKey, dataSource);
			return dataSource;
		}
	}
	
	/**
	 * 关闭数据库连接池
	 *  @param dbKey
	 * @return 
	 * @return
	 */
	public static void closeDBkey(final String dbKey){
		BasicDataSource dataSource = getDbSourceBydbKey(dbKey);
		try {
			if(dataSource!=null && !dataSource.isClosed()){
				dataSource.getConnection().commit();
				dataSource.getConnection().close();
				dataSource.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	private static JdbcTemplate getJdbcTemplate(String dbKey) {
		BasicDataSource dataSource = getDbSourceBydbKey(dbKey);
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
	
	//add-begin--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	/**
	 * 支持miniDao语法操作的Update
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param data sql语法中需要判断的数据及sql拼接注入中需要的数据
	 * @return
	 */
	public static int updateByHash(final String dbKey, String sql, HashMap<String, Object> data){
		int effectCount = 0;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);
		//根据模板获取sql
		sql = FreemarkerParseFactory.parseTemplateContent(sql, data);
		NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(jdbcTemplate.getDataSource());
		effectCount = namedParameterJdbcTemplate.update(sql, data);
		return effectCount;
	}
	//add-end--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	
	public static Object findOne(final String dbKey, String sql, Object... param) {
		List<Map<String, Object>> list;
		//update-begin--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
		list = findList(dbKey, sql, param);
		//update-end--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
		
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
	//add-begin--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	/**
	 * 支持miniDao语法操作的查询 返回HashMap
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param data sql语法中需要判断的数据及sql拼接注入中需要的数据
	 * @return
	 */
	public static Object findOneByHash(final String dbKey, String sql, HashMap<String, Object> data){
		List<Map<String, Object>> list;
		list = findListByHash(dbKey, sql, data);
		if(ListUtils.isNullOrEmpty(list)){
			logger.error("Except one, but not find actually");
		}
		if(list.size() > 1){
			logger.error("Except one, but more than one actually");
		}
		return list.get(0);
	}
	//add-end--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	//add-begin--Author:yugwu  Date:20170810 for:返回单个实例而非hashMap----
	/**
	 * 直接sql查询 根据clazz返回单个实例
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句
	 * @param clazz 返回实例的Class
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> Object findOne(final String dbKey, String sql, Class<T> clazz, Object... param) {
		Map<String, Object> map = (Map<String, Object>) findOne(dbKey, sql, param);
		return ReflectHelper.setAll(clazz, map);
	}
	/**
	 * 支持miniDao语法操作的查询 返回单个实例
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param clazz 返回实例的Class
	 * @param data sql语法中需要判断的数据及sql拼接注入中需要的数据
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> Object findOneByHash(final String dbKey, String sql, Class<T> clazz, HashMap<String, Object> data) {
		Map<String, Object> map = (Map<String, Object>) findOneByHash(dbKey, sql, data);
		return ReflectHelper.setAll(clazz, map);
	}
	//add-begin--Author:yugwu  Date:20170810 for:返回单个实例而非hashMap----
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
	//add-begin--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	/**
	 * 支持miniDao语法操作的查询
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param data sql语法中需要判断的数据及sql拼接注入中需要的数据
	 * @return
	 */
	public static List<Map<String, Object>> findListByHash(final String dbKey, String sql, HashMap<String, Object> data){
		List<Map<String, Object>> list;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);
		//根据模板获取sql
		sql = FreemarkerParseFactory.parseTemplateContent(sql, data);
		NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(jdbcTemplate.getDataSource());
		list = namedParameterJdbcTemplate.queryForList(sql, data);
		return list;
	}
	//add-end--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	//add-begin--Author:luobaoli  Date:20150620 for：增加返回值为List的方法
	//此方法只能返回单列，不能返回实体类
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
	//add-end--Author:luobaoli  Date:20150620 for：增加返回值为List的方法
	//add-begin--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	/**
	 * 支持miniDao语法操作的查询 返回单列数据list
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param clazz 类型Long、String等
	 * @param data sql语法中需要判断的数据及sql拼接注入中需要的数据
	 * @return
	 */
	public static <T> List<T> findListByHash(final String dbKey, String sql, Class<T> clazz, HashMap<String, Object> data){
		List<T> list;
		JdbcTemplate jdbcTemplate = getJdbcTemplate(dbKey);
		//根据模板获取sql
		sql = FreemarkerParseFactory.parseTemplateContent(sql, data);
		NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(jdbcTemplate.getDataSource());
		list = namedParameterJdbcTemplate.queryForList(sql, data, clazz);
		return list;
	}
	/**
	 * 直接sql查询 返回实体类列表
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param clazz 返回实体类列表的class
	 * @param param sql拼接注入中需要的数据
	 * @return
	 */
	public static <T> List<T> findListEntrys(final String dbKey, String sql, Class<T> clazz, Object... param){
		List<Map<String,Object>> queryList = findList(dbKey, sql, param);
		return ReflectHelper.transList2Entrys(queryList, clazz);
	}
	/**
	 * 支持miniDao语法操作的查询 返回实体类列表
	 * @param dbKey 数据源标识
	 * @param sql 执行sql语句，sql支持minidao语法逻辑
	 * @param clazz 返回实体类列表的class
	 * @param data sql语法中需要判断的数据及sql拼接注入中需要的数据
	 * @return
	 */
	public static <T> List<T> findListEntrysByHash(final String dbKey, String sql, Class<T> clazz, HashMap<String, Object> data){
		List<Map<String,Object>> queryList = findListByHash(dbKey, sql, data);
		return ReflectHelper.transList2Entrys(queryList, clazz);
	}
	//add-end--Author:yugwu  Date:20170808 for:TASK #1827 【改造】多数据源，支持minidao语法sql----
	
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		DynamicDataSourceEntity dynamicSourceEntity = new DynamicDataSourceEntity();
		
		String dbKey = "SAP_DB";
		String driverClassName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jeecg";
		String dbUser = "root";
		String dbPassword = "root";
		
		dynamicSourceEntity.setDbKey(dbKey);
		dynamicSourceEntity.setDriverClass(driverClassName);
		dynamicSourceEntity.setUrl(url);
		dynamicSourceEntity.setDbUser(dbUser);
		dynamicSourceEntity.setDbPassword(dbPassword);
		
		ResourceUtil.dynamicDataSourceMap.put(dbKey, dynamicSourceEntity);
		
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
		
		//List<Map<String, Object>> list = DynamicDBUtil.getList(jdbcTemplate, sql);
		//System.out.println(list.size());
	}
	public static class GwyuTest{
		public GwyuTest(){}
		private long id;
		private String sname;
		private long nlevel;
		public long getId() {
			return id;
		}
		public void setId(long id) {
			this.id = id;
		}
		public String getSname() {
			return sname;
		}
		public void setSname(String sname) {
			this.sname = sname;
		}
		public long getNlevel() {
			return nlevel;
		}
		public void setNlevel(long nlevel) {
			this.nlevel = nlevel;
		}
		
	}
	
}
