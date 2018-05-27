package org.jeecgframework.tag.vo.superquery;

/**
 * 查询字段配置
 * @author qinfeng
 *
 */
public class Field {

	/**
	 * 字段名
	 */
	private String name;
	/**
	 * 字段文本描述
	 */
	private String txt;
	/**
	 * 字段数据库类型     n: int类型;  c: 字符串类型 ;d: 时间类型;
	 */
	private String dtype;
	/**
	 * 控件显示类型     select: 下拉; input: 输入框; popup: 弹出; date: 时间（年月日）;datetime: 时间（年月日时分秒）;
	 */
	private String stype;
	/**
	 * 字典code（字典code，或者popup报表对应的字段）
	 */
	private String dicCode;
	/**
	 * 字典table（数据库表，或者报表code）
	 */
	private String dicTable;
	/**
	 * 字典Text（  表字段文本 ， 或者弹出回填字段,支持多个逗号隔开，顺序有要求）
	 */
	private String dictTxt;
	/**
	 * 排列序号
	 */
	private int seq;
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDtype() {
		return dtype;
	}
	public void setDtype(String dtype) {
		this.dtype = dtype;
	}
	public String getStype() {
		return stype;
	}
	public void setStype(String stype) {
		this.stype = stype;
	}
	public String getDicCode() {
		return dicCode;
	}
	public void setDicCode(String dicCode) {
		this.dicCode = dicCode;
	}
	public String getDicTable() {
		return dicTable;
	}
	public void setDicTable(String dicTable) {
		this.dicTable = dicTable;
	}
	public String getDictTxt() {
		return dictTxt;
	}
	public void setDictTxt(String dictTxt) {
		this.dictTxt = dictTxt;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
	}
}
