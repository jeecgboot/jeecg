package org.jeecgframework.tag.vo.easyui;
/**
 * 
 * @author  张代浩
 *
 */
public class Autocomplete {
	private String entityName;//实体名称
	private String labelField;//提示显示的字段
	private String valueField;//传递后台的字段
	private String searchField;//查询关键字字段
	private String trem;//查询传递的值
	private Integer maxRows;
	private Integer curPage;
	public String getSearchField() {
		return searchField;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public String getTrem() {
		return trem;
	}
	public void setTrem(String trem) {
		this.trem = trem;
	}
	public String getLabelField() {
		return labelField;
	}
	public void setLabelField(String labelField) {
		this.labelField = labelField;
	}
	public String getValueField() {
		return valueField;
	}
	public void setValueField(String valueField) {
		this.valueField = valueField;
	}
	public Integer getMaxRows() {
		return maxRows;
	}
	public void setMaxRows(Integer maxRows) {
		this.maxRows = maxRows;
	}
	public Integer getCurPage() {
		if(curPage==null||curPage<1){
			curPage = 1;
		}
		return curPage;
	}
	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}

}
