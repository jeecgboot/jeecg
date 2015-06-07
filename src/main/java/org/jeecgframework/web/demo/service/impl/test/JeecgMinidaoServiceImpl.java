package org.jeecgframework.web.demo.service.impl.test;

import java.util.List;
import org.jeecgframework.web.demo.dao.test.JeecgMinidaoDao;
import org.jeecgframework.web.demo.entity.test.JeecgMinidaoEntity;
import org.jeecgframework.web.demo.service.test.JeecgMinidaoServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Minidao例子
 * @author fancq
 *
 */
@Service("jeecgMinidaoService")
@Transactional
public class JeecgMinidaoServiceImpl implements JeecgMinidaoServiceI {
	@Autowired
	private JeecgMinidaoDao jeecgMinidaoDao;
	
	public List<JeecgMinidaoEntity> listAll(JeecgMinidaoEntity jeecgMinidao, int page, int rows) {
		List<JeecgMinidaoEntity> entities = jeecgMinidaoDao.getAllEntities2(jeecgMinidao, page, rows);
		return entities;
	}
	
	public JeecgMinidaoEntity getEntity(Class clazz, String id) {
		JeecgMinidaoEntity jeecgMinidao = (JeecgMinidaoEntity)jeecgMinidaoDao.getByIdHiber(clazz, id);
		return jeecgMinidao;
	}
	
	public void insert(JeecgMinidaoEntity jeecgMinidao) {
		jeecgMinidaoDao.saveByHiber(jeecgMinidao);
	}
	
	public void update(JeecgMinidaoEntity jeecgMinidao) {
		jeecgMinidaoDao.updateByHiber(jeecgMinidao);
	}
	
	public void delete(JeecgMinidaoEntity jeecgMinidao) {
		jeecgMinidaoDao.deleteByHiber(jeecgMinidao);
	}
	
	public void deleteAllEntitie(List<JeecgMinidaoEntity> entities) {
		for (JeecgMinidaoEntity entity : entities) {
			jeecgMinidaoDao.deleteByHiber(entity);
		}
	}
	
	public Integer getCount() {
		return jeecgMinidaoDao.getCount();
	}
	
	public Integer getSumSalary() {
		return jeecgMinidaoDao.getSumSalary();
	}
}