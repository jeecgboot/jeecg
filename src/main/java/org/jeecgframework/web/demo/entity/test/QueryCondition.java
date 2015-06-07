package org.jeecgframework.web.demo.entity.test;

import java.util.List;

public class QueryCondition {
	String field;
	String type;
	String condition;
	String value;
	String relation;
	List<QueryCondition> children;
	
	public List<QueryCondition> getChildren() {
		return children;
	}
	public void setChildren(List<QueryCondition> children) {
		this.children = children;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String toString(){
		StringBuffer sb =new StringBuffer();
		sb.append(this.relation).append(" ");
		sb.append(this.field).append(" ")
		.append(this.condition).append(" ");
		if("java.util.Date".equals(this.type)){
			sb.append("to_date('").append(this.value).append("','yyyy-MM-dd')");
		}else if("java.lang.Number".equals(this.type)
				||this.condition.indexOf("in")>0){//TODO 需要按类型处理
			sb.append(this.value);
		}else{
			sb.append("'").append(this.value).append("'");//TODO 需要处理特殊字符
		}
		return sb.toString();
	}
}
