package org.jeecgframework.web.system.manager;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.EhcacheUtil;
import org.jeecgframework.web.system.pojo.base.Client;

/**
 * 对在线用户的管理
 * @author JueYue
 * @date 2013-9-28
 * @version 1.0
 */

public class ClientManager {
	private final String CACHENAME ="eternalCache";
	private final String OnlineClientsKey ="onLineClients";

	private static ClientManager instance = new ClientManager();
	
	private ClientManager(){
		
	}
	
	public static ClientManager getInstance(){
		return instance;
	}
	
	/**
	 * 向ehcache缓存中增加Client对象
	 * @author xugj
	 * */
	@SuppressWarnings("unchecked")
	private boolean addClientToCachedMap(String sessionId,Client client ){
		HashMap<String, Client> onLineClients ;
		if(EhcacheUtil.get(CACHENAME, OnlineClientsKey)==null){
			onLineClients = new HashMap<String, Client>();
		}
		else{
			onLineClients =(HashMap<String, Client>) EhcacheUtil.get(CACHENAME,OnlineClientsKey);
		}
		onLineClients.put(sessionId, client);
		EhcacheUtil.put(CACHENAME,OnlineClientsKey, onLineClients);
		return true;
	}
	
	/**
	 * 从缓存中的Client集合中删除 Client对象
	 * */
	@SuppressWarnings("unchecked")
	private boolean removeClientFromCachedMap(String sessionId){
		HashMap<String, Client> onLineClients ;
		if(EhcacheUtil.get(CACHENAME, OnlineClientsKey)!=null){
			onLineClients =(HashMap<String, Client>) EhcacheUtil.get(CACHENAME,OnlineClientsKey);
			onLineClients.remove(sessionId);
			EhcacheUtil.put(CACHENAME, OnlineClientsKey, onLineClients);
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
		ContextHolderUtils.getSession().setAttribute(sessionId, client);
		if(client !=null){
			Client ret = new Client();
			ret.setIp(client.getIp());
			ret.setLogindatetime(client.getLogindatetime());
			ret.setUser(client.getUser());
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
		if(EhcacheUtil.get(CACHENAME,OnlineClientsKey)!=null){
			HashMap<String, Client> onLineClients = (HashMap<String, Client>) EhcacheUtil.get(CACHENAME,OnlineClientsKey);
			return onLineClients.values();
		}
		else
			return new ArrayList<Client>();
	}
}

