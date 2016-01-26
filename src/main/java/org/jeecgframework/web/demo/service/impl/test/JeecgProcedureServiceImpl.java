package org.jeecgframework.web.demo.service.impl.test;

import java.util.List;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.web.demo.dao.test.JeecgProcedureDao;
import org.jeecgframework.web.demo.service.test.JeecgProcedureServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("jeecgProcedureServiceImpl")
@Transactional
public class JeecgProcedureServiceImpl extends CommonServiceImpl implements JeecgProcedureServiceI{
	@Autowired
	private JeecgProcedureDao jeecgProcedureDao;
	@Override
	public List queryDataByProcedure(String tableName, String fields, String whereSql) {
		return jeecgProcedureDao.queryDataByProcedure(tableName, fields, whereSql);
	}
}