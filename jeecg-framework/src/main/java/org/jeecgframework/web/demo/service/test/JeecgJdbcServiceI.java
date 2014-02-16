package org.jeecgframework.web.demo.service.test;

import org.jeecgframework.web.demo.entity.test.JeecgJdbcEntity;
import net.sf.json.JSONObject;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;

public interface JeecgJdbcServiceI extends CommonService{
	public void getDatagrid1(JeecgJdbcEntity pageObj, DataGrid dataGrid);
	public void getDatagrid2(JeecgJdbcEntity pageObj, DataGrid dataGrid);
	public JSONObject getDatagrid3(JeecgJdbcEntity pageObj, DataGrid dataGrid);
	public void listAllByJdbc(DataGrid dataGrid);
}
