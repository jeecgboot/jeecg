package org.jeecgframework.core.timer;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Job {

 
//    @Scheduled(cron="*/10 * * * * *") 
//    public void s10(){
//        org.jeecgframework.core.util.LogUtil.info("==== 十秒执行一次=======10s");
//    }
//    
//    @Scheduled(cron="0 */1 * * * *") 
//    public void m1(){
//        org.jeecgframework.core.util.LogUtil.info("1m");
//    }
    
    /**
     * 每天1点执行一次
     * */
    @Scheduled(cron="0 0 1 * * ?") 
    public void oneOClockPerDay(){
        org.jeecgframework.core.util.LogUtil.info("1h");
    }
    
    
    
}