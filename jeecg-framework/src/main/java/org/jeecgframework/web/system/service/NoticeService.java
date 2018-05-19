/**
 * 
 */
package org.jeecgframework.web.system.service;

import java.io.Serializable;
import java.util.Date;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.system.pojo.base.TSNotice;


/**
 * 通知公告Service接口
 * @author  alax
 *
 */
public interface NoticeService extends CommonService{

	/**
	 * 
	 * @param noticeTilte 标题
	 * @param noticeContent 内容
	 * @param noticeType 类型
	 * @param noticeLevel 级别
	 * @param noticeTerm 期限
	 * @param createUser 创建者
	 * @return
	 */
	public String addNotice(String noticeTilte, String noticeContent,String noticeType,String noticeLevel,Date noticeTerm,String createUser);
	
	/**
	 * 
	 * @param noticeId 通告ID
	 * @param userid 用户ID
	 * @return
	 */
	public void addNoticeAuthorityUser(String noticeId, String userid);
	
public <T> void delete(T entity);
 	
 	public <T> Serializable save(T entity);
 	
 	public <T> void saveOrUpdate(T entity);
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(TSNotice t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(TSNotice t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(TSNotice t);
}
