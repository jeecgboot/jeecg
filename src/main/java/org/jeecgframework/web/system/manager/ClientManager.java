package org.jeecgframework.web.system.manager;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.system.pojo.base.Client;


/**
 * 对在线用户的管理
 * @author JueYue
 * @date 2013-9-28
 * @version 1.0
 */
public class ClientManager {
	
	private static ClientManager instance = new ClientManager();
	
	private ClientManager(){
		
	}
	
	public static ClientManager getInstance(){
		return instance;
	}
    //private Map<String,Client> map = new HashMap<String, Client>();
	private ConcurrentHashMap<String,Client> map = new ConcurrentHashMap<String, Client>();
	/**
	 * 
	 * @param sessionId
	 * @param client
	 */
	public void addClinet(String sessionId,Client client){
		Client old=map.get(sessionId);
		if(old==null){
			map.putIfAbsent(sessionId, client);
		}else{
			map.replace(sessionId, old,client);
		}
	}
	/**
	 * sessionId
	 */
	public void removeClinet(String sessionId){
		map.remove(sessionId);
	}
	/**
	 * 
	 * @param sessionId
	 * @return
	 */
	public Client getClient(String sessionId){
		return StringUtil.isEmpty(sessionId)?null:map.get(sessionId);
	}
	/**
	 *
	 * @return
	 */
	public Client getClient(){
		return map.get(ContextHolderUtils.getSession().getId());
	}
	/**
	 * 
	 * @return
	 */
	public Collection<Client> getAllClient(){
		return map.values();
	}

}
