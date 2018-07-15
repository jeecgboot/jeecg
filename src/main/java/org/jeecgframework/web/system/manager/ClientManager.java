package org.jeecgframework.web.system.manager;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.web.system.pojo.base.Client;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.CacheServiceI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * 对在线用户的管理
 * @author JueYue
 * @date 2013-9-28
 * @version 1.0
 */
@Service("clientManager")
public class ClientManager {
	private static final Logger log = LoggerFactory.getLogger(ClientManager.class);
	
	/**国际化缓存key*/
	private final static String ONLINE_CLIENTS_CACHE_KEY ="online_client_users";
	@Resource
	private  CacheServiceI cacheService;
	
	/**
	 * 向ehcache缓存中增加Client对象
	 * @author xugj
	 * */
	@SuppressWarnings("unchecked")
	private boolean addClientToCachedMap(String sessionId,Client client){
		HashMap<String, Client> onLineClients ;
		if(cacheService.get(CacheServiceI.FOREVER_CACHE, ONLINE_CLIENTS_CACHE_KEY)==null){
			onLineClients = new HashMap<String, Client>();
		}
		else{
			onLineClients =(HashMap<String, Client>) cacheService.get(CacheServiceI.FOREVER_CACHE,ONLINE_CLIENTS_CACHE_KEY);
		}
		onLineClients.put(sessionId, client);
		cacheService.put(CacheServiceI.FOREVER_CACHE,ONLINE_CLIENTS_CACHE_KEY, onLineClients);
		return true;
	}
	
	/**
	 * 从缓存中的Client集合中删除 Client对象
	 * */
	@SuppressWarnings("unchecked")
	private boolean removeClientFromCachedMap(String sessionId){
		HashMap<String, Client> onLineClients ;
		if(cacheService.get(CacheServiceI.FOREVER_CACHE, ONLINE_CLIENTS_CACHE_KEY)!=null){
			onLineClients =(HashMap<String, Client>) cacheService.get(CacheServiceI.FOREVER_CACHE,ONLINE_CLIENTS_CACHE_KEY);
			onLineClients.remove(sessionId);
			cacheService.put(CacheServiceI.FOREVER_CACHE, ONLINE_CLIENTS_CACHE_KEY, onLineClients);
			return true;
		}
		else{
			return false;
		}
	}
	
	/**
	 * 用户登录，向session中增加用户信息
	 * @param sessionId
	 * @param client
	 */
	public void addClinet(String sessionId,Client client){
		//当前session会话，保存登录用户信息
		ContextHolderUtils.getSession().setAttribute(sessionId, client);
		
		//保存在线用户信息列表
		if(client !=null && client.getUser()!=null){
			Client ret = new Client();
			ret.setIp(client.getIp());
			ret.setLogindatetime(client.getLogindatetime());
			//在线用户列表缓存，只保留几个字段显示即可，其他菜单权限内容不需要，降低内存占用
			TSUser t = new TSUser();
			t.setUserName(client.getUser().getUserName());
			t.setRealName(client.getUser().getRealName());
			ret.setUser(t);
			addClientToCachedMap(sessionId,ret);
		}
	}
	/**
	 * 用户退出登录 从Session中删除用户信息
	 * sessionId
	 */
	public void removeClinet(String sessionId){
		try {
			ContextHolderUtils.removeSession(sessionId);
		} catch (Exception e) {}
		
		try {
			HttpSession session = ContextHolderUtils.getSession();
			session.removeAttribute(sessionId);
		} catch (Exception e) {}
		//从在线用户列表移除用户
		removeClientFromCachedMap(sessionId);
	}
	
	/**
	 * 根据sessionId 得到Client 对象
	 * @param sessionId
	 */
	public Client getClient(String sessionId){
		if(!StringUtils.isEmpty(sessionId)&&ContextHolderUtils.getSession().getAttribute(sessionId)!=null){
			return (Client)ContextHolderUtils.getSession().getAttribute(sessionId);
		}
		else{
			return null;
		}
	}
	
	/**
	 * 得到Client 对象
	 */
	public Client getClient(){
		String sessionId = ContextHolderUtils.getSession().getId();
		if(!StringUtils.isEmpty(sessionId)&&ContextHolderUtils.getSession().getAttribute(sessionId)!=null){
			return (Client)ContextHolderUtils.getSession().getAttribute(sessionId);
		}
		else{
			return null;
		}
	}
	
	/**
	 * 得到所有在线用户
	 */
	@SuppressWarnings("unchecked")
	public Collection<Client> getAllClient(){
		if(cacheService.get(CacheServiceI.FOREVER_CACHE,ONLINE_CLIENTS_CACHE_KEY)!=null){
			HashMap<String, Client> onLineClients = (HashMap<String, Client>) cacheService.get(CacheServiceI.FOREVER_CACHE,ONLINE_CLIENTS_CACHE_KEY);
			return onLineClients.values();
		}
		else
			return new ArrayList<Client>();
	}

	public static ClientManager getInstance() {
		ClientManager clientManager = ApplicationContextUtil.getContext().getBean(ClientManager.class);
		log.debug("  ------------获取工具类------------clientManager------------------");
		return clientManager;
	}
}
