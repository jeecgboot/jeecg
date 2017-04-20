package com.jeecg.demo.entity;

import java.util.Date;

public class JeecgLogReport {
	private String id;
	private String name;
	private int ct;
	private int loginct;
	private int outct;
	private int xgct;
	
	
	public int getOutct() {
		return outct;
	}
	public void setOutct(int outct) {
		this.outct = outct;
	}
	public int getXgct() {
		return xgct;
	}
	public void setXgct(int xgct) {
		this.xgct = xgct;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCt() {
		return ct;
	}
	public void setCt(int ct) {
		this.ct = ct;
	}
	public int getLoginct() {
		return loginct;
	}
	public void setLoginct(int loginct) {
		this.loginct = loginct;
	}
	private Date beginDate;
	private Date endDate;

	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	
	private int value;
	private String color;


	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
}
