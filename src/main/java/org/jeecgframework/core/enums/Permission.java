package org.jeecgframework.core.enums;

/**
 * 许可类型
 *
 */
public enum Permission {
	/**普通权限*/
	NORMAL("0","默认"),
	/**跳过认证*/
	SKIP_AUTH("1","跳过拦截");
	
	private Permission(String key, String desc) {
		this.key = key;
		this.desc = desc;
	}
	private String key;
	private String desc;
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
}
