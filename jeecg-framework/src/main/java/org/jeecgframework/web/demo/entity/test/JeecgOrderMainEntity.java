package org.jeecgframework.web.demo.entity.test;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 订单信息
 * @author 张代浩
 * @date 2013-03-19 22:01:34
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jeecg_order_main", schema = "")
@SuppressWarnings("serial")
public class JeecgOrderMainEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**订单号*/
	private java.lang.String goOrderCode;
	/**订单类型*/
	private java.lang.String goderType;
	/**顾客类型 : 1直客 2同行*/
	private java.lang.String usertype;
	/**联系人*/
	private java.lang.String goContactName;
	/**手机*/
	private java.lang.String goTelphone;
	/**订单人数*/
	private java.lang.Integer goOrderCount;
	/**总价(不含返款)*/
	private BigDecimal goAllPrice;
	/**返款*/
	private BigDecimal goReturnPrice;
	/**备注*/
	private java.lang.String goContent;
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
	 *@return: java.lang.String  订单号
	 */
	@Column(name ="GO_ORDER_CODE",nullable=false,length=12)
	public java.lang.String getGoOrderCode(){
		return this.goOrderCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  订单号
	 */
	public void setGoOrderCode(java.lang.String goOrderCode){
		this.goOrderCode = goOrderCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  订单类型
	 */
	@Column(name ="GODER_TYPE",nullable=true)
	public java.lang.String getGoderType(){
		return this.goderType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  订单类型
	 */
	public void setGoderType(java.lang.String goderType){
		this.goderType = goderType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  顾客类型 : 1直客 2同行
	 */
	@Column(name ="USERTYPE",nullable=true)
	public java.lang.String getUsertype(){
		return this.usertype;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  顾客类型 : 1直客 2同行
	 */
	public void setUsertype(java.lang.String usertype){
		this.usertype = usertype;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  联系人
	 */
	@Column(name ="GO_CONTACT_NAME",nullable=true,length=16)
	public java.lang.String getGoContactName(){
		return this.goContactName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  联系人
	 */
	public void setGoContactName(java.lang.String goContactName){
		this.goContactName = goContactName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  手机
	 */
	@Column(name ="GO_TELPHONE",nullable=true,length=11)
	public java.lang.String getGoTelphone(){
		return this.goTelphone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  手机
	 */
	public void setGoTelphone(java.lang.String goTelphone){
		this.goTelphone = goTelphone;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  订单人数
	 */
	@Column(name ="GO_ORDER_COUNT",nullable=true,precision=10,scale=0)
	public java.lang.Integer getGoOrderCount(){
		return this.goOrderCount;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  订单人数
	 */
	public void setGoOrderCount(java.lang.Integer goOrderCount){
		this.goOrderCount = goOrderCount;
	}
	/**
	 *方法: 取得BigDecimal
	 *@return: BigDecimal  总价(不含返款)
	 */
	@Column(name ="GO_ALL_PRICE",nullable=true,precision=10,scale=2)
	public BigDecimal getGoAllPrice(){
		return this.goAllPrice;
	}

	/**
	 *方法: 设置BigDecimal
	 *@param: BigDecimal  总价(不含返款)
	 */
	public void setGoAllPrice(BigDecimal goAllPrice){
		this.goAllPrice = goAllPrice;
	}
	/**
	 *方法: 取得BigDecimal
	 *@return: BigDecimal  返款
	 */
	@Column(name ="GO_RETURN_PRICE",nullable=true,precision=10,scale=2)
	public BigDecimal getGoReturnPrice(){
		return this.goReturnPrice;
	}

	/**
	 *方法: 设置BigDecimal
	 *@param: BigDecimal  返款
	 */
	public void setGoReturnPrice(BigDecimal goReturnPrice){
		this.goReturnPrice = goReturnPrice;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */
	@Column(name ="GO_CONTENT",nullable=true,length=66)
	public java.lang.String getGoContent(){
		return this.goContent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setGoContent(java.lang.String goContent){
		this.goContent = goContent;
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
