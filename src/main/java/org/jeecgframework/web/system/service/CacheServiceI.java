package org.jeecgframework.web.system.service;

/**
 * 平台缓存工具类
 * @author qinfeng
 *
 */
public interface CacheServiceI {
	/**
	 * 类注解&系统缓存[临时缓存]
	 */
	public static String SYSTEM_BASE_CACHE = "systemBaseCache";
	/**
	 * UI标签[临时缓存]
	 */
	public static String TAG_CACHE = "tagCache";
	/**
	 * 字典\国际化\在线用户列表 [永久缓存]
	 */
	public static String FOREVER_CACHE = "foreverCache";
	/**
	 * 登录用户访问权限缓存[临时缓存]
	 */
	public static String SYS_AUTH_CACHE = "sysAuthCache";
	
	
	/**
	 * 获取缓存
	 * @param cacheName
	 * @param key
	 * @return
	 */
	public Object get(String cacheName, Object key);
	/**
	 * 设置缓存
	 * @param cacheName
	 * @param key
	 * @param value
	 */
	public void put(String cacheName, Object key, Object value);
	/**
	 * 移除缓存
	 * @param cacheName
	 * @param key
	 * @return
	 */
	public boolean remove(String cacheName, Object key);
	/**
	 * 清空所有缓存
	 */
	public void clean();
	
	/**
	 * 清空缓存
	 */
	public void clean(String cacheName);
}
