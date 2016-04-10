package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 内部邮件
 * @author onlineGenerator
 * @date 2016-03-13 20:09:29
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jform_inner_mail", schema = "")
@SuppressWarnings("serial")
public class JformInnerMailEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.util.Date createDate;
	/**主题*/
	@Excel(name="主题")
	private java.lang.String title;
	/**附件*/
	@Excel(name="附件")
	private java.lang.String attachment;
	/**内容*/
	@Excel(name="内容")
	private java.lang.String content;
	/**状态*/
	private java.lang.String status;
	/**接收者姓名列表*/
	private java.lang.String receiverNames;
	/**收件人标识列表*/
	@Excel(name="收件人标识列表")
	private java.lang.String receiverIds;
	
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
	 *@return: java.lang.String  主题
	 */
	@Column(name ="TITLE",nullable=true,length=100)
	public java.lang.String getTitle(){
		return this.title;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主题
	 */
	public void setTitle(java.lang.String title){
		this.title = title;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  附件
	 */
	@Column(name ="ATTACHMENT",nullable=true,length=1000)
	public java.lang.String getAttachment(){
		return this.attachment;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  附件
	 */
	public void setAttachment(java.lang.String attachment){
		this.attachment = attachment;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  内容
	 */
	@Column(name ="CONTENT",nullable=true,length=2000)
	public java.lang.String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  内容
	 */
	public void setContent(java.lang.String content){
		this.content = content;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  状态
	 */
	@Column(name ="STATUS",nullable=true,length=50)
	public java.lang.String getStatus(){
		return this.status;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  状态
	 */
	public void setStatus(java.lang.String status){
		this.status = status;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  接收者姓名列表
	 */
	@Column(name ="RECEIVER_NAMES",nullable=true,length=300)
	public java.lang.String getReceiverNames(){
		return this.receiverNames;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  接收者姓名列表
	 */
	public void setReceiverNames(java.lang.String receiverNames){
		this.receiverNames = receiverNames;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收件人标识列表
	 */
	@Column(name ="RECEIVER_IDS",nullable=true,length=300)
	public java.lang.String getReceiverIds(){
		return this.receiverIds;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收件人标识列表
	 */
	public void setReceiverIds(java.lang.String receiverIds){
		this.receiverIds = receiverIds;
	}
}
