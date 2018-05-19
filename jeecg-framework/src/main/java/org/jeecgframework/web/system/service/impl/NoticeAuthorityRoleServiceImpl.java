package org.jeecgframework.web.system.service.impl;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.web.system.pojo.base.TSNoticeAuthorityRole;
import org.jeecgframework.web.system.service.NoticeAuthorityRoleServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("noticeAuthorityRoleService")
@Transactional
public class NoticeAuthorityRoleServiceImpl extends CommonServiceImpl implements NoticeAuthorityRoleServiceI {

	
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
}