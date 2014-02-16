package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;
/**
 * 程序版本控制表
 * @author 张代浩
 *
 */
@Entity
@Table(name = "t_s_version")
public class TSVersion extends IdEntity implements java.io.Serializable {
	private String versionName;//版本名称
	private String versionCode;//版本编码
	private String loginPage;//登陆入口页面
	private String versionNum;//版本号
	@Column(name = "versionname", length = 30)
	public String getVersionName() {
		return versionName;
	}
	public void setVersionName(String versionName) {
		this.versionName = versionName;
	}
	
	@Column(name = "versioncode", length = 50)
	public String getVersionCode() {
		return versionCode;
	}
	public void setVersionCode(String versionCode) {
		this.versionCode = versionCode;
	}
	@Column(name = "loginpage", length = 100)
	public String getLoginPage() {
		return loginPage;
	}
	public void setLoginPage(String loginPage) {
		this.loginPage = loginPage;
	}
	@Column(name = "versionnum", length = 20)
	public String getVersionNum() {
		return versionNum;
	}
	public void setVersionNum(String versionNum) {
		this.versionNum = versionNum;
	}
}
