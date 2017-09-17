package com.jeecg.p3.demo.service;

import org.jeecgframework.minidao.pojo.MiniDaoPage;

import com.jeecg.p3.demo.entity.JeecgP3demoEntity;

/**
 * 描述：P3测试表
 * @author: www.jeecg.org
 * @since：2017年05月15日 20时07分37秒 星期一 
 * @version:1.0
 */
public interface JeecgP3demoService {
	
	public JeecgP3demoEntity get(String id);

	public int update(JeecgP3demoEntity jeecgP3demo);

	public void insert(JeecgP3demoEntity jeecgP3demo);

	public MiniDaoPage<JeecgP3demoEntity> getAll(JeecgP3demoEntity jeecgP3demo,int page,int rows);

	public void delete(JeecgP3demoEntity jeecgP3demo);
	
}
