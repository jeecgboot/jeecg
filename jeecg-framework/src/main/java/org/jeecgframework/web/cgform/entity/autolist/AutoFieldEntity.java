package org.jeecgframework.web.cgform.entity.autolist;
/**
 * 动态列表字段配置实体
 * @author 赵俊夫
 * @date Jul 4, 2013
 */
public class AutoFieldEntity {
	/** 字段编码*/
	private String name;
	/** 字段名称*/
	private String title;
	/** 是否隐藏*/
	private boolean isHidden;
	/** 是否查询*/
	private boolean isQuery;
	/** 查询模式*/
	private String queryMode;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public boolean isQuery() {
		return isQuery;
	}
	public void setQuery(boolean isQuery) {
		this.isQuery = isQuery;
	}
	public String getQueryMode() {
		return queryMode;
	}
	public void setQueryMode(String queryMode) {
		this.queryMode = queryMode;
	}
	public AutoFieldEntity(String name, String title, boolean isQuery,
			String queryMode) {
		this.name = name;
		this.title = title;
		this.isQuery = isQuery;
		this.queryMode = queryMode;
	}
	public boolean isHidden() {
		return isHidden;
	}
	public void setHidden(boolean isHidden) {
		this.isHidden = isHidden;
	}
	public AutoFieldEntity(String name, String title, boolean isHidden,
			boolean isQuery, String queryMode) {
		this.name = name;
		this.title = title;
		this.isHidden = isHidden;
		this.isQuery = isQuery;
		this.queryMode = queryMode;
	}
	public AutoFieldEntity() {
	}
	
}
