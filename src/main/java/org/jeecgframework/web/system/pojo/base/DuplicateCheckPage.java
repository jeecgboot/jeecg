package org.jeecgframework.web.system.pojo.base;

/**
 *@类:DuplicateCheckPage
 *@作者:张代浩
 *@E-mail:zhangdaiscott@163.com
 *@日期:2012-11-15
 *update-begin--Author:yankang  Date:201309012 for：[TASK#63]UI库常用控件参考示例【重复校验】
 *update-end--Author:yankang  Date:20130912 for：[TASK#63]UI库常用控件参考示例【重复校验】
 */

@SuppressWarnings("serial")
public class DuplicateCheckPage   implements java.io.Serializable {

	/**
	 * 表名
	 */
	private String tableName;
	
	/**
	 * 字段名
	 */
	private String fieldName;
	
	/**
	 * 字段值
	 */
	private String fieldVlaue;
	
	/**编辑数据ID*/
	private String rowObid;

	public String getRowObid() {
		return rowObid;
	}

	public void setRowObid(String rowObid) {
		this.rowObid = rowObid;
	}

	public String getTableName() {
		return tableName;
	}

	public String getFieldName() {
		return fieldName;
	}

	public String getFieldVlaue() {
		return fieldVlaue;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public void setFieldVlaue(String fieldVlaue) {
		this.fieldVlaue = fieldVlaue;
	}

}