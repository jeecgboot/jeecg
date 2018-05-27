package org.jeecgframework.tag.vo.superquery;

import java.util.ArrayList;
import java.util.List;

/**
 * 表查询字段配置
 * @author scott
 *
 */
public class TConfig {

	/**
	 * 表名
	 */
	private String table;
	/**
	 * 字段配置
	 */
	private List<Field> fields = new ArrayList<Field>();
	
	public void addField(Field f){
		fields.add(f);
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public List<Field> getFields() {
		return fields;
	}
	public void setFields(List<Field> fields) {
		this.fields = fields;
	}
}
