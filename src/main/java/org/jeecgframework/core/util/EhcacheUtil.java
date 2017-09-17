package org.jeecgframework.core.util;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

/**
 * ehcache 缓存工具类
 * 
 * cacheName在ehcache.xml中配置
 */
public class EhcacheUtil {

	//缓存NAME静态名称
	public static String DictCache = "dictCache";
	public static String EternalCache = "eternalCache";
	public static String TagCache = "tagCache";

	
	public static CacheManager manager = CacheManager.create();

	public static Object get(String cacheName, Object key) {
		Cache cache = manager.getCache(cacheName);
		if (cache != null) {
			Element element = cache.get(key);
			if (element != null) {
				return element.getObjectValue();
			}
		}
		return null;
	}

	public static void put(String cacheName, Object key, Object value) {
		Cache cache = manager.getCache(cacheName);
		if (cache != null) {
			cache.put(new Element(key, value));
		}
	}

	public static boolean remove(String cacheName, Object key) {
		Cache cache = manager.getCache(cacheName);
		if (cache != null) {
			return cache.remove(key);
		}
		return false;
	}
	
	/**
	 * 清空系统Ehcache缓存
	 */
	public static void clean() {
		Cache dictCache = manager.getCache(DictCache);
		Cache eternalCache = manager.getCache(EternalCache);
		Cache tagCache = manager.getCache(TagCache);
		if (dictCache != null) {
			dictCache.removeAll();
		}
		if (eternalCache != null) {
			eternalCache.removeAll();
		}
		if (tagCache != null) {
			tagCache.removeAll();
		}
	}

	public static void main(String[] args) {
		String key = "key";
		String value = "hello";
		EhcacheUtil.put("mytest", key, value);
		System.out.println(EhcacheUtil.get("mytest", key));
	}

}