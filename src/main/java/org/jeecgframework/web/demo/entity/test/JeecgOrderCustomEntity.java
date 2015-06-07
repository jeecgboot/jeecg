package org.jeecgframework.web.demo.entity.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 订单客户信息
 * @author 张代浩
 * @date 2013-03-19 22:14:01
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jeecg_order_custom", schema = "")
@SuppressWarnings("serial")
public class JeecgOrderCustomEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**团购订单号*/
	private java.lang.String goOrderCode;
	/**姓名*/
	private java.lang.String gocCusName;
	/**性别*/
	private java.lang.String gocSex;
	/**身份证号*/
	private java.lang.String gocIdcard;
	/**护照号*/
	private java.lang.String gocPassportCode;
	/**业务*/
	private java.lang.String gocBussContent;
	/**备注*/
	private java.lang.String gocContent;
	/**创建人*/
	private java.lang.String crtuser;
	/**创建人名字*/
	private java.lang.String crtuserName;
	/**创建时间*/
	private java.util.Date createDt;
	/**修改人*/
	private java.lang.String modifier;
	/**修改人名字*/
	private java.lang.String modifierName;
	/**修改时间*/
	private java.util.Date modifyDt;
	/**删除标记*/
	private java.lang.Integer delflag;
	/**删除时间*/
	private java.util.Date delDt;
	
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
	 *@return: java.lang.String  团购订单号
	 */
	@Column(name ="GO_ORDER_CODE",nullable=false,length=12)
	public java.lang.String getGoOrderCode(){
		return this.goOrderCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  团购订单号
	 */
	public void setGoOrderCode(java.lang.String goOrderCode){
		this.goOrderCode = goOrderCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  姓名
	 */
	@Column(name ="GOC_CUS_NAME",nullable=true,length=16)
	public java.lang.String getGocCusName(){
		return this.gocCusName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  姓名
	 */
	public void setGocCusName(java.lang.String gocCusName){
		this.gocCusName = gocCusName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  性别
	 */
	@Column(name ="GOC_SEX",nullable=true)
	public java.lang.String getGocSex(){
		return this.gocSex;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  性别
	 */
	public void setGocSex(java.lang.String gocSex){
		this.gocSex = gocSex;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  身份证号
	 */
	@Column(name ="GOC_IDCARD",nullable=true,length=18)
	public java.lang.String getGocIdcard(){
		return this.gocIdcard;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  身份证号
	 */
	public void setGocIdcard(java.lang.String gocIdcard){
		this.gocIdcard = gocIdcard;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  护照号
	 */
	@Column(name ="GOC_PASSPORT_CODE",nullable=true,length=10)
	public java.lang.String getGocPassportCode(){
		return this.gocPassportCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  护照号
	 */
	public void setGocPassportCode(java.lang.String gocPassportCode){
		this.gocPassportCode = gocPassportCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  业务
	 */
	@Column(name ="GOC_BUSS_CONTENT",nullable=true,length=33)
	public java.lang.String getGocBussContent(){
		return this.gocBussContent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  业务
	 */
	public void setGocBussContent(java.lang.String gocBussContent){
		this.gocBussContent = gocBussContent;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */
	@Column(name ="GOC_CONTENT",nullable=true,length=66)
	public java.lang.String getGocContent(){
		return this.gocContent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setGocContent(java.lang.String gocContent){
		this.gocContent = gocContent;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人
	 */
	@Column(name ="CRTUSER",nullable=true,length=12)
	public java.lang.String getCrtuser(){
		return this.crtuser;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人
	 */
	public void setCrtuser(java.lang.String crtuser){
		this.crtuser = crtuser;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名字
	 */
	@Column(name ="CRTUSER_NAME",nullable=true,length=10)
	public java.lang.String getCrtuserName(){
		return this.crtuserName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名字
	 */
	public void setCrtuserName(java.lang.String crtuserName){
		this.crtuserName = crtuserName;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建时间
	 */
	@Column(name ="CREATE_DT",nullable=true)
	public java.util.Date getCreateDt(){
		return this.createDt;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建时间
	 */
	public void setCreateDt(java.util.Date createDt){
		this.createDt = createDt;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人
	 */
	@Column(name ="MODIFIER",nullable=true,length=12)
	public java.lang.String getModifier(){
		return this.modifier;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人
	 */
	public void setModifier(java.lang.String modifier){
		this.modifier = modifier;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人名字
	 */
	@Column(name ="MODIFIER_NAME",nullable=true,length=10)
	public java.lang.String getModifierName(){
		return this.modifierName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人名字
	 */
	public void setModifierName(java.lang.String modifierName){
		this.modifierName = modifierName;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  修改时间
	 */
	@Column(name ="MODIFY_DT",nullable=true)
	public java.util.Date getModifyDt(){
		return this.modifyDt;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  修改时间
	 */
	public void setModifyDt(java.util.Date modifyDt){
		this.modifyDt = modifyDt;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  删除标记
	 */
	@Column(name ="DELFLAG",nullable=true,precision=10,scale=0)
	public java.lang.Integer getDelflag(){
		return this.delflag;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  删除标记
	 */
	public void setDelflag(java.lang.Integer delflag){
		this.delflag = delflag;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  删除时间
	 */
	@Column(name ="DEL_DT",nullable=true)
	public java.util.Date getDelDt(){
		return this.delDt;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  删除时间
	 */
	public void setDelDt(java.util.Date delDt){
		this.delDt = delDt;
	}
}
