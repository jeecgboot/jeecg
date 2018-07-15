package org.jeecgframework.web.system.pojo.base;

import java.util.List;

public class InterfaceRuleDto {
	
	/**
	 * 接口编码
	 */
	private String interfaceCode;
	
	/**
	 * 接口数据规则id
	 */
	private String dataRule;
	
	/**
	 * 接口规则
	 */
	private List<TSInterfaceDdataRuleEntity> interfaceDataRule;

	public String getInterfaceCode() {
		return interfaceCode;
	}

	public void setInterfaceCode(String interfaceCode) {
		this.interfaceCode = interfaceCode;
	}

	public String getDataRule() {
		return dataRule;
	}

	public void setDataRule(String dataRule) {
		this.dataRule = dataRule;
	}

	public List<TSInterfaceDdataRuleEntity> getInterfaceDataRule() {
		return interfaceDataRule;
	}

	public void setInterfaceDataRule(
			List<TSInterfaceDdataRuleEntity> interfaceDataRule) {
		this.interfaceDataRule = interfaceDataRule;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("InterfaceRuleDto [interfaceCode=");
		builder.append(interfaceCode);
		builder.append(", dataRule=");
		builder.append(dataRule);
		builder.append(", interfaceDataRule=");
		builder.append(interfaceDataRule);
		builder.append("]");
		return builder.toString();
	}
	
	
}
