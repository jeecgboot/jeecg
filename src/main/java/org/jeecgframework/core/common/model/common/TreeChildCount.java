package org.jeecgframework.core.common.model.common;

/**
 * 
 * 描述：树子节点计数
 * @author：zhoujf
 * @since：2017-3-15 下午04:29:56
 * @version:1.0
 */
public class TreeChildCount {
	
	private String parentId;
	private Long count;
	
	public TreeChildCount(String parentId, Long count) {
		this.parentId = parentId;
		this.count = count;
	}
	
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	

}
