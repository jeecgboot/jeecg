package org.jeecgframework.web.cgform.service.config;

import org.jeecgframework.web.cgform.exception.DBException;
import org.jeecgframework.web.cgform.service.impl.config.util.ColumnMeta;

public interface DbTableHandleI {
	/**
	 * 
	 * @param columnMeta
	 * @return
	 */
//	String getUpdateFieldDesc(ColumnMeta columnMeta,ColumnMeta datacolumnMeta);
	/**
	 * 
	 * @param columnMeta
	 * @return
	 */
	String getAddColumnSql(ColumnMeta columnMeta);
	/**
	 * 
	 * @param columnMeta
	 * @return
	 */
	String getReNameFieldName(ColumnMeta columnMeta);
	/**
	 * 修改字段
	 * @param cgformcolumnMeta form的自动配置信息
	 * @param datacolumnMeta   数据库表的字段信息
	 * @return
	 */
	String getUpdateColumnSql(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta) throws DBException;
	/**
	 * 根据数据类型转换类类型
	 * @return
	 */
	String getMatchClassTypeByDataType(String dataType,int digits);
	/**
	 * 删除表
	 * @param tableName
	 * @return
	 */
	String dropTableSQL(String tableName);
	/**
	 * 删除字段
	 * @param fieldName
	 * @return
	 */
	String getDropColumnSql(String fieldName);
	/**
	 * 添加注释
	 *@param columnMeta
	 *@return
	 */
	String getCommentSql(ColumnMeta columnMeta);
	/**
	 * 处理特殊sql
	 * @param cgformcolumnMeta
	 * @param datacolumnMeta
	 * @return
	 */
	String getSpecialHandle(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta);
}
