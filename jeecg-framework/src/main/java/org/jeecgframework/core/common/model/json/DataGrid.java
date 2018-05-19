package org.jeecgframework.core.common.model.json;

import java.util.List;

import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ResourceUtil;


/**
 * easyui的datagrid向后台传递参数使用的model
 * 
 * @author
 * 
 */
public class DataGrid {

	private int page = 1;// 当前页
	private int rows = 10;// 每页显示记录数
	private String sort = null;// 排序字段名

	private String order = "asc";// 按什么排序(asc,desc)

	private String field;//字段
	private String treefield;//树形数据表文本字段
	private List results;// 结果集
	private int total;//总记录数
	private String footer;//合计列
	private String sqlbuilder;//合计列

	//数据格式
	private String dataStyle = "easyui";

	
	
	public String getDataStyle() {
		return dataStyle;
	}

	public void setDataStyle(String dataStyle) {
		this.dataStyle = dataStyle;
	}

	public String getSqlbuilder() {
		return sqlbuilder;
	}

	public void setSqlbuilder(String sqlbuilder) {

		if(sqlbuilder.indexOf("≤") > 0) {
			sqlbuilder = sqlbuilder.replace("≤", "<=");
		}

		this.sqlbuilder = sqlbuilder;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getField() {
		return field;
	}

	public List getResults() {
		return results;
	}

	public void setResults(List results) {
		this.results = results;
	}

	public void setField(String field) {
		this.field = field;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		if(ContextHolderUtils.getRequest()!=null&&ResourceUtil.getParameter("rows")!=null){
			return rows;
		}
		return 10000;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

//	public SortDirection getOrder() {
//		return order;
//	}
//
//	public void setOrder(SortDirection order) {
//		this.order = order;
//	}
	
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
	
	public String getTreefield() {
		return treefield;
	}

	public void setTreefield(String treefield) {
		this.treefield = treefield;
	}

	public String getFooter() {
		return footer;
	}

	public void setFooter(String footer) {
		this.footer = footer;
	}
	
	public void clear(){
		if(results!=null){
			results.clear();
			results = null;
		}

		field = null;
		treefield = null;

	}
}
