package org.jeecgframework.web.system.sms.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import org.jeecgframework.web.system.sms.entity.TSSmsEntity;
import org.jeecgframework.web.system.sms.entity.TSSmsSqlEntity;
import org.jeecgframework.web.system.sms.entity.TSSmsTemplateEntity;
import org.jeecgframework.web.system.sms.entity.TSSmsTemplateSqlEntity;
import org.jeecgframework.web.system.sms.service.TSSmsServiceI;
import org.jeecgframework.web.system.sms.service.TSSmsSqlServiceI;
import org.jeecgframework.web.system.sms.service.TSSmsTemplateServiceI;
import org.jeecgframework.web.system.sms.service.TSSmsTemplateSqlServiceI;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
/**
 * 
  * @ClassName: TuiSongMsgUtil 统一发送消息的公用方法
  * @Description: TODO
  * @author Comsys-skyCc cmzcheng@gmail.com
  * @date 2014-9-18 下午3:20:34
  *
 */
public class TuiSongMsgUtil {

	
//	private static TSSmsServiceI tSSmsService; //短信表service；
//	private static SystemService systemService;
//	private static TSSmsTemplateSqlServiceI tSSmsTemplateSqlService;//业务sql消息模板关联service;
//	private static TSSmsTemplateServiceI tSSmsTemplateService;//消息模板service
//	private static TSSmsSqlServiceI tSSmsSqlService;//业务sqlservice
//	private static NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	private static Configuration configuration;
	/**
	  * sendMessage 统一消息发送接口
	  *
	  * @param @param msgType 消息类型
	  * @param @param code   业务配置CODE
	  * @param @param map    数据参数
	  * @param @param sentTo 发送给谁
	  * @param @return       发送结果
	  * @throws
	 */
	public static String sendMessage(String title,String msgType, String code,
			Map<String, Object> map, String sentTo) {
		// TODO Auto-generated method stub
		try {
			TSSmsEntity tss=new TSSmsEntity();
			tss.setEsType(msgType);
			tss.setEsTitle(title);
			tss.setEsReceiver(sentTo);
			tss.setEsStatus(Constants.SMS_SEND_STATUS_1);
			String hql="from TSSmsTemplateSqlEntity as tempSql where tempSql.code=? ";
			String smsContent="";
			List<TSSmsTemplateSqlEntity> tssmsTemplateSqlList=getTssmsTemplateSqlInstance().findHql(hql, code);
			for (TSSmsTemplateSqlEntity tsSmsTemplateSqlEntity : tssmsTemplateSqlList) {
				TSSmsSqlEntity tsSmsSqlEntity = getTSSmsServiceInstance().getEntity(TSSmsSqlEntity.class, tsSmsTemplateSqlEntity.getSqlId());
				String templateSql= tsSmsSqlEntity.getSqlContent();//获取对应业务sql表中的sql语句
				TSSmsTemplateEntity tsSmsTemplateEntity= getTSSmsServiceInstance().getEntity(TSSmsTemplateEntity.class, tsSmsTemplateSqlEntity.getTemplateId());
				String templateContent=tsSmsTemplateEntity.getTemplateContent();//获取模板表的对应的模板内容
				//执行查询出来的模板sql
				Map<String, Object> rootMap  =  getRootMapBySql(templateSql,map);
				StringReader strR= new StringReader(templateContent);
				Template template = new Template("strTemplate", strR, new Configuration());
				StringWriter stringWriter = new StringWriter();
				BufferedWriter writer = new BufferedWriter(stringWriter);
				template.process(rootMap, writer);
				smsContent = stringWriter.toString();
			}
			tss.setEsContent(smsContent);
			getTSSmsServiceInstance().save(tss);		//对库进行查询操作
			return "success";

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return e.getMessage();
		}
	}
	public static NamedParameterJdbcTemplate getNamedParameterJdbcTemplate(){
			NamedParameterJdbcTemplate namedParameterJdbcTemplate = ApplicationContextUtil.getContext().getBean(NamedParameterJdbcTemplate.class);
			return namedParameterJdbcTemplate;
		}
	
	/**
	 * 
	  * getTSSmsServiceInstance 获取短信service
	  *
	  * @Title: getTSSmsServiceInstance
	  * @Description: TODO
	  * @param @return    设定文件
	  * @return TSSmsServiceI    返回类型
	  * @throws
	 */
	public static Configuration getConfiguration(){
		
		if(configuration==null){
			configuration=ApplicationContextUtil.getContext().getBean(Configuration.class);
		}
		return configuration;
	}
	/**
	 * 
	  * getRootMapBySql 获取业务SQL的配置数据
	  *
	  * @Title: getSearchSql
	  * @Description: TODO
	  * @param @param templateSql
	  * @param @param map
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	public static Map<String, Object> getRootMapBySql(String templateSql,Map<String, Object> map){
		//调用查询sql的方法执行此sql
		SqlParameterSource sqlp  = new MapSqlParameterSource(map);
		return getNamedParameterJdbcTemplate().queryForMap(templateSql, sqlp);
	}
	/**
	 * 
	  * getTemplateServiceSql 获取短信sql具体的sql内容
	  *
	  * @Title: getTemplateServiceSql
	  * @Description: TODO
	  * @param @param sqlId
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	public static String getTemplateSql(String sqlId){
		String hql="from TSSmsSqlEntity as tssSql where tssSql.id=?";
		List<TSSmsSqlEntity>tssmsSqlList=getTSSmsSqlInstance().findHql(hql, sqlId);
		String sqlContent="";
		for (TSSmsSqlEntity tsSmsSqlEntity : tssmsSqlList) {
			sqlContent=tsSmsSqlEntity.getSqlContent();
		}
		return sqlContent;
	}
	/**
	 * 
	  * getTemplateContent 获取模板内容
	  *
	  * @Title: getTemplateContent
	  * @Description: TODO
	  * @param @param templateId
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	public static  String getTemplateContent(String templateId){
		String hql="from TSSmsTemplateEntity as template where template.id=? ";
		List<TSSmsTemplateEntity> tSSmsTemplateList=getTssmsTemplateInstance().findHql(hql, templateId);
		String templateConetent="";
		for (TSSmsTemplateEntity tsSmsTemplateEntity : tSSmsTemplateList) {
			templateConetent=tsSmsTemplateEntity.getTemplateContent();
		}
		return templateConetent;
	}
	
	/**
	 * 
	  * getTSSmsServiceInstance 获取短信service
	  *
	  * @Title: getTSSmsServiceInstance
	  * @Description: TODO
	  * @param @return    设定文件
	  * @return TSSmsServiceI    返回类型
	  * @throws
	 */
	public static TSSmsServiceI getTSSmsServiceInstance(){
		TSSmsServiceI tSSmsService = ApplicationContextUtil.getContext().getBean(TSSmsServiceI.class);
		return tSSmsService;
	}
	/**
	 * 
	  * getTssmsTemplateSqlInstance 获取短信模板关联service实体
	  *
	  * @Title: getTssmsTemplateSqlInstance
	  * @Description: TODO
	  * @param @return    设定文件
	  * @return TSSmsTemplateSqlServiceI    返回类型
	  * @throws
	 */
	public static TSSmsTemplateSqlServiceI getTssmsTemplateSqlInstance(){
		
		TSSmsTemplateSqlServiceI tSSmsTemplateSqlService = ApplicationContextUtil.getContext().getBean(TSSmsTemplateSqlServiceI.class);
			
		return tSSmsTemplateSqlService;
	}
	/**
	 * 
	  * getTssmsTemplateInstance 获取具体的模板service实体
	  *
	  * @Title: getTssmsTemplateInstance
	  * @Description: TODO
	  * @param @return    设定文件
	  * @return TSSmsTemplateServiceI    返回类型
	  * @throws
	 */
	public static TSSmsTemplateServiceI getTssmsTemplateInstance(){
		TSSmsTemplateServiceI tSSmsTemplateService=ApplicationContextUtil.getContext().getBean(TSSmsTemplateServiceI.class);
		return tSSmsTemplateService;
	}
	/**
	 * 
	  * getTSSmsSqlInstance 获取业务sql service实体
	  *
	  * @Title: getTSSmsSqlInstance
	  * @Description: TODO
	  * @param @return    设定文件
	  * @return TSSmsSqlServiceI    返回类型
	  * @throws
	 */
	public static TSSmsSqlServiceI getTSSmsSqlInstance(){
		TSSmsSqlServiceI tSSmsSqlService =ApplicationContextUtil.getContext().getBean(TSSmsSqlServiceI.class);
		return tSSmsSqlService;
	}
}
