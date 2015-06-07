package org.jeecgframework.core.groovy;

import groovy.lang.Binding;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class GroovyBinding extends Binding {
	private static ThreadLocal<Map<String, Object>> localVars = new ThreadLocal<Map<String, Object>>();

	private static Map<String, Object> propertyMap = new ConcurrentHashMap<String, Object>();

	public GroovyBinding() {
	}

	public GroovyBinding(Map<String, Object> variables) {
		localVars.set(variables);
	}

	public GroovyBinding(String[] args) {
		this();
		setVariable("args", args);
	}

	public Object getVariable(String name) {
		Map<String, Object> map = localVars.get();
		Object result = null;
		if ((map != null) && (map.containsKey(name))) {
			result = map.get(name);
		} else {
			result = propertyMap.get(name);
		}

		return result;
	}

	public void setVariable(String name, Object value) {
		if (localVars.get() == null) {
			Map<String, Object> vars = new LinkedHashMap<String, Object>();
			vars.put(name, value);
			localVars.set(vars);
		} else {
			(localVars.get()).put(name, value);
		}
	}

	public Map<String, Object> getVariables() {
		if (localVars.get() == null) {
			return new LinkedHashMap<String, Object>();
		}

		return localVars.get();
	}

	public void clearVariables() {
		localVars.remove();
	}

	public Object getProperty(String property) {
		return propertyMap.get(property);
	}

	public void setProperty(String property, Object newValue) {
		propertyMap.put(property, newValue);
	}
}