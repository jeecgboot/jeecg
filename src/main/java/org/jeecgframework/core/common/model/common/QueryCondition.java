package org.jeecgframework.core.common.model.common;

import java.util.List;
import org.jeecgframework.core.util.PropertiesUtil;

public class QueryCondition {

	Integer id;
	String state;

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
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String toString(){

		if(field == null || "".equals(field)){
			return "";
		}

		StringBuffer sb =new StringBuffer();
		sb.append(this.relation).append(" ");
		sb.append(this.field).append(" ")
		.append(this.condition).append(" ");
		if("Integer".equals(this.type)
				||"BigDecimal".equals(this.type)
				||"Double".equals(this.type)
				||"Long".equals(this.type)){//TODO 需要按类型处理
			sb.append(this.value);
		}else if("Date".equals(this.type)){
			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
			String dbtype = util.readProperty("jdbc.url.jeecg");
			if("oracle".equalsIgnoreCase(dbtype)){
				sb.append("to_date(");
			}
			//mysql slqserver无须函数，其他数据库情况未处理
			sb.append("'").append(this.value).append("'");
			if("oracle".equalsIgnoreCase(dbtype)){
				sb.append(",'yyyy-MM-dd')");
			}
		}else {
			sb.append("'").append(this.value.replaceAll("'","\'")).append("'");//TODO 需要处理特殊字符
		}
		return sb.toString();
	}
}
