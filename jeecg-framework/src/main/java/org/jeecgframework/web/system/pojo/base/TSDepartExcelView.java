package org.jeecgframework.web.system.pojo.base;

import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * 组织机构导入对象
 * @author Yan_东
 */
public class TSDepartExcelView implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	@Excel(name="机构ID",width=50)
	private String id;
	@Excel(name = "机构名称" ,width = 20)
	private String departName;//部门名称
	@Excel(name = "机构描述")
	private String description;//部门描述
	@Excel(name = "机构父ID",width = 50)
	private String parentId;
	@Excel(name = "机构类型")
	private String orgType;//机构类型
	@Excel(name = "电话",width = 20)
	private String mobile;//电话
	@Excel(name = "传真",width = 20)
	private String fax;//传真
	@Excel(name = "地址",width = 20)
	private String address;//地址
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getOrgType() {
		return orgType;
	}
	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
