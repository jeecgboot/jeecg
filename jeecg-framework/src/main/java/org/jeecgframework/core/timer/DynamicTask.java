package org.jeecgframework.core.timer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.text.ParseException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.springframework.stereotype.Service;

/**
 * 动态任务,用以动态调整Spring的任务
 * @author JueYue
 * @date 2013-9-20
 * @version 1.0
 */
@Service(value="dynamicTask")
public class DynamicTask {
	
	private static Logger logger = Logger.getLogger(DynamicTask.class);

	@Resource
	private Scheduler schedulerFactory;
	
	/**
	 * 更新定时任务的触发表达式
	 * 
	 * @param triggerName
	 *            触发器名字
	 * @param start
	 *            触发表达式
	 * @return 成功则返回true，否则返回false
	 */
	public boolean startOrStop(String triggerName,
			boolean start) {
		try {
			CronTrigger trigger = (CronTrigger) getTrigger(triggerName,
					Scheduler.DEFAULT_GROUP);
			if(start){
				schedulerFactory.resumeTrigger(trigger.getName(), trigger.getGroup());
				logger.info("trigger the start successfully!!");
			}else{
				schedulerFactory.pauseTrigger(trigger.getName(), trigger.getGroup());
				logger.info("trigger the pause successfully!!");
			}
			return true;
		}  catch (SchedulerException e) {
			logger.error("Fail to reschedule. " + e);
			return false;
		}
	}

	/**
	 * 更新定时任务的触发表达式
	 * 
	 * @param triggerName
	 *            触发器名字
	 * @param cronExpression
	 *            触发表达式
	 * @return 成功则返回true，否则返回false
	 */
	public boolean updateCronExpression(String triggerName,
			String cronExpression) {
		try {
			CronTrigger trigger = (CronTrigger) getTrigger(triggerName,
					Scheduler.DEFAULT_GROUP);
			if (trigger == null) {
				return false;
			}
			if (StringUtils.equals(trigger.getCronExpression(), cronExpression)) {
				logger.info("cronExpression is same with the running Schedule , no need to update.");
				return true;
			}
			trigger.setCronExpression(cronExpression);
			schedulerFactory.rescheduleJob(trigger.getName(), trigger.getGroup(),
					trigger);
			updateSpringMvcTaskXML(trigger,cronExpression);
			logger.info("Update the cronExpression successfully!!");
			return true;
		} catch (ParseException e) {
			logger.error("The new cronExpression - " + cronExpression
					+ " not conform to the standard. " + e);
			return false;
		} catch (SchedulerException e) {
			logger.error("Fail to reschedule. " + e);
			return false;
		}
	}

	/**
	 * 获取触发器
	 * 
	 * @param triggerName
	 *            触发器名字
	 * @param groupName
	 *            触发器组名字
	 * @return 对应Trigger
	 */
	private Trigger getTrigger(String triggerName, String groupName) {
		Trigger trigger = null;
		if (StringUtils.isBlank(groupName)) {
			logger.warn("Schedule Job Group is empty!");
			return null;
		}
		if (StringUtils.isBlank(triggerName)) {
			logger.warn("Schedule trigger Name is empty!");
			return null;
		}
		try {
			trigger = schedulerFactory.getTrigger(triggerName, groupName);
		} catch (SchedulerException e) {
			logger.warn("Fail to get the trigger (triggerName: " + triggerName
					+ ", groupName : " + groupName + ")");
			return null;
		}
		if (trigger == null) {
			logger.warn("Can not found the trigger of triggerName: "
					+ triggerName + ", groupName : " + groupName);
		}
		return trigger;
	}
	/**
	 * 更新spring-mvc-timeTask.xml 配置文件
	 * @param trigger
	 * @param cronExpression 
	 */
	@SuppressWarnings("unchecked")
	public synchronized static void updateSpringMvcTaskXML(CronTrigger trigger, String cronExpression) {
		Document document = null;
		File file = null;
		SAXReader saxReader = new SAXReader();
		try {
			URI url = DynamicTask.class.getClassLoader().getResource("spring-mvc-timeTask.xml").toURI();
			file = new File(url.getPath());
			document = saxReader.read(new FileInputStream(file));
		} catch (Exception e) {
			logger.error("读取系统中用到的SQL 语句XML出错");
			throw new RuntimeException("---------读取spring-mvc-timeTask.xml文件出错:" + e.getMessage());
		}
		Element root = document.getRootElement();
		List<Element> beans = root.elements();
		for (Element bean : beans) {
			if(bean.attribute("id")!=null&&
					bean.attribute("id").getValue().equals(trigger.getName())){
				beans = bean.elements();
				for (Element temp : beans) {
					if(temp.attribute("name")!=null&&
							temp.attribute("name").getValue().equals("cronExpression")){
						temp.attribute("value").setValue(cronExpression);
						break;
					}
				}
				break;
			}
		}
		XMLWriter  fileWriter = null;
		try {
			OutputFormat xmlFormat = OutputFormat.createPrettyPrint();
			xmlFormat.setEncoding("utf-8");
			fileWriter = new XMLWriter(new FileOutputStream(file),xmlFormat);
			fileWriter.write(document);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				fileWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}

}
