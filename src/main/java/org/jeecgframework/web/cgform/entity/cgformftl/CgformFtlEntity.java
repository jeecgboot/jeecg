package org.jeecgframework.web.cgform.entity.cgformftl;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: Word转Ftl
 * @author 张代浩
 * @date 2013-07-03 17:42:06
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_ftl", schema = "")
@SuppressWarnings("serial")
public class CgformFtlEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**表单ID*/
	private java.lang.String cgformId;
	/**表单名称*/
	private java.lang.String cgformName;
	/**版本号*/
	private java.lang.Integer ftlVersion;
	/**表单模板内容*/
	private String ftlContent;
	/**激活状态*/
	private java.lang.String ftlStatus;
	/**word路径*/
	private java.lang.String ftlWordUrl;
	/**创建人ID*/
	private java.lang.String createBy;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建时间*/
	private java.util.Date createDate;
	/**修改人ID*/
	private java.lang.String updateBy;
	/**修改人名称*/
	private java.lang.String updateName;
	/**修改时间*/
	private java.util.Date updateDate;
	/**模板类型 01 ckeditor 02 自定义 03 */
	private java.lang.String editorType;
	@Column(name ="EDITOR_TYPE",nullable=false,length=32)
	public java.lang.String getEditorType() {
		return editorType;
	}

	public void setEditorType(java.lang.String editorType) {
		this.editorType = editorType;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
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
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单ID
	 */
	@Column(name ="CGFORM_ID",nullable=false,length=36)
	public java.lang.String getCgformId(){
		return this.cgformId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表单ID
	 */
	public void setCgformId(java.lang.String cgformId){
		this.cgformId = cgformId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单名称
	 */
	@Column(name ="CGFORM_NAME",nullable=false,length=100)
	public java.lang.String getCgformName(){
		return this.cgformName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表单名称
	 */
	public void setCgformName(java.lang.String cgformName){
		this.cgformName = cgformName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  版本号
	 */
	@Column(name ="FTL_VERSION",nullable=false,length=10)
	public java.lang.Integer getFtlVersion(){
		return this.ftlVersion;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  版本号
	 */
	public void setFtlVersion(java.lang.Integer ftlVersion){
		this.ftlVersion = ftlVersion;
	}
	/**
	 *方法: 取得
	 *@return:   表单模板内容
	 */
	@Lob
	@Column(name ="FTL_CONTENT",nullable=true)
	public String getFtlContent(){
		return this.ftlContent;
	}

	/**
	 *方法: 设置
	 *@param:   表单模板内容
	 */
	public void setFtlContent(String ftlContent){
		this.ftlContent = ftlContent;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  激活状态
	 */
	@Column(name ="FTL_STATUS",nullable=true,length=50)
	public java.lang.String getFtlStatus(){
		return this.ftlStatus;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  激活状态
	 */
	public void setFtlStatus(java.lang.String ftlStatus){
		this.ftlStatus = ftlStatus;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  word路径
	 */
	@Column(name ="FTL_WORD_URL",nullable=true,length=200)
	public java.lang.String getFtlWordUrl(){
		return this.ftlWordUrl;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  word路径
	 */
	public void setFtlWordUrl(java.lang.String ftlWordUrl){
		this.ftlWordUrl = ftlWordUrl;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人ID
	 */
	@Column(name ="CREATE_BY",nullable=true,length=36)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人ID
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=32)
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
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建时间
	 */
	@Column(name ="CREATE_DATE",nullable=true)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建时间
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人ID
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=36)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人ID
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人名称
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=32)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  修改时间
	 */
	@Column(name ="UPDATE_DATE",nullable=true)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  修改时间
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
}
