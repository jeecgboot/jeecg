package org.jeecgframework.web.cgdynamgraph.entity.core;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 移动报表配置明细
 * @author 张代浩
 * @date 2013-12-07 16:00:21
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jform_cgdynamgraph_item", schema = "")
@SuppressWarnings("serial")
public class CgDynamGraphConfigItemEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**字段名*/
	private java.lang.String fieldName;
	/**字段序号*/
	private java.lang.Integer orderNum;
	/**字段文本*/
	private java.lang.String fieldTxt;
	/**字段类型*/
	private java.lang.String fieldType;
	//update_begin by:Robin for:TASK #344 动态报表需要增加，字段是否显示，字段herf
	/**字段href*/
	private String fieldHref;
	/**是否显示*/
	private String isShow;
	//update_begin by:Robin for:TASK #344 动态报表需要增加，字段是否显示，字段herf
	/**查询模式*/
	private java.lang.String sMode;
	/**取值表达式*/
	private java.lang.String replaceVa;
	/**字典Code*/
	private java.lang.String dictCode;
	/**是否查询*/
	private java.lang.String sFlag;
	/**外键*/
	private java.lang.String cgrheadId;
	
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
	 *@return: java.lang.String  字段名
	 */
	@Column(name ="FIELD_NAME",nullable=true,length=36)
	public java.lang.String getFieldName(){
		return this.fieldName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段名
	 */
	public void setFieldName(java.lang.String fieldName){
		this.fieldName = fieldName;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  字段序号
	 */
	@Column(name ="ORDER_NUM",nullable=true,length=10)
	public java.lang.Integer getOrderNum(){
		return this.orderNum;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  字段序号
	 */
	public void setOrderNum(java.lang.Integer orderNum){
		this.orderNum = orderNum;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段文本
	 */
	@Column(name ="FIELD_TXT",nullable=true,length=1000)
	public java.lang.String getFieldTxt(){
		return this.fieldTxt;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段文本
	 */
	public void setFieldTxt(java.lang.String fieldTxt){
		this.fieldTxt = fieldTxt;
	}
	
	
	/** 
	 * @return isShow 
	 */
	@Column(name = "IS_SHOW",nullable=true,length=5)
	public String getIsShow() {
		return isShow;
	}

	/** 
	 *  @param isShow 要设置的 isShow 
	 */
	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	/** 
	 * @return fieldHref 
	 */
	@Column(name ="FIELD_HREF",nullable=true,length=120)
	public String getFieldHref() {
		return fieldHref;
	}

	/** 
	 *  @param fieldHref 要设置的 fieldHref 
	 */
	public void setFieldHref(String fieldHref) {
		this.fieldHref = fieldHref;
	}
	
	
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段类型
	 */
	@Column(name ="FIELD_TYPE",nullable=true,length=10)
	public java.lang.String getFieldType(){
		return this.fieldType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段类型
	 */
	public void setFieldType(java.lang.String fieldType){
		this.fieldType = fieldType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  查询模式
	 */
	@Column(name ="S_MODE",nullable=true,length=10)
	public java.lang.String getSMode(){
		return this.sMode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  查询模式
	 */
	public void setSMode(java.lang.String sMode){
		this.sMode = sMode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  取值表达式
	 */
	@Column(name ="REPLACE_VA",nullable=true,length=36)
	public java.lang.String getReplaceVa(){
		return this.replaceVa;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  取值表达式
	 */
	public void setReplaceVa(java.lang.String replaceVa){
		this.replaceVa = replaceVa;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字典Code
	 */
	@Column(name ="DICT_CODE",nullable=true,length=36)
	public java.lang.String getDictCode(){
		return this.dictCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字典Code
	 */
	public void setDictCode(java.lang.String dictCode){
		this.dictCode = dictCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否查询
	 */
	@Column(name ="S_FLAG",nullable=true,length=2)
	public java.lang.String getSFlag(){
		return this.sFlag;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否查询
	 */
	public void setSFlag(java.lang.String sFlag){
		this.sFlag = sFlag;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  外键
	 */
	@Column(name ="CGRHEAD_ID",nullable=true,length=36)
	public java.lang.String getCgrheadId(){
		return this.cgrheadId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  外键
	 */
	public void setCgrheadId(java.lang.String cgrheadId){
		this.cgrheadId = cgrheadId;
	}
}
