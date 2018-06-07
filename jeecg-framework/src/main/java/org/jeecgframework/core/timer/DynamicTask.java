package org.jeecgframework.core.timer;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.http.client.ClientProtocolException;
import org.apache.log4j.Logger;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.HttpRequest;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.MyClassLoader;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.system.pojo.base.TSTimeTaskEntity;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.TimeTaskServiceI;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;

/**
 * 动态任务,用以动态调整Spring的任务
 * @author JueYue
 * @date 2013-9-20
 * @version 1.0
 */
@Service(value="dynamicTask")
public class DynamicTask {
	
	private static Logger logger = Logger.getLogger(DynamicTask.class);

	@Autowired(required=false)
	private Scheduler schedulerFactory;

	@Autowired(required=false)
	private TimeTaskServiceI timeTaskService;
	
	@Autowired(required=false)
	private SystemService systemService;
	
	
	/**
	 * 启动定时任务
	 * @param task
	 */
	private boolean startTask(TSTimeTaskEntity task){
		try {

			//quartz 1.6
//			JobDetail jobDetail = new JobDetail();
//			jobDetail.setName(task.getId());
//			jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
//			jobDetail.setJobClass(MyClassLoader.getClassByScn(task.getClassName()));
//			CronTrigger cronTrigger = new CronTrigger("cron_" + task.getId(),Scheduler.DEFAULT_GROUP, jobDetail.getName(),Scheduler.DEFAULT_GROUP);
//			cronTrigger.setCronExpression(task.getCronExpression());
			//quartz 2.3.0
			//向调度器中添加任务
			scheduleJob(task);

			return true;
		} catch (SchedulerException e) {
			logger.error("startTask SchedulerException"+" cron_" + task.getId()+ e.getMessage());	
		}
		return false;
	}
	
	/**
	 * 结束计划任务
	 * @param task
	 * @throws SchedulerException
	 */
	private boolean endTask(TSTimeTaskEntity task){
		
		try{

			//quartz 2.2
			TriggerKey triggerKey = new TriggerKey("cron_" + task.getId());
			//停止触发器
			schedulerFactory.pauseTrigger(triggerKey);
			//移除触发器
			schedulerFactory.unscheduleJob(triggerKey);
			JobKey jobKey = new JobKey(task.getId());
			//删除任务
			schedulerFactory.deleteJob(jobKey);

			//quartz 1.6
//			schedulerFactory.unscheduleJob("cron_" + task.getId());
			return true;
		}catch (SchedulerException e) {
			logger.error("endTask SchedulerException" + " cron_" + task.getId() + e.getMessage());
		}
		return false;
	}

	
	/**
	 * 开关定时任务
	 * @param task
	 * @param start
	 * @return
	 * @throws SchedulerException 
	 */
	public boolean startOrStop(TSTimeTaskEntity task, boolean start){
		boolean isSuccess = start ? startTask(task) : endTask(task);
		if(isSuccess){
			task.setIsStart(start?"1":"0");

			task.setIsEffect("1");

			timeTaskService.updateEntitie(task);
			systemService.addLog((start?"开启任务":"停止任务")+task.getTaskId(), Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			logger.info((start?"开启任务":"停止任务")+"-------TaskId:"+task.getTaskId()+"-------Describe:"+task.getTaskDescribe()+"-----ClassName:"+task.getClassName() );
		}
		return isSuccess;
	}

	/**
	 * 更新触发规则
	 * @param task
	 * @return
	 */
	public boolean updateCronExpression(TSTimeTaskEntity task) {
		try {
			String newExpression = task.getCronExpression();
			task = timeTaskService.get(TSTimeTaskEntity.class, task.getId());
			
			//任务运行中
			if("1".equals(task.getIsStart())){

//				CronTriggerBean trigger = (CronTriggerBean)schedulerFactory.getTrigger("cron_" + task.getId(), Scheduler.DEFAULT_GROUP);
//				String originExpression = trigger.getCronExpression();
				//检查运行中的任务触发规则是否与新规则一致
//			    if (!originExpression.equalsIgnoreCase(newExpression)) {
//			        trigger.setCronExpression(newExpression);
//			        schedulerFactory.rescheduleJob("cron_" + task.getId(), Scheduler.DEFAULT_GROUP, trigger);
//			    }
				//通过触发器key 向调度器 获取触发器实例
				Trigger oldTrigger = schedulerFactory.getTrigger(new TriggerKey("cron_" + task.getId()));
				//获取bulid对象
				TriggerBuilder tb = oldTrigger.getTriggerBuilder();
				//创建触发器
				CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(newExpression);
				Trigger newTrigger = tb.withSchedule(cronScheduleBuilder).build();
				//更新触发器
				schedulerFactory.rescheduleJob(oldTrigger.getKey(), newTrigger);

			}else{
				//立即生效
				List<String> ipList = IpUtil.getLocalIPList();
				String runServerIp = task.getRunServerIp();
				boolean isStart = task.getIsStart().equals("0");
				boolean isSuccess = false;
				if(ipList.contains(runServerIp) || StringUtil.isEmpty(runServerIp) || "本地".equals(runServerIp)){//当前服务器IP匹配成功
					isSuccess = this.startOrStop(task ,isStart);
				}else{
					try {
						String url = "http://" + task.getRunServer() + "/timeTaskController.do?remoteTask";//spring-mvc.xml
						String param = "id=" + task.getId() + "&isStart=" + (isStart ? "1" : "0");
						String jsonstr = HttpRequest.httpPost(url, param, false);
						if (null != jsonstr && jsonstr.length() > 0) {
							JSONObject json = (JSONObject) JSONObject.parse(jsonstr);
							isSuccess = json.getBooleanValue("success");
						}
					} catch (ClientProtocolException e) {
						logger.info("远程主机‘" + task.getRunServer() + "’响应超时");
						return false;
					} catch (IOException e) {
						logger.info("远程主机‘"+task.getRunServer() + "’响应超时");
						return false;
					}
				}
				if(isSuccess){
					/*task.setIsEffect("1");
					task.setIsStart("1");
					timeTaskService.updateEntitie(task);*/
					systemService.addLog(("立即生效开启任务成功，任务ID:") + task.getTaskId(), Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
					logger.info(("立即生效开启任务成功，任务ID:") + "-------TaskId:" + task.getTaskId() + "-------Describe:" + task.getTaskDescribe() + "-----ClassName:" + task.getClassName() );
					return true;
				}else{
					systemService.addLog(("立即生效开启任务失败，任务ID:") + task.getTaskId(), Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
					logger.info(("立即生效开启任务失败，任务ID:") + "-------TaskId:" + task.getTaskId() + "-------Describe:" + task.getTaskDescribe() + "-----ClassName:" + task.getClassName() );
					return false;
				}
			}
		} catch (SchedulerException e) {
			logger.error("updateCronExpression SchedulerException" + " cron_" + task.getId() + e.getMessage());
		}
		
		return false;
	}
	
	/**
	 * 更新触发规则
	 * @param task
	 * @return
	 */
	/*public boolean updateCronExpression(TSTimeTaskEntity task) {		
		
		try {
			String newExpression = task.getCronExpression();		
			task = timeTaskService.get(TSTimeTaskEntity.class, task.getId());		

			//任务运行中
			if("1".equals(task.getIsStart())){
				CronTriggerBean trigger = (CronTriggerBean)schedulerFactory.getTrigger("cron_" + task.getId(), Scheduler.DEFAULT_GROUP);             
				String originExpression = trigger.getCronExpression(); 	 
				//检查运行中的任务触发规则是否与新规则一致
			    if (!originExpression.equalsIgnoreCase(newExpression)) {  
			        trigger.setCronExpression(newExpression);  
			        schedulerFactory.rescheduleJob("cron_" + task.getId(), Scheduler.DEFAULT_GROUP, trigger); 
			    } 
			}else{
				//立即生效
				startTask(task);
				task.setIsEffect("1");
				task.setIsStart("1");
				timeTaskService.updateEntitie(task);
				systemService.addLog(("立即生效开启任务")+task.getTaskId(), Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
				logger.info(("立即生效开启任务")+"-------TaskId:"+task.getTaskId()+"-------Describe:"+task.getTaskDescribe()+"-----ClassName:"+task.getClassName() );
			}

			
			return true;
		} catch (SchedulerException e) {
			logger.error("updateCronExpression SchedulerException" + " cron_" + task.getId() + e.getMessage());
		} catch (ParseException e) {
			logger.error("updateCronExpression ParseException" + " cron_" + task.getId() + e.getMessage());
		}
		
		return false;
	}*/

	
	/**
	 * 系统初始加载任务
	 * @throws UnknownHostException 
	 */
	public void loadTask(){

		//String serverIp = InetAddress.getLocalHost().getHostAddress();
		List<String> ipList = IpUtil.getLocalIPList();
		TSTimeTaskEntity timTask = new TSTimeTaskEntity();
		timTask.setIsEffect("1");
		timTask.setIsStart("1");
		List<TSTimeTaskEntity> tasks = (List<TSTimeTaskEntity>)timeTaskService.findByExample(TSTimeTaskEntity.class.getName(), timTask);	
		logger.info(" register time task class num is ["+tasks.size()+"] ");
		if(tasks.size() > 0){
			for (TSTimeTaskEntity task : tasks) {
				//startTask(task);
				try {

					String runServerIp = task.getRunServerIp();					
					if(ipList.contains(runServerIp) || StringUtil.isEmpty(runServerIp) || "本地".equals(runServerIp)){//当前服务器IP匹配成功

						//quartz 1.6

//						JobDetail jobDetail = new JobDetail();
//						jobDetail.setName(task.getId());
//						jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
//						jobDetail.setJobClass(MyClassLoader.getClassByScn(task.getClassName()));
//						CronTrigger cronTrigger = new CronTrigger("cron_" + task.getId(),Scheduler.DEFAULT_GROUP, jobDetail.getName(),Scheduler.DEFAULT_GROUP);
//						cronTrigger.setCronExpression(task.getCronExpression());
						//向调度器中添加任务
						scheduleJob(task);

						logger.info(" register time task class is { "+task.getClassName()+" } ");
					}
				} catch (SchedulerException e) {
					logger.error("startTask SchedulerException"+" cron_" + task.getId()+ e.getMessage());	
				}
			}
		}
	}

	/**
	 * 注册 定时任务
	 * @param task 定时任务对象
	 * @throws SchedulerException
	 */
	private void scheduleJob(TSTimeTaskEntity task) throws SchedulerException {
		//build 要执行的任务
		JobDetail jobDetail = JobBuilder.newJob(MyClassLoader.getClassByScn(task.getClassName()))
				.withIdentity(task.getId())
			    .storeDurably()
			    .requestRecovery()
			    .build();
		//根据Cron表达式 build 触发时间对象
		CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(task.getCronExpression());
		//build 任务触发器
		CronTrigger cronTrigger = TriggerBuilder.newTrigger()
				.withIdentity("cron_" + task.getId())
				.withSchedule(cronScheduleBuilder)//标明触发时间
				.build();
		//向调度器注册 定时任务
		schedulerFactory.scheduleJob(jobDetail, cronTrigger);
	}

}
