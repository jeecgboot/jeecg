package org.jeecgframework.web.system.service.impl;

import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.web.system.dao.DepartAuthGroupDao;
import org.jeecgframework.web.system.service.DepartAuthGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("departAuthGroupService")
@Transactional
public class DepartAuthGroupServiceImpl extends CommonServiceImpl implements DepartAuthGroupService{
	
	@Autowired
	private DepartAuthGroupDao departAuthGroupDao;

	@Override
	public MiniDaoPage<Map<String,Object>> getDepartAuthGroupList(int page,
			int rows) {
		return departAuthGroupDao.getDepartAuthGroupList(page, rows);
	}

	@Override
	public List<Map<String, Object>> chkDepartAuthGroupList(String userId) {
		return departAuthGroupDao.chkDepartAuthGroupList(userId);
	}

	@Override
	public MiniDaoPage<Map<String,Object>> getDepartAuthGroupByUserId(
			int page, int rows, String userId) {
		return departAuthGroupDao.getDepartAuthGroupByUserId(page, rows, userId);
	}

	@Override
	public MiniDaoPage<Map<String,Object>> getDepartAuthRole(int page,
			int rows, String userId) {
		return departAuthGroupDao.getDepartAuthRole(page, rows, userId);
	}

	@Override
	public List<Map<String, Object>> chkDepartAuthRole() {
		return departAuthGroupDao.chkDepartAuthRole();
	}

}
