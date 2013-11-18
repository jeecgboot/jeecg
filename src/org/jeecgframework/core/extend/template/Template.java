package org.jeecgframework.core.extend.template;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Template {
	public HashMap<String, String> teprems = null;
	public String templatecCode;
	public String parameterName;
	public String parameterValue;
	public String parameterTagName;
	public String parameterTagValue;
	public Object templatecObject;
	public String templatePath;
	public Class templateClass;
	public Map<String, String> dataSourceMap;
	public List dataSet;

	public List getDataSet() {
		return dataSet;
	}

	public void setDataSet(List dataSet) {
		this.dataSet = dataSet;
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public Map<String, String> getDataSourceMap() {
		return dataSourceMap;
	}

	public void setDataSourceMap(Map<String, String> dataSourceMap) {
		this.dataSourceMap = dataSourceMap;
	}

	public String getParameterName() {
		return parameterName;
	}

	public Class getTemplateClass() {
		return templateClass;
	}

	public void setTemplateClass(Class templateClass) {
		this.templateClass = templateClass;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}

	public String getParameterTagName() {
		return parameterTagName;
	}

	public void setParameterTagName(String parameterTagName) {
		this.parameterTagName = parameterTagName;
	}

	public String getParameterTagValue() {
		return parameterTagValue;
	}

	public void setParameterTagValue(String parameterTagValue) {
		this.parameterTagValue = parameterTagValue;
	}

	public String getParameterValue() {
		return parameterValue;
	}

	public void setParameterValue(String parameterValue) {
		this.parameterValue = parameterValue;
	}

	public Object getTemplatecObject() {
		return templatecObject;
	}

	public void setTemplatecObject(Object templatecObject) {
		this.templatecObject = templatecObject;
	}

	public String getTemplatecCode() {
		return templatecCode;
	}

	public void setTemplatecCode(String templatecCode) {
		this.templatecCode = templatecCode;
	}

	public HashMap<String, String> getTeprems() {
		return teprems;
	}

	public void setTeprems(HashMap<String, String> teprems) {
		this.teprems = teprems;
	}

}
