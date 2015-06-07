package org.jeecgframework.tag.vo.easyui;

/**
 * TAB模型
 * 
 * @author 张代浩
 * 
 */
public class TabMenu {
	private String classLi ;//li上样式
	private String url;    //url地址
 	private String title;//名称
	private String icon;//标签图标
	private String iconColor;//标签图标颜色
	private boolean tab=true;//是否为可切换标签页
	public boolean isTab() {
		return tab;
	}
	public void setTab(boolean tab) {
		this.tab = tab;
	}
	public String getClassLi() {
		return classLi;
	}
	public void setClassLi(String classLi) {
		this.classLi = classLi;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIconColor() {
		return iconColor;
	}
	public void setIconColor(String iconColor) {
		this.iconColor = iconColor;
	}
 
	
}
