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
 * @Description: 订单产品信息
 * @author 张代浩
 * @date 2013-03-19 22:15:01
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jeecg_order_product", schema = "")
@SuppressWarnings("serial")
public class JeecgOrderProductEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**团购订单号*/
	private java.lang.String goOrderCode;
	/**服务项目类型*/
	private java.lang.String gopProductType;
	/**产品名称*/
	private java.lang.String gopProductName;
	/**个数*/
	private java.lang.Integer gopCount;
	/**单价*/
	private BigDecimal gopOnePrice;
	/**小计*/
	private BigDecimal gopSumPrice;
	/**备注*/
	private java.lang.String gopContent;
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
	 *@return: java.lang.String  服务项目类型
	 */
	@Column(name ="GOP_PRODUCT_TYPE",nullable=false,length=1)
	public java.lang.String getGopProductType(){
		return this.gopProductType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  服务项目类型
	 */
	public void setGopProductType(java.lang.String gopProductType){
		this.gopProductType = gopProductType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  产品名称
	 */
	@Column(name ="GOP_PRODUCT_NAME",nullable=true,length=33)
	public java.lang.String getGopProductName(){
		return this.gopProductName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  产品名称
	 */
	public void setGopProductName(java.lang.String gopProductName){
		this.gopProductName = gopProductName;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  个数
	 */
	@Column(name ="GOP_COUNT",nullable=true,precision=10,scale=0)
	public java.lang.Integer getGopCount(){
		return this.gopCount;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  个数
	 */
	public void setGopCount(java.lang.Integer gopCount){
		this.gopCount = gopCount;
	}
	/**
	 *方法: 取得BigDecimal
	 *@return: BigDecimal  单价
	 */
	@Column(name ="GOP_ONE_PRICE",nullable=true,precision=10,scale=2)
	public BigDecimal getGopOnePrice(){
		return this.gopOnePrice;
	}

	/**
	 *方法: 设置BigDecimal
	 *@param: BigDecimal  单价
	 */
	public void setGopOnePrice(BigDecimal gopOnePrice){
		this.gopOnePrice = gopOnePrice;
	}
	/**
	 *方法: 取得BigDecimal
	 *@return: BigDecimal  小计
	 */
	@Column(name ="GOP_SUM_PRICE",nullable=true,precision=10,scale=2)
	public BigDecimal getGopSumPrice(){
		return this.gopSumPrice;
	}

	/**
	 *方法: 设置BigDecimal
	 *@param: BigDecimal  小计
	 */
	public void setGopSumPrice(BigDecimal gopSumPrice){
		this.gopSumPrice = gopSumPrice;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */
	@Column(name ="GOP_CONTENT",nullable=true,length=66)
	public java.lang.String getGopContent(){
		return this.gopContent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setGopContent(java.lang.String gopContent){
		this.gopContent = gopContent;
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
