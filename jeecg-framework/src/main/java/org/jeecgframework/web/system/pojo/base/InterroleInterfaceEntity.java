package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * @Title: Entity
 * @Description: t_s_interrole_interface
 * @author onlineGenerator
 * @date 2017-11-30 16:12:31
 * @version V1.0
 *
 */
@Entity
@Table(name = "t_s_interrole_interface", schema = "")
@SuppressWarnings("serial")
public class InterroleInterfaceEntity implements java.io.Serializable {
	//接口权限	
	private TSInterfaceEntity interfaceEntity;
	//角色
	private InterroleEntity interroleEntity;
	//接口数据
	private java.lang.String dataRule;
	/** ID */
	private java.lang.String id;

	 

	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")

	@Column(name = "ID", nullable = false, length = 32)
	public java.lang.String getId() {
		return this.id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	@Column(name = "DATA_RULE", length = 1000)
	public java.lang.String getDataRule() {
		return this.dataRule;
	}

	public void setDataRule(java.lang.String dataRule) {
		this.dataRule = dataRule;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "interface_id")
	public TSInterfaceEntity getInterfaceEntity() {
		return this.interfaceEntity;
	}

	public void setInterfaceEntity(TSInterfaceEntity tSInterfaceEntity) {
		this.interfaceEntity = tSInterfaceEntity;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "interrole_id")
	public InterroleEntity getInterroleEntity() {
		return this.interroleEntity;
	}

	public void setInterroleEntity(InterroleEntity interroleEntity) {
		this.interroleEntity = interroleEntity;
	}

	// TODO 以下是两个表的关联关系
	
	/*public TSInterfaceEntity getTSInterface() {
		return InterroleEntity;
	}

	public void setTSInterface(TSInterfaceEntity InterroleEntity) {
		InterroleEntity = InterroleEntity;
	}*/

	
	
	/*public InterroleEntity getInterRole() {
		return InterRole;
	}

	public void setInterRole(InterroleEntity interRole) {
		InterRole = interRole;
	}*/
	
	
}
