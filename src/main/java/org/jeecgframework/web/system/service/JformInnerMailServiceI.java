package org.jeecgframework.web.system.service;
import java.io.Serializable;
import java.util.Map;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.FileUtils;
import org.jeecgframework.web.demo.entity.test.TFinanceFilesEntity;
import org.jeecgframework.web.system.pojo.base.JformInnerMailAttach;
import org.jeecgframework.web.system.pojo.base.JformInnerMailEntity;

public interface JformInnerMailServiceI extends CommonService{
	
	/**
	 * 附件删除
	 */
	public void deleteFile(JformInnerMailAttach file);
	
 	public <T> void delete(T entity);
 	
 	public <T> Serializable save(T entity);
 	
 	public <T> void saveOrUpdate(T entity);
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JformInnerMailEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JformInnerMailEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JformInnerMailEntity t);
}
