package org.jeecgframework.web.cgdynamgraph.entity.core;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 移动报表配置参数
 * @author onlineGenerator
 * @date 2015-12-01 11:22:58
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jform_cgdynamgraph_param", schema = "")
@SuppressWarnings("serial")
public class CgDynamGraphConfigParamEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
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
	/**参数名称*/
	@Excel(name="参数名称")
	private java.lang.String paramName;
	/**参数说明*/
	@Excel(name="参数说明")
	private java.lang.String paramDesc;
	/**数值*/
	@Excel(name="数值")
	private java.lang.String paramValue;
	/**排序*/
	@Excel(name="排序")
	private java.lang.Integer seq;
	/**数据源ID*/
	@Excel(name="动态报表ID")
	private java.lang.String cgrheadId;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
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
	 *@return: java.lang.String  参数名称
	 */
	@Column(name ="PARAM_NAME",nullable=false,length=32)
	public java.lang.String getParamName(){
		return this.paramName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  参数名称
	 */
	public void setParamName(java.lang.String paramName){
		this.paramName = paramName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  参数说明
	 */
	@Column(name ="PARAM_DESC",nullable=true,length=32)
	public java.lang.String getParamDesc(){
		return this.paramDesc;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  参数说明
	 */
	public void setParamDesc(java.lang.String paramDesc){
		this.paramDesc = paramDesc;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数值
	 */
	@Column(name ="PARAM_VALUE",nullable=true,length=32)
	public java.lang.String getParamValue(){
		return this.paramValue;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数值
	 */
	public void setParamValue(java.lang.String paramValue){
		this.paramValue = paramValue;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  排序
	 */
	@Column(name ="SEQ",nullable=true,length=32)
	public java.lang.Integer getSeq(){
		return this.seq;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  排序
	 */
	public void setSeq(java.lang.Integer seq){
		this.seq = seq;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  动态报表ID
	 */
	@Column(name ="CGRHEAD_ID",nullable=true,length=36)
	public java.lang.String getCgrheadId() {
		return cgrheadId;
	}

	public void setCgrheadId(java.lang.String cgrheadId) {
		this.cgrheadId = cgrheadId;
	}
	
	
}
