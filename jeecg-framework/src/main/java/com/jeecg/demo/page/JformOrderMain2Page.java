
package com.jeecg.demo.page;
import com.jeecg.demo.entity.JformOrderMain2Entity;
import com.jeecg.demo.entity.JformOrderTicket2Entity;
import com.jeecg.demo.entity.JformOrderCustomer2Entity;

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
 * @Description: 订单主信息
 * @author onlineGenerator
 * @date 2018-03-27 16:21:58
 * @version V1.0   
 *
 */
public class JformOrderMain2Page implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**订单号*/
    @Excel(name="订单号")
	private java.lang.String orderCode;
	/**订单日期*/
    @Excel(name="订单日期",format = "yyyy-MM-dd")
	private java.util.Date orderDate;
	/**订单金额*/
    @Excel(name="订单金额")
	private java.lang.Double orderMoney;
	/**备注*/
    @Excel(name="备注")
	private java.lang.String content;
	
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
	 *@return: java.lang.String  订单号
	 */
	public java.lang.String getOrderCode(){
		return this.orderCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  订单号
	 */
	public void setOrderCode(java.lang.String orderCode){
		this.orderCode = orderCode;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  订单日期
	 */
	public java.util.Date getOrderDate(){
		return this.orderDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  订单日期
	 */
	public void setOrderDate(java.util.Date orderDate){
		this.orderDate = orderDate;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  订单金额
	 */
	public java.lang.Double getOrderMoney(){
		return this.orderMoney;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  订单金额
	 */
	public void setOrderMoney(java.lang.Double orderMoney){
		this.orderMoney = orderMoney;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注
	 */
	public java.lang.String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注
	 */
	public void setContent(java.lang.String content){
		this.content = content;
	}

	/**保存-订单机票信息*/
    @ExcelCollection(name="订单机票信息")
	private List<JformOrderTicket2Entity> jformOrderTicket2List = new ArrayList<JformOrderTicket2Entity>();
		public List<JformOrderTicket2Entity> getJformOrderTicket2List() {
		return jformOrderTicket2List;
		}
		public void setJformOrderTicket2List(List<JformOrderTicket2Entity> jformOrderTicket2List) {
		this.jformOrderTicket2List = jformOrderTicket2List;
		}
	/**保存-订单客户信息*/
    @ExcelCollection(name="订单客户信息")
	private List<JformOrderCustomer2Entity> jformOrderCustomer2List = new ArrayList<JformOrderCustomer2Entity>();
		public List<JformOrderCustomer2Entity> getJformOrderCustomer2List() {
		return jformOrderCustomer2List;
		}
		public void setJformOrderCustomer2List(List<JformOrderCustomer2Entity> jformOrderCustomer2List) {
		this.jformOrderCustomer2List = jformOrderCustomer2List;
		}
}
