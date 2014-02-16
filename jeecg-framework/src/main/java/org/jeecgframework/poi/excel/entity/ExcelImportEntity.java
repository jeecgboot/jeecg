package org.jeecgframework.poi.excel.entity;

import java.lang.reflect.Method;
import java.util.List;
/**
 * excel 导入工具类,对cell类型做映射
 * @author jueyue
 * @version 1.0 2013年8月24日
 */
public class ExcelImportEntity {
	/**
	 * 对应exportName
	 */
	private String name;
	/**
	 * 对应exportType
	 */
	private int type;
	/**
	 * 对应 Collection NAME
	 */
	private String collectionName;
	/**
	 * 保存图片的地址
	 */
	private String  saveUrl;
	/**
	 * 保存图片的类型,1是文件,2是数据库
	 */
	private int  saveType;
	/**
	 * 对应exportType
	 */
	private String classType;
	/**
	 * 导入日期格式
	 */
	private String importFormat;
	/**
	 * set 和convert 合并
	 */
	private Method setMethod;
	
	private List<Method> setMethods;
	
	private List<ExcelImportEntity> list;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public List<ExcelImportEntity> getList() {
		return list;
	}

	public void setList(List<ExcelImportEntity> list) {
		this.list = list;
	}

	public Method getSetMethod() {
		return setMethod;
	}

	public void setSetMethod(Method setMethod) {
		this.setMethod = setMethod;
	}

	public List<Method> getSetMethods() {
		return setMethods;
	}

	public void setSetMethods(List<Method> setMethods) {
		this.setMethods = setMethods;
	}

	public String getSaveUrl() {
		return saveUrl;
	}

	public void setSaveUrl(String saveUrl) {
		this.saveUrl = saveUrl;
	}

	public String getClassType() {
		return classType;
	}

	public void setClassType(String classType) {
		this.classType = classType;
	}

	public String getCollectionName() {
		return collectionName;
	}

	public void setCollectionName(String collectionName) {
		this.collectionName = collectionName;
	}

	public int getSaveType() {
		return saveType;
	}

	public void setSaveType(int saveType) {
		this.saveType = saveType;
	}

	public String getImportFormat() {
		return importFormat;
	}

	public void setImportFormat(String importFormat) {
		this.importFormat = importFormat;
	}

}
