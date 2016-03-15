package org.jeecgframework.web.cgdynamgraph.service.core;

import java.util.List;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigHeadEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigItemEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigParamEntity;

public interface CgDynamGraphConfigHeadServiceI extends CommonService{
	
 	public <T> void delete(T entity);
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,
	        List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList,List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,
	        List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList,List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList);
	public void delMain (CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead);
	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(CgDynamGraphConfigHeadEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(CgDynamGraphConfigHeadEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(CgDynamGraphConfigHeadEntity t);
}
