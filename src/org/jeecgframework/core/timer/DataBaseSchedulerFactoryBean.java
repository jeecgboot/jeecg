package org.jeecgframework.core.timer;

import jeecg.system.pojo.base.TSTimeTaskEntity;
import jeecg.system.service.TimeTaskServiceI;

import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
/**
 * 读取数据库 然后判断是否启动任务
 * @author JueYue
 * @date 2013-9-22
 * @version 1.0
 */
public class DataBaseSchedulerFactoryBean extends SchedulerFactoryBean {
	
	@Autowired
	private TimeTaskServiceI timeTaskService;
	/**
	 * 读取数据库判断是否开始定时任务
	 */
	public void afterPropertiesSet() throws Exception {
		super.afterPropertiesSet();
		String[] trigerrNames = this.getScheduler().getTriggerNames(Scheduler.DEFAULT_GROUP);
		TSTimeTaskEntity task;
		for(int i = 0;i<trigerrNames.length;i++){
			task = timeTaskService.findUniqueByProperty(TSTimeTaskEntity.class,"taskId",trigerrNames[i]);
			if(task!=null&&task.getIsStart().equals("0")){
				this.getScheduler().pauseTrigger(trigerrNames[i],Scheduler.DEFAULT_GROUP);
			}
		}
	}

}
