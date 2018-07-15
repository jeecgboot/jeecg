package org.jeecgframework.tag.vo.superquery;

/**
 * 高级查询表关系配置
 * @author qinfeng
 *
 */
public class Table {
	/**
	 * 表名
	 */
	private String table;
	/**
	 * 是否主表 Y：是 N：否
	 */
	private String isMain;
	/**
	 * 外键字段
	 */
	private String fKey;
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

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	public String getfKey() {
		return fKey;
	}

	public void setfKey(String fKey) {
		this.fKey = fKey;
	}
}
