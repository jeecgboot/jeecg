package org.jeecgframework.core.common.model.common;

import java.io.Serializable;
import java.util.List;
/**
 * 
 * @author Hank
 * 修改于2014-01-25 添加List<T> 注入查询到的表数据 修改class1-->tableEntityClass
 * @param <T>
 */
public class DBTable<T> implements Serializable {

	public String tableName;
	public String entityName;
	public String tableTitle;
	public Class<T> tableEntityClass;
	public List<T> tableData;
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public String getTableTitle() {
		return tableTitle;
	}
	public void setTableTitle(String tableTitle) {
		this.tableTitle = tableTitle;
	}
	public Class<T> getClass1() {
		return tableEntityClass;
	}
	public void setClass1(Class<T> class1) {
		this.tableEntityClass = class1;
	}
	public List<T> getTableData() {
		return tableData;
	}
	public void setTableData(List<T> tableData) {
		this.tableData = tableData;
	}
	
}
