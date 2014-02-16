package org.jeecgframework.tag.vo.datatable;

import java.text.MessageFormat;

import javax.servlet.http.HttpServletRequest;

public class DataTables {
	private HttpServletRequest request; // 内部使用的 Request 对象
	private String sEchoParameter = "sEcho";

	// 起始索引和长度
	private String iDisplayStartParameter = "iDisplayStart";
	private String iDisplayLengthParameter = "iDisplayLength";

	// 列数
	private String iColumnsParameter = "iColumns";
	private String sColumnsParameter = "sColumns";
	private String sColumns;

	// 参与排序列数
	private String iSortingColsParameter = "iSortingCols";
	private String iSortColPrefixParameter = "iSortCol_"; // 排序列的索引
	private String sSortDirPrefixParameter = "sSortDir_"; // 排序的方向
															// asc, desc

	// 每一列的可排序性
	private String bSortablePrefixParameter = "bSortable_";

	// 全局搜索
	private String sSearchParameter = "sSearch";
	private String bRegexParameter = "bRegex";

	// 每一列的搜索
	private String bSearchablePrefixParameter = "bSearchable_";
	private String sSearchPrefixParameter = "sSearch_";
	private String bEscapeRegexPrefixParameter = "bRegex_";

	public SortInfo[] getSortColumns() {
		return sortColumns;
	}

	public void setSortColumns(SortInfo[] sortColumns) {
		this.sortColumns = sortColumns;
	}

	public int getColumnCount() {
		return ColumnCount;
	}

	public void setColumnCount(int columnCount) {
		ColumnCount = columnCount;
	}

	public ColumnInfo[] getColumns() {
		return columns;
	}

	public void setColumns(ColumnInfo[] columns) {
		this.columns = columns;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public Boolean getRegex() {
		return regex;
	}

	public void setRegex(Boolean regex) {
		this.regex = regex;
	}

	public Integer getEcho() {
		return echo;
	}

	public int getDisplayStart() {
		return displayStart;
	}

	public int getDisplayLength() {
		return displayLength;
	}

	public int getSortingCols() {
		return sortingCols;
	}

	private Integer echo;

	private int displayStart;

	private int displayLength;

	// 参与排序的列
	private int sortingCols;
	public int iSortingCols;

	// 排序列
	private SortInfo[] sortColumns;

	private int ColumnCount;

	private ColumnInfo[] columns;

	private String search;

	private Boolean regex;

	public void DataTablePram(HttpServletRequest httpRequest) {
		this.request = httpRequest;
	}

	public DataTables(HttpServletRequest request) // 用于 MVC 模式下的构造函数
	{
		this.request = request;

		this.echo = this.ParseIntParameter(sEchoParameter);
		this.displayStart = this.ParseIntParameter(iDisplayStartParameter);
		this.displayLength = this.ParseIntParameter(iDisplayLengthParameter);
		this.sortingCols = this.ParseIntParameter(iSortingColsParameter);

		this.search = this.ParseStringParameter(sSearchParameter);
		this.regex = this.ParseStringParameter(bRegexParameter) == "true";

		// 排序的列
		int count = sortingCols;
		this.sortColumns = new SortInfo[count];
		MessageFormat formatter = new MessageFormat("");
		for (int i = 0; i < count; i++) {
			SortInfo sortInfo = new SortInfo();
			sortInfo.setColumnId(this.ParseIntParameter(formatter.format("iSortCol_{0}", i)));
			String aString = this.ParseStringParameter(formatter.format("sSortDir_{0}", i));
			if (this.ParseStringParameter(formatter.format("sSortDir_{0}", i)).equals("desc")) {
				sortInfo.setSortOrder(SortDirection.asc);
			} else {
				sortInfo.setSortOrder(SortDirection.desc);
			}
			this.sortColumns[i] = sortInfo;
		}

		this.ColumnCount = this.ParseIntParameter(iColumnsParameter);

		count = this.ColumnCount;
		this.columns = new ColumnInfo[count];

		String[] names = this.ParseStringParameter(sColumnsParameter).split(",");
		this.sColumns = this.ParseStringParameter(sColumnsParameter);

		for (int i = 0; i < names.length; i++) {
			ColumnInfo col = new ColumnInfo();
			col.setName(names[i]);
			col.setSortable(this.ParseBooleanParameter(formatter.format("bSortable_{0}", i)));
			col.setSearchable(this.ParseBooleanParameter(formatter.format("bSearchable_{0}", i)));
			col.setSearch(this.ParseStringParameter(formatter.format("sSearch_{0}", i)));
			col.setRegex(this.ParseStringParameter(formatter.format("bRegex_{0}", i)) == "true");
			columns[i] = col;
		}
	}

	public String getsColumns() {
		return sColumns;
	}

	public void setsColumns(String sColumns) {
		this.sColumns = sColumns;
	}

	private int ParseIntParameter(String name) // 解析为整数
	{
		int result = 0;
		String parameter = this.request.getParameter(name);
		if (parameter != null) {
			result = Integer.parseInt(parameter);
		}
		return result;
	}

	private String ParseStringParameter(String name) // 解析为字符串
	{
		return this.request.getParameter(name);
	}

	private Boolean ParseBooleanParameter(String name) // 解析为布尔类型
	{
		Boolean result = false;
		String parameter = this.request.getParameter(name);
		if (parameter != null) {
			result = Boolean.parseBoolean(parameter);
		}
		return result;
	}

}
