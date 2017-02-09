package org.jeecgframework.web.demo.service.impl.test;

import org.jeecgframework.web.demo.entity.test.JeecgDemo;
import org.jeecgframework.web.demo.service.test.JeecgDemoServiceI;

import java.lang.reflect.Field;
import java.util.List;

import org.hibernate.Query;
import org.jeecgframework.core.common.hibernate.qbc.PagerUtil;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("jeecgDemoService")
@Transactional
public class JeecgDemoServiceImpl extends CommonServiceImpl implements JeecgDemoServiceI {

	/**
	 * 自定义排序查询
	 */
	public void getDemoList(JeecgDemo jeecgDemo,DataGrid dataGrid){
		String searchHql = "select demo from JeecgDemo demo where 1 = 1 ";
		//获取页面参数
		String userName = jeecgDemo.getUserName();
		String sex = jeecgDemo.getSex();
		Integer age = jeecgDemo.getAge();
		//拼接hql
		String sort=dataGrid.getSort();
		SortDirection order=dataGrid.getOrder();
		if(StringUtil.isNotEmpty(userName)){
			if(userName.indexOf("*")>-1){
				userName = userName.replace("*", "%");
				searchHql += " and demo.userName like :userName ";
			}else{
				searchHql += " and demo.userName = :userName ";
			}
		}
		if(StringUtil.isNotEmpty(sex)){
			searchHql += " and demo.sex = :sex ";
		}
		if(StringUtil.isNotEmpty(age)){
			searchHql += " and demo.age = :age ";
		}
		if(sort.equals("age")&&(order!=null)){
			searchHql+=" order by demo.age desc ";
		}
		Query query = getSession().createQuery(searchHql);
		if(StringUtil.isNotEmpty(userName)){
			query.setString("userName", userName);
		}
		if(StringUtil.isNotEmpty(sex)){
			query.setString("sex", sex);
		}
		if(StringUtil.isNotEmpty(age)){
			query.setInteger("age", age);
		}
		//封装结果
		int total = 0;
		List<JeecgDemo> demoList = query.list();
		total = demoList.size();
		dataGrid.setTotal(total);
		dataGrid.setResults(demoList);
	}

}
