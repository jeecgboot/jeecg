package org.jeecgframework.web.demo.entity.test;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: Excel导出
 * @author 张代浩
 * @date 2013-03-23 21:45:28
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jg_person", schema = "")
@SuppressWarnings("serial")
public class JpPersonEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**年龄*/
	@Excel(exportName="年龄", exportConvertSign = 0, exportFieldWidth = 10, importConvertSign = 0)
	private java.lang.Integer age;
	/**生日*/
	@Excel(exportName="生日", exportConvertSign = 1, exportFieldWidth = 30, importConvertSign = 0)
	private java.util.Date birthday;
	/**出生日期*/
	@Excel(exportName="出生日期", exportConvertSign = 1, exportFieldWidth = 30, importConvertSign = 0)
	private java.util.Date createdt;
	/**用户名*/
	@Excel(exportName="用户名", exportConvertSign = 0, exportFieldWidth = 20, importConvertSign = 0)
	private java.lang.String name;
	/**工资*/
	@Excel(exportName="工资", exportConvertSign = 0, exportFieldWidth = 10, importConvertSign = 0)
	private BigDecimal salary;
	static DateFormat dateFormaterCreatedt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	static DateFormat dateFormaterBirthday = new SimpleDateFormat("yyyy-MM-dd");
	public String convertGetCreatedt() {
		if (this.createdt != null) {
			return dateFormaterCreatedt.format(getCreatedt());
		} else
			return "";
	}
	public void convertSetCreatedt(String createdt) {
		if (createdt != null) {
			try {
				this.createdt = dateFormaterCreatedt.parse(createdt);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
	public String convertGetBirthday() {
		if (this.birthday != null) {
			return dateFormaterBirthday.format(getCreatedt());
		} else
			return "";
	}
	public void convertSetBirthday(String birthday) {
		if (birthday != null) {
			try {
				this.birthday = dateFormaterBirthday.parse(birthday);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
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
	 *@return: java.lang.Integer  年龄
	 */
	@Column(name ="AGE",nullable=false,precision=10,scale=0)
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
	public void setBirthday(java.util.Date birthday){
		this.birthday = birthday;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  出生日期
	 */
	@Column(name ="CREATEDT",nullable=false)
	public java.util.Date getCreatedt(){
		return this.createdt;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  出生日期
	 */
	public void setCreatedt(java.util.Date createdt){
		this.createdt = createdt;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  用户名
	 */
	@Column(name ="NAME",nullable=true,length=255)
	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  用户名
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}
	/**
	 *方法: 取得BigDecimal
	 *@return: BigDecimal  工资
	 */
	@Column(name ="SALARY",nullable=false,precision=19,scale=2)
	public BigDecimal getSalary(){
		return this.salary;
	}

	/**
	 *方法: 设置BigDecimal
	 *@param: BigDecimal  工资
	 */
	public void setSalary(BigDecimal salary){
		this.salary = salary;
	}
}
