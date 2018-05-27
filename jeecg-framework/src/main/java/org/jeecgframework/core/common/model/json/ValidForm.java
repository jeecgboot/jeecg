package org.jeecgframework.core.common.model.json;


/**
 * $.ajax后需要接受的JSON
 * 
 * @author
 * 
 */
public class ValidForm {

	private String status ="y";// 是否成功
	private String info = "验证通过";//提示信息
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	
}
