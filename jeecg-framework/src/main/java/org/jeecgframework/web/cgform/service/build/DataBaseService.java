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
	
	public int insertTable(String tableName, Map<String, Object> data);
	
	public int updateTable(String tableName,Object id, Map<String, Object> data);
	
	public Map<String, Object>  findOneForJdbc(String tableName, String id);
	
	public Map<String, Object> insertTableMore(Map<String,List<Map<String,Object>>> mapMore,String mainTableName) throws BusinessException;
	
	public boolean updateTableMore(Map<String,List<Map<String,Object>>> mapMore,String mainTableName) throws BusinessException;
	
	/**
	 * sql业务增强
	 * 
	 */
	public void executeSqlExtend(String formId,String buttonCode,Map<String, Object> data);

	public Object getPkValue(String tableName);
}
