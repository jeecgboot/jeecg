package org.jeecgframework.web.cgform.entity.autoform;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Blob;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 表单表
 * @author onlineGenerator
 * @date 2015-06-15 20:29:59
 * @version V1.0   
 *
 */
@Entity
@Table(name = "auto_form", schema = "")
@SuppressWarnings("serial")
public class AutoFormEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**表单名称*/
	@Excel(name="表单名称")
	private java.lang.String formName;
	/**表单描述*/
	@Excel(name="表单描述")
	private java.lang.String formDesc;
	/**模板样式*/
	@Excel(name="模板样式")
	private java.lang.String formStyleId;
	/**表单编辑器文本*/
	@Excel(name="表单内容")
	private java.lang.String formContent;
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
	@Excel(name="所属部门")
	private java.lang.String sysOrgCode;
	/**所属公司*/
	@Excel(name="所属公司")
	private java.lang.String sysCompanyCode;
	
	private java.lang.String formParse;
	
	/** 表单数据源ID **/
	private java.lang.String dbId;
	
	private java.lang.String autoFormId;
	private String mainTableSource;
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
	 *@return: java.lang.String  表单名称
	 */
	@Column(name ="FORM_NAME",nullable=true,length=100)
	public java.lang.String getFormName(){
		return this.formName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表单名称
	 */
	public void setFormName(java.lang.String formName){
		this.formName = formName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单描述
	 */
	@Column(name ="FORM_DESC",nullable=true,length=200)
	public java.lang.String getFormDesc(){
		return this.formDesc;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表单描述
	 */
	public void setFormDesc(java.lang.String formDesc){
		this.formDesc = formDesc;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  模板样式
	 */
	@Column(name ="FORM_STYLE_ID",nullable=true,length=36)
	public java.lang.String getFormStyleId(){
		return this.formStyleId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  模板样式
	 */
	public void setFormStyleId(java.lang.String formStyleId){
		this.formStyleId = formStyleId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单内容
	 */
	@Column(name ="FORM_CONTENT",nullable=true)
	public java.lang.String getFormContent(){
		return this.formContent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表单内容
	 */
	public void setFormContent(java.lang.String formContent){
		this.formContent = formContent;
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
	
	@Transient
	public java.lang.String getDbId() {
		return dbId;
	}

	public void setDbId(java.lang.String dbId) {
		this.dbId = dbId;
	}
	
	@Column(name ="FORM_PARSE",nullable=true)
	public java.lang.String getFormParse() {
		return formParse;
	}

	public void setFormParse(java.lang.String formParse) {
		this.formParse = formParse;
	}
	@Transient
	public java.lang.String getAutoFormId() {
		return autoFormId;
	}

	public void setAutoFormId(java.lang.String autoFormId) {
		this.autoFormId = autoFormId;
	}
	@Column(name ="main_table_source",nullable=true)
	public String getMainTableSource() {
		return mainTableSource;
	}

	public void setMainTableSource(String mainTableSource) {
		this.mainTableSource = mainTableSource;
	}
}
