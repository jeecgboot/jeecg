package org.jeecgframework.web.cgform.entity.button;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 表单自定义按钮
 * @author 张代浩
 * @date 2013-08-07 20:16:26
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_button", schema = "")
@SuppressWarnings("serial")
public class CgformButtonEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**外键关联cgform_head*/
	private java.lang.String formId;
	/**按钮编码*/
	private java.lang.String buttonCode;
	/**按钮名称*/
	private java.lang.String buttonName;
	/**按钮样式link/button*/
	private java.lang.String buttonStyle;
	/**动作类型:js/bus*/
	private java.lang.String optType;
	/**显示表达式:exp="status#eq#0"*/
	private java.lang.String exp;
	/**0:禁用/1:使用*/
	private java.lang.String buttonStatus;
	/**顺序*/
	private java.lang.Integer orderNum;
	/**按钮图标样式*/
	private java.lang.String buttonIcon;
	
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
	 *@return: java.lang.String  按钮名称
	 */
	@Column(name ="BUTTON_NAME",nullable=true,length=50)
	public java.lang.String getButtonName(){
		return this.buttonName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  按钮名称
	 */
	public void setButtonName(java.lang.String buttonName){
		this.buttonName = buttonName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  按钮样式link/button
	 */
	@Column(name ="BUTTON_STYLE",nullable=true,length=20)
	public java.lang.String getButtonStyle(){
		return this.buttonStyle;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  按钮样式link/button
	 */
	public void setButtonStyle(java.lang.String buttonStyle){
		this.buttonStyle = buttonStyle;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  动作类型:js/bus
	 */
	@Column(name ="OPT_TYPE",nullable=true,length=20)
	public java.lang.String getOptType(){
		return this.optType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  动作类型:js/bus
	 */
	public void setOptType(java.lang.String optType){
		this.optType = optType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  显示表达式:exp="status#eq#0"
	 */
	@Column(name ="EXP",nullable=true,length=255)
	public java.lang.String getExp(){
		return this.exp;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  显示表达式:exp="status#eq#0"
	 */
	public void setExp(java.lang.String exp){
		this.exp = exp;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  0:禁用/1:使用
	 */
	@Column(name ="BUTTON_STATUS",nullable=true,length=2)
	public java.lang.String getButtonStatus(){
		return this.buttonStatus;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  0:禁用/1:使用
	 */
	public void setButtonStatus(java.lang.String buttonStatus){
		this.buttonStatus = buttonStatus;
	}
	
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  顺序
	 */
	@Column(name ="order_num",nullable=true,length=4)
	public java.lang.Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(java.lang.Integer orderNum) {
		this.orderNum = orderNum;
	}

	@Column(name ="button_icon",nullable=true,length=20)
	public java.lang.String getButtonIcon() {
		return buttonIcon;
	}

	public void setButtonIcon(java.lang.String buttonIcon) {
		this.buttonIcon = buttonIcon;
	}
	
	
}
