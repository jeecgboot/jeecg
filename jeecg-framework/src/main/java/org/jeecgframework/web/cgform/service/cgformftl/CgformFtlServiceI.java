package org.jeecgframework.web.cgform.service.cgformftl;

import java.util.Map;

import org.jeecgframework.core.common.service.CommonService;

public interface CgformFtlServiceI extends CommonService{
	
	/**
	 * 根据tableName获取form模板信息
	 */
	public Map<String,Object> getCgformFtlByTableName(String tableName);
	
	/**
	 * 获得新增数据的版本号
	 * @param cgformId
	 * @return
	 */
	public int getNextVarsion(String cgformId);
	
	/**
	 * 是否有已经激活的模板
	 * @param cgformId
	 * @return
	 */
	public boolean hasActive(String cgformId);

}
