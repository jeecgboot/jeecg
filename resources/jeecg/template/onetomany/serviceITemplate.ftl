package ${bussiPackage}.service.${entityPackage};

import java.util.List;
import org.jeecgframework.core.common.service.CommonService;
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.entity.${sub.entityPackage}.${sub.entityName}Entity;
</#list>

public interface ${entityName}ServiceI extends CommonService{

	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>);
	public void delMain (${entityName}Entity ${entityName?uncap_first});
}
