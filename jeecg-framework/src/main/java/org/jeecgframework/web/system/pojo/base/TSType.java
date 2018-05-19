package org.jeecgframework.web.system.pojo.base;
// default package

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 通用类型字典表
 *  @author  张代浩
 */
@Entity
@Table(name = "t_s_type")
public class TSType extends IdEntity implements java.io.Serializable {

	private TSTypegroup TSTypegroup;//类型分组
	private TSType TSType;//父类型
	private String typename;//类型名称
	private String typecode;//类型编码

	private Date createDate;//创建时间
	private String createName;//创建用户

//	private List<TPProcess> TSProcesses = new ArrayList();
	private List<TSType> TSTypes =new ArrayList();

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "typegroupid")
	public TSTypegroup getTSTypegroup() {
		return this.TSTypegroup;
	}

	public void setTSTypegroup(TSTypegroup TSTypegroup) {
		this.TSTypegroup = TSTypegroup;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "typepid")
	public TSType getTSType() {
		return this.TSType;
	}

	public void setTSType(TSType TSType) {
		this.TSType = TSType;
	}

	@Column(name = "typename", length = 50)
	public String getTypename() {
		return this.typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	@Column(name = "typecode", length = 50)
	public String getTypecode() {
		return this.typecode;
	}

	public void setTypecode(String typecode) {
		this.typecode = typecode;
	}

	@Column(name="create_date")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Column(name="create_name",length=36)
	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	
//	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TSType")
//	public List<TPProcess> getTSProcesses() {
//		return this.TSProcesses;
//	}
//
//	public void setTSProcesses(List<TPProcess> TSProcesses) {
//		this.TSProcesses = TSProcesses;
//	}



	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TSType")
	public List<TSType> getTSTypes() {
		return this.TSTypes;
	}

	public void setTSTypes(List<TSType> TSTypes) {
		this.TSTypes = TSTypes;
	}

}