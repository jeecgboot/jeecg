package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;
import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * @Title: Entity
 * @Description: 数据日志
 * @author onlineGenerator
 * @date 2015-06-28 14:02:26
 * @version V1.0
 *
 */
@Entity
@Table(name = "t_s_data_log", schema = "")
@SuppressWarnings("serial")
public class TSDatalogEntity extends IdEntity implements java.io.Serializable {
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**更新日期*/
	private java.util.Date updateDate;
	/**所属部门*/
	private java.lang.String sysOrgCode;
	/**所属公司*/
	private java.lang.String sysCompanyCode;
	/**表名*/
	@Excel(name="表名")
	private java.lang.String tableName;
	/**数据ID*/
	@Excel(name="数据ID")
	private java.lang.String dataId;
	/**数据内容*/
	@Excel(name="数据内容")
	private java.lang.String dataContent;
	/**版本号*/
	@Excel(name="版本号")
	private java.lang.Integer versionNumber;

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=50)
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名称
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人登录名称
	 */
	@Column(name ="CREATE_BY",nullable=true,length=50)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人登录名称
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */
	@Column(name ="CREATE_DATE",nullable=true,length=20)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=50)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人登录名称
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=50)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人登录名称
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */
	@Column(name ="UPDATE_DATE",nullable=true,length=20)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  更新日期
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属部门
	 */
	@Column(name ="SYS_ORG_CODE",nullable=true,length=50)
	public java.lang.String getSysOrgCode(){
		return this.sysOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属部门
	 */
	public void setSysOrgCode(java.lang.String sysOrgCode){
		this.sysOrgCode = sysOrgCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属公司
	 */
	@Column(name ="SYS_COMPANY_CODE",nullable=true,length=50)
	public java.lang.String getSysCompanyCode(){
		return this.sysCompanyCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属公司
	 */
	public void setSysCompanyCode(java.lang.String sysCompanyCode){
		this.sysCompanyCode = sysCompanyCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表名
	 */
	@Column(name ="TABLE_NAME",nullable=true,length=32)
	public java.lang.String getTableName(){
		return this.tableName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表名
	 */
	public void setTableName(java.lang.String tableName){
		this.tableName = tableName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数据ID
	 */
	@Column(name ="DATA_ID",nullable=true,length=32)
	public java.lang.String getDataId(){
		return this.dataId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据ID
	 */
	public void setDataId(java.lang.String dataId){
		this.dataId = dataId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数据内容
	 */
	@Column(name ="DATA_CONTENT",nullable=true,length=32)
	public java.lang.String getDataContent(){
		return this.dataContent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据内容
	 */
	public void setDataContent(java.lang.String dataContent){
		this.dataContent = dataContent;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  版本号
	 */
	@Column(name ="VERSION_NUMBER",nullable=true,length=4)
	public java.lang.Integer getVersionNumber(){
		return this.versionNumber;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  版本号
	 */
	public void setVersionNumber(java.lang.Integer versionNumber){
		this.versionNumber = versionNumber;
	}
}
