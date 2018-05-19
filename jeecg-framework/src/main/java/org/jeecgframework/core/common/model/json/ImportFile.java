package org.jeecgframework.core.common.model.json;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 上传下载模型类
 * 
 * @author 张代浩
 * 
 */
public class ImportFile {
	private Object object;// 导出实体对象
	private String fileName;// 文件保存在硬盘的全路径对应实体字段	
	private String entityName;//导出实体名
	private String field;
	private Class entityClass;
	private MultipartHttpServletRequest multipartRequest;
	private HttpServletRequest request;
	private HttpServletResponse response;	
	public Object getObject() {
		return object;
	}
	public void setObject(Object object) {
		this.object = object;
	}
	 
	public Class getEntityClass() {
		return entityClass;
	}
	public void setEntityClass(Class entityClass) {
		this.entityClass = entityClass;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public MultipartHttpServletRequest getMultipartRequest() {
		return multipartRequest;
	}
	public void setMultipartRequest(MultipartHttpServletRequest multipartRequest) {
		this.multipartRequest = multipartRequest;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	public ImportFile(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
}
