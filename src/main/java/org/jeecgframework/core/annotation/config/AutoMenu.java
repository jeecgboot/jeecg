package org.jeecgframework.core.annotation.config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)   
@Target(ElementType.TYPE)
/**
 * 菜单注释标签
 * 系统启动自动加载菜单配置
 * Class级别
 * @author  张代浩
 */
public @interface AutoMenu {
	
	/**
	 * 菜单名称
	 * @return
	 */
	public String name();
	/**
	 * 等级
	 * @return
	 */
	public String level() default "0";
	/**
	 * 菜单地址
	 * @return
	 */
	public String url();
	
	/**
	 * 图标
	 * @return
	 */
	public String icon() default "402880e740ec1fd70140ec2064ec0002";
	/**
	 * 顺序
	 * @return
	 */
	public int order() default 0;
}


