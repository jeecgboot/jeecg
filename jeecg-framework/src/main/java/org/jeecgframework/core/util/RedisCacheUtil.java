package org.jeecgframework.core.util;

import java.util.Set;

import org.springframework.data.redis.core.RedisTemplate;

/**
 * radis 缓存工具类
 * @author Yandong
 *
 */
@SuppressWarnings("unchecked")
public class RedisCacheUtil {

	private static RedisTemplate redisTemplate;

	static{
		redisTemplate=(RedisTemplate) ApplicationContextUtil.getContext().getBean("redisTemplate");
	}

	public static Object get(String cacheName, Object key) {
		return redisTemplate.boundValueOps(cacheName+"_"+key).get();
	}

	public static void put(String cacheName, Object key, Object value) {
		redisTemplate.boundValueOps(cacheName+"_"+key).set(value);
	}

	public static boolean remove(String cacheName, Object key) {
		if(redisTemplate.hasKey(cacheName+"_"+key)){
			redisTemplate.delete(cacheName+"_"+key);
			return true;
		}
		return false;
	}

	/**
	 * 清空系统redis cache缓存
	 */
	public static void clean() {
		Set dictKeys = redisTemplate.keys(EhcacheUtil.DictCache+"*");
		Set eternalKeys = redisTemplate.keys(EhcacheUtil.EternalCache+"*");
		Set tagKeys = redisTemplate.keys(EhcacheUtil.TagCache+"*");
		if(dictKeys!=null && !dictKeys.isEmpty())redisTemplate.delete(dictKeys);
		if(eternalKeys!=null && !eternalKeys.isEmpty())redisTemplate.delete(eternalKeys);
		if(tagKeys!=null && !tagKeys.isEmpty())redisTemplate.delete(tagKeys);
	}
	
}
