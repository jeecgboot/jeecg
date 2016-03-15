package org.jeecgframework.web.demo.dao.test;

import java.util.List;

import org.jeecgframework.minidao.annotation.MiniDao;

@MiniDao
public interface JeecgProcedureDao {

	//TODO minidao-pe 升级
	//@Procedure("call formDataList(?,?,?)")
	public List queryDataByProcedure(String tableName,String fields,String whereSql);
}
