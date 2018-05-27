package org.jeecgframework.tag.vo.datatable;

/**
 * 排序值
 * @author  张代浩
 * @date 2012-7-26 下午3:07:40
 */
public class SortInfo {

	/**
	 * 排序列名
	 */
	private Integer columnId;
	/**
	 * desc or asc
	 */
	private SortDirection sortOrder;

	/**
	 * @return 排序列名
	 */
	public Integer getColumnId() {
		return columnId;
	}

	/**
	 * @param columnId
	 *            排序列名
	 */
	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}

	/**
	 * @return desc or asc
	 */
	public SortDirection getSortOrder() {
		return sortOrder;
	}

	/**
	 * @param sortOrder
	 *            desc or asc
	 */
	public void setSortOrder(SortDirection sortOrder) {
		this.sortOrder = sortOrder;
	}

}
