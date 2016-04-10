package org.jeecgframework.web.system.pojo.base;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

/**
 * 邮件附件
 * @author 许国杰
 */
@Entity
@Table(name = "jform_inner_mail_attach")
@PrimaryKeyJoinColumn(name = "id")
public class JformInnerMailAttach extends TSAttachment implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mailid;// 邮件id
	
	@Column(name = "mailid", length = 100)
	public String getMailid() {
		return mailid;
	}
	public void setMailid(String mailid) {
		this.mailid = mailid;
	}
	
	
}