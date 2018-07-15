package org.jeecgframework.web.system.pojo.base;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;
/**
 * 
  * @ClassName: TSInterfaceDdataRule 权限接口规则权限表
  * @author baiyu
 */
@Entity
@Table(name = "t_s_interface_datarule")
public class TSInterfaceDdataRuleEntity extends IdEntity implements Serializable {

	 
	private static final long serialVersionUID = 1L;
	/*
	 * 规则名称
	 */
	private String ruleName;
	/*
	 * 规则字段
	 */
	private String ruleColumn;
	/*
	 * 规则条件
	 */
	private String ruleConditions;
	/*
	 * 规则值
	 */
	private String ruleValue;
	/*
	 * 创建人id
	 */
	private String createBy;
	/*
	 * 创建人名称
	 */
	private String createName;
	/*
	 * 创建日期
	 */
	private Date createDate;
	/*
	 * 更新人id
	 */
	private String updateBy;
	/*
	 * 更新人名册
	 */
	private String updateName;
	/*
	 * 权限接口
	 */
	private TSInterfaceEntity TSInterface = new TSInterfaceEntity();
	
	/*
	 *更新日期
	 */
	private Date updateDate;
	
	@Column(name ="rule_name",nullable=false,length=32)
	public String getRuleName() {
		return ruleName;
	}
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	@Column(name ="rule_column",nullable=false,length=100)
	public String getRuleColumn() {
		return ruleColumn;
	}
	public void setRuleColumn(String ruleColumn) {
		this.ruleColumn = ruleColumn;
	}
	@Column(name ="rule_conditions",nullable=false,length=100)
	public String getRuleConditions() {
		return ruleConditions;
	}
	public void setRuleConditions(String ruleConditions) {
		this.ruleConditions = ruleConditions;
	}
	
	@Column(name ="rule_value",nullable=false,length=100)
	public String getRuleValue() {
		return ruleValue;
	}
	public void setRuleValue(String ruleValue) {
		this.ruleValue = ruleValue;
	}
	@Column(name ="create_by",nullable=false,length=32)
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	@Column(name ="create_name",nullable=false,length=32)
	public String getCreateName() {
		return createName;
	}
	public void setCreateName(String createName) {
		this.createName = createName;
	}
	@Column(name ="create_date",nullable=false)
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Column(name ="update_by",nullable=false,length=32)
	public String getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}
	@Column(name ="update_name",nullable=false,length=32)
	public String getUpdateName() {
		return updateName;
	}
	public void setUpdateName(String updateName) {
		this.updateName = updateName;
	}
	@Column(name ="update_date",nullable=false)
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "interface_id")
	public TSInterfaceEntity getTSInterface() {
		return TSInterface;
	}
	public void setTSInterface(TSInterfaceEntity tSInterface) {
		TSInterface = tSInterface;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TSInterfaceDdataRuleEntity [ruleName=");
		builder.append(ruleName);
		builder.append(", ruleColumn=");
		builder.append(ruleColumn);
		builder.append(", ruleConditions=");
		builder.append(ruleConditions);
		builder.append(", ruleValue=");
		builder.append(ruleValue);
		builder.append(", createBy=");
		builder.append(createBy);
		builder.append(", createName=");
		builder.append(createName);
		builder.append(", createDate=");
		builder.append(createDate);
		builder.append(", updateBy=");
		builder.append(updateBy);
		builder.append(", updateName=");
		builder.append(updateName);
		builder.append(", TSInterface=");
		builder.append(TSInterface);
		builder.append(", updateDate=");
		builder.append(updateDate);
		builder.append("]");
		return builder.toString();
	}
	
}
