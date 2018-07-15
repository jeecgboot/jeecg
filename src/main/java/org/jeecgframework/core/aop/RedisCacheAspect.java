package org.jeecgframework.core.aop;

import java.util.concurrent.TimeUnit;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.jeecgframework.core.annotation.Ehcache;
import org.springframework.data.redis.core.BoundValueOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

/**
 * redis缓存AOP
 * @author Yandong
 */
//@Component
//@Aspect
public class RedisCacheAspect {
	
	//TODO ?
	@Resource
	private RedisTemplate redisTemplate;

	@Pointcut("@annotation(org.jeecgframework.core.annotation.Ehcache)")
	public void simplePointcut() {}
	
	
	@Around("simplePointcut() && @annotation(ehcache)")
	public Object aroundLogCalls(ProceedingJoinPoint joinPoint,Ehcache ehcache)throws Throwable {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();

		String cacheKey ="";
		if(StringUtils.isNotBlank(ehcache.cacheName())){
			cacheKey=ehcache.cacheName();
		}else{
			cacheKey=getCacheKey(targetName, methodName, arguments);
		}
		
		Object result=null;
		BoundValueOperations<String,Object> valueOps = redisTemplate.boundValueOps(cacheKey);
		if(ehcache.eternal()){
			//永久缓存
			result = valueOps.get();
		}else{
			//临时缓存
			result = valueOps.get();
			valueOps.expire(20, TimeUnit.MINUTES);
		}

		if (result == null) {
			if ((arguments != null) && (arguments.length != 0)) {
				result = joinPoint.proceed(arguments);
			} else {
				result = joinPoint.proceed();
			}

			if(ehcache.eternal()){
				//永久缓存
				valueOps.set(result);
			}else{
				//临时缓存
				valueOps.set(result,20, TimeUnit.MINUTES);
			}
		}
		return result;
	}
	
	/**
	 * 获得cache key的方法
	 * cache key包括: 包名+类名+方法名
	 * 举例：com.co.cache.service.UserServiceImpl.getAllUser
	 */
	private String getCacheKey(String targetName, String methodName,Object[] arguments) {
		StringBuffer sb = new StringBuffer();
		sb.append(targetName).append(".").append(methodName);
		if ((arguments != null) && (arguments.length != 0)) {
			for (int i = 0; i < arguments.length; i++) {
				if (arguments[i] instanceof String[]) {
					String[] strArray = (String[]) arguments[i];
					sb.append(".");
					for (String str : strArray) {
						sb.append(str);
					}
				} else {
					sb.append(".").append(arguments[i]);
				}
			}
		}
		return sb.toString();
	}
}
