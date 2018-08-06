package com.jeecg.demo.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.core.common.controller.CustomJsonDateDeserializer;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: jeecg_demo
 * @author onlineGenerator
 * @date 2017-03-22 20:11:23
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jeecg_demo", schema = "")
@SuppressWarnings("serial")
public class JeecgDemoEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**名称*/
	@Excel(name="名称",width=32)
	private java.lang.String name;
	/**年龄*/
	@Excel(name="年龄")
	private java.lang.Integer age;
	/**生日*/
	@Excel(name="生日",format = "yyyy-MM-dd")
	private java.util.Date birthday;
	/**个人介绍*/
	@Excel(name="个人介绍")
	private java.lang.String content;
	/**部门*/
	@Excel(name="部门",dictTable="t_s_depart",dicCode="id",dicText="departname")
	private java.lang.String depId;
	/**邮箱*/
	@Excel(name="邮箱",width=32)
	private java.lang.String email;
	/**电话*/
	@Excel(name="电话",width=12)
	private java.lang.String phone;
	/**工资*/
	@Excel(name="工资",type=4)
	private Double salary;
	/**性别*/
	@Excel(name="性别",dicCode="sex")
	private java.lang.String sex;
	/**入职状态*/
	@Excel(name="入职状态",dicCode="sf_yn")
	private java.lang.String status;
	/**createDate*/
	private java.util.Date createDate;
	/**创建人id*/
	private java.lang.String createBy;
	/**创建人*/
	private java.lang.String createName;
	/**修改人id*/
	private java.lang.String updateBy;
	/**修改时间*/
	private java.util.Date updateDate;
	/**修改人*/
	private java.lang.String updateName;
	/** 组织 */
	@Excel(name="部门编码",width=200)
	private java.lang.String sysOrgCode;
	/** 公司 */
	private java.lang.String sysCompanyCode;
	
	private java.lang.String touxiang;
	private java.lang.String fujian;
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
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
	 *@param: java.lang.String  id
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  名称
	 */
	@Column(name ="NAME",nullable=false,length=255)
	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  名称
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  年龄
	 */
	@Column(name ="AGE",nullable=true,length=10)
	public java.lang.Integer getAge(){
		return this.age;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  年龄
	 */
	public void setAge(java.lang.Integer age){
		this.age = age;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  生日
	 */
	@Column(name ="BIRTHDAY",nullable=true)
	public java.util.Date getBirthday(){
		return this.birthday;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  生日
	 */
	@JsonDeserialize(using = CustomJsonDateDeserializer.class)
	public void setBirthday(java.util.Date birthday){
		this.birthday = birthday;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  个人介绍
	 */
	@Column(name ="CONTENT",nullable=true,length=255)
	public java.lang.String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  个人介绍
	 */
	public void setContent(java.lang.String content){
		this.content = content;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  部门
	 */
	@Column(name ="DEP_ID",nullable=true,length=255)
	public java.lang.String getDepId(){
		return this.depId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  部门
	 */
	public void setDepId(java.lang.String depId){
		this.depId = depId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  邮箱
	 */
	@Column(name ="EMAIL",nullable=true,length=255)
	public java.lang.String getEmail(){
		return this.email;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  邮箱
	 */
	public void setEmail(java.lang.String email){
		this.email = email;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  电话
	 */
	@Column(name ="PHONE",nullable=true,length=255)
	public java.lang.String getPhone(){
		return this.phone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  电话
	 */
	public void setPhone(java.lang.String phone){
		this.phone = phone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  工资
	 */
	@Column(name ="SALARY",nullable=true,scale=2,length=19)
	public Double getSalary(){
		return this.salary;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  工资
	 */
	public void setSalary(Double salary){
		this.salary = salary;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  性别
	 */
	@Column(name ="SEX",nullable=true,length=255)
	public java.lang.String getSex(){
		return this.sex;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  性别
	 */
	public void setSex(java.lang.String sex){
		this.sex = sex;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  入职状态
	 */
	@Column(name ="STATUS",nullable=true,length=255)
	public java.lang.String getStatus(){
		return this.status;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  入职状态
	 */
	public void setStatus(java.lang.String status){
		this.status = status;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  createDate
	 */
	@Column(name ="CREATE_DATE",nullable=true)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  createDate
	 */
	@JsonDeserialize(using = CustomJsonDateDeserializer.class)
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人id
	 */
	@Column(name ="CREATE_BY",nullable=true,length=32)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人id
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=32)
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人id
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=32)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人id
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
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
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=32)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	@Column(name = "sys_org_code", nullable = true, length = 15)
	public java.lang.String getSysOrgCode() {
		return sysOrgCode;
	}

	public void setSysOrgCode(java.lang.String sysOrgCode) {
		this.sysOrgCode = sysOrgCode;
	}

	@Column(name = "sys_company_code", nullable = true, length = 15)
	public java.lang.String getSysCompanyCode() {
		return sysCompanyCode;
	}

	public void setSysCompanyCode(java.lang.String sysCompanyCode) {
		this.sysCompanyCode = sysCompanyCode;
	}

	@Column(name = "touxiang", nullable = true, length = 255)
	public java.lang.String getTouxiang() {
		return touxiang;
	}

	public void setTouxiang(java.lang.String touxiang) {
		this.touxiang = touxiang;
	}

	@Column(name = "fujian", nullable = true, length = 255)
	public java.lang.String getFujian() {
		return fujian;
	}

	public void setFujian(java.lang.String fujian) {
		this.fujian = fujian;
	}
}
