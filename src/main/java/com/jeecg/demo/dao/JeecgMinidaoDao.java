package com.jeecg.demo.dao;

import java.util.List;
import java.util.Map;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.annotation.Sql;

import com.jeecg.demo.entity.JeecgDemoEntity;
import com.jeecg.demo.entity.JeecgLogReport;

/**
 * Minidao例子
 * 
 */
@MiniDao
public interface JeecgMinidaoDao {
	
	@Arguments("pid")
 	@Sql("select ID,NAME,PID from t_s_region where pid=:pid order by name_en")
    List<Map<String, String>> getProCity(String pid);
	
 	@Sql("select ID,NAME,PID from t_s_region order by name_en")
    List<Map<String, String>> getAllRegions();
 	
 	
 	@Arguments({"jeecgDemo", "page", "rows"})
	@ResultType(JeecgDemoEntity.class)
	public List<JeecgDemoEntity> getAllEntities(JeecgDemoEntity jeecgDemo, int page, int rows);

 	@Sql("SELECT count(*) FROM jeecg_demo")
	Integer getCount();

	@Sql("SELECT SUM(salary) FROM jeecg_demo")
	Integer getSumSalary();
	
	@Arguments("id")
	@ResultType(String.class)
	@Sql("SELECT org_code FROM t_s_depart where id=:id")
	public java.lang.String getOrgCode(String id);
 
	/*@Arguments({"jeecgMinidao", "page", "rows"})
	public List<Map> getAllEntities(JeecgMinidaoEntity jeecgMinidao, int page, int rows);

	@Arguments({"jeecgMinidao", "page", "rows"})
	@ResultType(JeecgMinidaoEntity.class)
	public List<JeecgMinidaoEntity> getAllEntities2(JeecgMinidaoEntity jeecgMinidao, int page, int rows);*/

	//@Arguments("id")
	//JeecgMinidaoEntity getJeecgMinidao(String id);

/*	
*/

	/*@Arguments("jeecgMinidao")
	int update(JeecgMinidaoEntity jeecgMinidao);

	@Arguments("jeecgMinidao")
	void insert(JeecgMinidaoEntity jeecgMinidao);

	@Arguments("jeecgMinidao")
	void delete(JeecgMinidaoEntity jeecgMinidao);*/
	
	@Arguments("log")
	@ResultType(JeecgLogReport.class)
	List<JeecgLogReport> getLogReportData(JeecgLogReport log);
	
	@Arguments("log")
	List<Map<String, Object>> getLogChartData(JeecgLogReport log);
}
