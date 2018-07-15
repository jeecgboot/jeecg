package org.jeecgframework.web.cgform.entity.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 
 * @Title:CgSubTableVO
 * @description:
 * @author 张代浩
 * @date Aug 24, 2013 11:33:33 AM
 * @version V1.0
 */
public class CgSubTableVO {
	
	CgFormHeadEntity head = new CgFormHeadEntity();
	
	//一对多使用
	List<Map<String, Object>> fieldList = new ArrayList<Map<String, Object>>();
	//一对多、一对一使用
	List<Map<String, Object>> hiddenFieldList = new ArrayList<Map<String, Object>>();
	
	//一对一使用
	List<Map<String, Object>> fieldNoAreaList = new ArrayList<Map<String, Object>>();
	//一对一使用
	List<Map<String, Object>> fieldAreaList = new ArrayList<Map<String, Object>>();
	

	public CgFormHeadEntity getHead() {
		return head;
	}

	public void setHead(CgFormHeadEntity head) {
		this.head = head;
	}

	public List<Map<String, Object>> getFieldList() {
		return fieldList;
	}

	public void setFieldList(List<Map<String, Object>> fieldList) {
		this.fieldList = fieldList;
		for(Map<String, Object> map:fieldList){
			if("Y".equals((String)map.get("is_show"))){
				if("textarea".equals((String)map.get("show_type"))){
					this.fieldAreaList.add(map);
				}else{
					this.fieldNoAreaList.add(map);
				}
			}
		}
	}

	public List<Map<String, Object>> getHiddenFieldList() {
		return hiddenFieldList;
	}

	public void setHiddenFieldList(List<Map<String, Object>> hiddenFieldList) {
		this.hiddenFieldList = hiddenFieldList;
	}

	public List<Map<String, Object>> getFieldNoAreaList() {
		return fieldNoAreaList;
	}

	public void setFieldNoAreaList(List<Map<String, Object>> fieldNoAreaList) {
		this.fieldNoAreaList = fieldNoAreaList;
	}

	public List<Map<String, Object>> getFieldAreaList() {
		return fieldAreaList;
	}

	public void setFieldAreaList(List<Map<String, Object>> fieldAreaList) {
		this.fieldAreaList = fieldAreaList;
	}
	
	

}
