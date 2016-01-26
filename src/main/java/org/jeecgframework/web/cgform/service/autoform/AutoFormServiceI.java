package org.jeecgframework.web.cgform.service.autoform;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormEntity;
import org.jeecgframework.web.cgform.exception.BusinessException;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface AutoFormServiceI extends CommonService{
	
 	public <T> void delete(T entity);
 	
 	public <T> Serializable save(T entity);
 	
 	public <T> void saveOrUpdate(T entity);
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(AutoFormEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(AutoFormEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(AutoFormEntity t);
 	
 	/**
 	 * 表单添加提交数据
 	 * @param formName 自定义表单名称
 	 * @param dataMap  表单数据
 	 * @throws BusinessException
 	 */
 	public void doAddTable(String formName,Map<String,Map<String,Object>> dataMap) throws BusinessException ;
 	
 	/**
 	 * 表单更新提交数据
 	 * @param formName 自定义表单名称
 	 * @param dataMap  表单数据
 	 * @throws BusinessException
 	 */
 	public String doUpdateTable(String formName,Map<String,Map<String,Object>> dataMap,Map<String, List<Map<String, Object>>> oldDataMap) throws BusinessException ;
}
