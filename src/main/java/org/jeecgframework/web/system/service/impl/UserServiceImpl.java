package org.jeecgframework.web.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSLog;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.pojo.base.TSUserOrg;
import org.jeecgframework.web.system.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 
 * @author  张代浩
 *
 */
@Service("userService")
@Transactional
public class UserServiceImpl extends CommonServiceImpl implements UserService {

	public TSUser checkUserExits(TSUser user){
		return this.commonDao.getUserByUserIdAndUserNameExits(user);
	}
	
	public TSUser checkUserExits(String username,String password){
		return this.commonDao.findUserByAccountAndPassword(username,password);
	}
	public String getUserRole(TSUser user){
		return this.commonDao.getUserRole(user);
	}
	
	public void pwdInit(TSUser user,String newPwd) {
			this.commonDao.pwdInit(user,newPwd);
	}
	
	public int getUsersOfThisRole(String id) {
		Criteria criteria = getSession().createCriteria(TSRoleUser.class);
		criteria.add(Restrictions.eq("TSRole.id", id));
		int allCounts = ((Long) criteria.setProjection(
				Projections.rowCount()).uniqueResult()).intValue();
		return allCounts;
	}
	
	@Override
	public String trueDel(TSUser user) {
		String message = "";
		List<TSRoleUser> roleUser = this.commonDao.findByProperty(TSRoleUser.class, "TSUser.id", user.getId());
		if (!user.getStatus().equals(Globals.User_ADMIN)) {
			if (roleUser.size()>0) {
				// 删除用户时先删除用户和角色关系表
				delRoleUser(user);
				this.commonDao.executeSql("delete from t_s_user_org where user_id=?", user.getId()); // 删除 用户-机构 数据
                this.commonDao.delete(user);
				message = "用户：" + user.getUserName() + "删除成功";
				this.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			} else {
				this.commonDao.delete(user);
				message = "用户：" + user.getUserName() + "删除成功";
			}
		} else {
			message = "超级管理员不可删除";
		}
		return message;
	}
	
	private void delRoleUser(TSUser user) {
		// 同步删除用户角色关联表
		List<TSRoleUser> roleUserList = this.commonDao.findByProperty(TSRoleUser.class, "TSUser.id", user.getId());
		if (roleUserList.size() >= 1) {
			for (TSRoleUser tRoleUser : roleUserList) {
				this.commonDao.delete(tRoleUser);
			}
		}
	}
	
	/**
	 * 添加日志
	 */
	private void addLog(String logcontent, Short loglevel, Short operatetype) {
		HttpServletRequest request = ContextHolderUtils.getRequest();
		String broswer = BrowserUtils.checkBrowse(request);
		TSLog log = new TSLog();
		log.setLogcontent(logcontent);
		log.setLoglevel(loglevel);
		log.setOperatetype(operatetype);
		log.setNote(oConvertUtils.getIp());
		log.setBroswer(broswer);
		log.setOperatetime(DateUtils.gettimestamp());
//		log.setTSUser(ResourceUtil.getSessionUser());
		/*start chenqian 201708031TASK #2317 【改造】系统日志表，增加两个字段，避免关联查询 [操作人账号] [操作人名字]*/
		TSUser u = ResourceUtil.getSessionUser();
		log.setUserid(u.getId());
		log.setUsername(u.getUserName());
		log.setRealname(u.getRealName());
		/*update-end--Author chenqian 201708031TASK #2317 【改造】系统日志表，增加两个字段，避免关联查询 [操作人账号] [操作人名字]*/
		commonDao.save(log);
	}

	@Override
	public void saveOrUpdate(TSUser user, String[] orgIds, String[] roleIds) {
		if(StringUtil.isNotEmpty(user.getId())){
			commonDao.executeSql("delete from t_s_user_org where user_id=?", user.getId());
			this.commonDao.updateEntitie(user);
			List<TSRoleUser> ru = commonDao.findByProperty(TSRoleUser.class, "TSUser.id", user.getId());
			commonDao.deleteAllEntitie(ru);
		}else{
			this.commonDao.save(user);
		}
		saveUserOrgList(user,orgIds);
		saveRoleUser(user,roleIds);
	}
	
	/**
     * 保存 用户-组织机构 关系信息
     * @param user user
     * @param orgIds 组织机构id数组
     */
	private void saveUserOrgList(TSUser user,String[] orgIds) {
        if(orgIds!=null && orgIds.length>0){
        	List<TSUserOrg> userOrgList = new ArrayList<TSUserOrg>();
        	for (String orgId : orgIds) {
        		if(StringUtils.isBlank(orgId))continue;
        		TSDepart depart = new TSDepart();
        		depart.setId(orgId);
        		
        		TSUserOrg userOrg = new TSUserOrg();
        		userOrg.setTsUser(user);
        		userOrg.setTsDepart(depart);
        		
        		userOrgList.add(userOrg);
        	}
        	if (!userOrgList.isEmpty()) {
        		commonDao.batchSave(userOrgList);
        	}
        }
    }

	/**
	 * 保存 用户角色关联表信息
	 * @param user
	 * @param roleIds
	 */
	private void saveRoleUser(TSUser user, String[] roleIds) {
		if(roleIds!=null && roleIds.length>0){
			for (int i = 0; i < roleIds.length; i++) {
				if(StringUtils.isBlank(roleIds[i]))continue;
				TSRoleUser rUser = new TSRoleUser();
				TSRole role = commonDao.get(TSRole.class, roleIds[i]);
				rUser.setTSRole(role);
				rUser.setTSUser(user);
				commonDao.save(rUser);
			}
		}
	}

}
