package org.jeecgframework.tag.vo.datatable;

/**
 * 列信息
 * 
 * @author  张代浩
 * @date 2012-7-26 下午3:07:40
 */
public class ColumnInfo {

	/**
	 * 列名
	 */
	private String name;
	/**
	 * 是否正则
	 */
	private Boolean regex;
	/**
	 * 查找
	 */
	private Boolean searchable;
	/**
	 * 查找
	 */
	private String search;
	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	/**
	 * 排序
	 */
	private Boolean sortable;

	/**
	 * @return 列名
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            列名
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return 是否正则
	 */
	public Boolean getRegex() {
		return regex;
	}

	/**
	 * @param regex
	 *            是否正则
	 */
	public void setRegex(Boolean regex) {
		this.regex = regex;
	}

	/**
	 * @return 查找
	 */
	public Boolean getSearchable() {
		return searchable;
	}

	/**
	 * @param searchable
	 *            查找
	 */
	public void setSearchable(Boolean searchable) {
		this.searchable = searchable;
	}

	/**
	 * @return 排序
	 */
	public Boolean getSortable() {
		return sortable;
	}

	/**
	 * @param sortable
	 *            排序
	 */
	public void setSortable(Boolean sortable) {
		this.sortable = sortable;
	}

}
