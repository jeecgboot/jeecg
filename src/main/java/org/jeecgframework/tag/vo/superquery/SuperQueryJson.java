package org.jeecgframework.tag.vo.superquery;

import java.util.ArrayList;
import java.util.List;

public class SuperQueryJson {

	/**
	 * 高级查询类型： M:主子表；S:单表
	 */
	private String type;
	/**
	 * 表集合
	 */
	private List<Table> tabs = new ArrayList<Table>();
	/**
	 * 表字段配置
	 */
	private List<TConfig> configs = new ArrayList<TConfig>();
	
	
	public void addTable(Table e){
		tabs.add(e);
	}
	public void addTconfig(TConfig t){
		configs.add(t);
	}
	public List<Table> getTabs() {
		return tabs;
	}
	public void setTabs(List<Table> tabs) {
		this.tabs = tabs;
	}
	public List<TConfig> getConfigs() {
		return configs;
	}
	public void setConfigs(List<TConfig> configs) {
		this.configs = configs;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
