package org.jeecgframework.web.demo.entity.test;

import java.sql.Blob;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**   
 * @Title: Entity
 * @Description: Blob型数据操作例子
 * @author 张代浩
 * @date 2013-06-07 14:46:09
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_s_attachment", schema = "")
@SuppressWarnings("serial")
public class JeecgBlobDataEntity implements java.io.Serializable {
	/**主键ID*/
	private java.lang.String id;
	/**用户ID*/
	private java.lang.String userid;
	/**businesskey*/
	private java.lang.String businesskey;
	/**类型ID*/
	private java.lang.String infotypeid;
	/**attachmenttitle*/
	private java.lang.String attachmenttitle;
	/**附件路径*/
	private java.lang.String realpath;
	/**subclassname*/
	private java.lang.String subclassname;
	/**createdate*/
	private java.util.Date createdate;
	/**附件内容*/
	private Blob attachmentcontent;
	/**flash路径*/
	private java.lang.String swfpath;
	/**note*/
	private java.lang.String note;
	/**extend*/
	private java.lang.String extend;
	/**busentityname*/
	private java.lang.String busentityname;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键ID
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
	 *@param: java.lang.String  主键ID
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  用户ID
	 */
	@Column(name ="USERID",nullable=true,length=32)
	public java.lang.String getUserid(){
		return this.userid;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  用户ID
	 */
	public void setUserid(java.lang.String userid){
		this.userid = userid;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  businesskey
	 */
	@Column(name ="BUSINESSKEY",nullable=true,length=32)
	public java.lang.String getBusinesskey(){
		return this.businesskey;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  businesskey
	 */
	public void setBusinesskey(java.lang.String businesskey){
		this.businesskey = businesskey;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  类型ID
	 */
	@Column(name ="INFOTYPEID",nullable=true,length=32)
	public java.lang.String getInfotypeid(){
		return this.infotypeid;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  类型ID
	 */
	public void setInfotypeid(java.lang.String infotypeid){
		this.infotypeid = infotypeid;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  attachmenttitle
	 */
	@Column(name ="ATTACHMENTTITLE",nullable=true,length=100)
	public java.lang.String getAttachmenttitle(){
		return this.attachmenttitle;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  attachmenttitle
	 */
	public void setAttachmenttitle(java.lang.String attachmenttitle){
		this.attachmenttitle = attachmenttitle;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  附件路径
	 */
	@Column(name ="REALPATH",nullable=true,length=100)
	public java.lang.String getRealpath(){
		return this.realpath;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  附件路径
	 */
	public void setRealpath(java.lang.String realpath){
		this.realpath = realpath;
	}
	/**
	 *方法: 取得java.lang.Object
	 *@return: java.lang.Object  subclassname
	 */
	@Column(name ="SUBCLASSNAME",nullable=true,length=65535)
	public java.lang.String getSubclassname(){
		return this.subclassname;
	}

	/**
	 *方法: 设置java.lang.Object
	 *@param: java.lang.Object  subclassname
	 */
	public void setSubclassname(java.lang.String subclassname){
		this.subclassname = subclassname;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  createdate
	 */
	@Column(name ="CREATEDATE",nullable=true)
	public java.util.Date getCreatedate(){
		return this.createdate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  createdate
	 */
	public void setCreatedate(java.util.Date createdate){
		this.createdate = createdate;
	}
	/**
	 *方法: 取得byte[]
	 *@return: byte[]  附件内容
	 */
	@Column(name ="ATTACHMENTCONTENT",length=3000)
	public Blob getAttachmentcontent(){
		return this.attachmentcontent;
	}

	/**
	 *方法: 设置byte[]
	 *@param: byte[]  附件内容
	 */
	public void setAttachmentcontent(Blob attachmentcontent){
		this.attachmentcontent = attachmentcontent;
	}
	/**
	 *方法: 取得java.lang.Object
	 *@return: java.lang.Object  flash路径
	 */
	@Column(name ="SWFPATH",nullable=true,length=65535)
	public java.lang.String getSwfpath(){
		return this.swfpath;
	}

	/**
	 *方法: 设置java.lang.Object
	 *@param: java.lang.Object  flash路径
	 */
	public void setSwfpath(java.lang.String swfpath){
		this.swfpath = swfpath;
	}
	/**
	 *方法: 取得java.lang.Object
	 *@return: java.lang.Object  note
	 */
	@Column(name ="NOTE",nullable=true,length=65535)
	public java.lang.String getNote(){
		return this.note;
	}

	/**
	 *方法: 设置java.lang.Object
	 *@param: java.lang.Object  note
	 */
	public void setNote(java.lang.String note){
		this.note = note;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  extend
	 */
	@Column(name ="EXTEND",nullable=true,length=32)
	public java.lang.String getExtend(){
		return this.extend;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  extend
	 */
	public void setExtend(java.lang.String extend){
		this.extend = extend;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  busentityname
	 */
	@Column(name ="BUSENTITYNAME",nullable=true,length=100)
	public java.lang.String getBusentityname(){
		return this.busentityname;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  busentityname
	 */
	public void setBusentityname(java.lang.String busentityname){
		this.busentityname = busentityname;
	}
}
