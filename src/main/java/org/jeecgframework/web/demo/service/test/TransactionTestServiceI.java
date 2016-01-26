package org.jeecgframework.web.demo.service.test;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.demo.entity.test.JeecgDemo;
import org.jeecgframework.web.demo.entity.test.JeecgMinidaoEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderCustomEntity;

import java.util.Map;

/**
 * Created by Administrator on 2015/8/6.
 */
public interface TransactionTestServiceI {
    /**
     * 获取三个表中数据的数量
      * @return
     */
      Map<String,Integer> getCounts();

    /**
     * 同时使用 minidao springjdbc hibernate 三种方式进行插入 测试事务回滚功能
     * @param entity minidao方式的entity
     * @param demo spirng jdbc 方式的entity
     * @param customEntity hibernate 方式的entity
     * @param rollback 是否进行回滚
     * @return 每种方式的数量
     */
    Map<String,Integer> insertData(JeecgMinidaoEntity entity,JeecgDemo demo,JeecgOrderCustomEntity customEntity,boolean rollback) throws Exception;
}
