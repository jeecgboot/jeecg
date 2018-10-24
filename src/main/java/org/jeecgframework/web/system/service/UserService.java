package org.jeecgframework.web.system.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSUser;
/**
 * 
 * @author  张代浩
 *
 */
public interface UserService extends CommonService{

	public TSUser checkUserExits(TSUser user);
	public TSUser checkUserExits(String username,String password);
	public String getUserRole(TSUser user);
	public void pwdInit(TSUser user, String newPwd);
	/**
	 * 判断这个角色是不是还有用户使用
	 *@Author JueYue
	 *@date   2013-11-12
	 *@param id
	 *@return
	 */
	public int getUsersOfThisRole(String id);
	
	/**
	 * 物理删除用户
	 * @param user
	 */
	public String trueDel(TSUser user);

	/**
	 * 添加或者修改用户，添加用户组织机构关联表，用户角色关联表
	 * @param user
	 * @param orgIds
	 * @param roleIds
	 */
	public void saveOrUpdate(TSUser user, String[] orgIds, String[] roleIds);

	
	/**
	 * 获取登录用户权限
	 * @param userId
	 * @return
	 */
	public Map<String, TSFunction> getLoginUserFunction(String userId);
	
	/**
	 * 获取权限的map
	 * 
	 * @param userid
	 * @return
	 */
	public Map<Integer, List<TSFunction>> getFunctionMap(String userid);
	
	public void saveLoginUserInfo(HttpServletRequest req, TSUser u, String orgId);
	
	
	public boolean isInBlackList(String ip);
	
	/**
	 * shortcut风格菜单图标个性化设置（一级菜单）
	 * @return
	 */
	public String getShortcutPrimaryMenu(List<TSFunction> primaryMenu);
	
	/**
	 * shortcut风格菜单图标个性化设置（二级菜单）
	 * @return
	 */
	public String getShortcutPrimaryMenuDiy(List<TSFunction> primaryMenu);
	
	/**
	 * 根据菜单ID找到指定用户拥有的权限的子菜单集合
	 * @author taoYan
	 * @since 2018年10月22日
	 */
	public List<TSFunction>  getSubFunctionList(String userid,String functionId);

}
