package org.jeecgframework.web.cgform.service.cgformftl;

import org.jeecgframework.core.common.service.CommonService;

import java.util.Map;

public interface CgformFtlServiceI extends CommonService{

    /**
     * 根据tableName获取form模板信息
     * <li>根据 ftlVersion 的值获取模板，如果该参数为空，则默认取第一个激活的模板</li>
     * @param tableName tableName
     * @param ftlVersion ftlVersion
     * @return form模板信息
     */
    public Map<String,Object> getCgformFtlByTableName(String tableName, String ftlVersion);


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
	/**
	 * 获取用户自定义模板的HTML,激活的
	 * @param id
	 * @return
	 */
	public String getUserFormFtl(String id);

}
