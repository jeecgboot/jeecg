package org.jeecgframework.web.system.service;

import java.util.List;
import java.util.Set;

import org.jeecgframework.web.system.pojo.base.DictEntity;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSIcon;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.web.system.pojo.base.TSTypegroup;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.core.common.service.CommonService;

/**
 *
 * @author  张代浩
 *
 */
public interface SystemService extends CommonService{
	/**
 	 * 方法描述:  查询数据字典
 	 * 作    者： yiming.zhang
 	 * 日    期： 2014年5月11日-下午4:22:42
 	 * @param dicTable
 	 * @param dicCode
 	 * @param dicText
 	 * @return
 	 * 返回类型： List<DictEntity>
 	 */
 	public List<DictEntity> queryDict(String dicTable,String dicCode, String dicText);

	/**
	 * 登陆用户检查
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public TSUser checkUserExits(TSUser user) throws Exception;
	/**
	 * 日志添加
	 * @param LogContent 内容
	 * @param loglevel 级别
	 * @param operatetype 类型
	 * @param TUser 操作人
	 */
	public void addLog(String LogContent, Short loglevel,Short operatetype);
	/**
	 * 根据类型编码和类型名称获取Type,如果为空则创建一个
	 * @param typecode
	 * @param typename
	 * @return
	 */
	public TSType getType(String typecode,String typename,TSTypegroup tsTypegroup);
	/**
	 * 根据类型分组编码和名称获取TypeGroup,如果为空则创建一个
	 * @param typecode
	 * @param typename
	 * @return
	 */
	public TSTypegroup getTypeGroup(String typegroupcode,String typgroupename);
	
	/**
	 * 获取页面控件权限控制的
	 * JS片段
	 * @param out
	 */
	public String getAuthFilterJS();
	
	/**
	 * 根据编码获取字典组
	 *
	 * @param typegroupCode
	 * @return
	 */
	public TSTypegroup getTypeGroupByCode(String typegroupCode);
	/**
	 * 对数据字典进行缓存
	 */
	public void initAllTypeGroups();

	/**
	 * 刷新字典缓存
	 * @param type
	 */
	public void refleshTypesCach(TSType type);
	/**
	 * 刷新字典分组缓存
	 */
	public void refleshTypeGroupCach();

	/**
	 * 刷新字典分组缓存&字典缓存
	 */
	public void refreshTypeGroupAndTypes();

	
	/**
	 * 刷新菜单
	 *
	 * @param id
	 */
	public void flushRoleFunciton(String id, TSFunction newFunciton);

    /**
     * 生成组织机构编码
     * @param id 组织机构主键
     * @param pid 组织机构的父级主键
     * @return 组织机构编码
     */
	String generateOrgCode(String id, String pid);

	/**
	  * 根据角色id 和 菜单Id 获取 具有操作权限的数据规则
	  * @Description: TODO
	  * @param @param roleId
	  * @param @param functionId
	  * @param @return    设定文件
	  * @return Set<String>    返回类型
	  * @throws
	 */

	public  Set<String> getDataRuleIdsByRoleIdAndFunctionId(String roleId,String functionId);
		
	/**
	 * 根据角色ID 和 菜单Id 获取 具有操作权限的按钮Codes
	 * @param roleId
	 * @param functionId
	 * @return
	 */
	public  Set<String> getOperationCodesByRoleIdAndFunctionId(String roleId,String functionId);

	
	/**
	 * 加载所有图标
	 * @return
	 */
	public  void initAllTSIcons();

	/**
	 * 更新图标
	 * @param icon
	 */
	public  void upTSIcons(TSIcon icon);
	/**
	 * 删除图标
	 * @param icon
	 */
	public  void delTSIcons(TSIcon icon);

	/**
	 * 添加数据日志
	 * @param tableName		操作表名
	 * @param dataId		数据ID
	 * @param dataContent	内容(JSON格式)
	 */

	public void addDataLog(String tableName, String dataId, String dataContent);

	/***
	 * 获取二级管理员页面控件权限授权配置【二级管理员后台权限配置功能】
	 * @param groupId 部门角色组ID
	 * @param functionId 选中菜单ID
	 * @Param type 0:部门管理员组/1:部门角色
	 */
	public Set<String> getDepartAuthGroupOperationSet(String groupId,String functionId,String type);
	
	/***
	 * 获取二级管理员数据权限授权配置【二级管理员后台权限配置功能】
	 * @param groupId 部门角色组ID
	 * @param functionId 选中菜单ID
	 * @Param type  0:部门管理员组/1:部门角色
	 */
	public Set<String> getDepartAuthGroupDataRuleSet(String groupId,String functionId,String type);

	
	/**
	 * 【AuthInterceptor】获取登录用户的数据权限Ids
	 * @param userId
	 * @param functionId
	 * @return
	 */

	public Set<String> getLoginDataRuleIdsByUserId(String userId,String functionId, String orgId);

	
	/***
	 * 【AuthInterceptor】获取登录用户的页面控件权限
	 */

	public List<TSOperation> getLoginOperationsByUserId(String userId,String functionId, String orgId);

	
	/**
	 * 【AuthInterceptor】判断是否有菜单访问权限
	 */
	public boolean loginUserIsHasMenuAuth(String requestPath,String clickFunctionId,String userid,String orgId);
	
	/**
	 * 【AuthInterceptor】通过请求地址，获取数据库对应的菜单ID
	 * @param requestPath
	 * @return
	 */
	public String getFunctionIdByUrl(String requestPath,String menuPath);
	
}
