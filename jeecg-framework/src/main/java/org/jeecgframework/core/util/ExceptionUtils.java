package org.jeecgframework.core.util;

import org.jeecgframework.core.common.exception.BusinessException;

public class ExceptionUtils {

	private ExceptionUtils(){
		//no instance
	}
	
	
	/**
	 * 如果目标为空则抛出异常
	 * @author 苍鹰
	 * 2009-11-3
	 * @param target
	 * @param errorMessage
	 */
	public static void throwIfNull(Object target,String errorMessage){
		if(target==null){
			throw new BusinessException(errorMessage);
		}
	}
	
	/**
	 * 如果目标为空则抛出异常
	 * 本方法空指针安全
	 * 2009-11-3
	 * @param target
	 * @param errorMessage
	 */
	public static void throwIfEmpty(String target,String errorMessage)
	{
		if(target==null || target.equals("")){
			throw new BusinessException(errorMessage);
		}
	}
	
}
