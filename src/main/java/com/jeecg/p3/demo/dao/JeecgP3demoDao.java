package com.jeecg.p3.demo.dao;

import org.jeecgframework.minidao.annotation.Param;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.annotation.Sql;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Repository;
import com.jeecg.p3.demo.entity.JeecgP3demoEntity;

/**
 * 描述：P3测试表
 * @author：www.jeecg.org
 * @since：2017年05月15日 20时07分37秒 星期一 
 * @version:1.0
 */
@Repository
public interface JeecgP3demoDao{

    /**
	 * 查询返回Java对象
	 * @param id
	 * @return
	 */
	@Sql("SELECT * FROM jeecg_p3demo WHERE ID = :id")
	JeecgP3demoEntity get(@Param("id") String id);
	
	/**
	 * 修改数据
	 * @param jeecgP3demo
	 * @return
	 */
	int update(@Param("jeecgP3demo") JeecgP3demoEntity jeecgP3demo);
	
	/**
	 * 插入数据
	 * @param act
	 */
	void insert(@Param("jeecgP3demo") JeecgP3demoEntity jeecgP3demo);
	
	/**
	 * 通用分页方法，支持（oracle、mysql、SqlServer、postgresql）
	 * @param jeecgP3demo
	 * @param page
	 * @param rows
	 * @return
	 */
	@ResultType(JeecgP3demoEntity.class)
	public MiniDaoPage<JeecgP3demoEntity> getAll(@Param("jeecgP3demo") JeecgP3demoEntity jeecgP3demo,@Param("page")  int page,@Param("rows") int rows);
	
	@Sql("DELETE from jeecg_p3demo WHERE ID = :jeecgP3demo.id")
	public void delete(@Param("jeecgP3demo") JeecgP3demoEntity jeecgP3demo);

	@ResultType(JeecgP3demoEntity.class)
	MiniDaoPage<JeecgP3demoEntity> getAllByOrder(@Param("jeecgP3demo")JeecgP3demoEntity query,@Param("page") int page,@Param("rows") int rows,@Param("sortName") String sort,@Param("sortOrder") String order);
	
}

