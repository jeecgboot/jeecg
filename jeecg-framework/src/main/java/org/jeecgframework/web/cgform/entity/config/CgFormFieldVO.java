package org.jeecgframework.web.cgform.entity.config;

import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.excel.annotation.ExcelTarget;



/**   
 * @Title: Entity
 * @Description: 自动生成表的列属性
 * @author jueyue
 * @date 2013-06-30 11:37:32
 * @version V1.0   
 *
 */
@ExcelTarget("cgFormFieldVO")
public class CgFormFieldVO implements java.io.Serializable {
	private static final long serialVersionUID = 8248068871232905945L;
	/**id*/
	private java.lang.String id;
	/**字段名称*/
	@Excel(name="字段名称",orderNum="1")
	private java.lang.String fieldName;
	/**功能注释*/
	@Excel(name="字段备注",orderNum="2")
	private java.lang.String content;
	/**字段类型*/
	@Excel(name="字段类型",orderNum="3")
	private java.lang.String type;
	/**字段长度*/
	@Excel(name="字段长度",orderNum="4")
	private java.lang.String length;
	/**小数点长度*/
	@Excel(name="小数点长度",orderNum="5")
	private java.lang.String pointLength;
	/**默认值*/
	@Excel(name="默认值",orderNum="6")
	private java.lang.String fieldDefault;
	/**是否允许空值*/
	@Excel(name="允许空值",orderNum="7")
	private java.lang.String isNull;

	public java.lang.String getId() {
		return id;
	}
	public void setId(java.lang.String id) {
		this.id = id;
	}
	public java.lang.String getFieldName() {
		return fieldName;
	}
	public void setFieldName(java.lang.String fieldName) {
		this.fieldName = fieldName;
	}
	public java.lang.String getLength() {
		return length;
	}
	public void setLength(java.lang.String length) {
		this.length = length;
	}
	public java.lang.String getPointLength() {
		return pointLength;
	}
	public void setPointLength(java.lang.String pointLength) {
		this.pointLength = pointLength;
	}
	public java.lang.String getType() {
		return type;
	}
	public void setType(java.lang.String type) {
		this.type = type;
	}
	public java.lang.String getIsNull() {
		return isNull;
	}
	public void setIsNull(java.lang.String isNull) {
		this.isNull = isNull;
	}
	public java.lang.String getContent() {
		return content;
	}
	public void setContent(java.lang.String content) {
		this.content = content;
	}
	public java.lang.String getFieldDefault() {
		return fieldDefault;
	}
	public void setFieldDefault(java.lang.String fieldDefault) {
		this.fieldDefault = fieldDefault;
	}
	@Override
	public String toString() {
		return "CgFormFieldVO [id=" + id + ", fieldName=" + fieldName
				+ ", content=" + content + ", type=" + type + ", length="
				+ length + ", pointLength=" + pointLength + ", fieldDefault="
				+ fieldDefault + ", isNull=" + isNull + "]";
	}

}
