package org.jeecgframework.tag.vo.easyui;

/**
 * Carousel
 * 
 * @author 张代浩
 * 
 */
public class Carousel {
	private String path; //图片路径
	private String message; //图片信息描述
	private boolean active=false; //当前显示项
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	 

}
