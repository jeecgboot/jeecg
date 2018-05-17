package com.jeecg.demo.service.impl;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.MyClassLoader;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgform.enhance.CgformEnhanceJavaInter;
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
 		//执行删除操作增强业务
		this.doDelBus(entity);
 	}
 	
 	public Serializable save(JeecgDemoEntity entity) throws Exception{
 		Serializable t = super.save(entity);
 		//执行新增操作增强业务
 		this.doAddBus(entity);
 		return t;
 	}
 	
 	public void saveOrUpdate(JeecgDemoEntity entity) throws Exception{
 		super.saveOrUpdate(entity);
 		//执行更新操作增强业务
 		this.doUpdateBus(entity);
 	}
 	
 	/**
	 * 新增操作增强业务
	 * @param t
	 * @return
	 */
	private void doAddBus(JeecgDemoEntity t) throws Exception{
		//-----------------sql增强 start----------------------------
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	}
 	/**
	 * 更新操作增强业务
	 * @param t
	 * @return
	 */
	private void doUpdateBus(JeecgDemoEntity t) throws Exception{
		//-----------------sql增强 start----------------------------
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	}
 	/**
	 * 删除操作增强业务
	 * @param id
	 * @return
	 */
	private void doDelBus(JeecgDemoEntity t) throws Exception{
	    //-----------------sql增强 start----------------------------
	 	//-----------------sql增强 end------------------------------
	 	
	 	//-----------------java增强 start---------------------------
	}
 	
 	private Map<String,Object> populationMap(JeecgDemoEntity t){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", t.getId());
		map.put("name", t.getName());
		map.put("age", t.getAge());
		map.put("birthday", t.getBirthday());
		map.put("content", t.getContent());
		map.put("dep_id", t.getDepId());
		map.put("email", t.getEmail());
		map.put("phone", t.getPhone());
		map.put("salary", t.getSalary());
		map.put("sex", t.getSex());
		map.put("status", t.getStatus());
		map.put("create_date", t.getCreateDate());
		map.put("create_by", t.getCreateBy());
		map.put("create_name", t.getCreateName());
		map.put("update_by", t.getUpdateBy());
		map.put("update_date", t.getUpdateDate());
		map.put("update_name", t.getUpdateName());
		return map;
	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @param t
	 * @return
	 */
 	public String replaceVal(String sql,JeecgDemoEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{name}",String.valueOf(t.getName()));
 		sql  = sql.replace("#{age}",String.valueOf(t.getAge()));
 		sql  = sql.replace("#{birthday}",String.valueOf(t.getBirthday()));
 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
 		sql  = sql.replace("#{dep_id}",String.valueOf(t.getDepId()));
 		sql  = sql.replace("#{email}",String.valueOf(t.getEmail()));
 		sql  = sql.replace("#{phone}",String.valueOf(t.getPhone()));
 		sql  = sql.replace("#{salary}",String.valueOf(t.getSalary()));
 		sql  = sql.replace("#{sex}",String.valueOf(t.getSex()));
 		sql  = sql.replace("#{status}",String.valueOf(t.getStatus()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	/**
	 * 执行JAVA增强
	 */
 	private void executeJavaExtend(String cgJavaType,String cgJavaValue,Map<String,Object> data) throws Exception {
 		if(StringUtil.isNotEmpty(cgJavaValue)){
			Object obj = null;
			try {
				if("class".equals(cgJavaType)){
					//因新增时已经校验了实例化是否可以成功，所以这块就不需要再做一次判断
					obj = MyClassLoader.getClassByScn(cgJavaValue).newInstance();
				}else if("spring".equals(cgJavaType)){
					obj = ApplicationContextUtil.getContext().getBean(cgJavaValue);
				}
				if(obj instanceof CgformEnhanceJavaInter){
					CgformEnhanceJavaInter javaInter = (CgformEnhanceJavaInter) obj;
					javaInter.execute("jeecg_demo",data);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("执行JAVA增强出现异常！");
			} 
		}
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
		      ps.setString(4, DateUtils.date2Str(new SimpleDateFormat("yyyy-MM-dd HH:mm")));
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