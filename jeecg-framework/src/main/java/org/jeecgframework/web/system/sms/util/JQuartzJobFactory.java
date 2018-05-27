package org.jeecgframework.web.system.sms.util;

import org.quartz.spi.TriggerFiredBundle;  
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;  
import org.springframework.scheduling.quartz.SpringBeanJobFactory;  
import org.springframework.stereotype.Component;  
/**
 * 指定schedulerFactory中的jobFactory
 * 完成任务对象的自动注入功能
 * @author Link Xue
 * @date 20171129
 * @version V1.0
 */ 
@Component("jQuartzJobFactory")  
public class JQuartzJobFactory extends SpringBeanJobFactory {  
  
    @Autowired  
    private AutowireCapableBeanFactory beanFactory;  
  
    
    /**
     * 覆盖createJobInstance方法
     * 对其创建出来的对象autowire
     */
    @Override  
    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {  
  
        Object jobInstance = super.createJobInstance(bundle);  
  
        beanFactory.autowireBean(jobInstance);  
  
        return jobInstance;  
  
    }  
} 