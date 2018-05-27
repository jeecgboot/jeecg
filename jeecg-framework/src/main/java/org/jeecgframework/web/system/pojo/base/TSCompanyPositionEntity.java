package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 职务管理
 * @author onlineGenerator
 * @date 2017-11-07 16:21:23
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_s_company_position", schema = "")
@SuppressWarnings("serial")
public class TSCompanyPositionEntity implements java.io.Serializable {
	/**序号*/
	private java.lang.String id;
	/**公司ID*/
	@Excel(name="公司ID",width=15)
	private java.lang.String companyId;
	/**职务编码*/
	@Excel(name="职务编码",width=15)
	private java.lang.String positionCode;
	/**职务名称*/
	@Excel(name="职务名称",width=15)
	private java.lang.String positionName;
	/**职务英文名*/
	@Excel(name="职务英文名",width=15)
	private java.lang.String positionNameEn;
	/**职务缩写*/
	@Excel(name="职务缩写",width=15)
	private java.lang.String positionNameAbbr;
	/**职务级别*/
	@Excel(name="职务级别",width=15)
	private java.lang.String positionLevel;
	/**备注*/
	@Excel(name="备注",width=15)
	private java.lang.String memo;
	/**逻辑删除状态*/
	@Excel(name="逻辑删除状态",width=15)
	private java.lang.Integer delFlag;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人账号*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人账号*/
	private java.lang.String updateBy;
	/**更新日期*/
	private java.util.Date updateDate;
	/**数据所属公司*/
	private java.lang.String sysCompanyCode;
	/**数据所属部门*/
	private java.lang.String sysOrgCode;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  序号
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")

	@Column(name ="ID",nullable=false,length=32)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  序号
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  公司ID
	 */

	@Column(name ="COMPANY_ID",nullable=true,length=36)
	public java.lang.String getCompanyId(){
		return this.companyId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  公司ID
	 */
	public void setCompanyId(java.lang.String companyId){
		this.companyId = companyId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职务编码
	 */

	@Column(name ="POSITION_CODE",nullable=true,length=64)
	public java.lang.String getPositionCode(){
		return this.positionCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职务编码
	 */
	public void setPositionCode(java.lang.String positionCode){
		this.positionCode = positionCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职务名称
	 */

	@Column(name ="POSITION_NAME",nullable=true,length=100)
	public java.lang.String getPositionName(){
		return this.positionName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职务名称
	 */
	public void setPositionName(java.lang.String positionName){
		this.positionName = positionName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职务英文名
	 */

	@Column(name ="POSITION_NAME_EN",nullable=true,length=255)
	public java.lang.String getPositionNameEn(){
		return this.positionNameEn;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职务英文名
	 */
	public void setPositionNameEn(java.lang.String positionNameEn){
		this.positionNameEn = positionNameEn;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职务缩写
	 */

	@Column(name ="POSITION_NAME_ABBR",nullable=true,length=255)
	public java.lang.String getPositionNameAbbr(){
		return this.positionNameAbbr;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职务缩写
	 */
	public void setPositionNameAbbr(java.lang.String positionNameAbbr){
		this.positionNameAbbr = positionNameAbbr;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职务级别
	 */

	@Column(name ="POSITION_LEVEL",nullable=true,length=50)
	public java.lang.String getPositionLevel(){
		return this.positionLevel;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职务级别
	 */
	public void setPositionLevel(java.lang.String positionLevel){
		this.positionLevel = positionLevel;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */

	@Column(name ="MEMO",nullable=true,length=500)
	public java.lang.String getMemo(){
		return this.memo;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setMemo(java.lang.String memo){
		this.memo = memo;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  逻辑删除状态
	 */

	@Column(name ="DEL_FLAG",nullable=true,length=10)
	public java.lang.Integer getDelFlag(){
		return this.delFlag;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  逻辑删除状态
	 */
	public void setDelFlag(java.lang.Integer delFlag){
		this.delFlag = delFlag;
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
	 *@return: java.lang.String  创建人账号
	 */

	@Column(name ="CREATE_BY",nullable=true,length=50)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人账号
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */

	@Column(name ="CREATE_DATE",nullable=true)
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
	 *@return: java.lang.String  更新人账号
	 */

	@Column(name ="UPDATE_BY",nullable=true,length=50)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人账号
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */

	@Column(name ="UPDATE_DATE",nullable=true)
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
	 *@return: java.lang.String  数据所属公司
	 */

	@Column(name ="SYS_COMPANY_CODE",nullable=true,length=50)
	public java.lang.String getSysCompanyCode(){
		return this.sysCompanyCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据所属公司
	 */
	public void setSysCompanyCode(java.lang.String sysCompanyCode){
		this.sysCompanyCode = sysCompanyCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数据所属部门
	 */

	@Column(name ="SYS_ORG_CODE",nullable=true,length=50)
	public java.lang.String getSysOrgCode(){
		return this.sysOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据所属部门
	 */
	public void setSysOrgCode(java.lang.String sysOrgCode){
		this.sysOrgCode = sysOrgCode;
	}
}
