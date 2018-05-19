package org.jeecgframework.web.system.pojo.base;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;


/**
 * @author  张代浩
 * 项目附件父表(其他附件表需继承该表)
 */
@Entity
@Table(name = "t_s_attachment")
@Inheritance(strategy = InheritanceType.JOINED)
public  class TSAttachment extends IdEntity implements java.io.Serializable {
	
	
	/**
	 * serialVersionUID:TODO（用一句话描述这个变量表示什么）
	 * @since Ver 1.1
	 */
	
	private static final long serialVersionUID = 1L;
	private TSUser TSUser;// 创建人
	private String businessKey;// 业务类主键
	private String subclassname;// 子类名称全路径
	private String attachmenttitle;// 附件名称
	private byte[] attachmentcontent;// 附件内容
	private String realpath;// 附件物理路径
	private Timestamp createdate;
	private String note;
	private String swfpath;// swf格式路径
	private String extend;// 扩展名
	
	@Column(name = "extend", length = 32)
	public String getExtend() {
		return extend;
	}

	public void setExtend(String extend) {
		this.extend = extend;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userid")
	public TSUser getTSUser() {
		return this.TSUser;
	}

	public void setTSUser(TSUser TSUser) {
		this.TSUser = TSUser;
	}

	@Column(name = "businesskey", length = 32)
	public String getBusinessKey() {
		return businessKey;
	}

	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
	}

	@Column(name = "attachmenttitle", length = 100)
	public String getAttachmenttitle() {
		return this.attachmenttitle;
	}

	public void setAttachmenttitle(String attachmenttitle) {
		this.attachmenttitle = attachmenttitle;
	}

	@Column(name = "attachmentcontent",length=3000)
	@Lob
	public byte[] getAttachmentcontent() {
		return this.attachmentcontent;
	}

	public void setAttachmentcontent(byte[] attachmentcontent) {
		this.attachmentcontent = attachmentcontent;
	}

	@Column(name = "realpath", length = 100)
	public String getRealpath() {
		return this.realpath;
	}

	public void setRealpath(String realpath) {
		this.realpath = realpath;
	}


	@Column(name = "createdate", length = 35)
	public Timestamp getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Timestamp createdate) {
		this.createdate = createdate;
	}

	@Column(name = "note", length = 300)
	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Column(name = "swfpath", length = 300)
	public String getSwfpath() {
		return this.swfpath;
	}

	public void setSwfpath(String swfpath) {
		this.swfpath = swfpath;
	}
	@Column(name = "subclassname", length = 300)
	public String getSubclassname() {
		return subclassname;
	}

	public void setSubclassname(String subclassname) {
		this.subclassname = subclassname;
	}


}