package org.jeecgframework.web.cgform.service.template;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.cgform.entity.template.CgformTemplateEntity;

import java.io.Serializable;
import java.util.List;

public interface CgformTemplateServiceI extends CommonService{
	
 	public <T> void delete(T entity);
 	
 	public <T> Serializable save(T entity);
 	
 	public <T> void saveOrUpdate(T entity);
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param
	 * @return
	 */
 	public boolean doAddSql(CgformTemplateEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param
	 * @return
	 */
 	public boolean doUpdateSql(CgformTemplateEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param
	 * @return
	 */
 	public boolean doDelSql(CgformTemplateEntity t);

	/**
	 * 通过编码查询模板信息
	 * @param code
	 * @return
	 */
	CgformTemplateEntity findByCode(String code);

	/**
	 * 通过风格类型查询
	 * @param type
	 * @return
	 */
	List<CgformTemplateEntity> getTemplateListByType(String type);
}
