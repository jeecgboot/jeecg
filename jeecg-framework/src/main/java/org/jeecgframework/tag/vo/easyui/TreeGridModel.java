package org.jeecgframework.tag.vo.easyui;

import java.util.Map;

/**
 * 
 * @ClassName: TreeGridModel 
 * @Description: TODO(树形列表模型设置类) 
 * @author  张代浩 
 * @date 2013-1-6 下午07:24:22 
 *
  */
public class TreeGridModel implements java.io.Serializable {
	private String idField;
	private String textField;
	private String childList;
 	private String parentId;
 	private String parentText;
 	private String code;
 	private String src;
 	private String roleid;
 	private String icon;
 	private String order;
 	private String functionType;
 	private String iconStyle;//图标样式
 	private Map<String, Object> fieldMap; // 存储实体字段信息容器：key-字段名称，value-字段值
 	
    public String getFunctionType() {
		return functionType;
	}
	public void setFunctionType(String functionType) {
		this.functionType = functionType;
	}

	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	public String getParentText() {
		return parentText;
	}
	public void setParentText(String parentText) {
		this.parentText = parentText;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	 
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}	
	public String getIdField() {
		return idField;
	}
	public void setIdField(String idField) {
		this.idField = idField;
	}
	public String getTextField() {
		return textField;
	}
	public void setTextField(String textField) {
		this.textField = textField;
	}
	public String getChildList() {
		return childList;
	}
	public void setChildList(String childList) {
		this.childList = childList;
	}

    public Map<String, Object> getFieldMap() {
        return fieldMap;
    }

    public void setFieldMap(Map<String, Object> fieldMap) {
        this.fieldMap = fieldMap;
    }

	public String getIconStyle() {
		return iconStyle;
	}
	public void setIconStyle(String iconStyle) {
		this.iconStyle = iconStyle;
	}

    
    
    
}
