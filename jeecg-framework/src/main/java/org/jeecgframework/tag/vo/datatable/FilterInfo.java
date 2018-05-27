package org.jeecgframework.tag.vo.datatable;

/**
 * 过滤查找
 * 
 * @author  张代浩
 * @date 2012-7-26 下午3:07:40
 */
public class FilterInfo {

	/**
	 * 查找的列名
	 */
	private String name;
	/**
	 * 查找的值
	 */
	private String search;

	/**
	 * @return 查找的列名
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            查找的列名
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return 查找的值
	 */
	public String getSearch() {
		return search;
	}

	/**
	 * @param search
	 *            查找的值
	 */
	public void setSearch(String search) {
		this.search = search;
	}

}
