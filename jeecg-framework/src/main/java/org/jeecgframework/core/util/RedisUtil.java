package org.jeecgframework.core.util;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.redis.core.BoundKeyOperations;
import org.springframework.data.redis.core.BoundListOperations;
import org.springframework.data.redis.core.BoundValueOperations;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * redis 缓存工具类
 * yugw 20170929 v2.0
 * redis数据库信息在redis.properties
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
public class RedisUtil {

	private static RedisTemplate redisTemplate;
	private static ConcurrentHashMap<String, BoundKeyOperations> boundKeyOperations = new ConcurrentHashMap<String, BoundKeyOperations>();

	/**
	 * 各个工具类的缓存区域，防止多区域之间因重名而报错
	 */
	private static String StringRKey = "StringR.";
	private static String ObjectRKey = "ObjectR.";
	private static String ListRKey = "ListR.";
	
	static {
		if (redisTemplate == null) {
			AbstractApplicationContext ac = new ClassPathXmlApplicationContext(
					"classpath:/redis.xml");
			redisTemplate = (RedisTemplate) ac.getBean("redisTemplate");
			ac.close();
		}
	}

	/**
	 * 专用于String的Redis处理工具类
	 * 所有工具类都包含getBound、setIfAbsent、set、delete、hasKey、get、getAndRemove等通用方法
	 * getBound用来缓存处理类，防止多次处理生成多个处理类；
	 * setIfAbsent 如果不存在就添加缓存
	 * set 添加或更改缓存内容
	 * delete 删除缓存
	 * hasKey 是否存在缓存
	 * get 获取缓存内容
	 * getAndRemove 获取缓存内容并删除缓存
	 */
	public static class StringR {
		/**getBound用来缓存处理类，防止多次处理生成多个处理类*/
		public static BoundValueOperations<String, String> getBound(String oldkey){
			cleanOperas();
			String key = StringRKey + oldkey;
			BoundKeyOperations boundKeyOperation = boundKeyOperations.get(key);
			if(boundKeyOperation == null){
				boundKeyOperation = redisTemplate.boundValueOps(key);
				boundKeyOperations.put(key, boundKeyOperation);
			}
			return (BoundValueOperations<String, String>)boundKeyOperation;
		}
		/**setIfAbsent 如果不存在就添加缓存*/
		public static Boolean setIfAbsent(String key, String value) {
			return setIfAbsent(key, value, 30L, TimeUnit.MINUTES);
		}
		/**setIfAbsent 如果不存在就添加缓存，并设置缓存超时时间*/
		public static Boolean setIfAbsent(String key, String value, long expire,
				TimeUnit timeUnit) {
			if(hasKey(key)){
				return false;
			}else{
				return set(key, value, expire, timeUnit);
			}
		}
		/**set 添加或更改缓存内容*/
		public static Boolean set(String key, String value) {
			return set(key, value, 30L, TimeUnit.MINUTES);
		}
		/**set 添加或更改缓存内容，并设置过期时间*/
		public static Boolean set(String key, String value, long expire,
				TimeUnit timeUnit) {
			Boolean rt = Boolean.FALSE;
			getBound(key).set(value);
			if (rt) {
				redisTemplate.expire(StringRKey + key, expire, timeUnit);
			}
			return rt;
		}
		/**get 获取缓存内容*/
		public static String get(String key) {
			return getBound(key).get();
		}
		/**getAndRemove 获取缓存内容并删除缓存*/
		public static String getAndRemove(String key) {
			String rt = get(key);
			delete(key);
			return rt;
		}
		/**delete 删除缓存*/
		public static void delete(String key) {
			RedisUtil.delete(StringRKey, key);
		}
		/**hasKey 是否存在缓存*/
		public static Boolean hasKey(String key) {
			return RedisUtil.hasKey(StringRKey, key);
		}
	}
	/**
	 * 专用于Object的Redis处理工具类
	 */
	public static class ObjectR {
		/**getBound用来缓存处理类，防止多次处理生成多个处理类*/
		public static BoundValueOperations getBound(String oldkey){
			cleanOperas();
			String key = ObjectRKey + oldkey;
			BoundKeyOperations boundKeyOperation = boundKeyOperations.get(key);
			if(boundKeyOperation == null){
				boundKeyOperation = redisTemplate.boundValueOps(key);
				boundKeyOperations.put(key, boundKeyOperation);
			}
			return (BoundValueOperations)boundKeyOperation;
		}
		/**setIfAbsent 如果不存在就添加缓存*/
		public static Boolean setIfAbsent(String key, Object value) {
			return setIfAbsent(key, value, 30L, TimeUnit.MINUTES);
		}
		/**setIfAbsent 如果不存在就添加缓存，并设置缓存超时时间*/
		public static Boolean setIfAbsent(String key, Object value, long expire,
				TimeUnit timeUnit) {
			if(hasKey(key)){
				return false;
			}else{
				return set(key, value, expire, timeUnit);
			}
		}
		/**set 添加或更改缓存内容*/
		public static Boolean set(String key, Object value) {
			return set(key, value, 30L, TimeUnit.MINUTES);
		}
		/**set 添加或更改缓存内容，并设置过期时间*/
		public static Boolean set(String key, Object value, long expire,
				TimeUnit timeUnit) {
			Boolean rt = Boolean.FALSE;
			if (value == null) {
				return rt;
			}
			getBound(key).set(value);
			if (rt) {
				redisTemplate.expire(ObjectRKey + key, expire, timeUnit);
			}
			return rt;
		}
		/**get 获取缓存内容*/
		public static Object get(String key) {
			return getBound(key).get();
		}
		/**getAndRemove 获取缓存内容并删除缓存*/
		public static Object getAndRemove(String key) {
			Object rt = get(key);
			delete(key);
			return rt;
		}
		/**delete 删除缓存*/
		public static void delete(String key) {
			RedisUtil.delete(ObjectRKey, key);
		}
		/**hasKey 是否存在缓存*/
		public static Boolean hasKey(String key) {
			return RedisUtil.hasKey(ObjectRKey, key);
		}
	}

	/**
	 * 专用于List的Redis处理工具类
	 * add 在list末添加新实体
	 * size 当前list的size
	 * get 当前list的第index个数据
	 * getAll 获取当前list数据
	 * getAllAndRemove 获取当前list数据，并删除缓存
	 */
	public static class ListR {
		/**getBound用来缓存处理类，防止多次处理生成多个处理类*/
		public static BoundListOperations getBound(String oldkey){
			cleanOperas();
			String key = ListRKey + oldkey;
			BoundKeyOperations boundKeyOperation = boundKeyOperations.get(key);
			if(boundKeyOperation == null){
				boundKeyOperation = redisTemplate.boundListOps(key);
				boundKeyOperations.put(key, boundKeyOperation);
			}
			return (BoundListOperations)boundKeyOperation;
		}
		/**setIfAbsent 如果不存在就添加缓存*/
		public static Boolean setIfAbsent(String key, List value) {
			return setIfAbsent(key, value, 30L, TimeUnit.MINUTES);
		}
		/**setIfAbsent 如果不存在就添加缓存，并设置缓存超时时间*/
		public static Boolean setIfAbsent(String key, List value, long expire,
				TimeUnit timeUnit) {
			if(hasKey(key)){
				return false;
			}else{
				return set(key, value, expire, timeUnit);
			}
		}
		/**set 添加或更改缓存内容*/
		public static Boolean set(String key, List value) {
			return set(key, value, 30L, TimeUnit.MINUTES);
		}
		/**set 添加或更改缓存内容，并设置过期时间*/
		public static Boolean set(String key, List value, long expire,
				TimeUnit timeUnit) {
			Boolean rt = Boolean.FALSE;
			if (value == null || value.size() <= 0) {
				return rt;
			}
			BoundListOperations boundListOperations = getBound(key);
			for(Object obj : value){
				boundListOperations.rightPush(obj);
			}
			if (rt) {
				redisTemplate.expire(ListRKey + key, expire, timeUnit);
			}
			return rt;
		}
		/**add 在list末添加新实体e*/
		public static Boolean add(String key, Object value) {
			return add(key, value, 30L, TimeUnit.MINUTES);
		}
		/**add 在list末添加新实体，并设置过期时间*/
		public static Boolean add(String key, Object value, long expire,
				TimeUnit timeUnit) {
			Boolean rt = Boolean.FALSE;
			if (value == null) {
				return rt;
			}
			getBound(key).rightPush(value);
			if (rt) {
				redisTemplate.expire(ListRKey + key, expire, timeUnit);
			}
			return rt;
		}
		/**size 当前list的size*/
		public static Long size(String key) {
			return getBound(key).size();
		}
		/**get 当前list的第index个数据*/
		public static Object get(String key, long index) {
			return getBound(key).index(index);
		}
		/**getAll 获取当前list数据*/
		public static ArrayList getAll(String key) {
			if(!hasKey(key)){
				return null;
			}
			List<String> list = getBound(key).range(0, size(key) - 1);
			ArrayList result = new ArrayList();
			for(Object single : list){
				result.add(single);
			}
			return result;
		}
		/**getAllAndRemove 获取当前list数据，并删除缓存*/
		public static ArrayList getAllAndRemove(String key) {
			ArrayList rt = getAll(key);
			delete(key);
			return rt;
		}
		/**delete 删除缓存*/
		public static void delete(String key) {
			RedisUtil.delete(ListRKey, key);
		}
		/**hasKey 是否存在缓存*/
		public static Boolean hasKey(String key) {
			return RedisUtil.hasKey(ListRKey, key);
		}
	}
	
	private static Long lastGet;
	/**清理boundKeyOperations*/
	public static void cleanOperas(){
		if(lastGet == null){
			lastGet = System.currentTimeMillis();
			return;
		}
		//每过20分钟清理一次，防止无效Opera占用内存
		if(System.currentTimeMillis() - lastGet > 20*60*1000){
			boundKeyOperations  = new ConcurrentHashMap<String, BoundKeyOperations>();
		}
	}

	/**
	 * 所有删除方法的入口
	 * @param area 缓存区域
	 * @param key
	 */
	public static void delete(String area, String key) {
		redisTemplate.delete(area + key);
	}

	/**
	 * 所有hasKey的入口
	 * @param area 缓存区域
	 * @param key
	 */
	public static Boolean hasKey(String area, String key) {
		return redisTemplate.hasKey(area + key);
	}
	/**
	 * 清理所有redis缓存
	 */
	public static void cleanAll(){
		redisTemplate.getConnectionFactory().getConnection().flushAll();
	}
}