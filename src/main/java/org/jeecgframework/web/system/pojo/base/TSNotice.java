package org.jeecgframework.web.system.pojo.base;
// default package

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 通知公告表
 *  @author  alax
 */
@Entity
@Table(name = "t_s_notice")
@SuppressWarnings("serial")
public class TSNotice extends IdEntity implements java.io.Serializable {

	private String noticeTitle;// 通告标题
	private String noticeContent;// 通告内容
	private String noticeType;// 通知公告类型（1：通知，2:公告）
	private String noticeLevel;// 通告授权级别（1:全员，2：角色，3：用户）
	private Date noticeTerm; //阅读期限
	private String createUser; //创建者
	private Date createTime;  //创建时间
	private String isRead; //是否已读(0:未读，1：已读)
	
	@Column(name ="notice_title",nullable=true)
	public String getNoticeTitle() {
		return noticeTitle;
	}
	
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	
	@Column(name ="notice_content",nullable=true)
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	
	@Column(name ="notice_type",nullable=true)
	public String getNoticeType() {
		return noticeType;
	}
	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}
	
	@Column(name ="notice_level",nullable=true)
	public String getNoticeLevel() {
		return noticeLevel;
	}
	public void setNoticeLevel(String noticeLevel) {
		this.noticeLevel = noticeLevel;
	}
	
	@Column(name ="notice_term",nullable=true)
	public Date getNoticeTerm() {
		return noticeTerm;
	}
	public void setNoticeTerm(Date noticeTerm) {
		this.noticeTerm = noticeTerm;
	}
	
	@Column(name ="create_user",nullable=true)
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	
	@Column(name ="create_time",nullable=true)
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	
	@Transient
	public String getIsRead() {
		return isRead;
	}
}