package org.jeecgframework.tag.core;

import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;
import org.jeecgframework.core.util.EhcacheUtil;
import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.engine.TempletContext;
import org.jeecgframework.web.system.controller.core.LoginController;
/**
 * add-by--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢---- --
 * @author yugw
 * Tag标签的父类，主要为做缓存使用
 */
public abstract class JeecgTag extends TagSupport {
	private Logger log = Logger.getLogger(LoginController.class);
	private static final long serialVersionUID = 1L;
	
	/**
	 * 获取缓存
	 * @return
	 */
	public StringBuffer getTagCache(){
		//EhcacheUtil.remove(EhcacheUtil.TagCache, toString());

		if(CgAutoListConstant.SYS_MODE_DEV.equalsIgnoreCase(TempletContext._sysMode)){
			return null;
		}

		
		//log.info("-----TagCache-----toString()-----"+toString());
		return (StringBuffer) EhcacheUtil.get(EhcacheUtil.TagCache, toString());
	}
	/**
	 * 存放缓存
	 * @param tagCache
	 */
	public void putTagCache(StringBuffer tagCache){
		EhcacheUtil.put(EhcacheUtil.TagCache, toString(), tagCache);
	}
}