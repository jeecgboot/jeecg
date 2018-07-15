package org.jeecgframework.web.system.pojo.base;


/**
 * 数据版本比较
 * @author
 *
 */
public class DataLogDiff implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private String name;
	private String value1;
	private String value2;
	private String diff;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue1() {
		return value1;
	}
	public void setValue1(String value1) {
		this.value1 = value1;
	}
	public String getValue2() {
		return value2;
	}
	public void setValue2(String value2) {
		this.value2 = value2;
	}
	public void setDiff(String diff) {
		this.diff = diff;
	}
	public String getDiff() {
		return diff;
	}
}
