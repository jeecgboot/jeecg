
package com.jeecg.demo.page;
import com.jeecg.demo.entity.JfromOrderEntity;
import com.jeecg.demo.entity.JfromOrderLineEntity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.excel.annotation.ExcelCollection;

/**   
 * @Title: Entity
 * @Description: 订单列表
 * @author onlineGenerator
 * @date 2017-12-14 13:36:56
 * @version V1.0   
 *
 */
public class JfromOrderPage implements java.io.Serializable {
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
	/**收货人*/
    @Excel(name="收货人")
	private java.lang.String receiverName;
	/**联系电话*/
    @Excel(name="联系电话")
	private java.lang.String receiverMobile;
	/**收货省*/
    @Excel(name="收货省")
	private java.lang.String receiverState;
	/**收货市*/
    @Excel(name="收货市")
	private java.lang.String receiverCity;
	/**收货区*/
    @Excel(name="收货区")
	private java.lang.String receiverDistrict;
	/**收货地址*/
    @Excel(name="收货地址")
	private java.lang.String receiverAddress;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
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
	 *@return: java.lang.String  收货人
	 */
	public java.lang.String getReceiverName(){
		return this.receiverName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货人
	 */
	public void setReceiverName(java.lang.String receiverName){
		this.receiverName = receiverName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  联系电话
	 */
	public java.lang.String getReceiverMobile(){
		return this.receiverMobile;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  联系电话
	 */
	public void setReceiverMobile(java.lang.String receiverMobile){
		this.receiverMobile = receiverMobile;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收货省
	 */
	public java.lang.String getReceiverState(){
		return this.receiverState;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货省
	 */
	public void setReceiverState(java.lang.String receiverState){
		this.receiverState = receiverState;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收货市
	 */
	public java.lang.String getReceiverCity(){
		return this.receiverCity;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货市
	 */
	public void setReceiverCity(java.lang.String receiverCity){
		this.receiverCity = receiverCity;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收货区
	 */
	public java.lang.String getReceiverDistrict(){
		return this.receiverDistrict;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货区
	 */
	public void setReceiverDistrict(java.lang.String receiverDistrict){
		this.receiverDistrict = receiverDistrict;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收货地址
	 */
	public java.lang.String getReceiverAddress(){
		return this.receiverAddress;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货地址
	 */
	public void setReceiverAddress(java.lang.String receiverAddress){
		this.receiverAddress = receiverAddress;
	}

	/**保存-订单表体*/
    @ExcelCollection(name="订单表体")
	private List<JfromOrderLineEntity> jfromOrderLineList = new ArrayList<JfromOrderLineEntity>();
		public List<JfromOrderLineEntity> getJfromOrderLineList() {
		return jfromOrderLineList;
		}
		public void setJfromOrderLineList(List<JfromOrderLineEntity> jfromOrderLineList) {
		this.jfromOrderLineList = jfromOrderLineList;
		}
}
