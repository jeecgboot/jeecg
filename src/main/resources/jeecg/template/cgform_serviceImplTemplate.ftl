<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.service.impl;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.${entityPackage}.entity.${entityName}Entity;
<#else>
package ${bussiPackage}.service.impl.${entityPackage};
import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
</#if>
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((${entityName}Entity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((${entityName}Entity)entity);
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