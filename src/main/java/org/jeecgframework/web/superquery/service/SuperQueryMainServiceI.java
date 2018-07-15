package org.jeecgframework.web.superquery.service;
import org.jeecgframework.web.superquery.entity.SuperQueryFieldEntity;
import org.jeecgframework.web.superquery.entity.SuperQueryMainEntity;
import org.jeecgframework.web.superquery.entity.SuperQueryTableEntity;

import java.util.List;
import org.jeecgframework.core.common.service.CommonService;

public interface SuperQueryMainServiceI extends CommonService{
	
 	public <T> void delete(T entity);
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(SuperQueryMainEntity superQueryMain,
	        List<SuperQueryTableEntity> superQueryTableList,List<SuperQueryFieldEntity> superQueryFieldList) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(SuperQueryMainEntity superQueryMain,
	        List<SuperQueryTableEntity> superQueryTableList,List<SuperQueryFieldEntity> superQueryFieldList);
	public void delMain (SuperQueryMainEntity superQueryMain);
	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(SuperQueryMainEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(SuperQueryMainEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(SuperQueryMainEntity t);
}
