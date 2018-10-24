package com.jeecg.demo.service.impl;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeecg.demo.entity.JeecgDemoEntity;
import com.jeecg.demo.service.JeecgDemoServiceI;

@Service("jeecgDemoService")
@Transactional
public class JeecgDemoServiceImpl extends CommonServiceImpl implements JeecgDemoServiceI {
	private static final Logger logger = Logger.getLogger(JeecgDemoServiceImpl.class);
	
	@Autowired
	private JdbcDao jdbcDao;


 	public void delete(JeecgDemoEntity entity) throws Exception{
 		super.delete(entity);
 	}
 	
 	public Serializable save(JeecgDemoEntity entity) throws Exception{
 		Serializable t = super.save(entity);
 		return t;
 	}
 	
 	public void saveOrUpdate(JeecgDemoEntity entity) throws Exception{
 		super.saveOrUpdate(entity);
 	}
 	
 	/**
 	 * JDBC批量添加
 	 */
	@Override
	public void jdbcBatchSave() throws Exception {
		final List<JeecgDemoEntity> jeecgDemoList=new ArrayList<JeecgDemoEntity>();
		for(int i=0;i<1000;i++){
		JeecgDemoEntity jeecgDemo=new JeecgDemoEntity();
		jeecgDemo.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		jeecgDemo.setName("批量测试"+i);
		jeecgDemo.setAge(10);
		jeecgDemoList.add(jeecgDemo);
		}
		String sql="insert into jeecg_demo (id,name,age,create_date) values (?,?,?,?)";
		logger.info("-------批处理sql ----"+ sql);
		jdbcDao.batchUpdate(sql, new BatchPreparedStatementSetter()
		  {
		   public void setValues(PreparedStatement ps,int i)throws SQLException
		   {
		      String id=jeecgDemoList.get(i).getId();
		      String name=jeecgDemoList.get(i).getName();
		      int age=jeecgDemoList.get(i).getAge();
		      ps.setString(1, id);
		      ps.setString(2, name);
		      ps.setInt(3, age);

//		      ps.setString(4, DateUtils.date2Str(new SimpleDateFormat("yyyy-MM-dd HH:mm")));
		      java.sql.Date date  = new java.sql.Date(new Date().getTime());
		      ps.setDate(4, date);

		   }
		   public int getBatchSize()
		   {
		    return jeecgDemoList.size();
		   }
		  });
	}

	/**
	 * 执行存储过程
	 */
	@Override
	public void jdbcProcedure() throws Exception {
		String sql = "call delete_jeecgDemo_createDate('"+DateUtils.getDate("yyyy-MM-dd")+"')";
		logger.info("-------执行存储过程--sql ----"+ sql);
	    jdbcDao.execute(sql);
	}


}