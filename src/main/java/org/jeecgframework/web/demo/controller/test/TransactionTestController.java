package org.jeecgframework.web.demo.controller.test;

import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.demo.entity.test.JeecgDemo;
import org.jeecgframework.web.demo.entity.test.JeecgMinidaoEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderCustomEntity;
import org.jeecgframework.web.demo.service.test.TransactionTestServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 事务回滚测试
 * Created by zzl on 2015/8/6.
 */
@Scope("prototype")
@Controller
@RequestMapping("/transactionTestController")
public class TransactionTestController {
    @Autowired
    private TransactionTestServiceI transactionTestService;
    @RequestMapping(params = "showPage")
    public String showPage(){
        return "jeecg/demo/test/transactionTestList";
    }
    @RequestMapping(params = "add")
    public String add(){
        return "jeecg/demo/test/transactionTest";
    }
    /**
     *  查询三个表数据数量
     * @return
     */
    @RequestMapping(params = "getDataCount")
    @ResponseBody
    public void getDataCount(HttpServletResponse response,DataGrid dataGrid){
        Map<String,Integer> dataMap=transactionTestService.getCounts();
        List<Map<String,Integer>> dataList=new ArrayList<Map<String, Integer>>();
        dataList.add(dataMap);
        dataGrid.setResults(dataList);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * 分别用minidao spring jdbc hibernate 插入数据 测试事务回滚性
     * @param entity
     * @param demo
     * @param customEntity
     * @param rollback 是否回滚
     * @return
     */
    @RequestMapping(params = "insertData")
    @ResponseBody
    public AjaxJson insertData(JeecgMinidaoEntity entity,JeecgDemo demo,JeecgOrderCustomEntity customEntity,boolean rollback){
        AjaxJson j = new AjaxJson();
        try{
            Map<String,Integer> dataMap= transactionTestService.insertData(entity, demo, customEntity, rollback);
            j.setMsg("保存成功！");
            j.setSuccess(true);
        }catch (Exception e){
            j.setMsg("保存失败，数据回滚！");
            j.setSuccess(true);
        }
        return j;
    }
}
