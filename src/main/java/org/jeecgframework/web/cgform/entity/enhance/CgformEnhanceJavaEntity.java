package org.jeecgframework.web.cgform.entity.enhance;

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
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: cgform_enhance_java
 * @author onlineGenerator
 * @date 2015-06-29 13:48:27
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_enhance_java", schema = "")
@SuppressWarnings("serial")
public class CgformEnhanceJavaEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	
	/**按纽编码*/
	private java.lang.String buttonCode;
	
	/**类型*/
	@Excel(name="类型")
	private java.lang.String cgJavaType;
	/**数值*/
	@Excel(name="数值")
	private java.lang.String cgJavaValue;
	/**表单ID*/
	@Excel(name="表单ID")
	private java.lang.String formId;
	/**生效状态 0:无效/1:有效*/
	@Excel(name="生效状态")
	private java.lang.String activeStatus;	

	/**事件状态 end：结束/start：开始**/
	@Excel(name="事件状态")
	private java.lang.String event;

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
	 *@return: java.lang.String  类型
	 */
	@Column(name ="CG_JAVA_TYPE",nullable=true,length=32)
	public java.lang.String getCgJavaType(){
		return this.cgJavaType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  类型
	 */
	public void setCgJavaType(java.lang.String cgJavaType){
		this.cgJavaType = cgJavaType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数值
	 */
	@Column(name ="CG_JAVA_VALUE",nullable=false,length=200)
	public java.lang.String getCgJavaValue(){
		return this.cgJavaValue;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数值
	 */
	public void setCgJavaValue(java.lang.String cgJavaValue){
		this.cgJavaValue = cgJavaValue;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单ID
	 */
	@Column(name ="FORM_ID",nullable=false,length=32)
	public java.lang.String getFormId(){
		return this.formId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表单ID
	 */
	public void setFormId(java.lang.String formId){
		this.formId = formId;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  按钮编码
	 */
	@Column(name ="BUTTON_CODE",nullable=true,length=50)
	public java.lang.String getButtonCode() {
		return buttonCode;
	}

	public void setButtonCode(java.lang.String buttonCode) {
		this.buttonCode = buttonCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  0:无效/1:有效
	 */
	@Column(name ="ACTIVE_STATUS",nullable=true,length=2)
	public java.lang.String getActiveStatus(){
		return this.activeStatus;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  0:无效/1:有效
	 */
	public void setActiveStatus(java.lang.String activeStatus){
		this.activeStatus = activeStatus;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  0：结束/1：开始
	 */
	public java.lang.String getEvent() {
		return event;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  0：结束/1：开始
	 */
	public void setEvent(java.lang.String event) {
		this.event = event;
	}

	@Override
	public String toString() {
		return "CgformEnhanceJavaEntity [id=" + id + ", buttonCode="
				+ buttonCode + ", cgJavaType=" + cgJavaType + ", cgJavaValue="
				+ cgJavaValue + ", formId=" + formId + ", activeStatus=" + activeStatus + ", event=" + event + "]";
	}
}
