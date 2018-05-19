package org.jeecgframework.web.graphreport.service.core;

import java.util.List;
import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportHeadEntity;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportItemEntity;

import java.io.Serializable;

public interface JformGraphreportHeadServiceI extends CommonService{
	
 	public <T> void delete(T entity);
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(JformGraphreportHeadEntity jformGraphreportHead,
						List<JformGraphreportItemEntity> jformGraphreportItemList) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(JformGraphreportHeadEntity jformGraphreportHead,
						   List<JformGraphreportItemEntity> jformGraphreportItemList);
	public void delMain(JformGraphreportHeadEntity jformGraphreportHead);
	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JformGraphreportHeadEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JformGraphreportHeadEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JformGraphreportHeadEntity t);
}
