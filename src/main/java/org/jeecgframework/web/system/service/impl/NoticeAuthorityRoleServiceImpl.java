package org.jeecgframework.web.system.service.impl;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.web.system.pojo.base.TSNoticeAuthorityRole;
import org.jeecgframework.web.system.pojo.base.TSNoticeReadUser;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.service.NoticeAuthorityRoleServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("noticeAuthorityRoleService")
@Transactional
public class NoticeAuthorityRoleServiceImpl extends CommonServiceImpl implements NoticeAuthorityRoleServiceI {

	@Autowired
	private SystemService systemService;
	
	private ExecutorService executor = Executors.newCachedThreadPool();
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((TSNoticeAuthorityRole)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((TSNoticeAuthorityRole)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((TSNoticeAuthorityRole)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(TSNoticeAuthorityRole t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(TSNoticeAuthorityRole t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(TSNoticeAuthorityRole t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,TSNoticeAuthorityRole t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{notice_id}",String.valueOf(t.getNoticeId()));
 		sql  = sql.replace("#{role_id}",String.valueOf(t.getRole().getId()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	/**
 	 * 检查通知公告授权角色是否存在
 	 */
 	public boolean checkAuthorityRole(String noticeId, String roleid) {
		CriteriaQuery cq = new CriteriaQuery(TSNoticeAuthorityRole.class);
		//查询条件组装器
		cq.eq("role.id", roleid);
		cq.eq("noticeId", noticeId);
		cq.add();
		List<TSNoticeAuthorityRole> rlist =   this.getListByCriteriaQuery(cq, false);
		if(rlist.size()==0){
			return false;
		}else{
			return true;
		}
	}

	@Override
	public void saveTSNoticeAuthorityRole(
			TSNoticeAuthorityRole noticeAuthorityRole) {
			if(this.checkAuthorityRole(noticeAuthorityRole.getNoticeId(), noticeAuthorityRole.getRole().getId())){
				throw new BusinessException("该角色已授权，请勿重复操作。");
			}else{
				final String noticeId = noticeAuthorityRole.getNoticeId();
				final String roleId = noticeAuthorityRole.getRole().getId();
				executor.execute(new Runnable() {
	
					@Override
					public void run() {
						String hql = "from TSRoleUser roleUser where roleUser.TSRole.id = ?";
						List<TSRoleUser> roleUserList = systemService.findHql(hql,roleId);
						for (TSRoleUser roleUser : roleUserList) {
							String userId = roleUser.getTSUser().getId();
							String noticeReadHql = "from TSNoticeReadUser where noticeId = ? and userId = ?";
							List<TSNoticeReadUser> noticeReadList = systemService.findHql(noticeReadHql,noticeId,userId);
							if(noticeReadList == null || noticeReadList.isEmpty()){
								//未授权过的消息，添加授权记录
								TSNoticeReadUser noticeRead = new TSNoticeReadUser();
								noticeRead.setNoticeId(noticeId);
								noticeRead.setUserId(userId);
								noticeRead.setCreateTime(new Date());
								systemService.save(noticeRead);
							}else if(noticeReadList.size() > 0){
								for (TSNoticeReadUser readUser : noticeReadList) {
									if(readUser.getDelFlag() == 1){
										readUser.setDelFlag(0);
										systemService.updateEntitie(readUser);
									}
								}
							}
						}
						roleUserList.clear();
					}
				});
				this.save(noticeAuthorityRole);
		}
	}

	@Override
	public void doDelTSNoticeAuthorityRole(
			TSNoticeAuthorityRole noticeAuthorityRole) {
		noticeAuthorityRole = systemService.getEntity(TSNoticeAuthorityRole.class, noticeAuthorityRole.getId());
		final String noticeId = noticeAuthorityRole.getNoticeId();
		final String roleId = noticeAuthorityRole.getRole().getId();
		executor.execute(new Runnable() {
			
			@Override
			public void run() {
				String hql = "from TSRoleUser roleUser where roleUser.TSRole.id = ?";
				List<TSRoleUser> roleUserList = systemService.findHql(hql,roleId);
				List<TSNoticeReadUser> deleteList = new ArrayList<TSNoticeReadUser>();
				List<TSNoticeReadUser> updateList = new ArrayList<TSNoticeReadUser>();
				for (TSRoleUser roleUser : roleUserList) {
					String userId = roleUser.getTSUser().getId();
					String noticeReadHql = "from TSNoticeReadUser where noticeId = ? and userId = ?";
					List<TSNoticeReadUser> noticeReadList = systemService.findHql(noticeReadHql,noticeId,userId);
					if(noticeReadList != null && noticeReadList.size() > 0){
						for (TSNoticeReadUser readUser : noticeReadList) {
							if(readUser.getIsRead() == 1){
								readUser.setDelFlag(1);
								updateList.add(readUser);
							}else if(readUser.getIsRead() == 0){
								deleteList.add(readUser);
							}
						}
					}
				}
				for (TSNoticeReadUser tsNoticeReadUser : updateList) {
					systemService.updateEntitie(tsNoticeReadUser);
				}
				for (TSNoticeReadUser readUser : deleteList) {
					systemService.delete(readUser);
				}
				updateList.clear();
				deleteList.clear();
				roleUserList.clear();
			}
		});
		this.delete(noticeAuthorityRole);
	}
}