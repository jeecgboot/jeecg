package org.jeecgframework.web.system.pojo.base;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 通知公告用户授权表
 *  @author  alax
 */
@Entity
@Table(name = "t_s_notice_authority_user")
@SuppressWarnings("serial")
public class TSNoticeAuthorityUser extends IdEntity implements java.io.Serializable {

	private String noticeId;// 通告ID
	private TSUser user;//用户
	
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	
	@Column(name ="notice_id",nullable=true)
	public String getNoticeId() {
		return noticeId;
	}

	public void setUser(TSUser user) {
		this.user = user;
	}
	
	@ManyToOne
	@JoinColumn(name="user_id")
	public TSUser getUser() {
		return user;
	}

	}