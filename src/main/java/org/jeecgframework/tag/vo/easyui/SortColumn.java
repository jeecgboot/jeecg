package org.jeecgframework.tag.vo.easyui;

/**
 * 
 * @author  张代浩
 *
 */
public class SortColumn {
	/**
	 * 排序索引
	 */
	protected String index;
	/**
	 * 自定义排序属性
	 */
	protected String order;
	/**
	 * 排序类型
	 */
	protected String type;
	/**
	 * 排序字段名字
	 */
	protected String name;
	/**
	 * 自定义取值
	 */
	protected String value;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getIndex() {
		return index;
	}

	public void setIndex(String index) {
		this.index = index;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
