package org.jeecgframework.web.cgform.service.config;

import java.util.List;
import java.util.Map;

import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.exception.BusinessException;
import org.jeecgframework.core.common.service.CommonService;

public interface CgFormFieldServiceI extends CommonService {
	/**
	 * 更新表
	 * 
	 * @param t
	 * @param isChange 索引是否更新
	 */

	void updateTable(CgFormHeadEntity t, String sign, boolean isChange);

	/**
	 * 创建表
	 * 
	 * @param tableProperty
	 */
	void saveTable(CgFormHeadEntity tableProperty);

	/**
	 * 重载创建表
	 * 
	 * @param cgFormHead
	 * @param a
	 */
	public void saveTable(CgFormHeadEntity cgFormHead, String a);

	/**
	 * 判断表是不是再数据库中存在了
	 * 
	 * @param tableName
	 * @return
	 */
	Boolean judgeTableIsExit(String tableName);

	/**
	 * 同步数据库
	 * @param synMethod 
	 * 
	 * @return
	 */
	public boolean dbSynch(CgFormHeadEntity cgFormHead, String synMethod)
			throws BusinessException;

	/**
	 * 删除这个配置表单 连同表
	 * 
	 * @param cgFormHead
	 */
	void deleteCgForm(CgFormHeadEntity cgFormHead);

	/**
	 * 根据tablename 获取表单配置
	 * 
	 * @return
	 */
	public List<Map<String, Object>> getCgFormFieldByTableName(String tableName);

	/**
	 * 根据formid 获取表单字段配置
	 * 
	 * @return
	 */
	public Map<String, CgFormFieldEntity> getCgFormFieldByFormId(String formid);

	/**
	 * 根据tableName 获取表单配置
	 * 
	 * @return
	 */
	public CgFormHeadEntity getCgFormHeadByTableName(String tableName);

	/**
	 * 根据tableName 获取表单所有配置信息
	 * 
	 * @return
	 */
	public Map<String, CgFormFieldEntity> getAllCgFormFieldByTableName(
			String tableName);

	/**
	 * 根据tableName 获取表单所有配置信息(缓存)
	 * 
	 * @return
	 */
	public Map<String, CgFormFieldEntity> getAllCgFormFieldByTableName(
			String tableName, String version);

	/**
	 * 根据tableName 获取表单所有hidden配置信息
	 * 
	 * @return
	 */
	public List<CgFormFieldEntity> getHiddenCgFormFieldByTableName(
			String tableName);

	/**
	 * 获取主表关联的附表的信息
	 * 
	 * @return
	 */
	public List<Map<String, Object>> getSubTableData(String mainTableName,
			String subTableName, Object mainTableId);

	/**
	 * 更新主表的附表串-用于表配置提交时调用
	 * 
	 * @author 赵俊夫
	 * @param entity
	 *            表单配置
	 * @return 更新是否成功
	 */
	public boolean appendSubTableStr4Main(CgFormHeadEntity entity);

	/**
	 * 剔除主表的附表串-用于表配置修改时调用
	 * 
	 * @author 赵俊夫
	 * @param entity
	 *            表单配置
	 * @return 更新是否成功
	 */
	public boolean removeSubTableStr4Main(CgFormHeadEntity entity);

	/**
	 * 按tabOrder排序subTableStr
	 * 
	 * @author fancq
	 * @param entity
	 */
	public void sortSubTableStr(CgFormHeadEntity entity);
	
	/**
	 * 获取表单的版本号
	 * 
	 * @param tableName
	 *            表单名
	 * @return
	 */
	public String getCgFormVersionByTableName(String tableName);

	/**
	 * 获取表单的版本号
	 * 
	 * @param id
	 *            表单id
	 * @return
	 */
	public String getCgFormVersionById(String id);

	/**
	 * 更新表单的版本号
	 * 
	 * @return
	 */
	public boolean updateVersion(String formId);

	/**
	 * 获取表单配置
	 * 
	 * @param tableName
	 * @param version
	 * @return
	 */
	public Map<String, Object> getFtlFormConfig(String tableName, String version);

	/**
	 * 根据tableName 获取表单配置 根据版本号缓存
	 * 
	 * @return
	 */
	public CgFormHeadEntity getCgFormHeadByTableName(String tableName,
			String version);
	/**
	 * 判断数据表是否存在
	 * @param tableName
	 * @return
	 */
	public boolean checkTableExist(String tableName);

	public int getByphysiceId(String id);

	/**
	 * 获取指定physiceId的配置记录数量	 
	 * @param list
	 * @return 键值对集合列表
	 */
	public List<Map<String,Object>> getPeizhiCountByIds(List<CgFormHeadEntity> list);
}
