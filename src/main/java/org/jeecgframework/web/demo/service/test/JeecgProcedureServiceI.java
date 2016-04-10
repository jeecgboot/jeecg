package org.jeecgframework.web.demo.service.test;

import java.util.List;


public interface JeecgProcedureServiceI{
	//update-begin--Author:luobaoli  Date:20150711 for：新增调用存储过程的service接口
	public List queryDataByProcedure(String tableName,String fields,String whereSql);
	//update-end--Author:luobaoli  Date:20150711 for：新增调用存储过程的service接口
}
