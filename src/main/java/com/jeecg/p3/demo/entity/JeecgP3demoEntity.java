package com.jeecg.p3.demo.entity;

import java.io.Serializable;
import java.util.Date;
import java.math.BigDecimal;

/**
 * 描述：P3测试表
 * @author: www.jeecg.org
 * @since：2017年05月15日 20时07分37秒 星期一 
 * @version:1.0
 */
public class JeecgP3demoEntity implements Serializable{
	private static final long serialVersionUID = 1L;
		/**	 *id	 */	private String id;	/**	 *创建人名称	 */	private String createName;	/**	 *创建人登录名称	 */	private String createBy;	/**	 *创建日期	 */	private Date createDate;	/**	 *更新人名称	 */	private String updateName;	/**	 *更新人登录名称	 */	private String updateBy;	/**	 *更新日期	 */	private Date updateDate;	/**	 *所属部门	 */	private String sysOrgCode;	/**	 *所属公司	 */	private String sysCompanyCode;	/**	 *流程状态	 */	private String bpmStatus;	/**	 *姓名	 */	private String name;	/**	 *性别	 */	private Integer sex;	/**	 *年龄	 */	private Integer age;	/**	 *地址	 */	private String address;	/**	 *电话	 */	private String phone;	/**	 *备注	 */	private String memo;	public String getId() {	    return this.id;	}	public void setId(String id) {	    this.id=id;	}	public String getCreateName() {	    return this.createName;	}	public void setCreateName(String createName) {	    this.createName=createName;	}	public String getCreateBy() {	    return this.createBy;	}	public void setCreateBy(String createBy) {	    this.createBy=createBy;	}	public Date getCreateDate() {	    return this.createDate;	}	public void setCreateDate(Date createDate) {	    this.createDate=createDate;	}	public String getUpdateName() {	    return this.updateName;	}	public void setUpdateName(String updateName) {	    this.updateName=updateName;	}	public String getUpdateBy() {	    return this.updateBy;	}	public void setUpdateBy(String updateBy) {	    this.updateBy=updateBy;	}	public Date getUpdateDate() {	    return this.updateDate;	}	public void setUpdateDate(Date updateDate) {	    this.updateDate=updateDate;	}	public String getSysOrgCode() {	    return this.sysOrgCode;	}	public void setSysOrgCode(String sysOrgCode) {	    this.sysOrgCode=sysOrgCode;	}	public String getSysCompanyCode() {	    return this.sysCompanyCode;	}	public void setSysCompanyCode(String sysCompanyCode) {	    this.sysCompanyCode=sysCompanyCode;	}	public String getBpmStatus() {	    return this.bpmStatus;	}	public void setBpmStatus(String bpmStatus) {	    this.bpmStatus=bpmStatus;	}	public String getName() {	    return this.name;	}	public void setName(String name) {	    this.name=name;	}	public Integer getSex() {	    return this.sex;	}	public void setSex(Integer sex) {	    this.sex=sex;	}	public Integer getAge() {	    return this.age;	}	public void setAge(Integer age) {	    this.age=age;	}	public String getAddress() {	    return this.address;	}	public void setAddress(String address) {	    this.address=address;	}	public String getPhone() {	    return this.phone;	}	public void setPhone(String phone) {	    this.phone=phone;	}	public String getMemo() {	    return this.memo;	}	public void setMemo(String memo) {	    this.memo=memo;	}
}

