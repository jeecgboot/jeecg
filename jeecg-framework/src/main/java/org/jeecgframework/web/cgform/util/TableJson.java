package org.jeecgframework.web.cgform.util;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;

/**
 * $.ajax后需要接受的JSON
 * 
 * @author
 * 
 */
public class TableJson {

	private boolean success = true;// 是否成功
	private String msg = "操作成功";// 提示信息
	private Integer tableType;
	private Object tableData = null;// 单表/主表信息
	private Map<String, Object> subTableDate;// 子表信息

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Integer getTableType() {
		return tableType;
	}

	public void setTableType(Integer tableType) {
		this.tableType = tableType;
	}

	public Object getTableData() {
		return tableData;
	}

	public void setTableData(Object tableData) {
		this.tableData = tableData;
	}

	public Map<String, Object> getSubTableDate() {
		return subTableDate;
	}

	public void setSubTableDate(Map<String, Object> subTableDate) {
		this.subTableDate = subTableDate;
	}

	@Override
	public String toString() {
		return "TableJson [success=" + success + ", msg=" + msg
				+ ", tableType=" + tableType + ", tableData=" + tableData
				+ ", subTableDate=" + subTableDate + "]";
	}
	
}
