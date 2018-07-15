<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.service;
import ${bussiPackage}.${entityPackage}.entity.${entityName}Entity;
<#else>
package ${bussiPackage}.service.${entityPackage};
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
</#if>
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface ${entityName}ServiceI extends CommonService{
	
 	public void delete(${entityName}Entity entity) throws Exception;
 	
 	public Serializable save(${entityName}Entity entity) throws Exception;
 	
 	public void saveOrUpdate(${entityName}Entity entity) throws Exception;
 	
	<#list buttons as btn>
 	<#if btn.optType=='action'>
 	/**
	 * 自定义按钮-[${btn.buttonName}]业务处理
	 * @param id
	 * @return
	 */
	 public void do${btn.buttonCode?cap_first}Bus(${entityName}Entity t) throws Exception;
 	</#if>
 	</#list> 
}
