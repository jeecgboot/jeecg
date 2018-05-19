package org.jeecgframework.core.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.jeecgframework.core.enums.Permission;

/**
 *jeecg权限认证注解 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE,ElementType.METHOD})
@Documented
public @interface JAuth {
	String value() default "";
	Permission auth() default Permission.NORMAL;
}