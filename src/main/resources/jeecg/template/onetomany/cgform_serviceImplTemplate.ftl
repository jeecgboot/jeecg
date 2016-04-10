<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.service.impl;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.${entityPackage}.entity.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.${sub.entityPackage}.entity.${sub.entityName}Entity;
</#list>
<#else>
package ${bussiPackage}.service.impl.${entityPackage};
import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
<#list subTab as sub>
import ${bussiPackage}.entity.${sub.entityPackage}.${sub.entityName}Entity;
</#list>
</#if>

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import java.util.ArrayList;
import java.util.UUID;
import java.io.Serializable;


@Service("${entityName?uncap_first}Service")
@Transactional
public class ${entityName}ServiceImpl extends CommonServiceImpl implements ${entityName}ServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((${entityName}Entity)entity);
 	}
	
	public void addMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>){
			//保存主信息
			this.save(${entityName?uncap_first});
		
			<#list subTab as sub>
			/**保存-${sub.ftlDescription}*/
			for(${sub.entityName}Entity ${sub.entityName?uncap_first}:${sub.entityName?uncap_first}List){
				<#list sub.foreignKeys as key>
				//外键设置
				<#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
				${sub.entityName?uncap_first}.set${subFieldMeta1[key]?cap_first}(${entityName?uncap_first}.get${jeecg_table_id?cap_first}());
				<#else>
				${sub.entityName?uncap_first}.set${subFieldMeta1[key]?cap_first}(${entityName?uncap_first}.get${key}());
				</#if>
				</#list>
				this.save(${sub.entityName?uncap_first});
			}
			</#list>
			//执行新增操作配置的sql增强
 			this.doAddSql(${entityName?uncap_first});
	}

	
	public void updateMain(${entityName}Entity ${entityName?uncap_first},
	        <#list subTab as sub>List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>) {
		//保存主表信息
		this.saveOrUpdate(${entityName?uncap_first});
		//===================================================================================
		//获取参数
	    <#list subTab as sub>
		    <#list sub.foreignKeys as key>
		    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
		Object ${jeecg_table_id}${sub_index} = ${entityName?uncap_first}.get${jeecg_table_id?cap_first}();
		    <#else>
		Object ${key?uncap_first}${sub_index} = ${entityName?uncap_first}.get${key}();
		    </#if>
		    </#list>
	    </#list>
		<#list subTab as sub>
		//===================================================================================
		//1.查询出数据库的明细数据-${sub.ftlDescription}
	    String hql${sub_index} = "from ${sub.entityName}Entity where 1 = 1<#list sub.foreignKeys as key> AND ${key?uncap_first} = ? </#list>";
	    List<${sub.entityName}Entity> ${sub.entityName?uncap_first}OldList = this.findHql(hql${sub_index},<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>${jeecg_table_id}${sub_index}<#else>${key?uncap_first}${sub_index}</#if><#if key_has_next>,</#if></#list>);
		//2.筛选更新明细数据-${sub.ftlDescription}
		if(${sub.entityName?uncap_first}List!=null&&${sub.entityName?uncap_first}List.size()>0){
		for(${sub.entityName}Entity oldE:${sub.entityName?uncap_first}OldList){
			boolean isUpdate = false;
				for(${sub.entityName}Entity sendE:${sub.entityName?uncap_first}List){
					//需要更新的明细数据-${sub.ftlDescription}
					if(oldE.getId().equals(sendE.getId())){
		    			try {
							MyBeanUtils.copyBeanNotNull2Bean(sendE,oldE);
							this.saveOrUpdate(oldE);
						} catch (Exception e) {
							e.printStackTrace();
							throw new BusinessException(e.getMessage());
						}
						isUpdate= true;
		    			break;
		    		}
		    	}
	    		if(!isUpdate){
		    		//如果数据库存在的明细，前台没有传递过来则是删除-${sub.ftlDescription}
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-${sub.ftlDescription}
			for(${sub.entityName}Entity ${sub.entityName?uncap_first}:${sub.entityName?uncap_first}List){
				if(oConvertUtils.isEmpty(${sub.entityName?uncap_first}.getId())){
					//外键设置
					 <#list sub.foreignKeys as key>
					    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
					${sub.entityName?uncap_first}.set${subFieldMeta1[key]?cap_first}(${entityName?uncap_first}.get${jeecg_table_id?cap_first}());
					    <#else>
					${sub.entityName?uncap_first}.set${subFieldMeta1[key]?cap_first}(${entityName?uncap_first}.get${key}());
					    </#if>
					 </#list>
					this.save(${sub.entityName?uncap_first});
				}
			}
		}
		</#list>
		//执行更新操作配置的sql增强
 		this.doUpdateSql(${entityName?uncap_first});
	}

	
	public void delMain(${entityName}Entity ${entityName?uncap_first}) {
		//删除主表信息
		this.delete(${entityName?uncap_first});
		//===================================================================================
		//获取参数
	    <#list subTab as sub>
		    <#list sub.foreignKeys as key>
		    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
		Object ${jeecg_table_id}${sub_index} = ${entityName?uncap_first}.get${jeecg_table_id?cap_first}();
		    <#else>
		Object ${key?uncap_first}${sub_index} = ${entityName?uncap_first}.get${key}();
		    </#if>
		    </#list>
	    </#list>
		<#list subTab as sub>
		//===================================================================================
		//删除-${sub.ftlDescription}
	    String hql${sub_index} = "from ${sub.entityName}Entity where 1 = 1<#list sub.foreignKeys as key> AND ${key?uncap_first} = ? </#list>";
	    List<${sub.entityName}Entity> ${sub.entityName?uncap_first}OldList = this.findHql(hql${sub_index},<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>${jeecg_table_id}${sub_index}<#else>${key?uncap_first}${sub_index}</#if><#if key_has_next>,</#if></#list>);
		this.deleteAllEntitie(${sub.entityName?uncap_first}OldList);
		</#list>
	}
	
	<#list buttons as btn>
	<#if btn.buttonStyle =='button' && btn.optType=='action'>
 	/**
	 * 自定义按钮-sql增强-${btn.buttonName}
	 * @param id
	 * @return
	 */
	 public boolean do${btn.buttonCode?cap_first}Sql(${entityName}Entity t){
	 	<#list buttonSqlMap[btn.buttonCode] as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	this.executeSql(replaceVal(sqlEnhance_${sql_index+1},t));
	 	</#list>
	 	return true;
	 }
 	</#if>
 	</#list> 
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(${entityName}Entity t){
 		<#list buttonSqlMap['add'] as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	this.executeSql(replaceVal(sqlEnhance_${sql_index+1},t));
	 	</#list>
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(${entityName}Entity t){
 		<#list buttonSqlMap['update'] as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	this.executeSql(replaceVal(sqlEnhance_${sql_index+1},t));
	 	</#list>
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(${entityName}Entity t){
 		<#list buttonSqlMap['delete'] as sql>
	 	//sql增强第${sql_index+1}条
	 	String sqlEnhance_${sql_index+1} ="${sql}";
	 	this.executeSql(replaceVal(sqlEnhance_${sql_index+1},t));
	 	</#list>
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,${entityName}Entity t){
 		<#list columns as po>
 		sql  = sql.replace("${'#'}{${fieldMeta[po.fieldName]?lower_case}}",String.valueOf(t.get${po.fieldName?cap_first}()));
 		</#list>
 		sql  = sql.replace("${'#'}{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}