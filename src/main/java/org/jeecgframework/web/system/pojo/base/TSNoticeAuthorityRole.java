package org.jeecgframework.web.system.pojo.base;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 通知公告角色授权表
 *  @author  alax
 */
@Entity
@Table(name = "t_s_notice_authority_role")
@SuppressWarnings("serial")
public class TSNoticeAuthorityRole extends IdEntity implements java.io.Serializable {

	private String noticeId;// 通告ID
	private TSRole role;// 
	
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	
	@Column(name ="notice_id",nullable=true)
	public String getNoticeId() {
		return noticeId;
	}

	public void setRole(TSRole role) {
		this.role = role;
	}
	
	@ManyToOne
	@JoinColumn(name="role_id")
	public TSRole getRole() {
		return role;
	}


	}