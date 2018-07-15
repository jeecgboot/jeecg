package org.jeecgframework.web.system.service.impl;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.web.system.pojo.base.TSNoticeAuthorityUser;
import org.jeecgframework.web.system.pojo.base.TSNoticeReadUser;
import org.jeecgframework.web.system.service.NoticeAuthorityUserServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("noticeAuthorityUserService")
@Transactional
public class NoticeAuthorityUserServiceImpl extends CommonServiceImpl implements NoticeAuthorityUserServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((TSNoticeAuthorityUser)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((TSNoticeAuthorityUser)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((TSNoticeAuthorityUser)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(TSNoticeAuthorityUser t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(TSNoticeAuthorityUser t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(TSNoticeAuthorityUser t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,TSNoticeAuthorityUser t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{notice_id}",String.valueOf(t.getNoticeId()));
 		sql  = sql.replace("#{user_id}",String.valueOf(t.getUser().getId()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	/**
 	 * 检查通知公告授权用户是否存在
 	 */
 	public boolean checkAuthorityUser(String noticeId, String userid) {
		CriteriaQuery cq = new CriteriaQuery(TSNoticeAuthorityUser.class);
		cq.eq("user.id", userid);
		cq.eq("noticeId", noticeId);
		cq.add();
		List<TSNoticeAuthorityUser> rlist =   this.getListByCriteriaQuery(cq, false);
		if(rlist.size()==0){
			return false;
		}else{
			return true;
		}
	}

	@Override
	public void saveNoticeAuthorityUser(TSNoticeAuthorityUser noticeAuthorityUser) {
		String noticeId = noticeAuthorityUser.getNoticeId();
		String userId = noticeAuthorityUser.getUser().getId();
		if(this.checkAuthorityUser(noticeId, userId)){
			throw new BusinessException("该用户已授权，请勿重复操作。");
		}else{
			String hql = "from TSNoticeReadUser where noticeId = ? and userId = ?";
			List<TSNoticeReadUser> noticeReadList = this.findHql(hql,noticeId,userId);
			if(noticeReadList == null || noticeReadList.isEmpty()){
				//未授权过的消息，添加授权记录
				TSNoticeReadUser noticeRead = new TSNoticeReadUser();
				noticeRead.setNoticeId(noticeId);
				noticeRead.setUserId(userId);
				noticeRead.setCreateTime(new Date());
				this.commonDao.save(noticeRead);
			}else if(noticeReadList.size() > 0){
				for (TSNoticeReadUser noticeRead : noticeReadList) {
					if(noticeRead.getDelFlag() == 1){
						noticeRead.setDelFlag(0);
						this.commonDao.updateEntitie(noticeRead);
					}
				}
				noticeReadList.clear();
			}
			this.commonDao.save(noticeAuthorityUser);
		}
	}

	@Override
	public void doDelNoticeAuthorityUser(TSNoticeAuthorityUser noticeAuthorityUser) {
		noticeAuthorityUser = this.commonDao.getEntity(TSNoticeAuthorityUser.class, noticeAuthorityUser.getId());
		if(noticeAuthorityUser != null){
			//删除授权关系的时候，判断是否已被阅读，如果已被阅读过，通过标记逻辑删除，否则直接删除数据
			String hql = "from TSNoticeReadUser where noticeId = ? and userId = ?";
			List<TSNoticeReadUser> noticeReadList = this.commonDao.findHql(hql,noticeAuthorityUser.getNoticeId(),noticeAuthorityUser.getUser().getId());
			if(noticeReadList != null && !noticeReadList.isEmpty()){
				for (TSNoticeReadUser noticeReadUser : noticeReadList) {
					if(noticeReadUser.getIsRead() == 1){
						noticeReadUser.setDelFlag(1);
						this.commonDao.updateEntitie(noticeReadUser);
					}else if(noticeReadUser.getIsRead() == 0){
						this.commonDao.delete(noticeReadUser);
					}
				}
				noticeReadList.clear();
			}
		}
		this.delete(noticeAuthorityUser);
	}
}