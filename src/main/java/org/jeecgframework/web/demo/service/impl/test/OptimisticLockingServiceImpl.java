package org.jeecgframework.web.demo.service.impl.test;

import org.jeecgframework.web.demo.entity.test.OptimisticLockingEntity;
import org.jeecgframework.web.demo.service.test.OptimisticLockingServiceI;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("optimisticLockingService")
@Transactional
public class OptimisticLockingServiceImpl extends CommonServiceImpl implements OptimisticLockingServiceI {
	public void  dd (){
		Session session1=getSession();  
        Session session2=getSession();  
        OptimisticLockingEntity stu1=this.get(OptimisticLockingEntity.class, "2c91992b3f74fd05013f74fda0260001");
        OptimisticLockingEntity stu2=this.get(OptimisticLockingEntity.class, "2c91992b3f74fd05013f74fda0260001");
          
        //这时候，两个版本号是相同的  
        org.jeecgframework.core.util.LogUtil.info("v1="+stu1.getVer()+"--v2="+stu2.getVer());  
          
        Transaction tx1=session1.beginTransaction();  
        stu1.setAccount(200);
        tx1.commit();  
        //这时候，两个版本号是不同的，其中一个的版本号递增了  
        org.jeecgframework.core.util.LogUtil.info("v1="+stu1.getVer()+"--v2="+stu2.getVer());  
          
        Transaction tx2=session2.beginTransaction();  
        stu2.setAccount(500);
          
        tx2.rollback();  
        session2.close();  
        session1.close(); 
	}
}