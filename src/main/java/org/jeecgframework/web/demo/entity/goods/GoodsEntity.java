package org.jeecgframework.web.demo.entity.goods;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 商品资料
 * @author onlineGenerator
 * @date 2016-06-01 21:16:32
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jfom_goods", schema = "")
@SuppressWarnings("serial")
public class GoodsEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**更新日期*/
	private java.util.Date updateDate;
	/**所属部门*/
	private java.lang.String sysOrgCode;
	/**所属公司*/
	private java.lang.String sysCompanyCode;
	/**流程状态*/
	private java.lang.String bpmStatus;
	/**商品名称*/
	@Excel(name="商品名称")
	private java.lang.String name;
	/**商品代码*/
	@Excel(name="商品代码")
	private java.lang.String code;
	/**商品全称*/
	@Excel(name="商品全称")
	private java.lang.String fullName;
	/**外部编码*/
	@Excel(name="外部编码")
	private java.lang.String outsideCode;
	/**厂家货号*/
	@Excel(name="厂家货号")
	private java.lang.String manufacturersNo;
	/**供应商*/
	@Excel(name="供应商")
	private java.lang.String supplier;
	/**单位*/
	@Excel(name="单位")
	private java.lang.String productUnit;
	/**货主*/
	@Excel(name="货主")
	private java.lang.String productOwner;
	/**品牌*/
	@Excel(name="品牌")
	private java.lang.String brand;
	/**年度*/
	@Excel(name="年度")
	private java.lang.String annual;
	/**季节*/
	@Excel(name="季节")
	private java.lang.String season;
	/**商品分类*/
	@Excel(name="商品分类")
	private java.lang.String productType;
	/**系列名称*/
	@Excel(name="系列名称")
	private java.lang.String seriesName;
	/**长度*/
	@Excel(name="长度")
	private java.lang.Double sizeLength;
	/**宽度*/
	@Excel(name="宽度")
	private java.lang.Double sizeWidth;
	/**高度*/
	@Excel(name="高度")
	private java.lang.Double sizeHeight;
	/**体积*/
	@Excel(name="体积")
	private java.lang.Double sizeVolume;
	/**上市时间*/
	@Excel(name="上市时间",format = "yyyy-MM-dd")
	private java.util.Date timeToMarket;
	/**成本价*/
	@Excel(name="成本价")
	private java.lang.Double priceCost;
	/**吊牌价*/
	@Excel(name="吊牌价")
	private java.lang.Double priceDrop;
	/**标准售价*/
	@Excel(name="标准售价")
	private java.lang.Double priceStandardSell;
	/**标准进价*/
	@Excel(name="标准进价")
	private java.lang.Double priceStandardBid;
	/**批发价*/
	@Excel(name="批发价")
	private java.lang.Double priceTrade;
	/**代理价*/
	@Excel(name="代理价")
	private java.lang.Double priceProxy;
	/**平台价*/
	@Excel(name="平台价")
	private java.lang.Double pricePlatform;
	/**赠品*/
	@Excel(name="赠品")
	private java.lang.String gift;
	/**虚拟商品*/
	@Excel(name="虚拟商品")
	private java.lang.String productVirtual;
	/**费用商品*/
	@Excel(name="费用商品")
	private java.lang.String productCost;
	/**打包点数*/
	@Excel(name="打包点数")
	private java.lang.String pointPack;
	/**销售点数*/
	@Excel(name="销售点数")
	private java.lang.String pointSell;
	/**唯一码商品*/
	@Excel(name="唯一码商品")
	private java.lang.String productUniquenessCode;
	/**批次管理*/
	@Excel(name="批次管理")
	private java.lang.String batchManage;
	/**单码商品*/
	@Excel(name="单码商品")
	private java.lang.String productSingleCode;
	/**保质期*/
	@Excel(name="保质期")
	private java.lang.String expirationDate;
	/**供货周期*/
	@Excel(name="供货周期")
	private java.lang.String supplyOfMaterialRound;
	/**安全库存*/
	@Excel(name="安全库存")
	private java.lang.String safetyInventory;
	/**国际码*/
	@Excel(name="国际码")
	private java.lang.String internationalCode;
	/**备注*/
	@Excel(name="备注")
	private java.lang.String remark;
	/**商品状态*/
	@Excel(name="商品状态")
	private java.lang.String productState;
	
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
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=50)
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名称
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人登录名称
	 */
	@Column(name ="CREATE_BY",nullable=true,length=50)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人登录名称
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */
	@Column(name ="CREATE_DATE",nullable=true,length=20)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=50)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人登录名称
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=50)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人登录名称
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */
	@Column(name ="UPDATE_DATE",nullable=true,length=20)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  更新日期
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属部门
	 */
	@Column(name ="SYS_ORG_CODE",nullable=true,length=50)
	public java.lang.String getSysOrgCode(){
		return this.sysOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属部门
	 */
	public void setSysOrgCode(java.lang.String sysOrgCode){
		this.sysOrgCode = sysOrgCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属公司
	 */
	@Column(name ="SYS_COMPANY_CODE",nullable=true,length=50)
	public java.lang.String getSysCompanyCode(){
		return this.sysCompanyCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属公司
	 */
	public void setSysCompanyCode(java.lang.String sysCompanyCode){
		this.sysCompanyCode = sysCompanyCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  流程状态
	 */
	@Column(name ="BPM_STATUS",nullable=true,length=32)
	public java.lang.String getBpmStatus(){
		return this.bpmStatus;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  流程状态
	 */
	public void setBpmStatus(java.lang.String bpmStatus){
		this.bpmStatus = bpmStatus;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  商品名称
	 */
	@Column(name ="NAME",nullable=true,length=32)
	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  商品名称
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  商品代码
	 */
	@Column(name ="CODE",nullable=true,length=32)
	public java.lang.String getCode(){
		return this.code;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  商品代码
	 */
	public void setCode(java.lang.String code){
		this.code = code;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  商品全称
	 */
	@Column(name ="FULL_NAME",nullable=true,length=32)
	public java.lang.String getFullName(){
		return this.fullName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  商品全称
	 */
	public void setFullName(java.lang.String fullName){
		this.fullName = fullName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  外部编码
	 */
	@Column(name ="OUTSIDE_CODE",nullable=true,length=32)
	public java.lang.String getOutsideCode(){
		return this.outsideCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  外部编码
	 */
	public void setOutsideCode(java.lang.String outsideCode){
		this.outsideCode = outsideCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  厂家货号
	 */
	@Column(name ="MANUFACTURERS_NO",nullable=true,length=32)
	public java.lang.String getManufacturersNo(){
		return this.manufacturersNo;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  厂家货号
	 */
	public void setManufacturersNo(java.lang.String manufacturersNo){
		this.manufacturersNo = manufacturersNo;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  供应商
	 */
	@Column(name ="SUPPLIER",nullable=true,length=32)
	public java.lang.String getSupplier(){
		return this.supplier;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  供应商
	 */
	public void setSupplier(java.lang.String supplier){
		this.supplier = supplier;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  单位
	 */
	@Column(name ="PRODUCT_UNIT",nullable=true,length=32)
	public java.lang.String getProductUnit(){
		return this.productUnit;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  单位
	 */
	public void setProductUnit(java.lang.String productUnit){
		this.productUnit = productUnit;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  货主
	 */
	@Column(name ="PRODUCT_OWNER",nullable=true,length=32)
	public java.lang.String getProductOwner(){
		return this.productOwner;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  货主
	 */
	public void setProductOwner(java.lang.String productOwner){
		this.productOwner = productOwner;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  品牌
	 */
	@Column(name ="BRAND",nullable=true,length=32)
	public java.lang.String getBrand(){
		return this.brand;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  品牌
	 */
	public void setBrand(java.lang.String brand){
		this.brand = brand;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  年度
	 */
	@Column(name ="ANNUAL",nullable=true,length=32)
	public java.lang.String getAnnual(){
		return this.annual;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  年度
	 */
	public void setAnnual(java.lang.String annual){
		this.annual = annual;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  季节
	 */
	@Column(name ="SEASON",nullable=true,length=32)
	public java.lang.String getSeason(){
		return this.season;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  季节
	 */
	public void setSeason(java.lang.String season){
		this.season = season;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  商品分类
	 */
	@Column(name ="PRODUCT_TYPE",nullable=true,length=32)
	public java.lang.String getProductType(){
		return this.productType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  商品分类
	 */
	public void setProductType(java.lang.String productType){
		this.productType = productType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  系列名称
	 */
	@Column(name ="SERIES_NAME",nullable=true,length=32)
	public java.lang.String getSeriesName(){
		return this.seriesName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  系列名称
	 */
	public void setSeriesName(java.lang.String seriesName){
		this.seriesName = seriesName;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  长度
	 */
	@Column(name ="SIZE_LENGTH",nullable=true,length=32)
	public java.lang.Double getSizeLength(){
		return this.sizeLength;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  长度
	 */
	public void setSizeLength(java.lang.Double sizeLength){
		this.sizeLength = sizeLength;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  宽度
	 */
	@Column(name ="SIZE_WIDTH",nullable=true,length=32)
	public java.lang.Double getSizeWidth(){
		return this.sizeWidth;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  宽度
	 */
	public void setSizeWidth(java.lang.Double sizeWidth){
		this.sizeWidth = sizeWidth;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  高度
	 */
	@Column(name ="SIZE_HEIGHT",nullable=true,length=32)
	public java.lang.Double getSizeHeight(){
		return this.sizeHeight;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  高度
	 */
	public void setSizeHeight(java.lang.Double sizeHeight){
		this.sizeHeight = sizeHeight;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  体积
	 */
	@Column(name ="SIZE_VOLUME",nullable=true,length=32)
	public java.lang.Double getSizeVolume(){
		return this.sizeVolume;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  体积
	 */
	public void setSizeVolume(java.lang.Double sizeVolume){
		this.sizeVolume = sizeVolume;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  上市时间
	 */
	@Column(name ="TIME_TO_MARKET",nullable=true,length=32)
	public java.util.Date getTimeToMarket(){
		return this.timeToMarket;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  上市时间
	 */
	public void setTimeToMarket(java.util.Date timeToMarket){
		this.timeToMarket = timeToMarket;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  成本价
	 */
	@Column(name ="PRICE_COST",nullable=true,length=32)
	public java.lang.Double getPriceCost(){
		return this.priceCost;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  成本价
	 */
	public void setPriceCost(java.lang.Double priceCost){
		this.priceCost = priceCost;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  吊牌价
	 */
	@Column(name ="PRICE_DROP",nullable=true,length=32)
	public java.lang.Double getPriceDrop(){
		return this.priceDrop;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  吊牌价
	 */
	public void setPriceDrop(java.lang.Double priceDrop){
		this.priceDrop = priceDrop;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  标准售价
	 */
	@Column(name ="PRICE_STANDARD_SELL",nullable=true,length=32)
	public java.lang.Double getPriceStandardSell(){
		return this.priceStandardSell;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  标准售价
	 */
	public void setPriceStandardSell(java.lang.Double priceStandardSell){
		this.priceStandardSell = priceStandardSell;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  标准进价
	 */
	@Column(name ="PRICE_STANDARD_BID",nullable=true,length=32)
	public java.lang.Double getPriceStandardBid(){
		return this.priceStandardBid;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  标准进价
	 */
	public void setPriceStandardBid(java.lang.Double priceStandardBid){
		this.priceStandardBid = priceStandardBid;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  批发价
	 */
	@Column(name ="PRICE_TRADE",nullable=true,length=32)
	public java.lang.Double getPriceTrade(){
		return this.priceTrade;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  批发价
	 */
	public void setPriceTrade(java.lang.Double priceTrade){
		this.priceTrade = priceTrade;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  代理价
	 */
	@Column(name ="PRICE_PROXY",nullable=true,length=32)
	public java.lang.Double getPriceProxy(){
		return this.priceProxy;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  代理价
	 */
	public void setPriceProxy(java.lang.Double priceProxy){
		this.priceProxy = priceProxy;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  平台价
	 */
	@Column(name ="PRICE_PLATFORM",nullable=true,length=32)
	public java.lang.Double getPricePlatform(){
		return this.pricePlatform;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  平台价
	 */
	public void setPricePlatform(java.lang.Double pricePlatform){
		this.pricePlatform = pricePlatform;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  赠品
	 */
	@Column(name ="GIFT",nullable=true,length=32)
	public java.lang.String getGift(){
		return this.gift;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  赠品
	 */
	public void setGift(java.lang.String gift){
		this.gift = gift;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  虚拟商品
	 */
	@Column(name ="PRODUCT_VIRTUAL",nullable=true,length=32)
	public java.lang.String getProductVirtual(){
		return this.productVirtual;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  虚拟商品
	 */
	public void setProductVirtual(java.lang.String productVirtual){
		this.productVirtual = productVirtual;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  费用商品
	 */
	@Column(name ="PRODUCT_COST",nullable=true,length=32)
	public java.lang.String getProductCost(){
		return this.productCost;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  费用商品
	 */
	public void setProductCost(java.lang.String productCost){
		this.productCost = productCost;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  打包点数
	 */
	@Column(name ="POINT_PACK",nullable=true,length=32)
	public java.lang.String getPointPack(){
		return this.pointPack;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  打包点数
	 */
	public void setPointPack(java.lang.String pointPack){
		this.pointPack = pointPack;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  销售点数
	 */
	@Column(name ="POINT_SELL",nullable=true,length=32)
	public java.lang.String getPointSell(){
		return this.pointSell;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  销售点数
	 */
	public void setPointSell(java.lang.String pointSell){
		this.pointSell = pointSell;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  唯一码商品
	 */
	@Column(name ="PRODUCT_UNIQUENESS_CODE",nullable=true,length=32)
	public java.lang.String getProductUniquenessCode(){
		return this.productUniquenessCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  唯一码商品
	 */
	public void setProductUniquenessCode(java.lang.String productUniquenessCode){
		this.productUniquenessCode = productUniquenessCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  批次管理
	 */
	@Column(name ="BATCH_MANAGE",nullable=true,length=32)
	public java.lang.String getBatchManage(){
		return this.batchManage;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  批次管理
	 */
	public void setBatchManage(java.lang.String batchManage){
		this.batchManage = batchManage;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  单码商品
	 */
	@Column(name ="PRODUCT_SINGLE_CODE",nullable=true,length=32)
	public java.lang.String getProductSingleCode(){
		return this.productSingleCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  单码商品
	 */
	public void setProductSingleCode(java.lang.String productSingleCode){
		this.productSingleCode = productSingleCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  保质期
	 */
	@Column(name ="EXPIRATION_DATE",nullable=true,length=32)
	public java.lang.String getExpirationDate(){
		return this.expirationDate;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  保质期
	 */
	public void setExpirationDate(java.lang.String expirationDate){
		this.expirationDate = expirationDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  供货周期
	 */
	@Column(name ="SUPPLY_OF_MATERIAL_ROUND",nullable=true,length=32)
	public java.lang.String getSupplyOfMaterialRound(){
		return this.supplyOfMaterialRound;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  供货周期
	 */
	public void setSupplyOfMaterialRound(java.lang.String supplyOfMaterialRound){
		this.supplyOfMaterialRound = supplyOfMaterialRound;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  安全库存
	 */
	@Column(name ="SAFETY_INVENTORY",nullable=true,length=32)
	public java.lang.String getSafetyInventory(){
		return this.safetyInventory;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  安全库存
	 */
	public void setSafetyInventory(java.lang.String safetyInventory){
		this.safetyInventory = safetyInventory;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  国际码
	 */
	@Column(name ="INTERNATIONAL_CODE",nullable=true,length=32)
	public java.lang.String getInternationalCode(){
		return this.internationalCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  国际码
	 */
	public void setInternationalCode(java.lang.String internationalCode){
		this.internationalCode = internationalCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */
	@Column(name ="REMARK",nullable=true,length=200)
	public java.lang.String getRemark(){
		return this.remark;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setRemark(java.lang.String remark){
		this.remark = remark;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  商品状态
	 */
	@Column(name ="PRODUCT_STATE",nullable=true,length=32)
	public java.lang.String getProductState(){
		return this.productState;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  商品状态
	 */
	public void setProductState(java.lang.String productState){
		this.productState = productState;
	}
}
