package org.jeecgframework.core.util;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
* @ClassName: ContextHolderUtils 
* @Description: TODO(上下文工具类) 
* @author  张代浩 
* @date 2012-12-15 下午11:27:39 
*
 */
public class ContextHolderUtils {
	/**
	 * SpringMvc下获取request
	 * 
	 * @return
	 */
	public static HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request;

	}

	/**
	 * SpringMvc下获取session
	 * 
	 * @return
	 */
	public static HttpSession getSession() {
		HttpServletRequest request = getRequest();
		String tempSessionId = request.getParameter("sessionId");
		HttpSession session = request.getSession();
		String sessionId = session.getId();
		if(StringUtil.isNotEmpty(tempSessionId) && !tempSessionId.equals(sessionId)){
			sessionId = tempSessionId;
			if(sessionMap.containsKey(sessionId)){
				session = sessionMap.get(sessionId);
			}
		}
		if(!sessionMap.containsKey(sessionId)){
			sessionMap.put(sessionId, session);
		}
		return session;
	}

	
	private static final Map<String, HttpSession> sessionMap = new HashMap<String, HttpSession>();
	
	public static HttpSession getSession(String sessionId){
		HttpSession session = sessionMap.get(sessionId);
		return session == null ? getSession() : session;
	}
	
	public static void removeSession(String sessionId){
		if(sessionMap.containsKey(sessionId)){
			sessionMap.remove(sessionId);
		}
	}

}
