package org.jeecgframework.web.demo.entity.test;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 资金管理
 * @author tanghong
 * @date 2013-06-26 23:57:04
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_finance", schema = "")
@SuppressWarnings("serial")
public class TFinanceEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**类别*/
	private java.lang.String category;
	/**年份*/
	private java.lang.Integer happenyear;
	/**拨款时间*/
	private java.util.Date paytime;
	/**收款单位*/
	private java.lang.String collectorg;
	/**拨款文件类别*/
	private java.lang.String approfiletype;
	/**指标文号*/
	private java.lang.String zbwno;
	/**金额合计*/
	private java.lang.Float moneytotal;
	/**支出科目*/
	private java.lang.String expenseaccount;
	/**资金用途*/
	private java.lang.String moneyuse;
	/**列支地区*/
	private java.lang.String moneyarea;
	/**资金来源*/
	private java.lang.String moneysource;
	/**采购年份*/
	private java.lang.String buyyear;
	/**采购项目号*/
	private java.lang.String buyprojectno;
	/**采购项目单位*/
	private java.lang.String buyprojectorg;
	/**采购金额*/
	private java.lang.Float buymoney;
	/**采购用途*/
	private java.lang.String buyuse;
	
	private List<TFinanceFilesEntity> financeFiles;
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
	 *@return: java.lang.String  类别
	 */
	@Column(name ="CATEGORY",nullable=true,length=255)
	public java.lang.String getCategory(){
		return this.category;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  类别
	 */
	public void setCategory(java.lang.String category){
		this.category = category;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  年份
	 */
	@Column(name ="HAPPENYEAR",nullable=true,precision=10,scale=0)
	public java.lang.Integer getHappenyear(){
		return this.happenyear;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  年份
	 */
	public void setHappenyear(java.lang.Integer happenyear){
		this.happenyear = happenyear;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  拨款时间
	 */
	@Column(name ="PAYTIME",nullable=true)
	public java.util.Date getPaytime(){
		return this.paytime;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  拨款时间
	 */
	public void setPaytime(java.util.Date paytime){
		this.paytime = paytime;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收款单位
	 */
	@Column(name ="COLLECTORG",nullable=true,length=255)
	public java.lang.String getCollectorg(){
		return this.collectorg;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收款单位
	 */
	public void setCollectorg(java.lang.String collectorg){
		this.collectorg = collectorg;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  拨款文件类别
	 */
	@Column(name ="APPROFILETYPE",nullable=true,length=255)
	public java.lang.String getApprofiletype(){
		return this.approfiletype;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  拨款文件类别
	 */
	public void setApprofiletype(java.lang.String approfiletype){
		this.approfiletype = approfiletype;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  指标文号
	 */
	@Column(name ="ZBWNO",nullable=true,length=255)
	public java.lang.String getZbwno(){
		return this.zbwno;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  指标文号
	 */
	public void setZbwno(java.lang.String zbwno){
		this.zbwno = zbwno;
	}
	/**
	 *方法: 取得java.lang.Float
	 *@return: java.lang.Float  金额合计
	 */
	@Column(name ="MONEYTOTAL",nullable=true,precision=12)
	public java.lang.Float getMoneytotal(){
		return this.moneytotal;
	}

	/**
	 *方法: 设置java.lang.Float
	 *@param: java.lang.Float  金额合计
	 */
	public void setMoneytotal(java.lang.Float moneytotal){
		this.moneytotal = moneytotal;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  支出科目
	 */
	@Column(name ="EXPENSEACCOUNT",nullable=true,length=255)
	public java.lang.String getExpenseaccount(){
		return this.expenseaccount;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  支出科目
	 */
	public void setExpenseaccount(java.lang.String expenseaccount){
		this.expenseaccount = expenseaccount;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  资金用途
	 */
	@Column(name ="MONEYUSE",nullable=true,length=255)
	public java.lang.String getMoneyuse(){
		return this.moneyuse;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  资金用途
	 */
	public void setMoneyuse(java.lang.String moneyuse){
		this.moneyuse = moneyuse;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  列支地区
	 */
	@Column(name ="MONEYAREA",nullable=true,length=255)
	public java.lang.String getMoneyarea(){
		return this.moneyarea;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  列支地区
	 */
	public void setMoneyarea(java.lang.String moneyarea){
		this.moneyarea = moneyarea;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  资金来源
	 */
	@Column(name ="MONEYSOURCE",nullable=true,length=255)
	public java.lang.String getMoneysource(){
		return this.moneysource;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  资金来源
	 */
	public void setMoneysource(java.lang.String moneysource){
		this.moneysource = moneysource;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  采购年份
	 */
	@Column(name ="BUYYEAR",nullable=true,length=255)
	public java.lang.String getBuyyear(){
		return this.buyyear;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  采购年份
	 */
	public void setBuyyear(java.lang.String buyyear){
		this.buyyear = buyyear;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  采购项目号
	 */
	@Column(name ="BUYPROJECTNO",nullable=true,length=255)
	public java.lang.String getBuyprojectno(){
		return this.buyprojectno;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  采购项目号
	 */
	public void setBuyprojectno(java.lang.String buyprojectno){
		this.buyprojectno = buyprojectno;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  采购项目单位
	 */
	@Column(name ="BUYPROJECTORG",nullable=true,length=255)
	public java.lang.String getBuyprojectorg(){
		return this.buyprojectorg;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  采购项目单位
	 */
	public void setBuyprojectorg(java.lang.String buyprojectorg){
		this.buyprojectorg = buyprojectorg;
	}
	/**
	 *方法: 取得java.lang.Float
	 *@return: java.lang.Float  采购金额
	 */
	@Column(name ="BUYMONEY",nullable=true,precision=12)
	public java.lang.Float getBuymoney(){
		return this.buymoney;
	}

	/**
	 *方法: 设置java.lang.Float
	 *@param: java.lang.Float  采购金额
	 */
	public void setBuymoney(java.lang.Float buymoney){
		this.buymoney = buymoney;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  采购用途
	 */
	@Column(name ="BUYUSE",nullable=true,length=255)
	public java.lang.String getBuyuse(){
		return this.buyuse;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  采购用途
	 */
	public void setBuyuse(java.lang.String buyuse){
		this.buyuse = buyuse;
	}

	@OneToMany(mappedBy="finance",cascade={CascadeType.REMOVE})
	public List<TFinanceFilesEntity> getFinanceFiles() {
		return financeFiles;
	}

	public void setFinanceFiles(List<TFinanceFilesEntity> financeFiles) {
		this.financeFiles = financeFiles;
	}
}
