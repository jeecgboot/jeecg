package org.jeecgframework.poi.excel.annotation;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * excel 导出是用于标记id的
 * @author jueyue
 *
 */
@Retention(RetentionPolicy.RUNTIME)   
@Target({ java.lang.annotation.ElementType.TYPE })
public @interface ExcelTarget {
	/**
	 *定义excel导出ID 来限定导出字段 
	 */
	public String id();
}

