package org.jeecgframework.web.system.sms.service.impl;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.ConnectException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.AuthenticationFailedException;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.DBTypeUtil;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.core.util.PropertiesUtil;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.jeecgframework.web.system.sms.entity.TSSmsEntity;
import org.jeecgframework.web.system.sms.service.TSSmsServiceI;
import org.jeecgframework.web.system.sms.util.CMPPSenderUtil;
import org.jeecgframework.web.system.sms.util.Constants;
import org.jeecgframework.web.system.sms.util.MailUtil;

import com.sun.mail.smtp.SMTPAddressFailedException;

@Service("tSSmsService")
@Transactional
public class TSSmsServiceImpl extends CommonServiceImpl implements TSSmsServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((TSSmsEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((TSSmsEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((TSSmsEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(TSSmsEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(TSSmsEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(TSSmsEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,TSSmsEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{es_title}",String.valueOf(t.getEsTitle()));
 		sql  = sql.replace("#{es_type}",String.valueOf(t.getEsType()));
 		sql  = sql.replace("#{es_sender}",String.valueOf(t.getEsSender()));
 		sql  = sql.replace("#{es_receiver}",String.valueOf(t.getEsReceiver()));
 		sql  = sql.replace("#{es_content}",String.valueOf(t.getEsContent()));
 		sql  = sql.replace("#{es_sendtime}",String.valueOf(t.getEsSendtime()));
 		sql  = sql.replace("#{es_status}",String.valueOf(t.getEsStatus()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
	/**
	 *  消息发送接口实现
	 */
	@Override
	@Transactional
	public void send() {
		LogUtil.info("===============消息发扫描开始=================");
		//List<TSSmsEntity> smsSendList = findHql("from TSSmsEntity e where e.esStatus = ? or e.esStatus = ? ", Constants.SMS_SEND_STATUS_1,Constants.SMS_SEND_STATUS_3);
		List<TSSmsEntity> smsSendList = findHql("from TSSmsEntity e where e.esStatus = ?", Constants.SMS_SEND_STATUS_1);
		if(smsSendList==null || smsSendList.size()==0){
			return;
		}
		PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
		for (TSSmsEntity tsSmsEntity : smsSendList) {
			String remark = "";
			if(Constants.SMS_SEND_TYPE_2.equals(tsSmsEntity.getEsType())){
				//邮件
				try {
					MailUtil.sendEmail(util.readProperty("mail.smtpHost"), tsSmsEntity.getEsReceiver(),tsSmsEntity.getEsTitle(), 
							tsSmsEntity.getEsContent(), util.readProperty("mail.sender"), 
							util.readProperty("mail.user"), util.readProperty("mail.pwd"));
					tsSmsEntity.setEsStatus(Constants.SMS_SEND_STATUS_2);
					tsSmsEntity.setEsSendtime(new Date());
					remark = "发送成功";
					tsSmsEntity.setRemark(remark);
					updateEntitie(tsSmsEntity);
				} catch (Exception e) {
					//tsSmsEntity.setEsStatus(Constants.SMS_SEND_STATUS_3);
					if (e instanceof AuthenticationFailedException){
						remark = "认证失败错误的用户名或者密码";
					}else if (e instanceof SMTPAddressFailedException){
						remark = "接受邮箱格式不对";
					}else if (e instanceof ConnectException){
						remark = "邮件服务器连接失败";
					}else{
						remark = e.getMessage();
					}
					//System.out.println(remark);
					//e.printStackTrace();
					tsSmsEntity.setEsStatus(Constants.SMS_SEND_STATUS_3);
					tsSmsEntity.setEsSendtime(new Date());
					tsSmsEntity.setRemark(remark);
					updateEntitie(tsSmsEntity);
				}
			}
			if(Constants.SMS_SEND_TYPE_1.equals(tsSmsEntity.getEsType())){
				//短信
				String r = CMPPSenderUtil.sendMsg(tsSmsEntity.getEsReceiver(), tsSmsEntity.getEsContent());
				if ("0".equals(r)){
					tsSmsEntity.setEsStatus(Constants.SMS_SEND_STATUS_2);
				}else {
					tsSmsEntity.setEsStatus(Constants.SMS_SEND_STATUS_3);
				}
			}
			//更新发送状态
			tsSmsEntity.setRemark(remark);
			tsSmsEntity.setEsSendtime(new Date());
			updateEntitie(tsSmsEntity);
		}
		LogUtil.info("===============消息发扫描结束=================");
	}

	public List<TSSmsEntity> getMsgsList(String curUser,String curDate) {
		List<TSSmsEntity> list = new ArrayList<TSSmsEntity>();
		String hql=null;
		if("sqlserver".equals(DBTypeUtil.getDBType())){
			hql = "from TSSmsEntity t where t.esType='3' and t.esReceiver=? and CONVERT(varchar(20),t.esSendtime) like ?";
		}else{
			hql = "from TSSmsEntity t where t.esType='3' and t.esReceiver=? and str(t.esSendtime) like ?";
		}
		list = this.findHql(hql, new Object[] {curUser,curDate+'%'});
		return list;
	}

}