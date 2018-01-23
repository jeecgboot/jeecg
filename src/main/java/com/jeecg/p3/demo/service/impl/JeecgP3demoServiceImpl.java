package com.jeecg.p3.demo.service.impl;

import javax.annotation.Resource;

import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Service;

import com.jeecg.p3.demo.dao.JeecgP3demoDao;
import com.jeecg.p3.demo.entity.JeecgP3demoEntity;
import com.jeecg.p3.demo.service.JeecgP3demoService;

/**
 * 描述：P3测试表
 * @author: www.jeecg.org
 * @since：2017年05月15日 20时07分37秒 星期一 
 * @version:1.0
 */

@Service("jeecgP3demoService")
public class JeecgP3demoServiceImpl implements JeecgP3demoService {
	@Resource
	private JeecgP3demoDao jeecgP3demoDao;

	@Override
	public JeecgP3demoEntity get(String id) {
		return jeecgP3demoDao.get(id);
	}

	@Override
	public int update(JeecgP3demoEntity jeecgP3demo) {
		return jeecgP3demoDao.update(jeecgP3demo);
	}

	@Override
	public void insert(JeecgP3demoEntity jeecgP3demo) {
		jeecgP3demoDao.insert(jeecgP3demo);
		
	}

	@Override
	public MiniDaoPage<JeecgP3demoEntity> getAll(JeecgP3demoEntity jeecgP3demo, int page, int rows) {
		return jeecgP3demoDao.getAll(jeecgP3demo, page, rows);
	}

	@Override
	public void delete(JeecgP3demoEntity jeecgP3demo) {
		jeecgP3demoDao.delete(jeecgP3demo);
		
	}

	@Override
	public MiniDaoPage<JeecgP3demoEntity> getAllByOrder(JeecgP3demoEntity query, int page, int rows, String sort,
			String order) {
		return jeecgP3demoDao.getAllByOrder(query,page,rows,sort,order);
	}

}
