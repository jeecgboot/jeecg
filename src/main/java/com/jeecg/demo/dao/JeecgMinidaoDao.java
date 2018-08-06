package com.jeecg.demo.dao;

import java.util.List;
import java.util.Map;

import org.jeecgframework.minidao.annotation.*;
import com.jeecg.demo.entity.JeecgDemoEntity;
import com.jeecg.demo.entity.JeecgLogReport;
import org.jeecgframework.minidao.pojo.MiniDaoPage;

/**
 * Minidao例子
 * 
 */
@MiniDao
public interface JeecgMinidaoDao {
	
	@Arguments("pid")
 	@Sql("select id,name,pid from t_s_region where pid=:pid order by name_en")
    List<Map<String, String>> getProCity(String pid);
	
 	@Sql("select id,name,pid from t_s_region order by name_en")
    List<Map<String, String>> getAllRegions();

 	@ResultType(JeecgDemoEntity.class)
	public MiniDaoPage<JeecgDemoEntity> getAllEntities(@Param("jeecgDemo") JeecgDemoEntity jeecgDemo, @Param("page")  int page, @Param("rows") int rows,@Param("sort")String sort, @Param("order")String order,@Param("authSql") String authSql);

 	@Sql("select count(*) from jeecg_demo")
	Integer getCount();

	@Sql("select sum(salary) from jeecg_demo")
	Integer getSumSalary();
	
	@Arguments("id")
	@ResultType(String.class)
	@Sql("select org_code from t_s_depart where id=:id")
	public java.lang.String getOrgCode(String id);
 
	@Arguments("log")
	@ResultType(JeecgLogReport.class)
	List<JeecgLogReport> getLogReportData(JeecgLogReport log);
	
	@Arguments("log")
	List<Map<String, Object>> getLogChartData(JeecgLogReport log);
}
