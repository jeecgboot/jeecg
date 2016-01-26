package org.jeecgframework.web.demo.service.test;

import java.util.List;

import org.jeecgframework.core.common.service.CommonService;

public interface JeecgProcedureServiceI extends CommonService{
	public List queryDataByProcedure(String tableName,String fields,String whereSql);
}
