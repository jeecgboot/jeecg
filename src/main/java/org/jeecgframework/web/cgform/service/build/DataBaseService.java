package org.jeecgframework.web.cgform.service.build;

import java.util.List;
import java.util.Map;

import org.jeecgframework.web.cgform.exception.BusinessException;

/**
 * 
 * @author  张代浩
 *
 */
public interface DataBaseService {
	
	//update-start--Author:luobaoli  Date:20150615 for： 调整接口，抛出异常
	public void insertTable(String tableName, Map<String, Object> data) throws BusinessException ;
	//update-end--Author:luobaoli  Date:20150615 for： 调整接口，抛出异常
	
	//update-start--Author:luobaoli  Date:20150630 for： 调整接口，抛出异常
	public int updateTable(String tableName,Object id, Map<String, Object> data) throws BusinessException ;
	//update-end--Author:luobaoli  Date:20150630 for： 调整接口，抛出异常
	
	public Map<String, Object>  findOneForJdbc(String tableName, String id);
	
	public Map<String, Object> insertTableMore(Map<String,List<Map<String,Object>>> mapMore,String mainTableName) throws BusinessException;
	
	public boolean updateTableMore(Map<String,List<Map<String,Object>>> mapMore,String mainTableName) throws BusinessException;
	
	/**
	 * sql业务增强
	 * 
	 */
	public void executeSqlExtend(String formId,String buttonCode,Map<String, Object> data);

	public Object getPkValue(String tableName);

	//update-start--Author:luobaoli  Date:20150630 for：增加JAVA业务增强功能
	/**
	 * java业务增强
	 * @param formId
	 * @param buttonCode
	 * @param data
	 */
	public void executeJavaExtend(String formId, String buttonCode,Map<String, Object> data) throws BusinessException;
	//update-end--Author:luobaoli  Date:20150630 for：增加JAVA业务增强功能
}
