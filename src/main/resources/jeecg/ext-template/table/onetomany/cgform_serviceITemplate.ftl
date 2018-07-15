<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.service;
import ${bussiPackage}.${entityPackage}.entity.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.${sub.entityPackage}.entity.${sub.entityName}Entity;
</#list>
<#else>
package ${bussiPackage}.service.${entityPackage};
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.entity.${sub.entityPackage}.${sub.entityName}Entity;
</#list>
</#if>

import java.util.List;
import org.jeecgframework.core.common.service.CommonService;
import java.io.Serializable;

public interface ${entityName}ServiceI extends CommonService{
	<#-- update--begin--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
 	public void delete(${entityName}Entity entity) throws Exception;
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>) throws Exception;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>) throws Exception;
	        
	/**
	 * 删除一对多
	 * 
	 */
	public void delMain (${entityName}Entity ${entityName?uncap_first}) throws Exception;
	<#-- update--end--author:jiaqiankun date:20180711 for：TASK #2899 【代码生成器 - 少卿】新版一对多模板没有写java增强逻辑 -->
}
