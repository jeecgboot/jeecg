package org.jeecgframework.tag.vo.datatable;

import java.util.List;

/**
 * DataTables期望的返回数据格式
 * 
 * @author  张代浩
 * @date 2012-7-26 上午11:23:17
 */
public class DataTableReturn {
	/**
	 * 过滤前总记录数
	 */
	private Integer iTotalRecords;
	/**
	 * 过滤后总记录数
	 */
	private Integer iTotalDisplayRecords;
	/**
	 * 页面发来的参数，原样返回
	 */
	private Integer sEcho;

	/**
	 * 返回的具体数据
	 */
	private List<?> aaData;

	/**
	 * @return 过滤前总记录数
	 */
	public Integer getiTotalRecords() {
		return iTotalRecords;
	}

	/**
	 * @param iTotalRecords
	 *            过滤前总记录数
	 */
	public void setiTotalRecords(Integer iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	/**
	 * @return 过滤后总记录数
	 */
	public Integer getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	/**
	 * @param iTotalDisplayRecords
	 *            过滤后总记录数
	 */
	public void setiTotalDisplayRecords(Integer iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	/**
	 * @return 页面发来的参数，原样返回
	 */
	public Integer getsEcho() {
		return sEcho;
	}

	/**
	 * @param sEcho
	 *            页面发来的参数，原样返回
	 */
	public void setsEcho(Integer sEcho) {
		this.sEcho = sEcho;
	}

	/**
	 * @return 返回的具体数据
	 */
	public List<?> getAaData() {
		return aaData;
	}

	/**
	 * @param aaData
	 *            返回的具体数据
	 */
	public void setAaData(List<?> aaData) {
		this.aaData = aaData;
	}
	public DataTableReturn(Integer iTotalRecords, Integer iTotalDisplayRecords,
			Integer sEcho, List<?> aaData) {
		this.iTotalRecords = iTotalRecords;
		this.iTotalDisplayRecords = iTotalDisplayRecords;
		this.sEcho = sEcho;
		this.aaData = aaData;
	}

}
