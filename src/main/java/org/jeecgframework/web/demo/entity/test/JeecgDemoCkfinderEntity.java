package org.jeecgframework.web.demo.entity.test;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * @Title: Entity
 * @Description: ckeditor+ckfinder例子
 * @author Alexander
 * @date 2013-09-19 18:29:21
 * @version V1.0
 * 
 */
@Entity
@Table(name = "ck_finder", schema = "")
@SuppressWarnings("serial")
public class JeecgDemoCkfinderEntity implements java.io.Serializable {
	/** id */
	private java.lang.String id;
	/** 图片 */
	private java.lang.String image;
	/** 附件 */
	private java.lang.String attachment;
	/** 备注 */
	private java.lang.String remark;

	/**
	 * 方法: 取得java.lang.String
	 * 
	 * @return: java.lang.String id
	 */

	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name = "ID", nullable = false, length = 32)
	public java.lang.String getId() {
		return this.id;
	}

	/**
	 * 方法: 设置java.lang.String
	 * 
	 * @param: java.lang.String id
	 */
	public void setId(java.lang.String id) {
		this.id = id;
	}

	/**
	 * 方法: 取得java.lang.String
	 * 
	 * @return: java.lang.String 图片
	 */
	@Column(name = "IMAGE", nullable = true, length = 255)
	public java.lang.String getImage() {
		return this.image;
	}

	/**
	 * 方法: 设置java.lang.String
	 * 
	 * @param: java.lang.String 图片
	 */
	public void setImage(java.lang.String image) {
		this.image = image;
	}

	/**
	 * 方法: 取得java.lang.String
	 * 
	 * @return: java.lang.String 附件
	 */
	@Column(name = "ATTACHMENT", nullable = true, length = 255)
	public java.lang.String getAttachment() {
		return this.attachment;
	}

	/**
	 * 方法: 设置java.lang.String
	 * 
	 * @param: java.lang.String 附件
	 */
	public void setAttachment(java.lang.String attachment) {
		this.attachment = attachment;
	}

	/**
	 * 方法: 取得java.lang.Object
	 * 
	 * @return: java.lang.Object 备注
	 */
	@Lob
	@Basic(fetch = FetchType.LAZY)
	@Column(name = "REMARK", nullable = true)
	public java.lang.String getRemark() {
		return this.remark;
	}

	/**
	 * 方法: 设置java.lang.Object
	 * 
	 * @param: java.lang.Object 备注
	 */
	public void setRemark(java.lang.String remark) {
		this.remark = remark;
	}
}
