package org.jeecgframework.web.cgform.entity.button;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 按钮sql增强
 * @author 张代浩
 * @date 2013-08-07 23:09:23
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_button_sql", schema = "")
@SuppressWarnings("serial")
public class CgformButtonSqlEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**外键关联cgform_head*/
	private java.lang.String formId;
	/**按钮编码*/
	private java.lang.String buttonCode;
	/**称名*/
	private java.lang.String cgbSqlName;
	/**强增sql*/
	private byte[] cgbSql;
	/**强增sql Str*/
	private String cgbSqlStr;
	/**描述*/
	private java.lang.String content;
	
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
	 *@return: java.lang.String  外键关联cgform_head
	 */
	@Column(name ="FORM_ID",nullable=true,length=32)
	public java.lang.String getFormId(){
		return this.formId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  外键关联cgform_head
	 */
	public void setFormId(java.lang.String formId){
		this.formId = formId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  按钮编码
	 */
	@Column(name ="BUTTON_CODE",nullable=true,length=50)
	public java.lang.String getButtonCode(){
		return this.buttonCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  按钮编码
	 */
	public void setButtonCode(java.lang.String buttonCode){
		this.buttonCode = buttonCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  称名
	 */
	@Column(name ="CGB_SQL_NAME",nullable=true,length=50)
	public java.lang.String getCgbSqlName(){
		return this.cgbSqlName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  称名
	 */
	public void setCgbSqlName(java.lang.String cgbSqlName){
		this.cgbSqlName = cgbSqlName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  强增sql
	 */
	@Column(name ="CGB_SQL",nullable=true)
	public byte[] getCgbSql(){
		return this.cgbSql;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  强增sql
	 */
	public void setCgbSql(byte[] cgbSql){
		this.cgbSql = cgbSql;
	}
	
	@Transient
	public String getCgbSqlStr() {
		if(cgbSql!=null){
			cgbSqlStr = new String(cgbSql);
		}
		return cgbSqlStr;
	}

	public void setCgbSqlStr(String cgbSqlStr) {
		this.cgbSqlStr = cgbSqlStr;
		if(cgbSqlStr!=null){
			this.cgbSql = cgbSqlStr.getBytes();
		}
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  描述
	 */
	@Column(name ="CONTENT",nullable=true,length=1000)
	public java.lang.String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  描述
	 */
	public void setContent(java.lang.String content){
		this.content = content;
	}
}
