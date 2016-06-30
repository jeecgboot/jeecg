package org.jeecgframework.web.system.pojo.base;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * TIcon entity.
 *  @author  张代浩
 */
@Entity
@Table(name = "t_s_icon")
public class TSIcon extends IdEntity implements java.io.Serializable {
	private String iconName;
	private Short iconType;
	private String iconPath;
	private byte[] iconContent;
	private String iconClas;
	private String extend;
	@Column(name = "name", nullable = false, length = 100)
	public String getIconName() {
		return this.iconName;
	}

	public void setIconName(String iconName) {
		this.iconName = iconName;
	}

	@Column(name = "type")
	public Short getIconType() {
		return this.iconType;
	}

	public void setIconType(Short iconType) {
		this.iconType = iconType;
	}

	@Column(name = "path", length = 300,precision =300)
	public String getIconPath() {
		return this.iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}
	@Column(name = "iconclas", length = 200)
	public String getIconClas() {
		return iconClas;
	}
	public void setIconClas(String iconClas) {
		this.iconClas = iconClas;
	}

	public void setIconContent(byte[] iconContent) {
		this.iconContent = iconContent;
	}
	@Column(name = "content",length = 1000,precision =3000)
	public byte[] getIconContent() {
		return iconContent;
	}
	@Column(name = "extend")
	public String getExtend() {
		return extend;
	}

	public void setExtend(String extend) {
		this.extend = extend;
	}

}