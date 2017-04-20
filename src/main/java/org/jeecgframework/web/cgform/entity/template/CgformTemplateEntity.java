package org.jeecgframework.web.cgform.entity.template;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.persistence.*;
import javax.xml.soap.Text;
import java.sql.Blob;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 自定义模板
 * @author onlineGenerator
 * @date 2015-06-15 11:04:12
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_template", schema = "")
@SuppressWarnings("serial")
public class CgformTemplateEntity implements java.io.Serializable {
	/**主键*/
	private String id;
	/**创建人名称*/
	private String createName;
	/**创建人登录名称*/
	private String createBy;
	/**创建日期*/
	private Date createDate;
	/**更新人名称*/
	private String updateName;
	/**更新人登录名称*/
	private String updateBy;
	/**更新日期*/
	private Date updateDate;
	/**所属部门*/
	private String sysOrgCode;
	/**所属公司*/
	private String sysCompanyCode;
	/**模板名称*/
	@Excel(name="模板名称")
	private String templateName;
	/**模板编码*/
	@Excel(name="模板编码")
	private String templateCode;
	/**模板类型*/
	@Excel(name="模板类型")
	private String templateType;
	/**是否共享*/
	@Excel(name="是否共享")
	private String templateShare;
	/**预览图*/
	@Excel(name="预览图")
	private String templatePic;
	/**模板描述*/
	@Excel(name="模板描述")
	private String templateComment;

	private String templateZipName;

	private String templateListName;
	private String templateAddName;
	private String templateUpdateName;
	private String templateDetailName;

	
	/**
	 * 状态 0 失效 1 有效
	 */
	private Integer status;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
	public String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键
	 */
	public void setId(String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=50)
	public String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名称
	 */
	public void setCreateName(String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人登录名称
	 */
	@Column(name ="CREATE_BY",nullable=true,length=50)
	public String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人登录名称
	 */
	public void setCreateBy(String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */
	@Column(name ="CREATE_DATE",nullable=true,length=20)
	public Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=50)
	public String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人名称
	 */
	public void setUpdateName(String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人登录名称
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=50)
	public String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人登录名称
	 */
	public void setUpdateBy(String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */
	@Column(name ="UPDATE_DATE",nullable=true,length=20)
	public Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  更新日期
	 */
	public void setUpdateDate(Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属部门
	 */
	@Column(name ="SYS_ORG_CODE",nullable=true,length=50)
	public String getSysOrgCode(){
		return this.sysOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属部门
	 */
	public void setSysOrgCode(String sysOrgCode){
		this.sysOrgCode = sysOrgCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属公司
	 */
	@Column(name ="SYS_COMPANY_CODE",nullable=true,length=50)
	public String getSysCompanyCode(){
		return this.sysCompanyCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属公司
	 */
	public void setSysCompanyCode(String sysCompanyCode){
		this.sysCompanyCode = sysCompanyCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  模板名称
	 */
	@Column(name ="TEMPLATE_NAME",nullable=true,length=100)
	public String getTemplateName(){
		return this.templateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  模板名称
	 */
	public void setTemplateName(String templateName){
		this.templateName = templateName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  模板编码
	 */
	@Column(name ="TEMPLATE_CODE",nullable=true,length=50)
	public String getTemplateCode(){
		return this.templateCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  模板编码
	 */
	public void setTemplateCode(String templateCode){
		this.templateCode = templateCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  模板类型
	 */
	@Column(name ="TEMPLATE_TYPE",nullable=true,length=32)
	public String getTemplateType(){
		return this.templateType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  模板类型
	 */
	public void setTemplateType(String templateType){
		this.templateType = templateType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否共享
	 */
	@Column(name ="TEMPLATE_SHARE",nullable=true,length=10)
	public String getTemplateShare(){
		return this.templateShare;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否共享
	 */
	public void setTemplateShare(String templateShare){
		this.templateShare = templateShare;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  预览图
	 */
	@Column(name ="TEMPLATE_PIC",nullable=true,length=100)
	public String getTemplatePic(){
		return this.templatePic;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  预览图
	 */
	public void setTemplatePic(String templatePic){
		this.templatePic = templatePic;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  模板描述
	 */
	@Column(name ="TEMPLATE_COMMENT",nullable=true,length=200)
	public String getTemplateComment(){
		return this.templateComment;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  模板描述
	 */
	public void setTemplateComment(String templateComment){
		this.templateComment = templateComment;
	}
	@Transient
	public String getTemplateZipName() {
		return templateZipName;
	}

	public void setTemplateZipName(String templateZipName) {
		this.templateZipName = templateZipName;
	}

	@Column(name ="template_list_name",nullable=true,length=200)
	public String getTemplateListName() {
		return templateListName;
	}

	public void setTemplateListName(String templateListName) {
		this.templateListName = templateListName;
	}
	@Column(name ="template_add_name",nullable=true,length=200)
	public String getTemplateAddName() {
		return templateAddName;
	}

	public void setTemplateAddName(String templateAddName) {
		this.templateAddName = templateAddName;
	}

	@Column(name ="template_update_name",nullable=true,length=200)
	public String getTemplateUpdateName() {
		return templateUpdateName;
	}

	public void setTemplateUpdateName(String templateUpdateName) {
		this.templateUpdateName = templateUpdateName;
	}

	@Column(name ="template_detail_name",nullable=true,length=200)
	public String getTemplateDetailName() {
		return templateDetailName;
	}

	public void setTemplateDetailName(String templateDetailName) {
		this.templateDetailName = templateDetailName;
	}

	@Column(name="status")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
