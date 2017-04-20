package org.jeecgframework.core.interceptors;

import java.lang.reflect.Array;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.jeecgframework.core.common.model.json.LogAnnotation;
import org.springframework.stereotype.Component;

/**
 * 日志拦截器
 * @author  张代浩
 *
 */
//@Component
//@Aspect
public class LogInterceptor {
	//@Before("execution(* com.renfang.controller.*.*(..))")
	public void beforeMethod(JoinPoint joinPoint) throws Exception {
		String temp = joinPoint.getStaticPart().toShortString();
		String longTemp = joinPoint.getStaticPart().toLongString();
		joinPoint.getStaticPart().toString();
		String classType = joinPoint.getTarget().getClass().getName();
		String methodName = temp.substring(10, temp.length() - 1);
		Class<?> className = Class.forName(classType);
		Class[] args = new Class[joinPoint.getArgs().length];
		String[] sArgs = (longTemp.substring(longTemp.lastIndexOf("(") + 1,
				longTemp.length() - 2)).split(",");
		for (int i = 0; i < args.length; i++) {
			if (sArgs[i].endsWith("String[]")) {
				args[i] = Array.newInstance(Class.forName("java.lang.String"),
						1).getClass();
			} else if (sArgs[i].endsWith("Long[]")) {
				args[i] = Array.newInstance(Class.forName("java.lang.Long"), 1)
						.getClass();
			} else if (sArgs[i].indexOf(".") == -1) {
				if (sArgs[i].equals("int")) {
					args[i] = int.class;
				} else if (sArgs[i].equals("char")) {
					args[i] = char.class;
				} else if (sArgs[i].equals("float")) {
					args[i] = float.class;
				} else if (sArgs[i].equals("long")) {
					args[i] = long.class;
				}
			} else {
				args[i] = Class.forName(sArgs[i]);
			}
		}
		Method method = className.getMethod(
				methodName.substring(methodName.indexOf(".") + 1,
						methodName.indexOf("(")), args);
		if (method.isAnnotationPresent(LogAnnotation.class)) {
			LogAnnotation logAnnotation = method
					.getAnnotation(LogAnnotation.class);
			String operateModelNm = logAnnotation.operateModelNm();
			String operateDescribe = logAnnotation.operateDescribe();
			String operateFuncNm = logAnnotation.operateFuncNm();

		}

	}
}