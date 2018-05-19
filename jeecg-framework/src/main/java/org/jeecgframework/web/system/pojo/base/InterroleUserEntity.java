package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 接口角色用户
 * @author  
 */
@Entity
@Table(name = "t_s_interrole_user")
public class InterroleUserEntity extends IdEntity implements java.io.Serializable {
	 
	private static final long serialVersionUID = 1L;
	private TSUser TSUser;
	private InterroleEntity interroleEntity;
	

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	public TSUser getTSUser() {
		return this.TSUser;
	}

	public void setTSUser(TSUser TSUser) {
		this.TSUser = TSUser;
	}

	

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "interrole_id")
	public InterroleEntity getInterroleEntity() {
		return interroleEntity;
	}

	public void setInterroleEntity(InterroleEntity interroleEntity) {
		this.interroleEntity = interroleEntity;
	}
}