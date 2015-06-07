package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: 定时任务管理
 * @author JueYue
 * @date 2013-09-21 20:47:43
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_s_timetask", schema = "")
@DynamicUpdate(true)
@DynamicInsert(true)
@SuppressWarnings("serial")
public class TSTimeTaskEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**任务ID*/
	private java.lang.String taskId;
	/**任务描述*/
	private java.lang.String taskDescribe;
	/**cron表达式*/
	private java.lang.String cronExpression;
	/**是否生效了0未生效,1生效了*/
	private java.lang.String isEffect;
	/**是否运行0停止,1运行*/
	private java.lang.String isStart;
	/**创建时间*/
	private java.util.Date createDate;
	/**创建人ID*/
	private java.lang.String createBy;
	/**创建人名称*/
	private java.lang.String createName;
	/**修改时间*/
	private java.util.Date updateDate;
	/**修改人ID*/
	private java.lang.String updateBy;
	/**修改人名称*/
	private java.lang.String updateName;
	
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
	 *@return: java.lang.String  任务ID
	 */
	@Column(name ="TASK_ID",nullable=false,length=100)
	public java.lang.String getTaskId(){
		return this.taskId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  任务ID
	 */
	public void setTaskId(java.lang.String taskId){
		this.taskId = taskId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  任务描述
	 */
	@Column(name ="TASK_DESCRIBE",nullable=false,length=50)
	public java.lang.String getTaskDescribe(){
		return this.taskDescribe;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  任务描述
	 */
	public void setTaskDescribe(java.lang.String taskDescribe){
		this.taskDescribe = taskDescribe;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  cron表达式
	 */
	@Column(name ="CRON_EXPRESSION",nullable=false,length=100)
	public java.lang.String getCronExpression(){
		return this.cronExpression;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  cron表达式
	 */
	public void setCronExpression(java.lang.String cronExpression){
		this.cronExpression = cronExpression;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否生效了0未生效,1生效了
	 */
	@Column(name ="IS_EFFECT",nullable=false,length=1)
	public java.lang.String getIsEffect(){
		return this.isEffect;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否生效了0未生效,1生效了
	 */
	public void setIsEffect(java.lang.String isEffect){
		this.isEffect = isEffect;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String 是否运行0停止,1运行
	 */
	@Column(name ="IS_START",nullable=false,length=1)
	public java.lang.String getIsStart(){
		return this.isStart;
	}
	
	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否运行0停止,1运行
	 */
	public void setIsStart(java.lang.String isStart){
		this.isStart = isStart;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建时间
	 */
	@Column(name ="CREATE_DATE",nullable=true)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建时间
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人ID
	 */
	@Column(name ="CREATE_BY",nullable=true,length=32)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人ID
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=32)
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
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  修改时间
	 */
	@Column(name ="UPDATE_DATE",nullable=true)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  修改时间
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人ID
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=32)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人ID
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人名称
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=32)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
}
