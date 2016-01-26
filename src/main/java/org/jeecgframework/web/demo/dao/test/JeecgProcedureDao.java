package org.jeecgframework.web.demo.dao.test;

import java.util.List;

import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.Procedure;

@MiniDao
public interface JeecgProcedureDao {

	@Procedure("call formDataList(?,?,?)")
	public List queryDataByProcedure(String tableName,String fields,String whereSql);
}
