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
 * @Description: 用户-公司-职务关联表
 * @author onlineGenerator
 * @date 2017-11-09 16:55:01
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_s_user_position_rel", schema = "")
@SuppressWarnings("serial")
public class TSUserPositionRelEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**用户id*/
	@Excel(name="用户id",width=15)
	private java.lang.String userId;
	/**职务id*/
	@Excel(name="职务id",width=15)
	private java.lang.String positionId;
	/**公司ID*/
	@Excel(name="公司ID",width=15)
	private java.lang.String companyId;
	
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
	 *@return: java.lang.String  用户id
	 */

	@Column(name ="USER_ID",nullable=true,length=32)
	public java.lang.String getUserId(){
		return this.userId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  用户id
	 */
	public void setUserId(java.lang.String userId){
		this.userId = userId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职务id
	 */

	@Column(name ="POSITION_ID",nullable=true,length=32)
	public java.lang.String getPositionId(){
		return this.positionId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职务id
	 */
	public void setPositionId(java.lang.String positionId){
		this.positionId = positionId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  公司ID
	 */

	@Column(name ="COMPANY_ID",nullable=true,length=32)
	public java.lang.String getCompanyId(){
		return this.companyId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  公司ID
	 */
	public void setCompanyId(java.lang.String companyId){
		this.companyId = companyId;
	}
}
