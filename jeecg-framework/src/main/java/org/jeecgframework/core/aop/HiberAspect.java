package org.jeecgframework.core.aop;

import java.io.Serializable;
import java.util.Date;


import org.jeecgframework.web.system.pojo.base.TSUser;

import org.apache.log4j.Logger;
import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.springframework.stereotype.Component;

/**
 * Hiberate拦截器：实现创建人，创建时间，创建人名称自动注入;
 *                修改人,修改时间,修改人名自动注入;
 * @author  张代浩
 */
@Component
public class HiberAspect extends EmptyInterceptor {
	private static final Logger logger = Logger.getLogger(HiberAspect.class);
	private static final long serialVersionUID = 1L;



public boolean onSave(Object entity, Serializable id, Object[] state,
		String[] propertyNames, Type[] types) {
	TSUser currentUser = null;
	try {
		currentUser = ResourceUtil.getSessionUserName();
	} catch (RuntimeException e) {
		logger.warn("当前session为空,无法获取用户");
	}
	if(currentUser==null){
		return true;
	}
	try {
		//添加数据
		 for (int index=0;index<propertyNames.length;index++)
		 {
		     /*找到名为"创建时间"的属性*/
		     if ("createDate".equals(propertyNames[index]))
		     {
		         /*使用拦截器将对象的"创建时间"属性赋上值*/
		    	 if(oConvertUtils.isEmpty(state[index])){
		    		 state[index] = new Date();
		    	 }
		         continue;
		     }
		     /*找到名为"创建人"的属性*/
		     else if ("createBy".equals(propertyNames[index]))
		     {
		         /*使用拦截器将对象的"创建人"属性赋上值*/
		    	 if(oConvertUtils.isEmpty(state[index])){
		    		  state[index] = currentUser.getUserName();
		    	 }
		         continue;
		     }
		     /*找到名为"创建人名称"的属性*/
		     else if ("createName".equals(propertyNames[index]))
		     {
		         /*使用拦截器将对象的"创建人名称"属性赋上值*/
		    	 if(oConvertUtils.isEmpty(state[index])){
		    		 state[index] = currentUser.getRealName();
		    	 }
		         continue;
		     }
		 }
	} catch (RuntimeException e) {
		e.printStackTrace();
	}
	 return true;
}


public boolean onFlushDirty(Object entity, Serializable id,
		Object[] currentState, Object[] previousState,
		String[] propertyNames, Type[] types) {
	TSUser currentUser = null;
	try {
		currentUser = ResourceUtil.getSessionUserName();
	} catch (RuntimeException e1) {
		logger.warn("当前session为空,无法获取用户");
	}
	if(currentUser==null){
		return true;
	}
	//添加数据
     for (int index=0;index<propertyNames.length;index++)
     {
         /*找到名为"修改时间"的属性*/
         if ("updateDate".equals(propertyNames[index]))
         {
             /*使用拦截器将对象的"修改时间"属性赋上值*/
        	 currentState[index] = new Date();
             continue;
         }
         /*找到名为"修改人"的属性*/
         else if ("updateBy".equals(propertyNames[index]))
         {
             /*使用拦截器将对象的"修改人"属性赋上值*/
        	 currentState[index] = currentUser.getUserName();
        	 continue;
         }
         /*找到名为"修改人名称"的属性*/
         else if ("updateName".equals(propertyNames[index]))
         {
             /*使用拦截器将对象的"修改人名称"属性赋上值*/
        	 currentState[index] = currentUser.getRealName();
        	 continue;
         }
     }
	 return true;
}
}
