package org.jeecgframework.core.annotation.config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)   
@Target(ElementType.METHOD)
/**
 * 菜单操作按钮注释标签
 * 系统启动自动加载菜单对应的操作权限
 * Method级别
 * @author  张代浩
 */
public @interface AutoMenuOperation {
	
	/**
	 * 操作名称
	 * @return
	 */
	public String name();
	/**
	 * 操作码
	 * @return
	 */
	public String code();
	
	/**
	 * 操作码类型
	 * @return
	 */
	public MenuCodeType codeType() default MenuCodeType.TAG;
	
	/**
	 * 图标
	 * @return
	 */
	public String icon() default "";
	/**
	 * 状态
	 * @return
	 */
	public int status() default 0;
}

