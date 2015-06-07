package org.jeecgframework.web.demo.entity.test;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;

/**   
 * @Title: Entity
 * @Description: 通过JDBC访问数据库
 * @author 张代浩
 * @date 2013-05-20 13:18:38
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jeecg_demo", schema = "")
@SuppressWarnings("serial")
public class JeecgJdbcEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**age*/
	private java.lang.Integer age;
	/**birthday*/
	private java.util.Date birthday;
	/**createTime*/
	private java.util.Date createTime;
	/**depId*/
	private java.lang.String depId;
	/**email*/
	private java.lang.String email;
	/**mobilePhone*/
	private java.lang.String mobilePhone;
	/**officePhone*/
	private java.lang.String officePhone;
	/**salary*/
	private BigDecimal salary;
	/**sex*/
	private java.lang.String sex;
	/**userName*/
	private java.lang.String userName;
	
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
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  age
	 */
	@Column(name ="AGE",nullable=true,precision=10,scale=0)
	public java.lang.Integer getAge(){
		return this.age;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  age
	 */
	public void setAge(java.lang.Integer age){
		this.age = age;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  birthday
	 */
	@Column(name ="BIRTHDAY",nullable=true)
	public java.util.Date getBirthday(){
		return this.birthday;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  birthday
	 */
	public void setBirthday(java.util.Date birthday){
		this.birthday = birthday;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  createTime
	 */
	@Column(name ="CREATE_TIME",nullable=true)
	public java.util.Date getCreateTime(){
		return this.createTime;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  createTime
	 */
	public void setCreateTime(java.util.Date createTime){
		this.createTime = createTime;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  depId
	 */
	@Column(name ="DEP_ID",nullable=true,length=255)
	public java.lang.String getDepId(){
		return this.depId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  depId
	 */
	public void setDepId(java.lang.String depId){
		this.depId = depId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  email
	 */
	@Column(name ="EMAIL",nullable=true,length=255)
	public java.lang.String getEmail(){
		return this.email;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  email
	 */
	public void setEmail(java.lang.String email){
		this.email = email;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  mobilePhone
	 */
	@Column(name ="MOBILE_PHONE",nullable=true,length=255)
	public java.lang.String getMobilePhone(){
		return this.mobilePhone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  mobilePhone
	 */
	public void setMobilePhone(java.lang.String mobilePhone){
		this.mobilePhone = mobilePhone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  officePhone
	 */
	@Column(name ="OFFICE_PHONE",nullable=true,length=255)
	public java.lang.String getOfficePhone(){
		return this.officePhone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  officePhone
	 */
	public void setOfficePhone(java.lang.String officePhone){
		this.officePhone = officePhone;
	}
	/**
	 *方法: 取得BigDecimal
	 *@return: BigDecimal  salary
	 */
	@Column(name ="SALARY",nullable=true,precision=19,scale=2)
	public BigDecimal getSalary(){
		return this.salary;
	}

	/**
	 *方法: 设置BigDecimal
	 *@param: BigDecimal  salary
	 */
	public void setSalary(BigDecimal salary){
		this.salary = salary;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  sex
	 */
	@Column(name ="SEX",nullable=true,length=4)
	public java.lang.String getSex(){
		return this.sex;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  sex
	 */
	public void setSex(java.lang.String sex){
		this.sex = sex;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  userName
	 */
	@Column(name ="USER_NAME",nullable=false,length=255)
	public java.lang.String getUserName(){
		return this.userName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  userName
	 */
	public void setUserName(java.lang.String userName){
		this.userName = userName;
	}
}
