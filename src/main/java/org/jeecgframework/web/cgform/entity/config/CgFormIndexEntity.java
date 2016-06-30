package org.jeecgframework.web.cgform.entity.config;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;

import javax.xml.soap.Text;

import java.sql.Blob;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.ForeignKey;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.SequenceGenerator;

import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 索引表
 * @author onlineGenerator
 * @date 2016-06-09 20:39:52
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_index", schema = "")
@SuppressWarnings("serial")
public class CgFormIndexEntity implements java.io.Serializable {
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
	/**索引名称*/
	@Excel(name="索引名称")
	private java.lang.String indexName;
	/**索引栏位*/
	@Excel(name="索引栏位")
	private java.lang.String indexField;
	/**索引类型*/
	@Excel(name="索引类型")
	private java.lang.String indexType;
	/**关联的表*/
	private CgFormHeadEntity table;
	
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
	 *@return: java.lang.String  索引名称
	 */
	@Column(name ="INDEX_NAME",nullable=true,length=100)
	public java.lang.String getIndexName(){
		return this.indexName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  索引名称
	 */
	public void setIndexName(java.lang.String indexName){
		this.indexName = indexName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  索引栏位
	 */
	@Column(name ="INDEX_FIELD",nullable=true,length=500)
	public java.lang.String getIndexField(){
		return this.indexField;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  索引栏位
	 */
	public void setIndexField(java.lang.String indexField){
		this.indexField = indexField;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  索引类型
	 */
	@Column(name ="INDEX_TYPE",nullable=true,length=32)
	public java.lang.String getIndexType(){
		return this.indexType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  索引类型
	 */
	public void setIndexType(java.lang.String indexType){
		this.indexType = indexType;
	}
	/**
	 *方法: 取得TablePropertyEntity
	 *@return: TablePropertyEntity  关联的表ＩＤ
	 */
	@ManyToOne
	@JoinColumn(name ="table_id",nullable=false,referencedColumnName="id")
	@JsonIgnore
	@ForeignKey(name="null")
	public CgFormHeadEntity getTable(){
		return this.table;
	}

	/**
	 *方法: 设置TablePropertyEntity
	 *@param: TablePropertyEntity  关联的表ID
	 */
	public void setTable(CgFormHeadEntity table){
		this.table = table;
	}
}
