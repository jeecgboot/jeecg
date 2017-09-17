package org.jeecgframework.tag.vo.easyui;
/**
 * 
 * @author  张代浩
 *
 */
public class ColumnValue {
	private String name;
	private String text;
	private String value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String toString(){
		return new StringBuffer().append("ColumnValue [name=").append(name)
				.append(",text=").append(text)
				.append(",value=").append(value)
				.append("]").toString();
	}
}
