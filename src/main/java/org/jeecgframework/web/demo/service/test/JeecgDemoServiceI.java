package org.jeecgframework.web.demo.service.test;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.demo.entity.test.JeecgDemo;


public interface JeecgDemoServiceI extends CommonService{

	public void getDemoList(JeecgDemo jeecgDemo,DataGrid dataGrid);

}
