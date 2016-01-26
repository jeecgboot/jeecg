package org.jeecgframework.web.system.pojo.base;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.Formula;
import org.jeecgframework.core.common.entity.IdEntity;

/**
 *菜单权限表
 * @author  张代浩
 */
@Entity
@Table(name = "t_s_function")
@org.hibernate.annotations.Proxy(lazy = false)

public class TSFunction extends IdEntity implements java.io.Serializable {
	private TSFunction TSFunction;//父菜单
	private String functionName;//菜单名称
	private Short functionLevel;//菜单等级
	private String functionUrl;//菜单地址
	private Short functionIframe;//菜单地址打开方式
	private String functionOrder;//菜单排序
	private Short functionType;//菜单类型
	private TSIcon TSIcon = new TSIcon();//菜单图标
	private TSIcon TSIconDesk;// 云桌面菜单图标
	/*private int subFunctionSize;
	@Formula(value = "(SELECT count(t_s_function.id) FROM t_s_function where t_s_function.parentfunctionid = id)")
	public int getSubFunctionSize() {
		return subFunctionSize;
	}*/
	public boolean hasSubFunction(Map<Integer, List<TSFunction>> map) {
		if(map.containsKey(this.getFunctionLevel()+1)){
			return hasSubFunction(map.get(this.getFunctionLevel()+1));
		}
		return false;
	}
	public boolean hasSubFunction(List<TSFunction> functions) {
		for (TSFunction f : functions) {
			if(f.getTSFunction().getId().equals(this.getId())){
				return true;
			}
		}
		return false;
	}
	/*public void setSubFunctionSize(int subFunctionSize) {
		this.subFunctionSize = subFunctionSize;
	}*/
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "desk_iconid")
    public TSIcon getTSIconDesk() {
        return TSIconDesk;
    }
    public void setTSIconDesk(TSIcon TSIconDesk) {
        this.TSIconDesk = TSIconDesk;
    }
    
	private List<TSFunction> TSFunctions = new ArrayList<TSFunction>();
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "iconid")
	public TSIcon getTSIcon() {
		return TSIcon;
	}
	public void setTSIcon(TSIcon tSIcon) {
		TSIcon = tSIcon;
	}
    @ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "parentfunctionid")
	public TSFunction getTSFunction() {
		return this.TSFunction;
	}

	public void setTSFunction(TSFunction TSFunction) {
		this.TSFunction = TSFunction;
	}

	@Column(name = "functionname", nullable = false, length = 50)
	public String getFunctionName() {
		return this.functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	@Column(name = "functionlevel")
	public Short getFunctionLevel() {
		return this.functionLevel;
	}

	public void setFunctionLevel(Short functionLevel) {
		this.functionLevel = functionLevel;
	}
	
	@Column(name = "functiontype")
	public Short getFunctionType() {
		return this.functionType;
	}

	public void setFunctionType(Short functionType) {
		this.functionType = functionType;
	}
	
	@Column(name = "functionurl", length = 100)
	public String getFunctionUrl() {
		return this.functionUrl;
	}

	public void setFunctionUrl(String functionUrl) {
		this.functionUrl = functionUrl;
	}
	@Column(name = "functionorder")
	public String getFunctionOrder() {
		return functionOrder;
	}

	public void setFunctionOrder(String functionOrder) {
		this.functionOrder = functionOrder;
	}
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TSFunction")
	public List<TSFunction> getTSFunctions() {
		return TSFunctions;
	}
	public void setTSFunctions(List<TSFunction> TSFunctions) {
		this.TSFunctions = TSFunctions;
	}
	@Column(name = "functioniframe")
	public Short getFunctionIframe() {
		return functionIframe;
	}
	public void setFunctionIframe(Short functionIframe) {
		this.functionIframe = functionIframe;
	}

}