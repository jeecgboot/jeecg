package org.jeecgframework.web.system.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jeecgframework.web.cgform.engine.FreemarkerHelper;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJsEntity;
import org.jeecgframework.web.demo.entity.test.CKEditorEntity;
import org.jeecgframework.web.demo.entity.test.CourseEntity;
import org.jeecgframework.web.demo.entity.test.JeecgDemoCkfinderEntity;
import org.jeecgframework.web.demo.entity.test.JeecgJdbcEntity;
import org.jeecgframework.web.demo.entity.test.JeecgMatterBom;
import org.jeecgframework.web.demo.entity.test.JeecgNoteEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderCustomEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderMainEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderProductEntity;
import org.jeecgframework.web.demo.entity.test.StudentEntity;
import org.jeecgframework.web.demo.entity.test.TSStudent;
import org.jeecgframework.web.demo.entity.test.TeacherEntity;
import org.jeecgframework.web.system.dao.repair.RepairDao;
import org.jeecgframework.web.system.pojo.base.*;
import org.jeecgframework.web.system.service.RepairService;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Description 修复数据库Service
 * @ClassName: RepairService
 * @author tanghan
 * @date 2013-7-19 下午01:31:00
 */
@Service("repairService")
@Transactional
public class RepairServiceImpl extends CommonServiceImpl implements
		RepairService {
	
	@Autowired
	private RepairDao repairDao;

	/**
	 * @Description 先清空数据库，然后再修复数据库
	 * @author tanghan 2013-7-19
	 */
	
	public void deleteAndRepair() {
		// 由于表中有主外键关系，清空数据库需注意
		commonDao.executeHql("delete TSLog");
		commonDao.executeHql("delete CKEditorEntity");
		commonDao.executeHql("delete CgformEnhanceJsEntity");
		commonDao.executeHql("delete CgFormFieldEntity");
		commonDao.executeHql("delete CgFormHeadEntity");
		commonDao.executeHql("delete TSAttachment");
		commonDao.executeHql("delete TSOperation");
		commonDao.executeHql("delete TSRoleFunction");
		commonDao.executeHql("delete TSRoleUser");
		commonDao.executeHql("delete TSUser");
		commonDao.executeHql("delete TSBaseUser");
		commonDao.executeHql("update TSFunction ts set ts.TSFunction = null");
		commonDao.executeHql("delete TSFunction");
		commonDao.executeHql("update TSDepart t set t.TSPDepart = null");
		commonDao.executeHql("delete TSDepart");
		commonDao.executeHql("delete TSIcon");
		commonDao.executeHql("delete TSRole");
		commonDao.executeHql("delete TSType");
		commonDao.executeHql("delete TSTypegroup");
		commonDao.executeHql("update TSDemo t set t.TSDemo = null");
		commonDao.executeHql("delete TSDemo");
		commonDao.executeHql("delete JeecgDemoCkfinderEntity");
		commonDao.executeHql("delete TSTimeTaskEntity");
		commonDao.executeHql("update TSTerritory t set t.TSTerritory = null");
		commonDao.executeHql("delete TSTerritory");
		commonDao.executeHql("delete StudentEntity");
		commonDao.executeHql("delete CourseEntity");
		commonDao.executeHql("delete TeacherEntity");
		commonDao.executeHql("delete JeecgJdbcEntity ");
		commonDao.executeHql("delete JeecgOrderMainEntity ");
		commonDao.executeHql("delete JeecgOrderProductEntity ");
		commonDao.executeHql("delete JeecgOrderCustomEntity ");
		commonDao.executeHql("delete JeecgNoteEntity ");
		commonDao.executeHql("update JeecgMatterBom mb set mb.parent = null");
		commonDao.executeHql("delete JeecgMatterBom ");
		repair();
	}

	/**
	 * @Description 修复数据库
	 * @author tanghan 2013-7-19
	 */
	
	synchronized public void repair() {
		//repairCkFinder();// 修复智能表单ck_finder数据库
		repaireIcon(); // 修复图标
		repairAttachment(); // 修改附件
		repairDepart();// 修复部门表
		repairMenu();// 修复菜单权限
		repairRole();// 修复角色
		repairUser(); // 修复基本用户
		repairTypeAndGroup();// 修复字典类型
		repairType();// 修复字典值
		repairOperation(); // 修复操作表
		repairRoleFunction();// 修复角色和权限的关系
		repairUserRole();// 修复用户和角色的关系
		repairDemo(); // 修复Demo表，(页面表单验证功能);
		repairLog();// 修复日志表
		repairCkEditor(); // 修复此表，初始化HTML在线编辑功能
		repairCgFormHead();// 修复智能表单header表
		repairCgFormField(); // 修复在线表单字段
		repairTask();//修复任务管理
		repairExcel();//修复Excel导出导入demo
		repairDao.batchRepairTerritory();//修复地域管理
		repairJdbcEntity();//修复表单例子无tag
		repairJeecgNoteEntity();//表单模型
		repairOrder();//修复订单一对多
		repairMatterBom();//修复物料Bom
		repairReportEntity();//修复报表统计demo
	}
	
	/**
	 * 修复物料Bom
	 *@Author fancq
	 *@date   2013-11-14
	 */
	private void repairMatterBom() {
		JeecgMatterBom entity = new JeecgMatterBom();
		entity.setCode("001");
		entity.setName("电脑");
		entity.setUnit("台");
		entity.setWeight("100");
		entity.setPrice(new BigDecimal(5000));
		entity.setStock(10);
		entity.setAddress("广东深圳");
		entity.setProductionDate(new Date());
		entity.setQuantity(5);
		commonDao.save(entity);
		
		JeecgMatterBom entity2 = new JeecgMatterBom();
		entity2.setCode("001001");
		entity2.setName("主板");
		entity2.setUnit("个");
		entity2.setWeight("60");
		entity2.setPrice(new BigDecimal(800));
		entity2.setStock(18);
		entity2.setAddress("上海");
		entity2.setProductionDate(new Date());
		entity2.setQuantity(6);
		entity2.setParent(entity);
		commonDao.save(entity2);
	}

	/**
	 * 修复订单一对多
	 *@Author JueYue
	 *@date   2013-11-12
	 */
	private void repairOrder() {
		JeecgOrderMainEntity main = new JeecgOrderMainEntity();
		main.setGoAllPrice(new BigDecimal(1111111));
		main.setGoContactName("alex");
		main.setGoContent("别放辣椒");
		main.setGoderType("1");
		main.setGoOrderCode("11111AAA");
		main.setGoOrderCount(1);
		main.setGoReturnPrice(new BigDecimal(100));
		main.setUsertype("1");
		commonDao.save(main);
		JeecgOrderProductEntity product = new JeecgOrderProductEntity();
		product.setGoOrderCode(main.getGoOrderCode());
		product.setGopCount(1);
		product.setGopOnePrice(new BigDecimal(100));
		product.setGopProductName("最最美味的地锅鸡");
		product.setGopProductType("1");
		product.setGopSumPrice(new BigDecimal(100));
		commonDao.save(product);
		JeecgOrderCustomEntity coustom = new JeecgOrderCustomEntity();
		coustom.setGoOrderCode(main.getGoOrderCode());
		coustom.setGocCusName("小明");
		coustom.setGocSex("1");
		commonDao.save(coustom);
	}

	/**
	 * 修复表单模型
	 *@Author JueYue
	 *@date   2013-11-12
	 */
	private void repairJeecgNoteEntity() {
		JeecgNoteEntity entity = new JeecgNoteEntity();
		entity.setAge(10);
		entity.setBirthday(new Date());
		entity.setCreatedt(new Date());
		entity.setName("小红");
		entity.setSalary(new BigDecimal(1000));
		commonDao.save(entity);
	}

	/**
	 * 修复表单例子无tag
	 * @throws ParseException 
	 *@Author JueYue
	 *@date   2013-11-12
	 */
	private void repairJdbcEntity(){
		JeecgJdbcEntity entity = new JeecgJdbcEntity();
		entity.setAge(12);
		entity.setBirthday(DateUtils.str2Date("2014-02-14",new SimpleDateFormat("yyyy-MM-dd")));
		entity.setDepId("123");
		entity.setEmail("demo@jeecg.com");
		entity.setMobilePhone("13111111111");
		entity.setOfficePhone("66666666");
		entity.setSalary(new BigDecimal(111111));
		entity.setSex("1");
		entity.setUserName("小明");
		commonDao.save(entity);
	}

	/**
	 * 修复Excel导出导入数据
	 *@Author JueYue
	 *@date 2013-11-10
	 */
	private void repairExcel() {
		CourseEntity course = new CourseEntity();
		course.setName("海贼王");
		TeacherEntity teacher = new TeacherEntity();
		teacher.setName("路飞");
		teacher.setPic("upload/Teacher/pic3345280233.PNG");
		course.setTeacher(teacher);
		List<StudentEntity> list = new ArrayList<StudentEntity>();
		StudentEntity student = new StudentEntity();
		student.setName("卓洛");
		student.setSex("0");
		list.add(student);
		student = new StudentEntity();
		student.setName("山治 ");
		student.setSex("0");
		list.add(student);
		course.setStudents(list);
		commonDao.save(course.getTeacher());
		commonDao.save(course);
		commonDao.save(course);
		for (StudentEntity s :course.getStudents()){
			s.setCourse(course);
		}
		commonDao.batchSave(course.getStudents());
	}

	/**
	 * 修复任务管理
	 * @author JueYue
	 * @serialData 2013年11月5日
	 */
	private void repairTask() {
		TSTimeTaskEntity task = new TSTimeTaskEntity();
		task.setTaskId("taskDemoServiceTaskCronTrigger");
		task.setTaskDescribe("测试Demo");
		task.setCronExpression("0 0/1 * * * ?");
		task.setIsEffect("0");
		task.setIsStart("0");
		commonDao.saveOrUpdate(task);
	}

	/**
	 * @Description 修复智能表单ck_finder数据库
	 * @author Alexander 2013-10-13
	 */
	private void repairCkFinder() {
		JeecgDemoCkfinderEntity ckfinder = new JeecgDemoCkfinderEntity();
		ckfinder.setImage("/jeecg/userfiles/images/%E6%9C%AA%E5%91%BD%E5%90%8D.jpg");
		ckfinder.setAttachment("/jeecg/userfiles/files/JEECG%20UI%E6%A0%87%E7%AD%BE%E5%BA%93%E5%B8%AE%E5%8A%A9%E6%96%87%E6%A1%A3v3_2.pdf");
		String str = "<img alt=\"\" src=\"/jeecg/userfiles/images/%E6%9C%AA%E5%91%BD%E5%90%8D.jpg\" style=\"height:434px; width:439px\" /><br />\r\n可爱的小猫<br />\r\n<br />\r\n<strong><span style=\"font-size:14.0pt\">1</span></strong><strong><span style=\"font-family:宋体; font-size:14.0pt; line-height:150%\">．</span></strong><strong><span style=\"font-size:14.0pt\">CRM</span></strong><strong><span style=\"font-family:宋体; font-size:14.0pt; line-height:150%\">概述</span></strong><br />\r\n<strong><span style=\"font-size:12.0pt\">1</span></strong><strong><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">．</span></strong><strong><span style=\"font-size:12.0pt\">1</span></strong><strong><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">概念</span></strong>\r\n\r\n<p style=\"line-height:150%; text-indent:24.0pt\"><span style=\"color:black; font-family:宋体; font-size:12.0pt; line-height:150%\">CRM</span><span style=\"color:black; font-family:宋体; font-size:12.0pt; line-height:150%\">是一项商业战略，它是按照客户细分原则有效的组织企业资源，来培养以客户为中心的</span><span style=\"color:red; font-family:宋体; font-size:12.0pt; line-height:150%\">经营行为以及实施以</span><span style=\"color:black; font-family:宋体; font-size:12.0pt; line-height:150%\">客户为中心的业务流程，以此为手段来提高企业的获利能力、收入及客户满意度。</span></p>\r\n\r\n<p style=\"line-height:150%; text-indent:24.0pt\"><span style=\"color:black; font-family:宋体; font-size:12.0pt; line-height:150%\">U8CRM</span><span style=\"color:black; font-family:宋体; font-size:12.0pt; line-height:150%\">同样是基于客户为中心应用原则，</span><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">把客户作为企业最重要的资源，围绕客户的生命周期，从客户接触开始，到客户交易、客户服务的全程进行跟踪管理、过程监控，并通过对客户多角度分析，识别客户满足度和价值度，从而不断改进产品和服务，使客户价值最大化、终身化。</span></p>\r\n<strong><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">1</span></strong><strong><span style=\"font-family:宋体; font-size:12.0pt; line-height:	150%\">．2应用价值</span></strong>\r\n\r\n<p style=\"line-height:150%; text-indent:24.0pt\"><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">统一企业的客户资源：系统帮助企业建立完整的客户、联系人资源档案，不同的组织、部门可以根据资源权限访问相关的客户资料。</span></p>\r\n<span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">深入挖掘价值客户：系统帮助用户建立价值评估体系，基于客户交易数据，多角度、全方位评估客户价值。通过客户价值的评估，挖掘价值客户，进而更好的服务价值客户。例如，帮助企业发现带来80%销售收入的20%价值客户。</span>\r\n\r\n<p style=\"line-height:150%; text-indent:24.0pt\"><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">跟踪和监控销售机会：系统侧重售前业务管理，从客户向企业表达意向开始，围绕销售线索不同阶段，提供对商机客户购买意向、接触过程、竞争对手、阶段评估等信息的追踪记录，并通过销售漏斗有效监督整个销售过程是否正常。</span></p>\r\n\r\n<p style=\"line-height:150%; text-indent:24.0pt\"><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">科学预测未来销售情况：提供了一种预测模式，系统可以按照销售商机的预期销售收入和预计成交时间，科学的预测未来可能实现的销售收入。</span></p>\r\n\r\n<p style=\"line-height:150%; text-indent:24.0pt\"><span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">提供科学理性的分析决策：系统提供基于客户完整业务（客户关系管理、供应链和财务）的决策分析，并通过报表的形式展现给用户，辅助企业做出数字化决策。</span></p>\r\n<span style=\"font-family:宋体; font-size:12.0pt; line-height:150%\">资源共享：CRM系统与企业销售系统、财务系统等集成应用，实现企业信息化的整合和共享。</span><br />\r\n&nbsp;";
		ckfinder.setRemark(str);
		commonDao.saveOrUpdate(ckfinder);
	}

	/**
	 * @Description 修复智能表单Head数据库
	 * @author tanghan 2013-7-28
	 */
	private void repairCgFormHead() {
		CgFormHeadEntity order_main = new CgFormHeadEntity();
		order_main.setTableName("jform_order_main");
		order_main.setIsTree("N");
		order_main.setIsPagination("Y");
		order_main.setIsCheckbox("N");
		order_main.setQuerymode("group");
		order_main.setIsDbSynch("N");
		order_main.setContent("订单主信息");
		order_main.setCreateBy("admin");
		order_main.setCreateDate(new Date());
		order_main.setJformPkType("UUID");
		// order_main.setJsPlugIn("0");
		// order_main.setSqlPlugIn("0");
		order_main.setCreateName("管理员");
		order_main.setJformVersion("57");
		order_main.setJformType(2);
		order_main.setRelationType(0);
		order_main.setSubTableStr("jform_order_ticket,jform_order_customer");
		commonDao.saveOrUpdate(order_main);

		CgFormHeadEntity leave = new CgFormHeadEntity();
		leave.setTableName("jform_leave");
		leave.setIsTree("N");
		leave.setIsPagination("Y");
		leave.setIsCheckbox("N");
		leave.setJformPkType("UUID");
		leave.setQuerymode("group");
		leave.setIsDbSynch("N");
		leave.setContent("请假单");
		leave.setCreateBy("admin");
		leave.setCreateDate(new Date());
		// leave.setJsPlugIn("0");
		// leave.setSqlPlugIn("0");
		leave.setCreateName("管理员");
		leave.setJformVersion("51");
		leave.setJformType(1);
		leave.setRelationType(0);
		commonDao.saveOrUpdate(leave);
//		CgFormHeadEntity cgreport_head = new CgFormHeadEntity();
//		cgreport_head.setTableName("jform_cgreport_head");
//		cgreport_head.setIsTree("N");
//		cgreport_head.setIsPagination("Y");
//		cgreport_head.setIsCheckbox("N");
//		cgreport_head.setQuerymode("single");
//		cgreport_head.setIsDbSynch("N");
//		cgreport_head.setContent("动态报表配置抬头");
//		cgreport_head.setCreateBy("admin");
//		cgreport_head.setCreateDate(new Date());
		/*
		 * cgreport_head.setJsPlugIn("$(function(){"+"\r\n" +
		 * "$(\"body\").append(\"<link href=\\\"plug-in/lhgDialog/skins/default.css\\\" rel=\\\"stylesheet\\\" id=\\\"lhgdialoglink\\\">\");"
		 * +"\r\n" +
		 * "var $btn = $(\"<div class=\\\"ui_buttons\\\"  style=\\\"display:inline-block;\\\"><input style=\\\"position: relative;top: -8px;\\\" class=\\\"ui_state_highlight\\\" type=\\\"button\\\" value=\\\"sql解析\\\"        id=\\\"sqlAnalyze\\\" /></div>\");"
		 * +"\r\n" +"$(\"#cgr_sql\").after($btn);"+"\r\n"
		 * +"$btn.click(function(){"+"\r\n" +" $.ajax({"+"\r\n"
		 * +"     url:\"cgReportController.do?getFields\","+"\r\n"
		 * +"    data:{sql:$(\"#cgr_sql\").val()},"+"\r\n"
		 * +"   type:\"Post\","+"\r\n" +"    dataType:\"json\","+"\r\n"
		 * +"    success:function(data){"+"\r\n"
		 * +"      if(data.status==\"success\"){"+"\r\n"
		 * +"         $(\"#add_jform_cgreport_item_table\").empty();"+"\r\n"
		 * +"      $.each(data.datas,function(index,e){"+"\r\n" +
		 * "        var $tr = $(\"#add_jform_cgreport_item_table_template tr\").clone();"
		 * +"\r\n" +"      $tr.find(\"td:eq(1) :text\").val(e);"+"\r\n"
		 * +"       $tr.find(\"td:eq(2) :text\").val(index);"+"\r\n"
		 * +"       $tr.find(\"td:eq(3) :text\").val(e);"+"\r\n"
		 * +"       $(\"#add_jform_cgreport_item_table\").append($tr);"+"\r\n"
		 * +"      }); "+"\r\n"
		 * +"    resetTrNum(\"add_jform_cgreport_item_table\");"+"\r\n"
		 * +"    }"+"\r\n" +"  }"+"\r\n" +"  });"+"\r\n" +" });"+"\r\n" +"});");
		 * cgreport_head.setSqlPlugIn("0");
		 */
//		cgreport_head.setCreateName("管理员");
//		cgreport_head.setJformVersion("87");
//		cgreport_head.setJformType(2);
//		cgreport_head.setRelationType(0);
//		cgreport_head.setSubTableStr("jform_cgreport_item");
//		/* cgreport_head.setSqlPlugIn("select * from t_s_user"); */
//
//		commonDao.saveOrUpdate(cgreport_head);
//
//		CgFormHeadEntity cgreport_item = new CgFormHeadEntity();
//		cgreport_item.setTableName("jform_cgreport_item");
//		cgreport_item.setIsTree("N");
//		cgreport_item.setIsPagination("Y");
//		cgreport_item.setIsCheckbox("N");
//		cgreport_item.setQuerymode("single");
//		cgreport_item.setIsDbSynch("N");
//		cgreport_item.setContent("动态报表配置明细");
//		cgreport_item.setCreateBy("admin");
//		cgreport_item.setCreateDate(new Date());
//		/*
//		 * cgreport_item.setJsPlugIn("0"); cgreport_item.setSqlPlugIn("0");
//		 */
//		cgreport_item.setCreateName("管理员");
//		cgreport_item.setJformVersion("12");
//		cgreport_item.setJformType(3);
//		cgreport_item.setRelationType(0);
//		commonDao.saveOrUpdate(cgreport_item);

		CgFormHeadEntity customer = new CgFormHeadEntity();
		customer.setTableName("jform_order_customer");
		customer.setIsTree("N");
		customer.setIsPagination("Y");
		customer.setIsCheckbox("Y");
		customer.setQuerymode("single");
		customer.setIsDbSynch("N");
		customer.setContent("订单客户信息");
		customer.setCreateBy("admin");
		customer.setJformPkType("UUID");
		customer.setCreateDate(new Date());
		/*
		 * customer.setJsPlugIn("alert(' hello world ');");
		 * customer.setSqlPlugIn("0");
		 */
		customer.setCreateName("管理员");
		customer.setJformVersion("16");
		customer.setJformType(3);
		customer.setRelationType(0);
		commonDao.saveOrUpdate(customer);

		CgFormHeadEntity ticket = new CgFormHeadEntity();
		ticket.setTableName("jform_order_ticket");
		ticket.setIsTree("N");
		ticket.setIsPagination("Y");
		ticket.setIsCheckbox("N");
		ticket.setQuerymode("single");
		ticket.setIsDbSynch("N");
		ticket.setJformPkType("UUID");
		ticket.setContent("订单机票信息");
		ticket.setCreateBy("admin");
		ticket.setCreateDate(new Date());
		/*
		 * ticket.setJsPlugIn(
		 * "$(\"input/[name=\'name\']\").change( function() { \r\n 这里可以写些验证代码 \r\n  var name = $(\"#name\").val();  \r\nalert(name);});"
		 * ); ticket.setSqlPlugIn("0");
		 */
		ticket.setCreateName("管理员");
		ticket.setJformVersion("20");
		ticket.setJformType(3);
		ticket.setRelationType(0);
		commonDao.saveOrUpdate(ticket);

		CgFormHeadEntity price1 = new CgFormHeadEntity();
		price1.setTableName("jform_price1");
		price1.setIsTree("N");
		price1.setIsPagination("Y");
		price1.setIsCheckbox("N");
		price1.setQuerymode("group");
		price1.setIsDbSynch("N");
		price1.setJformPkType("UUID");
		price1.setContent("价格认证机构统计表");
		price1.setCreateBy("admin");
		price1.setCreateDate(new Date());
		/*
		 * price1.setJsPlugIn("0"); price1.setSqlPlugIn("0");
		 */
		price1.setCreateName("管理员");
		price1.setJformVersion("3");
		price1.setJformType(1);
		price1.setRelationType(0);
		commonDao.saveOrUpdate(price1);

	}

	/**
	 * @Description 同步智能表单字段表
	 * @author tanghan 2013-7-28
	 */
	private void repairCgFormField() {
		// 表单[订单主信息] - 字段清单
		CgFormHeadEntity jform_order_main = commonDao.findByProperty(
				CgFormHeadEntity.class, "tableName", "jform_order_main").get(0);
		CgFormFieldEntity jform_order_main_id = new CgFormFieldEntity();
		jform_order_main_id.setFieldName("id");
		jform_order_main_id.setTable(jform_order_main);
		jform_order_main_id.setFieldLength(0);
		jform_order_main_id.setIsKey("Y");
		jform_order_main_id.setIsNull("N");
		jform_order_main_id.setIsQuery("N");
		jform_order_main_id.setIsShow("N");
		jform_order_main_id.setIsShowList("N");
		jform_order_main_id.setShowType("text");
		jform_order_main_id.setLength(36);
		jform_order_main_id.setType("string");
		jform_order_main_id.setOrderNum(0);
		jform_order_main_id.setPointLength(0);
		jform_order_main_id.setQueryMode("single");
		jform_order_main_id.setContent("主键");
		jform_order_main_id.setCreateBy("admin");
		jform_order_main_id.setCreateDate(new Date());
		jform_order_main_id.setCreateName("管理员");
		jform_order_main_id.setDictField("");
		jform_order_main_id.setDictTable("");
		jform_order_main_id.setMainTable("");
		jform_order_main_id.setMainField("");
		commonDao.saveOrUpdate(jform_order_main_id);

		CgFormFieldEntity jform_order_main_order_code = new CgFormFieldEntity();
		jform_order_main_order_code.setFieldName("order_code");
		jform_order_main_order_code.setTable(jform_order_main);
		jform_order_main_order_code.setFieldLength(0);
		jform_order_main_order_code.setIsKey("N");
		jform_order_main_order_code.setIsNull("Y");
		jform_order_main_order_code.setIsQuery("Y");
		jform_order_main_order_code.setIsShow("Y");
		jform_order_main_order_code.setIsShowList("Y");
		jform_order_main_order_code.setShowType("text");
		jform_order_main_order_code.setLength(50);
		jform_order_main_order_code.setType("string");
		jform_order_main_order_code.setOrderNum(1);
		jform_order_main_order_code.setPointLength(0);
		jform_order_main_order_code.setQueryMode("single");
		jform_order_main_order_code.setContent("订单号");
		jform_order_main_order_code.setCreateBy("admin");
		jform_order_main_order_code.setCreateDate(new Date());
		jform_order_main_order_code.setCreateName("管理员");
		jform_order_main_order_code.setDictField("");
		jform_order_main_order_code.setDictTable("");
		jform_order_main_order_code.setMainTable("");
		jform_order_main_order_code.setMainField("");
		commonDao.saveOrUpdate(jform_order_main_order_code);

		CgFormFieldEntity jform_order_main_order_date = new CgFormFieldEntity();
		jform_order_main_order_date.setFieldName("order_date");
		jform_order_main_order_date.setTable(jform_order_main);
		jform_order_main_order_date.setFieldLength(0);
		jform_order_main_order_date.setIsKey("N");
		jform_order_main_order_date.setIsNull("Y");
		jform_order_main_order_date.setIsQuery("Y");
		jform_order_main_order_date.setIsShow("Y");
		jform_order_main_order_date.setIsShowList("Y");
		jform_order_main_order_date.setShowType("date");
		jform_order_main_order_date.setLength(20);
		jform_order_main_order_date.setType("Date");
		jform_order_main_order_date.setOrderNum(2);
		jform_order_main_order_date.setPointLength(0);
		jform_order_main_order_date.setQueryMode("single");
		jform_order_main_order_date.setContent("订单日期");
		jform_order_main_order_date.setCreateBy("admin");
		jform_order_main_order_date.setCreateDate(new Date());
		jform_order_main_order_date.setCreateName("管理员");
		jform_order_main_order_date.setDictField("");
		jform_order_main_order_date.setDictTable("");
		jform_order_main_order_date.setMainTable("");
		jform_order_main_order_date.setMainField("");
		commonDao.saveOrUpdate(jform_order_main_order_date);

		CgFormFieldEntity jform_order_main_order_money = new CgFormFieldEntity();
		jform_order_main_order_money.setFieldName("order_money");
		jform_order_main_order_money.setTable(jform_order_main);
		jform_order_main_order_money.setFieldLength(0);
		jform_order_main_order_money.setIsKey("N");
		jform_order_main_order_money.setIsNull("Y");
		jform_order_main_order_money.setIsQuery("Y");
		jform_order_main_order_money.setIsShow("Y");
		jform_order_main_order_money.setIsShowList("Y");
		jform_order_main_order_money.setShowType("text");
		jform_order_main_order_money.setLength(10);
		jform_order_main_order_money.setType("double");
		jform_order_main_order_money.setOrderNum(3);
		jform_order_main_order_money.setPointLength(3);
		jform_order_main_order_money.setQueryMode("single");
		jform_order_main_order_money.setContent("订单金额");
		jform_order_main_order_money.setCreateBy("admin");
		jform_order_main_order_money.setCreateDate(new Date());
		jform_order_main_order_money.setCreateName("管理员");
		jform_order_main_order_money.setDictField("");
		jform_order_main_order_money.setDictTable("");
		jform_order_main_order_money.setMainTable("");
		jform_order_main_order_money.setMainField("");
		commonDao.saveOrUpdate(jform_order_main_order_money);

		CgFormFieldEntity jform_order_main_content = new CgFormFieldEntity();
		jform_order_main_content.setFieldName("content");
		jform_order_main_content.setTable(jform_order_main);
		jform_order_main_content.setFieldLength(0);
		jform_order_main_content.setIsKey("N");
		jform_order_main_content.setIsNull("Y");
		jform_order_main_content.setIsQuery("Y");
		jform_order_main_content.setIsShow("Y");
		jform_order_main_content.setIsShowList("Y");
		jform_order_main_content.setShowType("text");
		jform_order_main_content.setLength(255);
		jform_order_main_content.setType("string");
		jform_order_main_content.setOrderNum(4);
		jform_order_main_content.setPointLength(0);
		jform_order_main_content.setQueryMode("single");
		jform_order_main_content.setContent("备注");
		jform_order_main_content.setCreateBy("admin");
		jform_order_main_content.setCreateDate(new Date());
		jform_order_main_content.setCreateName("管理员");
		jform_order_main_content.setDictField("");
		jform_order_main_content.setDictTable("");
		jform_order_main_content.setMainTable("");
		jform_order_main_content.setMainField("");
		commonDao.saveOrUpdate(jform_order_main_content);

		// 表单[请假单] - 字段清单
		CgFormHeadEntity jform_leave = commonDao.findByProperty(
				CgFormHeadEntity.class, "tableName", "jform_leave").get(0);
		CgFormFieldEntity jform_leave_id = new CgFormFieldEntity();
		jform_leave_id.setFieldName("id");
		jform_leave_id.setTable(jform_leave);
		jform_leave_id.setFieldLength(0);
		jform_leave_id.setIsKey("Y");
		jform_leave_id.setIsNull("N");
		jform_leave_id.setIsQuery("N");
		jform_leave_id.setIsShow("N");
		jform_leave_id.setIsShowList("N");
		jform_leave_id.setShowType("text");
		jform_leave_id.setLength(36);
		jform_leave_id.setType("string");
		jform_leave_id.setOrderNum(0);
		jform_leave_id.setPointLength(0);
		jform_leave_id.setQueryMode("single");
		jform_leave_id.setContent("主键");
		jform_leave_id.setCreateBy("admin");
		jform_leave_id.setCreateDate(new Date());
		jform_leave_id.setCreateName("管理员");
		jform_leave_id.setDictField("");
		jform_leave_id.setDictTable("");
		jform_leave_id.setMainTable("");
		jform_leave_id.setMainField("");
		commonDao.saveOrUpdate(jform_leave_id);

		CgFormFieldEntity jform_leave_title = new CgFormFieldEntity();
		jform_leave_title.setFieldName("title");
		jform_leave_title.setTable(jform_leave);
		jform_leave_title.setFieldLength(0);
		jform_leave_title.setIsKey("N");
		jform_leave_title.setIsNull("N");
		jform_leave_title.setIsQuery("N");
		jform_leave_title.setIsShow("Y");
		jform_leave_title.setIsShowList("Y");
		jform_leave_title.setShowType("text");
		jform_leave_title.setLength(50);
		jform_leave_title.setType("string");
		jform_leave_title.setOrderNum(1);
		jform_leave_title.setPointLength(0);
		jform_leave_title.setQueryMode("single");
		jform_leave_title.setContent("请假标题");
		jform_leave_title.setCreateBy("admin");
		jform_leave_title.setCreateDate(new Date());
		jform_leave_title.setCreateName("管理员");
		jform_leave_title.setDictField("");
		jform_leave_title.setDictTable("");
		jform_leave_title.setMainTable("");
		jform_leave_title.setMainField("");
		commonDao.saveOrUpdate(jform_leave_title);

		CgFormFieldEntity jform_leave_people = new CgFormFieldEntity();
		jform_leave_people.setFieldName("people");
		jform_leave_people.setTable(jform_leave);
		jform_leave_people.setFieldLength(0);
		jform_leave_people.setIsKey("N");
		jform_leave_people.setIsNull("N");
		jform_leave_people.setIsQuery("Y");
		jform_leave_people.setIsShow("Y");
		jform_leave_people.setIsShowList("Y");
		jform_leave_people.setShowType("text");
		jform_leave_people.setLength(20);
		jform_leave_people.setType("string");
		jform_leave_people.setOrderNum(2);
		jform_leave_people.setPointLength(0);
		jform_leave_people.setQueryMode("single");
		jform_leave_people.setContent("请假人");
		jform_leave_people.setCreateBy("admin");
		jform_leave_people.setCreateDate(new Date());
		jform_leave_people.setCreateName("管理员");
		jform_leave_people.setDictField("");
		jform_leave_people.setDictTable("");
		jform_leave_people.setMainTable("");
		jform_leave_people.setMainField("");
		commonDao.saveOrUpdate(jform_leave_people);

		CgFormFieldEntity jform_leave_sex = new CgFormFieldEntity();
		jform_leave_sex.setFieldName("sex");
		jform_leave_sex.setTable(jform_leave);
		jform_leave_sex.setFieldLength(0);
		jform_leave_sex.setIsKey("N");
		jform_leave_sex.setIsNull("N");
		jform_leave_sex.setIsQuery("Y");
		jform_leave_sex.setIsShow("Y");
		jform_leave_sex.setIsShowList("Y");
		jform_leave_sex.setShowType("list");
		jform_leave_sex.setLength(10);
		jform_leave_sex.setType("string");
		jform_leave_sex.setOrderNum(3);
		jform_leave_sex.setPointLength(0);
		jform_leave_sex.setQueryMode("single");
		jform_leave_sex.setContent("性别");
		jform_leave_sex.setCreateBy("admin");
		jform_leave_sex.setCreateDate(new Date());
		jform_leave_sex.setCreateName("管理员");
		jform_leave_sex.setDictField("sex");
		jform_leave_sex.setDictTable("");
		jform_leave_sex.setMainTable("");
		jform_leave_sex.setMainField("");
		commonDao.saveOrUpdate(jform_leave_sex);

		CgFormFieldEntity jform_leave_begindate = new CgFormFieldEntity();
		jform_leave_begindate.setFieldName("begindate");
		jform_leave_begindate.setTable(jform_leave);
		jform_leave_begindate.setFieldLength(0);
		jform_leave_begindate.setIsKey("N");
		jform_leave_begindate.setIsNull("N");
		jform_leave_begindate.setIsQuery("N");
		jform_leave_begindate.setIsShow("Y");
		jform_leave_begindate.setIsShowList("Y");
		jform_leave_begindate.setShowType("date");
		jform_leave_begindate.setLength(0);
		jform_leave_begindate.setType("Date");
		jform_leave_begindate.setOrderNum(4);
		jform_leave_begindate.setPointLength(0);
		jform_leave_begindate.setQueryMode("group");
		jform_leave_begindate.setContent("请假开始时间");
		jform_leave_begindate.setCreateBy("admin");
		jform_leave_begindate.setCreateDate(new Date());
		jform_leave_begindate.setCreateName("管理员");
		jform_leave_begindate.setDictField("");
		jform_leave_begindate.setDictTable("");
		jform_leave_begindate.setMainTable("");
		jform_leave_begindate.setMainField("");
		commonDao.saveOrUpdate(jform_leave_begindate);

		CgFormFieldEntity jform_leave_enddate = new CgFormFieldEntity();
		jform_leave_enddate.setFieldName("enddate");
		jform_leave_enddate.setTable(jform_leave);
		jform_leave_enddate.setFieldLength(0);
		jform_leave_enddate.setIsKey("N");
		jform_leave_enddate.setIsNull("N");
		jform_leave_enddate.setIsQuery("N");
		jform_leave_enddate.setIsShow("Y");
		jform_leave_enddate.setIsShowList("Y");
		jform_leave_enddate.setShowType("datetime");
		jform_leave_enddate.setLength(0);
		jform_leave_enddate.setType("Date");
		jform_leave_enddate.setOrderNum(5);
		jform_leave_enddate.setPointLength(0);
		jform_leave_enddate.setQueryMode("group");
		jform_leave_enddate.setContent("请假结束时间");
		jform_leave_enddate.setCreateBy("admin");
		jform_leave_enddate.setCreateDate(new Date());
		jform_leave_enddate.setCreateName("管理员");
		jform_leave_enddate.setDictField("");
		jform_leave_enddate.setDictTable("");
		jform_leave_enddate.setMainTable("");
		jform_leave_enddate.setMainField("");
		commonDao.saveOrUpdate(jform_leave_enddate);

		CgFormFieldEntity jform_leave_hol_dept = new CgFormFieldEntity();
		jform_leave_hol_dept.setFieldName("hol_dept");
		jform_leave_hol_dept.setTable(jform_leave);
		jform_leave_hol_dept.setFieldLength(0);
		jform_leave_hol_dept.setIsKey("N");
		jform_leave_hol_dept.setIsNull("N");
		jform_leave_hol_dept.setIsQuery("N");
		jform_leave_hol_dept.setIsShow("Y");
		jform_leave_hol_dept.setIsShowList("Y");
		jform_leave_hol_dept.setShowType("list");
		jform_leave_hol_dept.setLength(32);
		jform_leave_hol_dept.setType("string");
		jform_leave_hol_dept.setOrderNum(7);
		jform_leave_hol_dept.setPointLength(0);
		jform_leave_hol_dept.setQueryMode("single");
		jform_leave_hol_dept.setContent("所属部门");
		jform_leave_hol_dept.setCreateBy("admin");
		jform_leave_hol_dept.setCreateDate(new Date());
		jform_leave_hol_dept.setCreateName("管理员");
		jform_leave_hol_dept.setDictField("id");
		jform_leave_hol_dept.setDictTable("t_s_depart");
		jform_leave_hol_dept.setDictText("departname");
		jform_leave_hol_dept.setMainTable("");
		jform_leave_hol_dept.setMainField("");
		commonDao.saveOrUpdate(jform_leave_hol_dept);

		CgFormFieldEntity jform_leave_hol_reson = new CgFormFieldEntity();
		jform_leave_hol_reson.setFieldName("hol_reson");
		jform_leave_hol_reson.setTable(jform_leave);
		jform_leave_hol_reson.setFieldLength(0);
		jform_leave_hol_reson.setIsKey("N");
		jform_leave_hol_reson.setIsNull("N");
		jform_leave_hol_reson.setIsQuery("N");
		jform_leave_hol_reson.setIsShow("Y");
		jform_leave_hol_reson.setIsShowList("Y");
		jform_leave_hol_reson.setShowType("text");
		jform_leave_hol_reson.setLength(255);
		jform_leave_hol_reson.setType("string");
		jform_leave_hol_reson.setOrderNum(8);
		jform_leave_hol_reson.setPointLength(0);
		jform_leave_hol_reson.setQueryMode("single");
		jform_leave_hol_reson.setContent("请假原因");
		jform_leave_hol_reson.setCreateBy("admin");
		jform_leave_hol_reson.setCreateDate(new Date());
		jform_leave_hol_reson.setCreateName("管理员");
		jform_leave_hol_reson.setDictField("");
		jform_leave_hol_reson.setDictTable("");
		jform_leave_hol_reson.setMainTable("");
		jform_leave_hol_reson.setMainField("");
		commonDao.saveOrUpdate(jform_leave_hol_reson);

		CgFormFieldEntity jform_leave_dep_leader = new CgFormFieldEntity();
		jform_leave_dep_leader.setFieldName("dep_leader");
		jform_leave_dep_leader.setTable(jform_leave);
		jform_leave_dep_leader.setFieldLength(0);
		jform_leave_dep_leader.setIsKey("N");
		jform_leave_dep_leader.setIsNull("N");
		jform_leave_dep_leader.setIsQuery("N");
		jform_leave_dep_leader.setIsShow("Y");
		jform_leave_dep_leader.setIsShowList("Y");
		jform_leave_dep_leader.setShowType("text");
		jform_leave_dep_leader.setLength(20);
		jform_leave_dep_leader.setType("string");
		jform_leave_dep_leader.setOrderNum(9);
		jform_leave_dep_leader.setPointLength(0);
		jform_leave_dep_leader.setQueryMode("single");
		jform_leave_dep_leader.setContent("部门审批人");
		jform_leave_dep_leader.setCreateBy("admin");
		jform_leave_dep_leader.setCreateDate(new Date());
		jform_leave_dep_leader.setCreateName("管理员");
		jform_leave_dep_leader.setDictField("");
		jform_leave_dep_leader.setDictTable("");
		jform_leave_dep_leader.setMainTable("");
		jform_leave_dep_leader.setMainField("");
		commonDao.saveOrUpdate(jform_leave_dep_leader);

		CgFormFieldEntity jform_leave_content = new CgFormFieldEntity();
		jform_leave_content.setFieldName("content");
		jform_leave_content.setTable(jform_leave);
		jform_leave_content.setFieldLength(0);
		jform_leave_content.setIsKey("N");
		jform_leave_content.setIsNull("N");
		jform_leave_content.setIsQuery("N");
		jform_leave_content.setIsShow("Y");
		jform_leave_content.setIsShowList("Y");
		jform_leave_content.setShowType("text");
		jform_leave_content.setLength(255);
		jform_leave_content.setType("string");
		jform_leave_content.setOrderNum(10);
		jform_leave_content.setPointLength(0);
		jform_leave_content.setQueryMode("single");
		jform_leave_content.setContent("部门审批意见");
		jform_leave_content.setCreateBy("admin");
		jform_leave_content.setCreateDate(new Date());
		jform_leave_content.setCreateName("管理员");
		jform_leave_content.setDictField("");
		jform_leave_content.setDictTable("");
		jform_leave_content.setMainTable("");
		jform_leave_content.setMainField("");
		commonDao.saveOrUpdate(jform_leave_content);

		CgFormFieldEntity jform_leave_day_num = new CgFormFieldEntity();
		jform_leave_day_num.setFieldName("day_num");
		jform_leave_day_num.setTable(jform_leave);
		jform_leave_day_num.setFieldLength(120);
		jform_leave_day_num.setIsKey("N");
		jform_leave_day_num.setIsNull("Y");
		jform_leave_day_num.setIsQuery("N");
		jform_leave_day_num.setIsShow("Y");
		jform_leave_day_num.setIsShowList("Y");
		jform_leave_day_num.setShowType("text");
		jform_leave_day_num.setLength(10);
		jform_leave_day_num.setType("int");
		jform_leave_day_num.setOrderNum(6);
		jform_leave_day_num.setPointLength(0);
		jform_leave_day_num.setQueryMode("single");
		jform_leave_day_num.setContent("请假天数");
		jform_leave_day_num.setCreateBy("admin");
		jform_leave_day_num.setCreateDate(new Date());
		jform_leave_day_num.setCreateName("管理员");
		jform_leave_day_num.setDictField("");
		jform_leave_day_num.setDictTable("");
		jform_leave_day_num.setMainTable("");
		jform_leave_day_num.setMainField("");
		commonDao.saveOrUpdate(jform_leave_day_num);
		// 表单[动态报表配置抬头] - 字段清单
//		CgFormHeadEntity jform_cgreport_head = commonDao.findByProperty(
//				CgFormHeadEntity.class, "tableName", "jform_cgreport_head")
//				.get(0);
//		CgFormFieldEntity jform_cgreport_head_id = new CgFormFieldEntity();
//		// begin - 动态报表配置的js增强
//		String cgReportFormId = jform_cgreport_head.getId();
//		CgformEnhanceJsEntity cgReportJs = new CgformEnhanceJsEntity();
//		cgReportJs.setCgJsType("form");
//		cgReportJs
//				.setCgJs(new BigInteger(
//						"242866756E6374696F6E28297B0D0A242822626F647922292E617070656E6428223C6C696E6B20687265663D5C22706C75672D696E2F6C68674469616C6F672F736B696E732F64656661756C742E6373735C222072656C3D5C227374796C6573686565745C222069643D5C226C68676469616C6F676C696E6B5C223E22293B0D0A766172202462746E203D202428223C64697620636C6173733D5C2275695F627574746F6E735C2220207374796C653D5C22646973706C61793A696E6C696E652D626C6F636B3B5C223E3C696E707574207374796C653D5C22706F736974696F6E3A2072656C61746976653B746F703A202D3870783B5C2220636C6173733D5C2275695F73746174655F686967686C696768745C2220747970653D5C22627574746F6E5C222076616C75653D5C2273716CBDE2CEF65C22202020202020202069643D5C2273716C416E616C797A655C22202F3E3C2F6469763E22293B0D0A242822236367725F73716C22292E6166746572282462746E293B0D0A2462746E2E636C69636B2866756E6374696F6E28297B0D0A20242E616A6178287B0D0A202020202075726C3A2263675265706F7274436F6E74726F6C6C65722E646F3F6765744669656C6473222C0D0A20202020646174613A7B73716C3A242822236367725F73716C22292E76616C28297D2C0D0A09747970653A22506F7374222C0D0A2020202064617461547970653A226A736F6E222C0D0A20202020737563636573733A66756E6374696F6E2864617461297B0D0A202020202020696628646174612E7374617475733D3D227375636365737322297B0D0A202020202020202020242822236164645F6A666F726D5F63677265706F72745F6974656D5F7461626C6522292E656D70747928293B0D0A202020202020242E6561636828646174612E64617461732C66756E6374696F6E28696E6465782C65297B0D0A202020202020202076617220247472203D20242822236164645F6A666F726D5F63677265706F72745F6974656D5F7461626C655F74656D706C61746520747222292E636C6F6E6528293B0D0A2020202020202474722E66696E64282274643A6571283129203A7465787422292E76616C2865293B0D0A202020202020202474722E66696E64282274643A6571283229203A7465787422292E76616C28696E646578293B0D0A202020202020202474722E66696E64282274643A6571283329203A7465787422292E76616C2865293B0D0A20202020202020242822236164645F6A666F726D5F63677265706F72745F6974656D5F7461626C6522292E617070656E6428247472293B0D0A2020202020207D293B200D0A20202020726573657454724E756D28226164645F6A666F726D5F63677265706F72745F6974656D5F7461626C6522293B0D0A202020207D656C73657B0D0A0909242E6D657373616765722E616C6572742827B4EDCEF3272C646174612E6461746173293B0D0A097D0D0A20207D0D0A20207D293B0D0A207D293B0D0A7D293B",
//						16).toByteArray());
//		cgReportJs.setFormId(cgReportFormId);
//		commonDao.saveOrUpdate(cgReportJs);
//		// end - 动态报表配置的js增强
//		jform_cgreport_head_id.setFieldName("id");
//		jform_cgreport_head_id.setTable(jform_cgreport_head);
//		jform_cgreport_head_id.setFieldLength(120);
//		jform_cgreport_head_id.setIsKey("Y");
//		jform_cgreport_head_id.setIsNull("N");
//		jform_cgreport_head_id.setIsQuery("N");
//		jform_cgreport_head_id.setIsShow("N");
//		jform_cgreport_head_id.setIsShowList("N");
//		jform_cgreport_head_id.setShowType("checkbox");
//		jform_cgreport_head_id.setLength(36);
//		jform_cgreport_head_id.setType("string");
//		jform_cgreport_head_id.setOrderNum(0);
//		jform_cgreport_head_id.setPointLength(0);
//		jform_cgreport_head_id.setQueryMode("single");
//		jform_cgreport_head_id.setContent("主键");
//		jform_cgreport_head_id.setCreateBy("admin");
//		jform_cgreport_head_id.setCreateDate(new Date());
//		jform_cgreport_head_id.setCreateName("管理员");
//		jform_cgreport_head_id.setDictField("");
//		jform_cgreport_head_id.setDictTable("");
//		jform_cgreport_head_id.setMainTable("");
//		jform_cgreport_head_id.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_head_id);
//
//		CgFormFieldEntity jform_cgreport_head_code = new CgFormFieldEntity();
//		jform_cgreport_head_code.setFieldName("code");
//		jform_cgreport_head_code.setTable(jform_cgreport_head);
//		jform_cgreport_head_code.setFieldLength(120);
//		jform_cgreport_head_code.setIsKey("N");
//		jform_cgreport_head_code.setIsNull("N");
//		jform_cgreport_head_code.setIsQuery("Y");
//		jform_cgreport_head_code.setIsShow("Y");
//		jform_cgreport_head_code.setIsShowList("Y");
//		jform_cgreport_head_code.setShowType("text");
//		jform_cgreport_head_code.setLength(36);
//		jform_cgreport_head_code.setType("string");
//		jform_cgreport_head_code.setOrderNum(1);
//		jform_cgreport_head_code.setPointLength(0);
//		jform_cgreport_head_code.setQueryMode("single");
//		jform_cgreport_head_code.setContent("编码");
//		jform_cgreport_head_code.setCreateBy("admin");
//		jform_cgreport_head_code.setCreateDate(new Date());
//		jform_cgreport_head_code.setCreateName("管理员");
//		jform_cgreport_head_code.setDictField("");
//		jform_cgreport_head_code.setDictTable("");
//		jform_cgreport_head_code.setMainTable("");
//		jform_cgreport_head_code.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_head_code);
//
//		CgFormFieldEntity jform_cgreport_head_name = new CgFormFieldEntity();
//		jform_cgreport_head_name.setFieldName("name");
//		jform_cgreport_head_name.setTable(jform_cgreport_head);
//		jform_cgreport_head_name.setFieldLength(120);
//		jform_cgreport_head_name.setIsKey("N");
//		jform_cgreport_head_name.setIsNull("N");
//		jform_cgreport_head_name.setIsQuery("Y");
//		jform_cgreport_head_name.setIsShow("Y");
//		jform_cgreport_head_name.setIsShowList("Y");
//		jform_cgreport_head_name.setShowType("text");
//		jform_cgreport_head_name.setLength(100);
//		jform_cgreport_head_name.setType("string");
//		jform_cgreport_head_name.setOrderNum(2);
//		jform_cgreport_head_name.setPointLength(0);
//		jform_cgreport_head_name.setQueryMode("single");
//		jform_cgreport_head_name.setContent("名称");
//		jform_cgreport_head_name.setCreateBy("admin");
//		jform_cgreport_head_name.setCreateDate(new Date());
//		jform_cgreport_head_name.setCreateName("管理员");
//		jform_cgreport_head_name.setDictField("");
//		jform_cgreport_head_name.setDictTable("");
//		jform_cgreport_head_name.setMainTable("");
//		jform_cgreport_head_name.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_head_name);
//
//		CgFormFieldEntity jform_cgreport_head_cgr_sql = new CgFormFieldEntity();
//		jform_cgreport_head_cgr_sql.setFieldName("cgr_sql");
//		jform_cgreport_head_cgr_sql.setTable(jform_cgreport_head);
//		jform_cgreport_head_cgr_sql.setFieldLength(120);
//		jform_cgreport_head_cgr_sql.setIsKey("N");
//		jform_cgreport_head_cgr_sql.setIsNull("N");
//		jform_cgreport_head_cgr_sql.setIsQuery("Y");
//		jform_cgreport_head_cgr_sql.setIsShow("Y");
//		jform_cgreport_head_cgr_sql.setIsShowList("Y");
//		jform_cgreport_head_cgr_sql.setShowType("textarea");
//		jform_cgreport_head_cgr_sql.setLength(2000);
//		jform_cgreport_head_cgr_sql.setType("string");
//		jform_cgreport_head_cgr_sql.setOrderNum(3);
//		jform_cgreport_head_cgr_sql.setPointLength(0);
//		jform_cgreport_head_cgr_sql.setQueryMode("single");
//		jform_cgreport_head_cgr_sql.setContent("查询数据SQL");
//		jform_cgreport_head_cgr_sql.setCreateBy("admin");
//		jform_cgreport_head_cgr_sql.setCreateDate(new Date());
//		jform_cgreport_head_cgr_sql.setCreateName("管理员");
//		jform_cgreport_head_cgr_sql.setDictField("");
//		jform_cgreport_head_cgr_sql.setDictTable("");
//		jform_cgreport_head_cgr_sql.setMainTable("");
//		jform_cgreport_head_cgr_sql.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_head_cgr_sql);
//
//		CgFormFieldEntity jform_cgreport_head_content = new CgFormFieldEntity();
//		jform_cgreport_head_content.setFieldName("content");
//		jform_cgreport_head_content.setTable(jform_cgreport_head);
//		jform_cgreport_head_content.setFieldLength(120);
//		jform_cgreport_head_content.setIsKey("N");
//		jform_cgreport_head_content.setIsNull("N");
//		jform_cgreport_head_content.setIsQuery("Y");
//		jform_cgreport_head_content.setIsShow("Y");
//		jform_cgreport_head_content.setIsShowList("Y");
//		jform_cgreport_head_content.setShowType("textarea");
//		jform_cgreport_head_content.setLength(1000);
//		jform_cgreport_head_content.setType("string");
//		jform_cgreport_head_content.setOrderNum(4);
//		jform_cgreport_head_content.setPointLength(0);
//		jform_cgreport_head_content.setQueryMode("single");
//		jform_cgreport_head_content.setContent("描述");
//		jform_cgreport_head_content.setCreateBy("admin");
//		jform_cgreport_head_content.setCreateDate(new Date());
//		jform_cgreport_head_content.setCreateName("管理员");
//		jform_cgreport_head_content.setDictField("");
//		jform_cgreport_head_content.setDictTable("");
//		jform_cgreport_head_content.setMainTable("");
//		jform_cgreport_head_content.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_head_content);
//
//		// 表单[动态报表配置明细] - 字段清单
//		CgFormHeadEntity jform_cgreport_item = commonDao.findByProperty(
//				CgFormHeadEntity.class, "tableName", "jform_cgreport_item")
//				.get(0);
//		CgFormFieldEntity jform_cgreport_item_id = new CgFormFieldEntity();
//		jform_cgreport_item_id.setFieldName("id");
//		jform_cgreport_item_id.setTable(jform_cgreport_item);
//		jform_cgreport_item_id.setFieldLength(120);
//		jform_cgreport_item_id.setIsKey("Y");
//		jform_cgreport_item_id.setIsNull("N");
//		jform_cgreport_item_id.setIsQuery("N");
//		jform_cgreport_item_id.setIsShow("N");
//		jform_cgreport_item_id.setIsShowList("N");
//		jform_cgreport_item_id.setShowType("checkbox");
//		jform_cgreport_item_id.setLength(36);
//		jform_cgreport_item_id.setType("string");
//		jform_cgreport_item_id.setOrderNum(0);
//		jform_cgreport_item_id.setPointLength(0);
//		jform_cgreport_item_id.setQueryMode("single");
//		jform_cgreport_item_id.setContent("主键");
//		jform_cgreport_item_id.setCreateBy("admin");
//		jform_cgreport_item_id.setCreateDate(new Date());
//		jform_cgreport_item_id.setCreateName("管理员");
//		jform_cgreport_item_id.setDictField("");
//		jform_cgreport_item_id.setDictTable("");
//		jform_cgreport_item_id.setMainTable("");
//		jform_cgreport_item_id.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_id);
//
//		CgFormFieldEntity jform_cgreport_item_field_name = new CgFormFieldEntity();
//		jform_cgreport_item_field_name.setFieldName("field_name");
//		jform_cgreport_item_field_name.setTable(jform_cgreport_item);
//		jform_cgreport_item_field_name.setFieldLength(120);
//		jform_cgreport_item_field_name.setIsKey("N");
//		jform_cgreport_item_field_name.setIsNull("Y");
//		jform_cgreport_item_field_name.setIsQuery("N");
//		jform_cgreport_item_field_name.setIsShow("Y");
//		jform_cgreport_item_field_name.setIsShowList("Y");
//		jform_cgreport_item_field_name.setShowType("text");
//		jform_cgreport_item_field_name.setLength(36);
//		jform_cgreport_item_field_name.setType("string");
//		jform_cgreport_item_field_name.setOrderNum(1);
//		jform_cgreport_item_field_name.setPointLength(0);
//		jform_cgreport_item_field_name.setQueryMode("single");
//		jform_cgreport_item_field_name.setContent("字段名");
//		jform_cgreport_item_field_name.setCreateBy("admin");
//		jform_cgreport_item_field_name.setCreateDate(new Date());
//		jform_cgreport_item_field_name.setCreateName("管理员");
//		jform_cgreport_item_field_name.setDictField("");
//		jform_cgreport_item_field_name.setDictTable("");
//		jform_cgreport_item_field_name.setMainTable("");
//		jform_cgreport_item_field_name.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_field_name);
//
//		CgFormFieldEntity jform_cgreport_item_order_num = new CgFormFieldEntity();
//		jform_cgreport_item_order_num.setFieldName("order_num");
//		jform_cgreport_item_order_num.setTable(jform_cgreport_item);
//		jform_cgreport_item_order_num.setFieldLength(120);
//		jform_cgreport_item_order_num.setIsKey("N");
//		jform_cgreport_item_order_num.setIsNull("Y");
//		jform_cgreport_item_order_num.setIsQuery("N");
//		jform_cgreport_item_order_num.setIsShow("Y");
//		jform_cgreport_item_order_num.setIsShowList("Y");
//		jform_cgreport_item_order_num.setShowType("text");
//		jform_cgreport_item_order_num.setLength(10);
//		jform_cgreport_item_order_num.setType("int");
//		jform_cgreport_item_order_num.setOrderNum(2);
//		jform_cgreport_item_order_num.setPointLength(0);
//		jform_cgreport_item_order_num.setQueryMode("single");
//		jform_cgreport_item_order_num.setContent("字段序号");
//		jform_cgreport_item_order_num.setCreateBy("admin");
//		jform_cgreport_item_order_num.setCreateDate(new Date());
//		jform_cgreport_item_order_num.setCreateName("管理员");
//		jform_cgreport_item_order_num.setDictField("");
//		jform_cgreport_item_order_num.setDictTable("");
//		jform_cgreport_item_order_num.setMainTable("");
//		jform_cgreport_item_order_num.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_order_num);
//
//		CgFormFieldEntity jform_cgreport_item_s_mode = new CgFormFieldEntity();
//		jform_cgreport_item_s_mode.setFieldName("s_mode");
//		jform_cgreport_item_s_mode.setTable(jform_cgreport_item);
//		jform_cgreport_item_s_mode.setFieldLength(120);
//		jform_cgreport_item_s_mode.setIsKey("N");
//		jform_cgreport_item_s_mode.setIsNull("Y");
//		jform_cgreport_item_s_mode.setIsQuery("N");
//		jform_cgreport_item_s_mode.setIsShow("Y");
//		jform_cgreport_item_s_mode.setIsShowList("Y");
//		jform_cgreport_item_s_mode.setShowType("list");
//		jform_cgreport_item_s_mode.setLength(10);
//		jform_cgreport_item_s_mode.setType("string");
//		jform_cgreport_item_s_mode.setOrderNum(5);
//		jform_cgreport_item_s_mode.setPointLength(0);
//		jform_cgreport_item_s_mode.setQueryMode("single");
//		jform_cgreport_item_s_mode.setContent("查询模式");
//		jform_cgreport_item_s_mode.setCreateBy("admin");
//		jform_cgreport_item_s_mode.setCreateDate(new Date());
//		jform_cgreport_item_s_mode.setCreateName("管理员");
//		jform_cgreport_item_s_mode.setDictField("searchmode");
//		jform_cgreport_item_s_mode.setDictTable("");
//		jform_cgreport_item_s_mode.setMainTable("");
//		jform_cgreport_item_s_mode.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_s_mode);
//
//		CgFormFieldEntity jform_cgreport_item_replace_va = new CgFormFieldEntity();
//		jform_cgreport_item_replace_va.setFieldName("replace_va");
//		jform_cgreport_item_replace_va.setTable(jform_cgreport_item);
//		jform_cgreport_item_replace_va.setFieldLength(120);
//		jform_cgreport_item_replace_va.setIsKey("N");
//		jform_cgreport_item_replace_va.setIsNull("Y");
//		jform_cgreport_item_replace_va.setIsQuery("N");
//		jform_cgreport_item_replace_va.setIsShow("Y");
//		jform_cgreport_item_replace_va.setIsShowList("Y");
//		jform_cgreport_item_replace_va.setShowType("text");
//		jform_cgreport_item_replace_va.setLength(36);
//		jform_cgreport_item_replace_va.setType("string");
//		jform_cgreport_item_replace_va.setOrderNum(6);
//		jform_cgreport_item_replace_va.setPointLength(0);
//		jform_cgreport_item_replace_va.setQueryMode("single");
//		jform_cgreport_item_replace_va.setContent("取值表达式");
//		jform_cgreport_item_replace_va.setCreateBy("admin");
//		jform_cgreport_item_replace_va.setCreateDate(new Date());
//		jform_cgreport_item_replace_va.setCreateName("管理员");
//		jform_cgreport_item_replace_va.setDictField("");
//		jform_cgreport_item_replace_va.setDictTable("");
//		jform_cgreport_item_replace_va.setMainTable("");
//		jform_cgreport_item_replace_va.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_replace_va);
//
//		CgFormFieldEntity jform_cgreport_item_dict_code = new CgFormFieldEntity();
//		jform_cgreport_item_dict_code.setFieldName("dict_code");
//		jform_cgreport_item_dict_code.setTable(jform_cgreport_item);
//		jform_cgreport_item_dict_code.setFieldLength(120);
//		jform_cgreport_item_dict_code.setIsKey("N");
//		jform_cgreport_item_dict_code.setIsNull("Y");
//		jform_cgreport_item_dict_code.setIsQuery("N");
//		jform_cgreport_item_dict_code.setIsShow("Y");
//		jform_cgreport_item_dict_code.setIsShowList("Y");
//		jform_cgreport_item_dict_code.setShowType("text");
//		jform_cgreport_item_dict_code.setLength(36);
//		jform_cgreport_item_dict_code.setType("string");
//		jform_cgreport_item_dict_code.setOrderNum(7);
//		jform_cgreport_item_dict_code.setPointLength(0);
//		jform_cgreport_item_dict_code.setQueryMode("single");
//		jform_cgreport_item_dict_code.setContent("字典Code");
//		jform_cgreport_item_dict_code.setCreateBy("admin");
//		jform_cgreport_item_dict_code.setCreateDate(new Date());
//		jform_cgreport_item_dict_code.setCreateName("管理员");
//		jform_cgreport_item_dict_code.setDictField("");
//		jform_cgreport_item_dict_code.setDictTable("");
//		jform_cgreport_item_dict_code.setMainTable("");
//		jform_cgreport_item_dict_code.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_dict_code);
//
//		CgFormFieldEntity jform_cgreport_item_s_flag = new CgFormFieldEntity();
//		jform_cgreport_item_s_flag.setFieldName("s_flag");
//		jform_cgreport_item_s_flag.setTable(jform_cgreport_item);
//		jform_cgreport_item_s_flag.setFieldLength(120);
//		jform_cgreport_item_s_flag.setIsKey("N");
//		jform_cgreport_item_s_flag.setIsNull("Y");
//		jform_cgreport_item_s_flag.setIsQuery("N");
//		jform_cgreport_item_s_flag.setIsShow("Y");
//		jform_cgreport_item_s_flag.setIsShowList("Y");
//		jform_cgreport_item_s_flag.setShowType("list");
//		jform_cgreport_item_s_flag.setLength(2);
//		jform_cgreport_item_s_flag.setType("string");
//		jform_cgreport_item_s_flag.setOrderNum(8);
//		jform_cgreport_item_s_flag.setPointLength(0);
//		jform_cgreport_item_s_flag.setQueryMode("single");
//		jform_cgreport_item_s_flag.setContent("是否查询");
//		jform_cgreport_item_s_flag.setCreateBy("admin");
//		jform_cgreport_item_s_flag.setCreateDate(new Date());
//		jform_cgreport_item_s_flag.setCreateName("管理员");
//		jform_cgreport_item_s_flag.setDictField("yesorno");
//		jform_cgreport_item_s_flag.setDictTable("");
//		jform_cgreport_item_s_flag.setMainTable("");
//		jform_cgreport_item_s_flag.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_s_flag);
//
//		CgFormFieldEntity jform_cgreport_item_cgrhead_id = new CgFormFieldEntity();
//		jform_cgreport_item_cgrhead_id.setFieldName("cgrhead_id");
//		jform_cgreport_item_cgrhead_id.setTable(jform_cgreport_item);
//		jform_cgreport_item_cgrhead_id.setFieldLength(120);
//		jform_cgreport_item_cgrhead_id.setIsKey("N");
//		jform_cgreport_item_cgrhead_id.setIsNull("Y");
//		jform_cgreport_item_cgrhead_id.setIsQuery("N");
//		jform_cgreport_item_cgrhead_id.setIsShow("N");
//		jform_cgreport_item_cgrhead_id.setIsShowList("N");
//		jform_cgreport_item_cgrhead_id.setShowType("text");
//		jform_cgreport_item_cgrhead_id.setLength(36);
//		jform_cgreport_item_cgrhead_id.setType("string");
//		jform_cgreport_item_cgrhead_id.setOrderNum(9);
//		jform_cgreport_item_cgrhead_id.setPointLength(0);
//		jform_cgreport_item_cgrhead_id.setQueryMode("single");
//		jform_cgreport_item_cgrhead_id.setContent("外键");
//		jform_cgreport_item_cgrhead_id.setCreateBy("admin");
//		jform_cgreport_item_cgrhead_id.setCreateDate(new Date());
//		jform_cgreport_item_cgrhead_id.setCreateName("管理员");
//		jform_cgreport_item_cgrhead_id.setDictField("");
//		jform_cgreport_item_cgrhead_id.setDictTable("");
//		jform_cgreport_item_cgrhead_id.setMainTable("jform_cgreport_head");
//		jform_cgreport_item_cgrhead_id.setMainField("id");
//		commonDao.saveOrUpdate(jform_cgreport_item_cgrhead_id);
//
//		CgFormFieldEntity jform_cgreport_item_field_txt = new CgFormFieldEntity();
//		jform_cgreport_item_field_txt.setFieldName("field_txt");
//		jform_cgreport_item_field_txt.setTable(jform_cgreport_item);
//		jform_cgreport_item_field_txt.setFieldLength(120);
//		jform_cgreport_item_field_txt.setIsKey("N");
//		jform_cgreport_item_field_txt.setIsNull("Y");
//		jform_cgreport_item_field_txt.setIsQuery("N");
//		jform_cgreport_item_field_txt.setIsShow("Y");
//		jform_cgreport_item_field_txt.setIsShowList("Y");
//		jform_cgreport_item_field_txt.setShowType("text");
//		jform_cgreport_item_field_txt.setLength(1000);
//		jform_cgreport_item_field_txt.setType("string");
//		jform_cgreport_item_field_txt.setOrderNum(3);
//		jform_cgreport_item_field_txt.setPointLength(0);
//		jform_cgreport_item_field_txt.setQueryMode("single");
//		jform_cgreport_item_field_txt.setContent("字段文本");
//		jform_cgreport_item_field_txt.setCreateBy("admin");
//		jform_cgreport_item_field_txt.setCreateDate(new Date());
//		jform_cgreport_item_field_txt.setCreateName("管理员");
//		jform_cgreport_item_field_txt.setDictField("");
//		jform_cgreport_item_field_txt.setDictTable("");
//		jform_cgreport_item_field_txt.setMainTable("");
//		jform_cgreport_item_field_txt.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_field_txt);
//
//		CgFormFieldEntity jform_cgreport_item_field_type = new CgFormFieldEntity();
//		jform_cgreport_item_field_type.setFieldName("field_type");
//		jform_cgreport_item_field_type.setTable(jform_cgreport_item);
//		jform_cgreport_item_field_type.setFieldLength(120);
//		jform_cgreport_item_field_type.setIsKey("N");
//		jform_cgreport_item_field_type.setIsNull("Y");
//		jform_cgreport_item_field_type.setIsQuery("N");
//		jform_cgreport_item_field_type.setIsShow("Y");
//		jform_cgreport_item_field_type.setIsShowList("Y");
//		jform_cgreport_item_field_type.setShowType("list");
//		jform_cgreport_item_field_type.setLength(10);
//		jform_cgreport_item_field_type.setType("string");
//		jform_cgreport_item_field_type.setOrderNum(4);
//		jform_cgreport_item_field_type.setPointLength(0);
//		jform_cgreport_item_field_type.setQueryMode("single");
//		jform_cgreport_item_field_type.setContent("字段类型");
//		jform_cgreport_item_field_type.setCreateBy("admin");
//		jform_cgreport_item_field_type.setCreateDate(new Date());
//		jform_cgreport_item_field_type.setCreateName("管理员");
//		jform_cgreport_item_field_type.setDictField("fieldtype");
//		jform_cgreport_item_field_type.setDictTable("");
//		jform_cgreport_item_field_type.setMainTable("");
//		jform_cgreport_item_field_type.setMainField("");
//		commonDao.saveOrUpdate(jform_cgreport_item_field_type);

		// 表单[订单客户信息] - 字段清单
		CgFormHeadEntity jform_order_customer = commonDao.findByProperty(
				CgFormHeadEntity.class, "tableName", "jform_order_customer")
				.get(0);
		CgFormFieldEntity jform_order_customer_id = new CgFormFieldEntity();
		jform_order_customer_id.setFieldName("id");
		jform_order_customer_id.setTable(jform_order_customer);
		jform_order_customer_id.setFieldLength(0);
		jform_order_customer_id.setIsKey("Y");
		jform_order_customer_id.setIsNull("N");
		jform_order_customer_id.setIsQuery("N");
		jform_order_customer_id.setIsShow("N");
		jform_order_customer_id.setIsShowList("N");
		jform_order_customer_id.setShowType("text");
		jform_order_customer_id.setLength(36);
		jform_order_customer_id.setType("string");
		jform_order_customer_id.setOrderNum(0);
		jform_order_customer_id.setPointLength(0);
		jform_order_customer_id.setQueryMode("single");
		jform_order_customer_id.setContent("主键");
		jform_order_customer_id.setCreateBy("admin");
		jform_order_customer_id.setCreateDate(new Date());
		jform_order_customer_id.setCreateName("管理员");
		jform_order_customer_id.setDictField("");
		jform_order_customer_id.setDictTable("");
		jform_order_customer_id.setMainTable("");
		jform_order_customer_id.setMainField("");
		commonDao.saveOrUpdate(jform_order_customer_id);

		CgFormFieldEntity jform_order_customer_name = new CgFormFieldEntity();
		jform_order_customer_name.setFieldName("name");
		jform_order_customer_name.setTable(jform_order_customer);
		jform_order_customer_name.setFieldLength(0);
		jform_order_customer_name.setIsKey("N");
		jform_order_customer_name.setIsNull("Y");
		jform_order_customer_name.setIsQuery("Y");
		jform_order_customer_name.setIsShow("Y");
		jform_order_customer_name.setIsShowList("Y");
		jform_order_customer_name.setShowType("text");
		jform_order_customer_name.setLength(32);
		jform_order_customer_name.setType("string");
		jform_order_customer_name.setOrderNum(1);
		jform_order_customer_name.setPointLength(0);
		jform_order_customer_name.setQueryMode("single");
		jform_order_customer_name.setContent("客户名");
		jform_order_customer_name.setCreateBy("admin");
		jform_order_customer_name.setCreateDate(new Date());
		jform_order_customer_name.setCreateName("管理员");
		jform_order_customer_name.setDictField("");
		jform_order_customer_name.setDictTable("");
		jform_order_customer_name.setMainTable("");
		jform_order_customer_name.setMainField("");
		commonDao.saveOrUpdate(jform_order_customer_name);

		CgFormFieldEntity jform_order_customer_money = new CgFormFieldEntity();
		jform_order_customer_money.setFieldName("money");
		jform_order_customer_money.setTable(jform_order_customer);
		jform_order_customer_money.setFieldLength(0);
		jform_order_customer_money.setIsKey("N");
		jform_order_customer_money.setIsNull("Y");
		jform_order_customer_money.setIsQuery("Y");
		jform_order_customer_money.setIsShow("Y");
		jform_order_customer_money.setIsShowList("Y");
		jform_order_customer_money.setShowType("text");
		jform_order_customer_money.setLength(10);
		jform_order_customer_money.setType("double");
		jform_order_customer_money.setOrderNum(2);
		jform_order_customer_money.setPointLength(2);
		jform_order_customer_money.setQueryMode("group");
		jform_order_customer_money.setContent("单价");
		jform_order_customer_money.setCreateBy("admin");
		jform_order_customer_money.setCreateDate(new Date());
		jform_order_customer_money.setCreateName("管理员");
		jform_order_customer_money.setDictField("");
		jform_order_customer_money.setDictTable("");
		jform_order_customer_money.setMainTable("");
		jform_order_customer_money.setMainField("");
		commonDao.saveOrUpdate(jform_order_customer_money);

		CgFormFieldEntity jform_order_customer_fk_id = new CgFormFieldEntity();
		jform_order_customer_fk_id.setFieldName("fk_id");
		jform_order_customer_fk_id.setTable(jform_order_customer);
		jform_order_customer_fk_id.setFieldLength(120);
		jform_order_customer_fk_id.setIsKey("N");
		jform_order_customer_fk_id.setIsNull("N");
		jform_order_customer_fk_id.setIsQuery("Y");
		jform_order_customer_fk_id.setIsShow("N");
		jform_order_customer_fk_id.setIsShowList("N");
		jform_order_customer_fk_id.setShowType("text");
		jform_order_customer_fk_id.setLength(36);
		jform_order_customer_fk_id.setType("string");
		jform_order_customer_fk_id.setOrderNum(5);
		jform_order_customer_fk_id.setPointLength(0);
		jform_order_customer_fk_id.setQueryMode("single");
		jform_order_customer_fk_id.setContent("外键");
		jform_order_customer_fk_id.setCreateBy("admin");
		jform_order_customer_fk_id.setCreateDate(new Date());
		jform_order_customer_fk_id.setCreateName("管理员");
		jform_order_customer_fk_id.setDictField("");
		jform_order_customer_fk_id.setDictTable("");
		jform_order_customer_fk_id.setMainTable("jform_order_main");
		jform_order_customer_fk_id.setMainField("id");
		commonDao.saveOrUpdate(jform_order_customer_fk_id);

		CgFormFieldEntity jform_order_customer_telphone = new CgFormFieldEntity();
		jform_order_customer_telphone.setFieldName("telphone");
		jform_order_customer_telphone.setTable(jform_order_customer);
		jform_order_customer_telphone.setFieldLength(120);
		jform_order_customer_telphone.setIsKey("N");
		jform_order_customer_telphone.setIsNull("Y");
		jform_order_customer_telphone.setIsQuery("Y");
		jform_order_customer_telphone.setIsShow("Y");
		jform_order_customer_telphone.setIsShowList("Y");
		jform_order_customer_telphone.setShowType("text");
		jform_order_customer_telphone.setLength(32);
		jform_order_customer_telphone.setType("string");
		jform_order_customer_telphone.setOrderNum(4);
		jform_order_customer_telphone.setPointLength(0);
		jform_order_customer_telphone.setQueryMode("single");
		jform_order_customer_telphone.setContent("电话");
		jform_order_customer_telphone.setCreateBy("admin");
		jform_order_customer_telphone.setCreateDate(new Date());
		jform_order_customer_telphone.setCreateName("管理员");
		jform_order_customer_telphone.setDictField("");
		jform_order_customer_telphone.setDictTable("");
		jform_order_customer_telphone.setMainTable("");
		jform_order_customer_telphone.setMainField("");
		commonDao.saveOrUpdate(jform_order_customer_telphone);

		CgFormFieldEntity jform_order_customer_sex = new CgFormFieldEntity();
		jform_order_customer_sex.setFieldName("sex");
		jform_order_customer_sex.setTable(jform_order_customer);
		jform_order_customer_sex.setFieldLength(120);
		jform_order_customer_sex.setIsKey("N");
		jform_order_customer_sex.setIsNull("Y");
		jform_order_customer_sex.setIsQuery("Y");
		jform_order_customer_sex.setIsShow("Y");
		jform_order_customer_sex.setIsShowList("Y");
		jform_order_customer_sex.setShowType("select");
		jform_order_customer_sex.setLength(4);
		jform_order_customer_sex.setType("string");
		jform_order_customer_sex.setOrderNum(3);
		jform_order_customer_sex.setPointLength(0);
		jform_order_customer_sex.setQueryMode("single");
		jform_order_customer_sex.setContent("性别");
		jform_order_customer_sex.setCreateBy("admin");
		jform_order_customer_sex.setCreateDate(new Date());
		jform_order_customer_sex.setCreateName("管理员");
		jform_order_customer_sex.setDictField("sex");
		jform_order_customer_sex.setDictTable("");
		jform_order_customer_sex.setMainTable("");
		jform_order_customer_sex.setMainField("");
		commonDao.saveOrUpdate(jform_order_customer_sex);

		// 表单[订单机票信息] - 字段清单
		CgFormHeadEntity jform_order_ticket = commonDao.findByProperty(
				CgFormHeadEntity.class, "tableName", "jform_order_ticket").get(
				0);
		CgFormFieldEntity jform_order_ticket_id = new CgFormFieldEntity();
		jform_order_ticket_id.setFieldName("id");
		jform_order_ticket_id.setTable(jform_order_ticket);
		jform_order_ticket_id.setFieldLength(120);
		jform_order_ticket_id.setIsKey("Y");
		jform_order_ticket_id.setIsNull("N");
		jform_order_ticket_id.setIsQuery("N");
		jform_order_ticket_id.setIsShow("N");
		jform_order_ticket_id.setIsShowList("N");
		jform_order_ticket_id.setShowType("checkbox");
		jform_order_ticket_id.setLength(36);
		jform_order_ticket_id.setType("string");
		jform_order_ticket_id.setOrderNum(0);
		jform_order_ticket_id.setPointLength(0);
		jform_order_ticket_id.setQueryMode("single");
		jform_order_ticket_id.setContent("主键");
		jform_order_ticket_id.setCreateBy("admin");
		jform_order_ticket_id.setCreateDate(new Date());
		jform_order_ticket_id.setCreateName("管理员");
		jform_order_ticket_id.setDictField("");
		jform_order_ticket_id.setDictTable("");
		jform_order_ticket_id.setMainTable("");
		jform_order_ticket_id.setMainField("");
		commonDao.saveOrUpdate(jform_order_ticket_id);

		CgFormFieldEntity jform_order_ticket_ticket_code = new CgFormFieldEntity();
		jform_order_ticket_ticket_code.setFieldName("ticket_code");
		jform_order_ticket_ticket_code.setTable(jform_order_ticket);
		jform_order_ticket_ticket_code.setFieldLength(120);
		jform_order_ticket_ticket_code.setIsKey("N");
		jform_order_ticket_ticket_code.setIsNull("N");
		jform_order_ticket_ticket_code.setIsQuery("Y");
		jform_order_ticket_ticket_code.setIsShow("Y");
		jform_order_ticket_ticket_code.setIsShowList("Y");
		jform_order_ticket_ticket_code.setShowType("text");
		jform_order_ticket_ticket_code.setLength(100);
		jform_order_ticket_ticket_code.setType("string");
		jform_order_ticket_ticket_code.setOrderNum(1);
		jform_order_ticket_ticket_code.setPointLength(0);
		jform_order_ticket_ticket_code.setQueryMode("single");
		jform_order_ticket_ticket_code.setContent("航班号");
		jform_order_ticket_ticket_code.setCreateBy("admin");
		jform_order_ticket_ticket_code.setCreateDate(new Date());
		jform_order_ticket_ticket_code.setCreateName("管理员");
		jform_order_ticket_ticket_code.setDictField("");
		jform_order_ticket_ticket_code.setDictTable("");
		jform_order_ticket_ticket_code.setMainTable("");
		jform_order_ticket_ticket_code.setMainField("");
		commonDao.saveOrUpdate(jform_order_ticket_ticket_code);

		CgFormFieldEntity jform_order_ticket_tickect_date = new CgFormFieldEntity();
		jform_order_ticket_tickect_date.setFieldName("tickect_date");
		jform_order_ticket_tickect_date.setTable(jform_order_ticket);
		jform_order_ticket_tickect_date.setFieldLength(120);
		jform_order_ticket_tickect_date.setIsKey("N");
		jform_order_ticket_tickect_date.setIsNull("N");
		jform_order_ticket_tickect_date.setIsQuery("Y");
		jform_order_ticket_tickect_date.setIsShow("Y");
		jform_order_ticket_tickect_date.setIsShowList("Y");
		jform_order_ticket_tickect_date.setShowType("datetime");
		jform_order_ticket_tickect_date.setLength(10);
		jform_order_ticket_tickect_date.setType("Date");
		jform_order_ticket_tickect_date.setOrderNum(2);
		jform_order_ticket_tickect_date.setPointLength(0);
		jform_order_ticket_tickect_date.setQueryMode("single");
		jform_order_ticket_tickect_date.setContent("航班时间");
		jform_order_ticket_tickect_date.setCreateBy("admin");
		jform_order_ticket_tickect_date.setCreateDate(new Date());
		jform_order_ticket_tickect_date.setCreateName("管理员");
		jform_order_ticket_tickect_date.setDictField("");
		jform_order_ticket_tickect_date.setDictTable("");
		jform_order_ticket_tickect_date.setMainTable("");
		jform_order_ticket_tickect_date.setMainField("");
		commonDao.saveOrUpdate(jform_order_ticket_tickect_date);

		CgFormFieldEntity jform_order_ticket_fck_id = new CgFormFieldEntity();
		jform_order_ticket_fck_id.setFieldName("fck_id");
		jform_order_ticket_fck_id.setTable(jform_order_ticket);
		jform_order_ticket_fck_id.setFieldLength(120);
		jform_order_ticket_fck_id.setIsKey("N");
		jform_order_ticket_fck_id.setIsNull("N");
		jform_order_ticket_fck_id.setIsQuery("N");
		jform_order_ticket_fck_id.setIsShow("N");
		jform_order_ticket_fck_id.setIsShowList("N");
		jform_order_ticket_fck_id.setShowType("text");
		jform_order_ticket_fck_id.setLength(36);
		jform_order_ticket_fck_id.setType("string");
		jform_order_ticket_fck_id.setOrderNum(3);
		jform_order_ticket_fck_id.setPointLength(0);
		jform_order_ticket_fck_id.setQueryMode("single");
		jform_order_ticket_fck_id.setContent("外键");
		jform_order_ticket_fck_id.setCreateBy("admin");
		jform_order_ticket_fck_id.setCreateDate(new Date());
		jform_order_ticket_fck_id.setCreateName("管理员");
		jform_order_ticket_fck_id.setDictField("");
		jform_order_ticket_fck_id.setDictTable("");
		jform_order_ticket_fck_id.setMainTable("jform_order_main");
		jform_order_ticket_fck_id.setMainField("id");
		commonDao.saveOrUpdate(jform_order_ticket_fck_id);

		// 表单[价格认证机构统计表] - 字段清单
		CgFormHeadEntity jform_price1 = commonDao.findByProperty(
				CgFormHeadEntity.class, "tableName", "jform_price1").get(0);
		CgFormFieldEntity jform_price1_id = new CgFormFieldEntity();
		jform_price1_id.setFieldName("id");
		jform_price1_id.setTable(jform_price1);
		jform_price1_id.setFieldLength(0);
		jform_price1_id.setIsKey("Y");
		jform_price1_id.setIsNull("N");
		jform_price1_id.setIsQuery("N");
		jform_price1_id.setIsShow("N");
		jform_price1_id.setIsShowList("N");
		jform_price1_id.setShowType("text");
		jform_price1_id.setLength(36);
		jform_price1_id.setType("string");
		jform_price1_id.setOrderNum(0);
		jform_price1_id.setPointLength(0);
		jform_price1_id.setQueryMode("single");
		jform_price1_id.setContent("主键");
		jform_price1_id.setCreateBy("admin");
		jform_price1_id.setCreateDate(new Date());
		jform_price1_id.setCreateName("管理员");
		jform_price1_id.setDictField("");
		jform_price1_id.setDictTable("");
		jform_price1_id.setMainTable("");
		jform_price1_id.setMainField("");
		commonDao.saveOrUpdate(jform_price1_id);

		CgFormFieldEntity jform_price1_a = new CgFormFieldEntity();
		jform_price1_a.setFieldName("a");
		jform_price1_a.setTable(jform_price1);
		jform_price1_a.setFieldLength(0);
		jform_price1_a.setIsKey("N");
		jform_price1_a.setIsNull("N");
		jform_price1_a.setIsQuery("Y");
		jform_price1_a.setIsShow("Y");
		jform_price1_a.setIsShowList("Y");
		jform_price1_a.setShowType("text");
		jform_price1_a.setLength(10);
		jform_price1_a.setType("double");
		jform_price1_a.setOrderNum(1);
		jform_price1_a.setPointLength(2);
		jform_price1_a.setQueryMode("group");
		jform_price1_a.setContent("机构合计");
		jform_price1_a.setCreateBy("admin");
		jform_price1_a.setCreateDate(new Date());
		jform_price1_a.setCreateName("管理员");
		jform_price1_a.setDictField("");
		jform_price1_a.setDictTable("");
		jform_price1_a.setMainTable("");
		jform_price1_a.setMainField("");
		commonDao.saveOrUpdate(jform_price1_a);

		CgFormFieldEntity jform_price1_b1 = new CgFormFieldEntity();
		jform_price1_b1.setFieldName("b1");
		jform_price1_b1.setTable(jform_price1);
		jform_price1_b1.setFieldLength(0);
		jform_price1_b1.setIsKey("N");
		jform_price1_b1.setIsNull("N");
		jform_price1_b1.setIsQuery("N");
		jform_price1_b1.setIsShow("Y");
		jform_price1_b1.setIsShowList("Y");
		jform_price1_b1.setShowType("text");
		jform_price1_b1.setLength(10);
		jform_price1_b1.setType("double");
		jform_price1_b1.setOrderNum(2);
		jform_price1_b1.setPointLength(2);
		jform_price1_b1.setQueryMode("group");
		jform_price1_b1.setContent("行政小计");
		jform_price1_b1.setCreateBy("admin");
		jform_price1_b1.setCreateDate(new Date());
		jform_price1_b1.setCreateName("管理员");
		jform_price1_b1.setDictField("");
		jform_price1_b1.setDictTable("");
		jform_price1_b1.setMainTable("");
		jform_price1_b1.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b1);

		CgFormFieldEntity jform_price1_b11 = new CgFormFieldEntity();
		jform_price1_b11.setFieldName("b11");
		jform_price1_b11.setTable(jform_price1);
		jform_price1_b11.setFieldLength(0);
		jform_price1_b11.setIsKey("N");
		jform_price1_b11.setIsNull("N");
		jform_price1_b11.setIsQuery("N");
		jform_price1_b11.setIsShow("Y");
		jform_price1_b11.setIsShowList("Y");
		jform_price1_b11.setShowType("text");
		jform_price1_b11.setLength(100);
		jform_price1_b11.setType("string");
		jform_price1_b11.setOrderNum(3);
		jform_price1_b11.setPointLength(0);
		jform_price1_b11.setQueryMode("group");
		jform_price1_b11.setContent("行政省");
		jform_price1_b11.setCreateBy("admin");
		jform_price1_b11.setCreateDate(new Date());
		jform_price1_b11.setCreateName("管理员");
		jform_price1_b11.setDictField("");
		jform_price1_b11.setDictTable("");
		jform_price1_b11.setMainTable("");
		jform_price1_b11.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b11);

		CgFormFieldEntity jform_price1_b12 = new CgFormFieldEntity();
		jform_price1_b12.setFieldName("b12");
		jform_price1_b12.setTable(jform_price1);
		jform_price1_b12.setFieldLength(0);
		jform_price1_b12.setIsKey("N");
		jform_price1_b12.setIsNull("N");
		jform_price1_b12.setIsQuery("N");
		jform_price1_b12.setIsShow("Y");
		jform_price1_b12.setIsShowList("Y");
		jform_price1_b12.setShowType("text");
		jform_price1_b12.setLength(100);
		jform_price1_b12.setType("string");
		jform_price1_b12.setOrderNum(4);
		jform_price1_b12.setPointLength(0);
		jform_price1_b12.setQueryMode("group");
		jform_price1_b12.setContent("行政市");
		jform_price1_b12.setCreateBy("admin");
		jform_price1_b12.setCreateDate(new Date());
		jform_price1_b12.setCreateName("管理员");
		jform_price1_b12.setDictField("");
		jform_price1_b12.setDictTable("");
		jform_price1_b12.setMainTable("");
		jform_price1_b12.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b12);

		CgFormFieldEntity jform_price1_b13 = new CgFormFieldEntity();
		jform_price1_b13.setFieldName("b13");
		jform_price1_b13.setTable(jform_price1);
		jform_price1_b13.setFieldLength(0);
		jform_price1_b13.setIsKey("N");
		jform_price1_b13.setIsNull("N");
		jform_price1_b13.setIsQuery("N");
		jform_price1_b13.setIsShow("Y");
		jform_price1_b13.setIsShowList("Y");
		jform_price1_b13.setShowType("text");
		jform_price1_b13.setLength(100);
		jform_price1_b13.setType("string");
		jform_price1_b13.setOrderNum(5);
		jform_price1_b13.setPointLength(0);
		jform_price1_b13.setQueryMode("single");
		jform_price1_b13.setContent("行政县");
		jform_price1_b13.setCreateBy("admin");
		jform_price1_b13.setCreateDate(new Date());
		jform_price1_b13.setCreateName("管理员");
		jform_price1_b13.setDictField("");
		jform_price1_b13.setDictTable("");
		jform_price1_b13.setMainTable("");
		jform_price1_b13.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b13);

		CgFormFieldEntity jform_price1_b2 = new CgFormFieldEntity();
		jform_price1_b2.setFieldName("b2");
		jform_price1_b2.setTable(jform_price1);
		jform_price1_b2.setFieldLength(0);
		jform_price1_b2.setIsKey("N");
		jform_price1_b2.setIsNull("N");
		jform_price1_b2.setIsQuery("N");
		jform_price1_b2.setIsShow("Y");
		jform_price1_b2.setIsShowList("Y");
		jform_price1_b2.setShowType("text");
		jform_price1_b2.setLength(10);
		jform_price1_b2.setType("double");
		jform_price1_b2.setOrderNum(6);
		jform_price1_b2.setPointLength(2);
		jform_price1_b2.setQueryMode("single");
		jform_price1_b2.setContent("事业合计");
		jform_price1_b2.setCreateBy("admin");
		jform_price1_b2.setCreateDate(new Date());
		jform_price1_b2.setCreateName("管理员");
		jform_price1_b2.setDictField("");
		jform_price1_b2.setDictTable("");
		jform_price1_b2.setMainTable("");
		jform_price1_b2.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b2);

		CgFormFieldEntity jform_price1_b3 = new CgFormFieldEntity();
		jform_price1_b3.setFieldName("b3");
		jform_price1_b3.setTable(jform_price1);
		jform_price1_b3.setFieldLength(0);
		jform_price1_b3.setIsKey("N");
		jform_price1_b3.setIsNull("N");
		jform_price1_b3.setIsQuery("N");
		jform_price1_b3.setIsShow("Y");
		jform_price1_b3.setIsShowList("Y");
		jform_price1_b3.setShowType("text");
		jform_price1_b3.setLength(10);
		jform_price1_b3.setType("double");
		jform_price1_b3.setOrderNum(7);
		jform_price1_b3.setPointLength(2);
		jform_price1_b3.setQueryMode("single");
		jform_price1_b3.setContent("参公小计");
		jform_price1_b3.setCreateBy("admin");
		jform_price1_b3.setCreateDate(new Date());
		jform_price1_b3.setCreateName("管理员");
		jform_price1_b3.setDictField("");
		jform_price1_b3.setDictTable("");
		jform_price1_b3.setMainTable("");
		jform_price1_b3.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b3);

		CgFormFieldEntity jform_price1_b31 = new CgFormFieldEntity();
		jform_price1_b31.setFieldName("b31");
		jform_price1_b31.setTable(jform_price1);
		jform_price1_b31.setFieldLength(0);
		jform_price1_b31.setIsKey("N");
		jform_price1_b31.setIsNull("N");
		jform_price1_b31.setIsQuery("N");
		jform_price1_b31.setIsShow("Y");
		jform_price1_b31.setIsShowList("Y");
		jform_price1_b31.setShowType("text");
		jform_price1_b31.setLength(100);
		jform_price1_b31.setType("string");
		jform_price1_b31.setOrderNum(8);
		jform_price1_b31.setPointLength(0);
		jform_price1_b31.setQueryMode("single");
		jform_price1_b31.setContent("参公省");
		jform_price1_b31.setCreateBy("admin");
		jform_price1_b31.setCreateDate(new Date());
		jform_price1_b31.setCreateName("管理员");
		jform_price1_b31.setDictField("");
		jform_price1_b31.setDictTable("");
		jform_price1_b31.setMainTable("");
		jform_price1_b31.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b31);

		CgFormFieldEntity jform_price1_b32 = new CgFormFieldEntity();
		jform_price1_b32.setFieldName("b32");
		jform_price1_b32.setTable(jform_price1);
		jform_price1_b32.setFieldLength(0);
		jform_price1_b32.setIsKey("N");
		jform_price1_b32.setIsNull("N");
		jform_price1_b32.setIsQuery("N");
		jform_price1_b32.setIsShow("Y");
		jform_price1_b32.setIsShowList("Y");
		jform_price1_b32.setShowType("text");
		jform_price1_b32.setLength(100);
		jform_price1_b32.setType("string");
		jform_price1_b32.setOrderNum(9);
		jform_price1_b32.setPointLength(0);
		jform_price1_b32.setQueryMode("single");
		jform_price1_b32.setContent("参公市");
		jform_price1_b32.setCreateBy("admin");
		jform_price1_b32.setCreateDate(new Date());
		jform_price1_b32.setCreateName("管理员");
		jform_price1_b32.setDictField("");
		jform_price1_b32.setDictTable("");
		jform_price1_b32.setMainTable("");
		jform_price1_b32.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b32);

		CgFormFieldEntity jform_price1_b33 = new CgFormFieldEntity();
		jform_price1_b33.setFieldName("b33");
		jform_price1_b33.setTable(jform_price1);
		jform_price1_b33.setFieldLength(0);
		jform_price1_b33.setIsKey("N");
		jform_price1_b33.setIsNull("N");
		jform_price1_b33.setIsQuery("N");
		jform_price1_b33.setIsShow("Y");
		jform_price1_b33.setIsShowList("Y");
		jform_price1_b33.setShowType("text");
		jform_price1_b33.setLength(100);
		jform_price1_b33.setType("string");
		jform_price1_b33.setOrderNum(10);
		jform_price1_b33.setPointLength(0);
		jform_price1_b33.setQueryMode("single");
		jform_price1_b33.setContent("参公县");
		jform_price1_b33.setCreateBy("admin");
		jform_price1_b33.setCreateDate(new Date());
		jform_price1_b33.setCreateName("管理员");
		jform_price1_b33.setDictField("");
		jform_price1_b33.setDictTable("");
		jform_price1_b33.setMainTable("");
		jform_price1_b33.setMainField("");
		commonDao.saveOrUpdate(jform_price1_b33);

		CgFormFieldEntity jform_price1_c1 = new CgFormFieldEntity();
		jform_price1_c1.setFieldName("c1");
		jform_price1_c1.setTable(jform_price1);
		jform_price1_c1.setFieldLength(0);
		jform_price1_c1.setIsKey("N");
		jform_price1_c1.setIsNull("N");
		jform_price1_c1.setIsQuery("N");
		jform_price1_c1.setIsShow("Y");
		jform_price1_c1.setIsShowList("Y");
		jform_price1_c1.setShowType("text");
		jform_price1_c1.setLength(10);
		jform_price1_c1.setType("double");
		jform_price1_c1.setOrderNum(11);
		jform_price1_c1.setPointLength(2);
		jform_price1_c1.setQueryMode("single");
		jform_price1_c1.setContent("全额拨款");
		jform_price1_c1.setCreateBy("admin");
		jform_price1_c1.setCreateDate(new Date());
		jform_price1_c1.setCreateName("管理员");
		jform_price1_c1.setDictField("");
		jform_price1_c1.setDictTable("");
		jform_price1_c1.setMainTable("");
		jform_price1_c1.setMainField("");
		commonDao.saveOrUpdate(jform_price1_c1);

		CgFormFieldEntity jform_price1_c2 = new CgFormFieldEntity();
		jform_price1_c2.setFieldName("c2");
		jform_price1_c2.setTable(jform_price1);
		jform_price1_c2.setFieldLength(0);
		jform_price1_c2.setIsKey("N");
		jform_price1_c2.setIsNull("N");
		jform_price1_c2.setIsQuery("N");
		jform_price1_c2.setIsShow("Y");
		jform_price1_c2.setIsShowList("Y");
		jform_price1_c2.setShowType("text");
		jform_price1_c2.setLength(10);
		jform_price1_c2.setType("double");
		jform_price1_c2.setOrderNum(12);
		jform_price1_c2.setPointLength(2);
		jform_price1_c2.setQueryMode("single");
		jform_price1_c2.setContent("差额拨款");
		jform_price1_c2.setCreateBy("admin");
		jform_price1_c2.setCreateDate(new Date());
		jform_price1_c2.setCreateName("管理员");
		jform_price1_c2.setDictField("");
		jform_price1_c2.setDictTable("");
		jform_price1_c2.setMainTable("");
		jform_price1_c2.setMainField("");
		commonDao.saveOrUpdate(jform_price1_c2);

		CgFormFieldEntity jform_price1_c3 = new CgFormFieldEntity();
		jform_price1_c3.setFieldName("c3");
		jform_price1_c3.setTable(jform_price1);
		jform_price1_c3.setFieldLength(0);
		jform_price1_c3.setIsKey("N");
		jform_price1_c3.setIsNull("N");
		jform_price1_c3.setIsQuery("N");
		jform_price1_c3.setIsShow("Y");
		jform_price1_c3.setIsShowList("Y");
		jform_price1_c3.setShowType("text");
		jform_price1_c3.setLength(10);
		jform_price1_c3.setType("double");
		jform_price1_c3.setOrderNum(13);
		jform_price1_c3.setPointLength(2);
		jform_price1_c3.setQueryMode("single");
		jform_price1_c3.setContent("自收自支");
		jform_price1_c3.setCreateBy("admin");
		jform_price1_c3.setCreateDate(new Date());
		jform_price1_c3.setCreateName("管理员");
		jform_price1_c3.setDictField("");
		jform_price1_c3.setDictTable("");
		jform_price1_c3.setMainTable("");
		jform_price1_c3.setMainField("");
		commonDao.saveOrUpdate(jform_price1_c3);

		CgFormFieldEntity jform_price1_d = new CgFormFieldEntity();
		jform_price1_d.setFieldName("d");
		jform_price1_d.setTable(jform_price1);
		jform_price1_d.setFieldLength(0);
		jform_price1_d.setIsKey("N");
		jform_price1_d.setIsNull("N");
		jform_price1_d.setIsQuery("Y");
		jform_price1_d.setIsShow("Y");
		jform_price1_d.setIsShowList("Y");
		jform_price1_d.setShowType("text");
		jform_price1_d.setLength(10);
		jform_price1_d.setType("int");
		jform_price1_d.setOrderNum(14);
		jform_price1_d.setPointLength(2);
		jform_price1_d.setQueryMode("single");
		jform_price1_d.setContent("经费合计");
		jform_price1_d.setCreateBy("admin");
		jform_price1_d.setCreateDate(new Date());
		jform_price1_d.setCreateName("管理员");
		jform_price1_d.setDictField("");
		jform_price1_d.setDictTable("");
		jform_price1_d.setMainTable("");
		jform_price1_d.setMainField("");
		commonDao.saveOrUpdate(jform_price1_d);

		CgFormFieldEntity jform_price1_d1 = new CgFormFieldEntity();
		jform_price1_d1.setFieldName("d1");
		jform_price1_d1.setTable(jform_price1);
		jform_price1_d1.setFieldLength(0);
		jform_price1_d1.setIsKey("N");
		jform_price1_d1.setIsNull("N");
		jform_price1_d1.setIsQuery("N");
		jform_price1_d1.setIsShow("Y");
		jform_price1_d1.setIsShowList("Y");
		jform_price1_d1.setShowType("text");
		jform_price1_d1.setLength(1000);
		jform_price1_d1.setType("string");
		jform_price1_d1.setOrderNum(15);
		jform_price1_d1.setPointLength(0);
		jform_price1_d1.setQueryMode("single");
		jform_price1_d1.setContent("机构资质");
		jform_price1_d1.setCreateBy("admin");
		jform_price1_d1.setCreateDate(new Date());
		jform_price1_d1.setCreateName("管理员");
		jform_price1_d1.setDictField("");
		jform_price1_d1.setDictTable("");
		jform_price1_d1.setMainTable("");
		jform_price1_d1.setMainField("");
		commonDao.saveOrUpdate(jform_price1_d1);

	}

	/**
	 * @Description 修复HTML在线编辑功能
	 * @author tanghan 2013-7-28
	 */
	private void repairCkEditor() {
		CKEditorEntity ckEditor = new CKEditorEntity();
		String str = "<html><head><title></title><link href='plug-in/easyui/themes/default/easyui.css' id='easyuiTheme' rel='stylesheet' type='text/css' />"
				+ "<link href='plug-in/easyui/themes/icon.css' rel='stylesheet' type='text/css' />"
				+ "<link href='plug-in/accordion/css/accordion.css' rel='stylesheet' type='text/css' />"
				+ "<link href='plug-in/Validform/css/style.css' rel='stylesheet' type='text/css' />"
				+ "<link href='plug-in/Validform/css/tablefrom.css' rel='stylesheet' type='text/css' />"
				+ "<style type='text/css'>body{font-size:12px;}table {border:1px solid #000000;border-collapse: collapse;}"
				+ "td {border:1px solid #000000;background:white;font-size:12px;font-family: 新宋体;color: #333;</style></head>"
				+ "<body><div><p>附件2：</p><h1 style='text-align:center'>"
				+ "<span style='font-size:24px'><strong>价格认证人员统计表</strong></span>"
				+ "</h1><p>填报单位（盖章）：<input name='org_name' type='text' value='${org_name?if_exists?html}' /></p>"
				+ "<p>单位代码号：<input name='num' type='text' value='${num?if_exists?html}' /> "
				+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ "&nbsp;&nbsp;单位：人填&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ "&nbsp;&nbsp;&nbsp; 报日期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年&nbsp;&nbsp; 月&nbsp;&nbsp; 日</p><"
				+ "form action='cgFormBuildController.do?saveOrUpdate' id='formobj' method='post' name='formobj'>"
				+ "<input name='tableName' type='hidden' value='${tableName?if_exists?html}' /> "
				+ "<input name='id' type='hidden' value='${id?if_exists?html}' />#{jform_hidden_field}<input type='hidden' />"
				+ "<p>&nbsp;</p><table border='1' cellpadding='0' cellspacing='0' style='width:1016px'>"
				+ "<tbody><tr><td rowspan='4'><p>&nbsp;</p><p>&nbsp;</p><p>合计</p><p>&nbsp;</p></td>"
				+ "<td colspan='6' rowspan='2'><p>&nbsp;</p><p>人数</p></td><td colspan='5' rowspan='2'>"
				+ "<p>&nbsp;</p><p>学历</p></td><td colspan='4' rowspan='2'><p>&nbsp;</p><p>取得的（上岗）执业资格</p>"
				+ "</td><td colspan='4'><p>专业技术职称</p></td></tr><tr><td colspan='4'><p>（经济系列、工程系列）</p>"
				+ "</td></tr><tr><td colspan='3'><p>在编人员</p></td><td colspan='2'><p>聘用人员</p></td><td rowspan='2'>"
				+ "<p>临时(借用)人员</p></td><td rowspan='2'><p>高中</p></td><td rowspan='2'><p>大专</p></td><td rowspan='2'>"
				+ "<p>本科</p></td><td rowspan='2'><p>研究生</p></td><td rowspan='2'><p>其它</p></td><td rowspan='2'><p>价格</p>"
				+ "<p>鉴证员</p></td><td rowspan='2'><p>价格</p><p>鉴证师</p></td><td rowspan='2'><p>复核</p><p>裁定员</p></td>"
				+ "<td rowspan='2'><p>其它</p></td><td rowspan='2'><p>初级</p></td><td rowspan='2'><p>中级</p></td><td rowspan='2'>"
				+ "<p>高级</p></td><td rowspan='2'><p>其它</p></td></tr><tr><td><p>本单位</p></td><td colspan='2'><p>其它</p></td>"
				+ "<td><p>长期</p></td><td><p>短期</p></td></tr><tr><td><p>A1</p></td><td><p>B1</p></td><td><p>B2</p></td>"
				+ "<td colspan='2'><p>B3</p></td><td><p>B4</p></td><td><p>B5</p></td><td><p>C1</p></td><td><p>C2</p></td>"
				+ "<td><p>C3</p></td><td><p>C4</p></td><td><p>C5</p></td><td><p>D1</p></td><td><p>D2</p></td><td><p>D3</p>"
				+ "</td><td><p>D4</p></td><td><p>E1</p></td><td><p>E2</p></td><td><p>E3</p></td><td><p>E4</p></td></tr>"
				+ "<tr><td><p><input name='a1' size='4' type='text' value='${a1?if_exists?html}' /></p></td><td>"
				+ "<p><input name='b1' size='4' type='text' value='${b1?if_exists?html}' /></p></td><td><p>"
				+ "<input name='b2' size='4' type='text' value='${b2?if_exists?html}' /></p></td><td colspan='2'><p>"
				+ "<input name='b3' size='4' type='text' value='${b3?if_exists?html}' /></p></td><td><p>"
				+ "<input name='b4' size='4' type='text' value='${b4?if_exists?html}' /></p></td><td><p>"
				+ "<input name='b5' size='4' type='text' value='${b5?if_exists?html}' /></p></td><td><p>"
				+ "<input name='c1' size='4' type='text' value='${c1?if_exists?html}' /></p></td><td><p>"
				+ "<input name='c2' size='4' type='text' value='${c2?if_exists?html}' /></p></td><td><p>"
				+ "<input name='c3' size='4' type='text' value='${c3?if_exists?html}' /></p></td><td><p>"
				+ "<input name='c4' size='4' type='text' value='${c4?if_exists?html}' /></p></td><td><p>"
				+ "<input name='c5' size='4' type='text' value='${c5?if_exists?html}' /></p></td><td><p>"
				+ "<input name='d1' size='4' type='text' value='${d1?if_exists?html}' /></p></td><td><p>"
				+ "<input name='d2' size='4' type='text' value='${d2?if_exists?html}' /></p></td><td><p>"
				+ "<input name='d3' size='4' type='text' value='${d3?if_exists?html}' /></p></td><td><p>"
				+ "<input name='d4' size='4' type='text' value='${d4?if_exists?html}' /></p></td><td><p>"
				+ "<input name='e1' size='4' type='text' value='${e1?if_exists?html}' /></p></td><td><p>"
				+ "<input name='e2' size='4' type='text' value='${e2?if_exists?html}' /></p></td><td><p>"
				+ "<input name='e3' size='4' type='text' value='${e3?if_exists?html}' /></p></td><td><p>"
				+ "<input name='e4' size='4' type='text' value='${e4?if_exists?html}' /></p></td></tr>"
				+ "<tr><td colspan='20'><p>&nbsp;</p><p>填报说明：</p><p>一、合计（A）：填报至统计截止期的本机构的人员总数。</p>"
				+ "<p>二、人数：</p><p>在编人员：分别按照价格认证机构编制内及其它具有价格主管部门编制的实有人数填报在B1、B2栏内。"
				+ "</p><p>聘用人员：按照经价格主管部门或价格认证机构人事部门认可的并签订三年以上的工作合同的人员（B3）；以及没有经过价"
				+ "格主管部门或价格认证机构人事部门认可的签订合同少于三年的人员（B4）分别来进行统计。</p><p>临时（借用）人员（B5）：特指"
				+ "外聘的临时工，或者工作关系不在本单位且无长期聘用合同的借调人员等。</p><p>三、表内各栏目关系</p><p>A=B1+B2+B3+B4+B5=C1+"
				+ "C2+C3+C4+C5=D1+D2+D3+D4=E1+E2+E3+E4</p></td></tr></tbody></table></form></div></body></html>";
		ckEditor.setContents(str.getBytes());
		commonDao.saveOrUpdate(ckEditor);
	}

	/**
	 * @Description 修复日志表
	 * @author tanghan 2013-7-28
	 */
	private void repairLog() {
		TSUser admin = commonDao.findByProperty(TSUser.class, "signatureFile",
				"images/renfang/qm/licf.gif").get(0);
		try {
			TSLog log1 = new TSLog();
			log1.setLogcontent("用户: admin登录成功");
			log1.setBroswer("Chrome");
			log1.setNote("169.254.200.136");
			log1.setTSUser(admin);
			log1.setOperatetime(DateUtils.parseTimestamp("2013-4-24 16:22:40",
					"yyyy-MM-dd HH:mm"));
			log1.setOperatetype((short) 1);
			log1.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log1);

			TSLog log2 = new TSLog();
			log2.setLogcontent("用户: admin登录成功");
			log2.setBroswer("Chrome");
			log2.setNote("10.10.10.1");
			log2.setTSUser(admin);
			log2.setOperatetime(DateUtils.parseTimestamp("2013-4-24 17:12:22",
					"yyyy-MM-dd HH:mm"));
			log2.setOperatetype((short) 1);
			log2.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log2);

			TSLog log3 = new TSLog();
			log3.setLogcontent("用户: admin登录成功");
			log3.setBroswer("Chrome");
			log3.setNote("169.254.218.201");
			log3.setTSUser(admin);
			log3.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:37:11",
					"yyyy-MM-dd HH:mm"));
			log3.setOperatetype((short) 1);
			log3.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log3);

			TSLog log4 = new TSLog();
			log4.setLogcontent("用户admin已退出");
			log4.setBroswer("Chrome");
			log4.setNote("169.254.218.201");
			log4.setTSUser(admin);
			log4.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:38:33",
					"yyyy-MM-dd HH:mm"));
			log4.setOperatetype((short) 1);
			log4.setLoglevel((short) 2);
			commonDao.saveOrUpdate(log4);

			TSLog log5 = new TSLog();
			log5.setLogcontent("用户: admin登录成功");
			log5.setBroswer("MSIE 9.0");
			log5.setNote("169.254.218.201");
			log5.setTSUser(admin);
			log5.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:38:42",
					"yyyy-MM-dd HH:mm"));
			log5.setOperatetype((short) 1);
			log5.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log5);

			TSLog log6 = new TSLog();
			log6.setLogcontent("JeecgDemo例子: 12被删除 成功");
			log6.setBroswer("MSIE 9.0");
			log6.setNote("169.254.218.201");
			log6.setTSUser(admin);
			log6.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:00",
					"yyyy-MM-dd HH:mm"));
			log6.setOperatetype((short) 1);
			log6.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log6);

			TSLog log7 = new TSLog();
			log7.setLogcontent("JeecgDemo例子: 12被删除 成功");
			log7.setBroswer("MSIE 9.0");
			log7.setNote("169.254.218.201");
			log7.setTSUser(admin);
			log7.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:02",
					"yyyy-MM-dd HH:mm"));
			log7.setOperatetype((short) 1);
			log7.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log7);

			TSLog log8 = new TSLog();
			log8.setLogcontent("JeecgDemo例子: 12被删除 成功");
			log8.setBroswer("Chrome");
			log8.setNote("169.254.218.201");
			log8.setTSUser(admin);
			log8.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:04",
					"yyyy-MM-dd HH:mm"));
			log8.setOperatetype((short) 1);
			log8.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log8);

			TSLog log9 = new TSLog();
			log9.setLogcontent("权限: 单表模型被更新成功");
			log9.setBroswer("MSIE 9.0");
			log9.setNote("169.254.218.201");
			log9.setTSUser(admin);
			log9.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:30",
					"yyyy-MM-dd HH:mm"));
			log9.setOperatetype((short) 1);
			log9.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log9);

			TSLog log10 = new TSLog();
			log10.setLogcontent("删除成功");
			log10.setBroswer("Chrome");
			log10.setNote("169.254.218.201");
			log10.setTSUser(admin);
			log10.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:38",
					"yyyy-MM-dd HH:mm"));
			log10.setOperatetype((short) 1);
			log10.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log10);

			TSLog log11 = new TSLog();
			log11.setLogcontent("删除成功");
			log11.setBroswer("MSIE 9.0");
			log11.setNote("169.254.218.201");
			log11.setTSUser(admin);
			log11.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:40",
					"yyyy-MM-dd HH:mm"));
			log11.setOperatetype((short) 1);
			log11.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log11);

			TSLog log12 = new TSLog();
			log12.setLogcontent("删除成功");
			log12.setBroswer("Chrome");
			log12.setNote("169.254.218.201");
			log12.setTSUser(admin);
			log12.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:41",
					"yyyy-MM-dd HH:mm"));
			log12.setOperatetype((short) 1);
			log12.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log12);

			TSLog log13 = new TSLog();
			log13.setLogcontent("删除成功");
			log13.setBroswer("Firefox");
			log13.setNote("169.254.218.201");
			log13.setTSUser(admin);
			log13.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:39:42",
					"yyyy-MM-dd HH:mm"));
			log13.setOperatetype((short) 1);
			log13.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log13);

			TSLog log14 = new TSLog();
			log14.setLogcontent("添加成功");
			log14.setBroswer("Chrome");
			log14.setNote("169.254.218.201");
			log14.setTSUser(admin);
			log14.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:40:00",
					"yyyy-MM-dd HH:mm"));
			log14.setOperatetype((short) 1);
			log14.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log14);

			TSLog log15 = new TSLog();
			log15.setLogcontent("更新成功");
			log15.setBroswer("Chrome");
			log15.setNote("169.254.218.201");
			log15.setTSUser(admin);
			log15.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:40:04",
					"yyyy-MM-dd HH:mm"));
			log15.setOperatetype((short) 1);
			log15.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log15);

			TSLog log16 = new TSLog();
			log16.setLogcontent("JeecgDemo例子: 12被添加成功");
			log16.setBroswer("Chrome");
			log16.setNote("169.254.218.201");
			log16.setTSUser(admin);
			log16.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:40:44",
					"yyyy-MM-dd HH:mm"));
			log16.setOperatetype((short) 1);
			log16.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log16);

			TSLog log17 = new TSLog();
			log17.setLogcontent("部门: 信息部被更新成功");
			log17.setBroswer("Chrome");
			log17.setNote("169.254.218.201");
			log17.setTSUser(admin);
			log17.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:41:26",
					"yyyy-MM-dd HH:mm"));
			log17.setOperatetype((short) 1);
			log17.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log17);

			TSLog log18 = new TSLog();
			log18.setLogcontent("部门: 设计部被更新成功");
			log18.setBroswer("Chrome");
			log18.setNote("169.254.218.201");
			log18.setTSUser(admin);
			log18.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:41:38",
					"yyyy-MM-dd HH:mm"));
			log18.setOperatetype((short) 1);
			log18.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log18);

			TSLog log19 = new TSLog();
			log19.setLogcontent("类型: 信息部流程被更新成功");
			log19.setBroswer("Chrome");
			log19.setNote("169.254.218.201");
			log19.setTSUser(admin);
			log19.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:46:55",
					"yyyy-MM-dd HH:mm"));
			log19.setOperatetype((short) 1);
			log19.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log19);

			TSLog log20 = new TSLog();
			log20.setLogcontent("用户: admin登录成功");
			log20.setBroswer("Chrome");
			log20.setNote("169.254.218.201");
			log20.setTSUser(admin);
			log20.setOperatetime(DateUtils.parseTimestamp("2013-3-10 15:48:47",
					"yyyy-MM-dd HH:mm"));
			log20.setOperatetype((short) 1);
			log20.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log20);

			TSLog log21 = new TSLog();
			log21.setLogcontent("用户: admin登录成功");
			log21.setBroswer("Firefox");
			log21.setNote("169.254.218.201");
			log21.setTSUser(admin);
			log21.setOperatetime(DateUtils.parseTimestamp("2013-3-21 23:23:52",
					"yyyy-MM-dd HH:mm"));
			log21.setOperatetype((short) 1);
			log21.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log21);

			TSLog log22 = new TSLog();
			log22.setLogcontent("用户: admin登录成功");
			log22.setBroswer("Chrome");
			log22.setNote("169.254.218.201");
			log22.setTSUser(admin);
			log22.setOperatetime(DateUtils.parseTimestamp("2013-3-21 23:26:22",
					"yyyy-MM-dd HH:mm"));
			log22.setOperatetype((short) 1);
			log22.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log22);

			TSLog log23 = new TSLog();
			log23.setLogcontent("权限: 一对多实例被添加成功");
			log23.setBroswer("Chrome");
			log23.setNote("169.254.218.201");
			log23.setTSUser(admin);
			log23.setOperatetime(DateUtils.parseTimestamp("2013-3-21 23:28:34",
					"yyyy-MM-dd HH:mm"));
			log23.setOperatetype((short) 1);
			log23.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log23);

			TSLog log24 = new TSLog();
			log24.setLogcontent("用户: admin登录成功");
			log24.setBroswer("Chrome");
			log24.setNote("169.254.218.201");
			log24.setTSUser(admin);
			log24.setOperatetime(DateUtils.parseTimestamp("2013-3-22 8:25:07",
					"yyyy-MM-dd HH:mm"));
			log24.setOperatetype((short) 1);
			log24.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log24);

			TSLog log25 = new TSLog();
			log25.setLogcontent("用户: admin登录成功");
			log25.setBroswer("Firefox");
			log25.setNote("169.254.218.201");
			log25.setTSUser(admin);
			log25.setOperatetime(DateUtils.parseTimestamp("2013-3-22 9:05:25",
					"yyyy-MM-dd HH:mm"));
			log25.setOperatetype((short) 1);
			log25.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log25);

			TSLog log26 = new TSLog();
			log26.setLogcontent("用户: admin登录成功");
			log26.setBroswer("Chrome");
			log26.setNote("169.254.218.201");
			log26.setTSUser(admin);
			log26.setOperatetime(DateUtils.parseTimestamp("2013-3-22 9:09:05",
					"yyyy-MM-dd HH:mm"));
			log26.setOperatetype((short) 1);
			log26.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log26);

			TSLog log27 = new TSLog();
			log27.setLogcontent("用户: admin登录成功");
			log27.setBroswer("MSIE 8.0");
			log27.setNote("169.254.218.201");
			log27.setTSUser(admin);
			log27.setOperatetime(DateUtils.parseTimestamp("2013-3-22 9:28:50",
					"yyyy-MM-dd HH:mm"));
			log27.setOperatetype((short) 1);
			log27.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log27);

			TSLog log28 = new TSLog();
			log28.setLogcontent("用户: admin登录成功");
			log28.setBroswer("Firefox");
			log28.setNote("169.254.218.201");
			log28.setTSUser(admin);
			log28.setOperatetime(DateUtils.parseTimestamp("2013-3-22 10:32:59",
					"yyyy-MM-dd HH:mm"));
			log28.setOperatetype((short) 1);
			log28.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log28);

			TSLog log29 = new TSLog();
			log29.setLogcontent("物品: 笔记本添加成功");
			log29.setBroswer("Chrome");
			log29.setNote("169.254.218.201");
			log29.setTSUser(admin);
			log29.setOperatetime(DateUtils.parseTimestamp("2013-3-22 10:35:44",
					"yyyy-MM-dd HH:mm"));
			log29.setOperatetype((short) 1);
			log29.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log29);

			TSLog log30 = new TSLog();
			log30.setLogcontent("用户: admin登录成功");
			log30.setBroswer("Firefox");
			log30.setNote("169.254.218.201");
			log30.setTSUser(admin);
			log30.setOperatetime(DateUtils.parseTimestamp("2013-3-22 10:41:46",
					"yyyy-MM-dd HH:mm"));
			log30.setOperatetype((short) 1);
			log30.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log30);

			TSLog log31 = new TSLog();
			log31.setLogcontent("用户: admin登录成功");
			log31.setBroswer("Firefox");
			log31.setNote("169.254.218.201");
			log31.setTSUser(admin);
			log31.setOperatetime(DateUtils.parseTimestamp("2013-3-22 16:11:14",
					"yyyy-MM-dd HH:mm"));
			log31.setOperatetype((short) 1);
			log31.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log31);

			TSLog log32 = new TSLog();
			log32.setLogcontent("用户: admin登录成功");
			log32.setBroswer("Chrome");
			log32.setNote("169.254.218.201");
			log32.setTSUser(admin);
			log32.setOperatetime(DateUtils.parseTimestamp("2013-3-22 21:49:43",
					"yyyy-MM-dd HH:mm"));
			log32.setOperatetype((short) 1);
			log32.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log32);

			TSLog log33 = new TSLog();
			log33.setLogcontent("用户: admin登录成功");
			log33.setBroswer("Chrome");
			log33.setNote("169.254.218.201");
			log33.setTSUser(admin);
			log33.setOperatetime(DateUtils.parseTimestamp("2013-3-22 23:17:12",
					"yyyy-MM-dd HH:mm"));
			log33.setOperatetype((short) 1);
			log33.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log33);

			TSLog log34 = new TSLog();
			log34.setLogcontent("用户: admin登录成功");
			log34.setBroswer("Chrome");
			log34.setNote("169.254.218.201");
			log34.setTSUser(admin);
			log34.setOperatetime(DateUtils.parseTimestamp("2013-3-22 23:27:22",
					"yyyy-MM-dd HH:mm"));
			log34.setOperatetype((short) 1);
			log34.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log34);

			TSLog log35 = new TSLog();
			log35.setLogcontent("用户: admin登录成功");
			log35.setBroswer("Chrome");
			log35.setNote("169.254.218.201");
			log35.setTSUser(admin);
			log35.setOperatetime(DateUtils.parseTimestamp("2013-3-23 0:16:10",
					"yyyy-MM-dd HH:mm"));
			log35.setOperatetype((short) 1);
			log35.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log35);

			TSLog log36 = new TSLog();
			log36.setLogcontent("用户: admin登录成功");
			log36.setBroswer("Chrome");
			log36.setNote("169.254.218.201");
			log36.setTSUser(admin);
			log36.setOperatetime(DateUtils.parseTimestamp("2013-3-23 0:22:46",
					"yyyy-MM-dd HH:mm"));
			log36.setOperatetype((short) 1);
			log36.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log36);

			TSLog log37 = new TSLog();
			log37.setLogcontent("用户: admin登录成功");
			log37.setBroswer("Firefox");
			log37.setNote("169.254.218.201");
			log37.setTSUser(admin);
			log37.setOperatetime(DateUtils.parseTimestamp("2013-3-23 0:31:11",
					"yyyy-MM-dd HH:mm"));
			log37.setOperatetype((short) 1);
			log37.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log37);

			TSLog log38 = new TSLog();
			log38.setLogcontent("用户: admin登录成功");
			log38.setBroswer("Chrome");
			log38.setNote("169.254.218.201");
			log38.setTSUser(admin);
			log38.setOperatetime(DateUtils.parseTimestamp("2013-3-23 14:23:36",
					"yyyy-MM-dd HH:mm"));
			log38.setOperatetype((short) 1);
			log38.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log38);

			TSLog log39 = new TSLog();
			log39.setLogcontent("流程参数: 主任审批被添加成功");
			log39.setBroswer("Chrome");
			log39.setNote("169.254.218.201");
			log39.setTSUser(admin);
			log39.setOperatetime(DateUtils.parseTimestamp("2013-3-23 15:05:30",
					"yyyy-MM-dd HH:mm"));
			log39.setOperatetype((short) 1);
			log39.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log39);

			TSLog log40 = new TSLog();
			log40.setLogcontent("业务参数: 入职申请被添加成功");
			log40.setBroswer("Firefox");
			log40.setNote("169.254.218.201");
			log40.setTSUser(admin);
			log40.setOperatetime(DateUtils.parseTimestamp("2013-3-23 15:05:42",
					"yyyy-MM-dd HH:mm"));
			log40.setOperatetype((short) 1);
			log40.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log40);

			TSLog log41 = new TSLog();
			log41.setLogcontent("权限: 入职申请被添加成功");
			log41.setBroswer("Chrome");
			log41.setNote("169.254.218.201");
			log41.setTSUser(admin);
			log41.setOperatetime(DateUtils.parseTimestamp("2013-3-23 15:12:56",
					"yyyy-MM-dd HH:mm"));
			log41.setOperatetype((short) 1);
			log41.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log41);

			TSLog log42 = new TSLog();
			log42.setLogcontent("权限: 入职办理被添加成功");
			log42.setBroswer("Firefox");
			log42.setNote("169.254.218.201");
			log42.setTSUser(admin);
			log42.setOperatetime(DateUtils.parseTimestamp("2013-3-23 15:13:23",
					"yyyy-MM-dd HH:mm"));
			log42.setOperatetype((short) 1);
			log42.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log42);

			TSLog log43 = new TSLog();
			log43.setLogcontent("用户: admin登录成功");
			log43.setBroswer("Chrome");
			log43.setNote("10.10.10.1");
			log43.setTSUser(admin);
			log43.setOperatetime(DateUtils.parseTimestamp("2013-5-6 15:27:19",
					"yyyy-MM-dd HH:mm"));
			log43.setOperatetype((short) 1);
			log43.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log43);

			TSLog log44 = new TSLog();
			log44.setLogcontent("用户: admin登录成功");
			log44.setBroswer("MSIE 8.0");
			log44.setNote("192.168.197.1");
			log44.setTSUser(admin);
			log44.setOperatetime(DateUtils.parseTimestamp("2013-7-7 15:16:05",
					"yyyy-MM-dd HH:mm"));
			log44.setOperatetype((short) 1);
			log44.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log44);

			TSLog log45 = new TSLog();
			log45.setLogcontent("用户: admin登录成功");
			log45.setBroswer("MSIE 8.0");
			log45.setNote("192.168.197.1");
			log45.setTSUser(admin);
			log45.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:02:38",
					"yyyy-MM-dd HH:mm"));
			log45.setOperatetype((short) 1);
			log45.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log45);

			TSLog log46 = new TSLog();
			log46.setLogcontent("用户: admin登录成功");
			log46.setBroswer("MSIE 8.0");
			log46.setNote("192.168.197.1");
			log46.setTSUser(admin);
			log46.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:07:49",
					"yyyy-MM-dd HH:mm"));
			log46.setOperatetype((short) 1);
			log46.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log46);

			TSLog log47 = new TSLog();
			log47.setLogcontent("用户: admin登录成功");
			log47.setBroswer("MSIE 8.0");
			log47.setNote("192.168.197.1");
			log47.setTSUser(admin);
			log47.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:09:10",
					"yyyy-MM-dd HH:mm"));
			log47.setOperatetype((short) 1);
			log47.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log47);

			TSLog log48 = new TSLog();
			log48.setLogcontent("用户: admin登录成功");
			log48.setBroswer("MSIE 8.0");
			log48.setNote("192.168.197.1");
			log48.setTSUser(admin);
			log48.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:11:49",
					"yyyy-MM-dd HH:mm"));
			log48.setOperatetype((short) 1);
			log48.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log48);

			TSLog log49 = new TSLog();
			log49.setLogcontent("用户: admin登录成功");
			log49.setBroswer("MSIE 8.0");
			log49.setNote("192.168.197.1");
			log49.setTSUser(admin);
			log49.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:13:44",
					"yyyy-MM-dd HH:mm"));
			log49.setOperatetype((short) 1);
			log49.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log49);

			TSLog log50 = new TSLog();
			log50.setLogcontent("用户: admin登录成功");
			log50.setBroswer("MSIE 8.0");
			log50.setNote("192.168.197.1");
			log50.setTSUser(admin);
			log50.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:16:52",
					"yyyy-MM-dd HH:mm"));
			log50.setOperatetype((short) 1);
			log50.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log50);

			TSLog log51 = new TSLog();
			log51.setLogcontent("用户: admin登录成功");
			log51.setBroswer("MSIE 8.0");
			log51.setNote("192.168.197.1");
			log51.setTSUser(admin);
			log51.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:19:18",
					"yyyy-MM-dd HH:mm"));
			log51.setOperatetype((short) 1);
			log51.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log51);

			TSLog log52 = new TSLog();
			log52.setLogcontent("用户: admin登录成功");
			log52.setBroswer("MSIE 8.0");
			log52.setNote("192.168.197.1");
			log52.setTSUser(admin);
			log52.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:27:05",
					"yyyy-MM-dd HH:mm"));
			log52.setOperatetype((short) 1);
			log52.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log52);

			TSLog log53 = new TSLog();
			log53.setLogcontent("用户: admin登录成功");
			log53.setBroswer("MSIE 8.0");
			log53.setNote("192.168.197.1");
			log53.setTSUser(admin);
			log53.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:42:32",
					"yyyy-MM-dd HH:mm"));
			log53.setOperatetype((short) 1);
			log53.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log53);

			TSLog log54 = new TSLog();
			log54.setLogcontent("用户: admin登录成功");
			log54.setBroswer("MSIE 8.0");
			log54.setNote("192.168.197.1");
			log54.setTSUser(admin);
			log54.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:44:38",
					"yyyy-MM-dd HH:mm"));
			log54.setOperatetype((short) 1);
			log54.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log54);

			TSLog log55 = new TSLog();
			log55.setLogcontent("用户: admin登录成功");
			log55.setBroswer("MSIE 8.0");
			log55.setNote("192.168.197.1");
			log55.setTSUser(admin);
			log55.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:49:06",
					"yyyy-MM-dd HH:mm"));
			log55.setOperatetype((short) 1);
			log55.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log55);

			TSLog log56 = new TSLog();
			log56.setLogcontent("用户: admin登录成功");
			log56.setBroswer("MSIE 8.0");
			log56.setNote("192.168.197.1");
			log56.setTSUser(admin);
			log56.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:50:51",
					"yyyy-MM-dd HH:mm"));
			log56.setOperatetype((short) 1);
			log56.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log56);

			TSLog log57 = new TSLog();
			log57.setLogcontent("用户: admin登录成功");
			log57.setBroswer("MSIE 8.0");
			log57.setNote("192.168.197.1");
			log57.setTSUser(admin);
			log57.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:53:48",
					"yyyy-MM-dd HH:mm"));
			log57.setOperatetype((short) 1);
			log57.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log57);

			TSLog log58 = new TSLog();
			log58.setLogcontent("修改成功");
			log58.setBroswer("MSIE 8.0");
			log58.setNote("192.168.197.1");
			log58.setTSUser(admin);
			log58.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:56:45",
					"yyyy-MM-dd HH:mm"));
			log58.setOperatetype((short) 1);
			log58.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log58);

			TSLog log59 = new TSLog();
			log59.setLogcontent("用户: admin登录成功");
			log59.setBroswer("MSIE 8.0");
			log59.setNote("192.168.197.1");
			log59.setTSUser(admin);
			log59.setOperatetime(DateUtils.parseTimestamp("2013-7-7 16:59:22",
					"yyyy-MM-dd HH:mm"));
			log59.setOperatetype((short) 1);
			log59.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log59);

			TSLog log60 = new TSLog();
			log60.setLogcontent("创建成功");
			log60.setBroswer("MSIE 8.0");
			log60.setNote("192.168.197.1");
			log60.setTSUser(admin);
			log60.setOperatetime(DateUtils.parseTimestamp("2013-7-7 17:22:42",
					"yyyy-MM-dd HH:mm"));
			log60.setOperatetype((short) 1);
			log60.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log60);

			TSLog log61 = new TSLog();
			log61.setLogcontent("修改成功");
			log61.setBroswer("MSIE 8.0");
			log61.setNote("192.168.197.1");
			log61.setTSUser(admin);
			log61.setOperatetime(DateUtils.parseTimestamp("2013-7-7 17:26:03",
					"yyyy-MM-dd HH:mm"));
			log61.setOperatetype((short) 1);
			log61.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log61);

			TSLog log62 = new TSLog();
			log62.setLogcontent("删除成功");
			log62.setBroswer("MSIE 8.0");
			log62.setNote("192.168.197.1");
			log62.setTSUser(admin);
			log62.setOperatetime(DateUtils.parseTimestamp("2013-7-7 17:31:00",
					"yyyy-MM-dd HH:mm"));
			log62.setOperatetype((short) 1);
			log62.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log62);

			TSLog log63 = new TSLog();
			log63.setLogcontent("修改成功");
			log63.setBroswer("MSIE 8.0");
			log63.setNote("192.168.197.1");
			log63.setTSUser(admin);
			log63.setOperatetime(DateUtils.parseTimestamp("2013-7-7 17:35:02",
					"yyyy-MM-dd HH:mm"));
			log63.setOperatetype((short) 1);
			log63.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log63);

			TSLog log64 = new TSLog();
			log64.setLogcontent("用户: admin登录成功");
			log64.setBroswer("MSIE 8.0");
			log64.setNote("192.168.197.1");
			log64.setTSUser(admin);
			log64.setOperatetime(DateUtils.parseTimestamp("2013-7-7 17:46:39",
					"yyyy-MM-dd HH:mm"));
			log64.setOperatetype((short) 1);
			log64.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log64);

			TSLog log65 = new TSLog();
			log65.setLogcontent("用户: admin登录成功");
			log65.setBroswer("MSIE 8.0");
			log65.setNote("192.168.197.1");
			log65.setTSUser(admin);
			log65.setOperatetime(DateUtils.parseTimestamp("2013-7-7 17:55:01",
					"yyyy-MM-dd HH:mm"));
			log65.setOperatetype((short) 1);
			log65.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log65);

			TSLog log66 = new TSLog();
			log66.setLogcontent("用户: admin登录成功");
			log66.setBroswer("MSIE 8.0");
			log66.setNote("192.168.197.1");
			log66.setTSUser(admin);
			log66.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:08:56",
					"yyyy-MM-dd HH:mm"));
			log66.setOperatetype((short) 1);
			log66.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log66);

			TSLog log67 = new TSLog();
			log67.setLogcontent("用户: admin登录成功");
			log67.setBroswer("MSIE 8.0");
			log67.setNote("192.168.197.1");
			log67.setTSUser(admin);
			log67.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:13:02",
					"yyyy-MM-dd HH:mm"));
			log67.setOperatetype((short) 1);
			log67.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log67);

			TSLog log68 = new TSLog();
			log68.setLogcontent("用户: admin登录成功");
			log68.setBroswer("MSIE 8.0");
			log68.setNote("192.168.197.1");
			log68.setTSUser(admin);
			log68.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:15:50",
					"yyyy-MM-dd HH:mm"));
			log68.setOperatetype((short) 1);
			log68.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log68);

			TSLog log69 = new TSLog();
			log69.setLogcontent("修改成功");
			log69.setBroswer("MSIE 8.0");
			log69.setNote("192.168.197.1");
			log69.setTSUser(admin);
			log69.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:28:42",
					"yyyy-MM-dd HH:mm"));
			log69.setOperatetype((short) 1);
			log69.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log69);

			TSLog log70 = new TSLog();
			log70.setLogcontent("修改成功");
			log70.setBroswer("MSIE 8.0");
			log70.setNote("192.168.197.1");
			log70.setTSUser(admin);
			log70.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:29:12",
					"yyyy-MM-dd HH:mm"));
			log70.setOperatetype((short) 1);
			log70.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log70);

			TSLog log71 = new TSLog();
			log71.setLogcontent("修改成功");
			log71.setBroswer("MSIE 8.0");
			log71.setNote("192.168.197.1");
			log71.setTSUser(admin);
			log71.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:30:12",
					"yyyy-MM-dd HH:mm"));
			log71.setOperatetype((short) 1);
			log71.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log71);

			TSLog log72 = new TSLog();
			log72.setLogcontent("修改成功");
			log72.setBroswer("MSIE 8.0");
			log72.setNote("192.168.197.1");
			log72.setTSUser(admin);
			log72.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:31:00",
					"yyyy-MM-dd HH:mm"));
			log72.setOperatetype((short) 1);
			log72.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log72);

			TSLog log73 = new TSLog();
			log73.setLogcontent("修改成功");
			log73.setBroswer("MSIE 8.0");
			log73.setNote("192.168.197.1");
			log73.setTSUser(admin);
			log73.setOperatetime(DateUtils.parseTimestamp("2013-7-7 18:31:26",
					"yyyy-MM-dd HH:mm"));
			log73.setOperatetype((short) 1);
			log73.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log73);

			TSLog log74 = new TSLog();
			log74.setLogcontent("物品: 555添加成功");
			log74.setBroswer("MSIE 9.0");
			log74.setNote("192.168.1.103");
			log74.setTSUser(admin);
			log74.setOperatetime(DateUtils.parseTimestamp("2013-3-20 23:03:06",
					"yyyy-MM-dd HH:mm"));
			log74.setOperatetype((short) 1);
			log74.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log74);

			TSLog log75 = new TSLog();
			log75.setLogcontent("用户: admin登录成功");
			log75.setBroswer("MSIE 9.0");
			log75.setNote("192.168.1.103");
			log75.setTSUser(admin);
			log75.setOperatetime(DateUtils.parseTimestamp("2013-3-20 23:19:25",
					"yyyy-MM-dd HH:mm"));
			log75.setOperatetype((short) 1);
			log75.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log75);

			TSLog log76 = new TSLog();
			log76.setLogcontent("用户: admin登录成功");
			log76.setBroswer("MSIE 9.0");
			log76.setNote("192.168.1.103");
			log76.setTSUser(admin);
			log76.setOperatetime(DateUtils.parseTimestamp("2013-3-21 20:09:02",
					"yyyy-MM-dd HH:mm"));
			log76.setOperatetype((short) 1);
			log76.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log76);

			TSLog log77 = new TSLog();
			log77.setLogcontent("用户: admin登录成功");
			log77.setBroswer("MSIE 9.0");
			log77.setNote("192.168.1.103");
			log77.setTSUser(admin);
			log77.setOperatetime(DateUtils.parseTimestamp("2013-3-21 20:27:25",
					"yyyy-MM-dd HH:mm"));
			log77.setOperatetype((short) 1);
			log77.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log77);

			TSLog log78 = new TSLog();
			log78.setLogcontent("用户: admin登录成功");
			log78.setBroswer("MSIE 9.0");
			log78.setNote("192.168.1.103");
			log78.setTSUser(admin);
			log78.setOperatetime(DateUtils.parseTimestamp("2013-3-21 20:44:40",
					"yyyy-MM-dd HH:mm"));
			log78.setOperatetype((short) 1);
			log78.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log78);

			TSLog log79 = new TSLog();
			log79.setLogcontent("用户: admin登录成功");
			log79.setBroswer("MSIE 9.0");
			log79.setNote("192.168.1.103");
			log79.setTSUser(admin);
			log79.setOperatetime(DateUtils.parseTimestamp("2013-3-21 20:54:13",
					"yyyy-MM-dd HH:mm"));
			log79.setOperatetype((short) 1);
			log79.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log79);

			TSLog log80 = new TSLog();
			log80.setLogcontent("用户: admin登录成功");
			log80.setBroswer("MSIE 9.0");
			log80.setNote("192.168.1.103");
			log80.setTSUser(admin);
			log80.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:01:54",
					"yyyy-MM-dd HH:mm"));
			log80.setOperatetype((short) 1);
			log80.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log80);

			TSLog log81 = new TSLog();
			log81.setLogcontent("用户: admin登录成功");
			log81.setBroswer("MSIE 9.0");
			log81.setNote("192.168.1.103");
			log81.setTSUser(admin);
			log81.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:13:05",
					"yyyy-MM-dd HH:mm"));
			log81.setOperatetype((short) 1);
			log81.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log81);

			TSLog log82 = new TSLog();
			log82.setLogcontent("物品: 55添加成功");
			log82.setBroswer("MSIE 9.0");
			log82.setNote("192.168.1.103");
			log82.setTSUser(admin);
			log82.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:15:07",
					"yyyy-MM-dd HH:mm"));
			log82.setOperatetype((short) 1);
			log82.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log82);

			TSLog log83 = new TSLog();
			log83.setLogcontent("用户: admin登录成功");
			log83.setBroswer("MSIE 9.0");
			log83.setNote("192.168.1.103");
			log83.setTSUser(admin);
			log83.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:22:57",
					"yyyy-MM-dd HH:mm"));
			log83.setOperatetype((short) 1);
			log83.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log83);

			TSLog log84 = new TSLog();
			log84.setLogcontent("物品: 55添加成功");
			log84.setBroswer("MSIE 9.0");
			log84.setNote("192.168.1.103");
			log84.setTSUser(admin);
			log84.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:23:12",
					"yyyy-MM-dd HH:mm"));
			log84.setOperatetype((short) 1);
			log84.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log84);

			TSLog log85 = new TSLog();
			log85.setLogcontent("物品: 33添加成功");
			log85.setBroswer("MSIE 9.0");
			log85.setNote("192.168.1.103");
			log85.setTSUser(admin);
			log85.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:23:47",
					"yyyy-MM-dd HH:mm"));
			log85.setOperatetype((short) 1);
			log85.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log85);

			TSLog log86 = new TSLog();
			log86.setLogcontent("用户: admin登录成功");
			log86.setBroswer("MSIE 9.0");
			log86.setNote("192.168.1.103");
			log86.setTSUser(admin);
			log86.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:25:09",
					"yyyy-MM-dd HH:mm"));
			log86.setOperatetype((short) 1);
			log86.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log86);

			TSLog log87 = new TSLog();
			log87.setLogcontent("用户: admin登录成功");
			log87.setBroswer("MSIE 9.0");
			log87.setNote("192.168.1.103");
			log87.setTSUser(admin);
			log87.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:27:58",
					"yyyy-MM-dd HH:mm"));
			log87.setOperatetype((short) 1);
			log87.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log87);

			TSLog log88 = new TSLog();
			log88.setLogcontent("权限: 采购审批被添加成功");
			log88.setBroswer("MSIE 9.0");
			log88.setNote("192.168.1.103");
			log88.setTSUser(admin);
			log88.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:29:04",
					"yyyy-MM-dd HH:mm"));
			log88.setOperatetype((short) 1);
			log88.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log88);

			TSLog log89 = new TSLog();
			log89.setLogcontent("权限: 采购审批被更新成功");
			log89.setBroswer("MSIE 9.0");
			log89.setNote("192.168.1.103");
			log89.setTSUser(admin);
			log89.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:29:56",
					"yyyy-MM-dd HH:mm"));
			log89.setOperatetype((short) 1);
			log89.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log89);

			TSLog log90 = new TSLog();
			log90.setLogcontent("权限: 采购审批被更新成功");
			log90.setBroswer("MSIE 9.0");
			log90.setNote("192.168.1.103");
			log90.setTSUser(admin);
			log90.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:30:08",
					"yyyy-MM-dd HH:mm"));
			log90.setOperatetype((short) 1);
			log90.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log90);

			TSLog log91 = new TSLog();
			log91.setLogcontent("用户: admin更新成功");
			log91.setBroswer("MSIE 9.0");
			log91.setNote("192.168.1.103");
			log91.setTSUser(admin);
			log91.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:31:21",
					"yyyy-MM-dd HH:mm"));
			log91.setOperatetype((short) 1);
			log91.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log91);

			TSLog log92 = new TSLog();
			log92.setLogcontent("流程参数: 采购审批员审批被添加成功");
			log92.setBroswer("MSIE 9.0");
			log92.setNote("192.168.1.103");
			log92.setTSUser(admin);
			log92.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:36:03",
					"yyyy-MM-dd HH:mm"));
			log92.setOperatetype((short) 1);
			log92.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log92);

			TSLog log93 = new TSLog();
			log93.setLogcontent("流程参数: 采购审批员审批被更新成功");
			log93.setBroswer("MSIE 9.0");
			log93.setNote("192.168.1.103");
			log93.setTSUser(admin);
			log93.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:36:11",
					"yyyy-MM-dd HH:mm"));
			log93.setOperatetype((short) 1);
			log93.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log93);

			TSLog log94 = new TSLog();
			log94.setLogcontent("流程参数: 采购审批员审批被更新成功");
			log94.setBroswer("MSIE 9.0");
			log94.setNote("192.168.1.103");
			log94.setTSUser(admin);
			log94.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:37:16",
					"yyyy-MM-dd HH:mm"));
			log94.setOperatetype((short) 1);
			log94.setLoglevel((short) 5);
			commonDao.saveOrUpdate(log94);

			TSLog log95 = new TSLog();
			log95.setLogcontent("流程类别: 采购审批员审批被删除 成功");
			log95.setBroswer("MSIE 9.0");
			log95.setNote("192.168.1.103");
			log95.setTSUser(admin);
			log95.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:38:20",
					"yyyy-MM-dd HH:mm"));
			log95.setOperatetype((short) 1);
			log95.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log95);

			TSLog log96 = new TSLog();
			log96.setLogcontent("物品: 44添加成功");
			log96.setBroswer("MSIE 9.0");
			log96.setNote("192.168.1.103");
			log96.setTSUser(admin);
			log96.setOperatetime(DateUtils.parseTimestamp("2013-3-21 21:43:51",
					"yyyy-MM-dd HH:mm"));
			log96.setOperatetype((short) 1);
			log96.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log96);

			TSLog log97 = new TSLog();
			log97.setLogcontent("用户: admin登录成功");
			log97.setBroswer("MSIE 9.0");
			log97.setNote("192.168.1.105");
			log97.setTSUser(admin);
			log97.setOperatetime(DateUtils.parseTimestamp("2013-2-7 10:10:29",
					"yyyy-MM-dd HH:mm"));
			log97.setOperatetype((short) 1);
			log97.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log97);

			TSLog log98 = new TSLog();
			log98.setLogcontent("权限: 上传下载被添加成功");
			log98.setBroswer("MSIE 9.0");
			log98.setNote("192.168.1.105");
			log98.setTSUser(admin);
			log98.setOperatetime(DateUtils.parseTimestamp("2013-2-7 11:07:26",
					"yyyy-MM-dd HH:mm"));
			log98.setOperatetype((short) 1);
			log98.setLoglevel((short) 3);
			commonDao.saveOrUpdate(log98);

			TSLog log99 = new TSLog();
			log99.setLogcontent("权限: 插件演示被删除成功");
			log99.setBroswer("MSIE 9.0");
			log99.setNote("192.168.1.105");
			log99.setTSUser(admin);
			log99.setOperatetime(DateUtils.parseTimestamp("2013-2-7 11:07:39",
					"yyyy-MM-dd HH:mm"));
			log99.setOperatetype((short) 1);
			log99.setLoglevel((short) 4);
			commonDao.saveOrUpdate(log99);

			TSLog log100 = new TSLog();
			log100.setLogcontent("用户: admin登录成功");
			log100.setBroswer("MSIE 9.0");
			log100.setNote("192.168.1.105");
			log100.setTSUser(admin);
			log100.setOperatetime(DateUtils.parseTimestamp("2013-2-7 11:07:54",
					"yyyy-MM-dd HH:mm"));
			log100.setOperatetype((short) 1);
			log100.setLoglevel((short) 1);
			commonDao.saveOrUpdate(log100);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @Description 修复Demo表，（界面表单验证功能）
	 * @author tanghan 2013-7-23
	 */
	private void repairDemo() {
		TSDemo demo = new TSDemo();
		// -------------------------------------------------
		// 复杂字符串文本读取，采用文件方式存储
		String html = new FreemarkerHelper().parseTemplate("/org/jeecgframework/web/system/txt/valid-code-demo.ftl", null);
		// -------------------------------------------------
		demo.setDemocode(html);
		demo.setDemotitle("表单验证");
		commonDao.saveOrUpdate(demo);

	}

	/**
	 * @Description 修复User表
	 * @author tanghan 2013-7-23
	 */
	private void repairUser() {
		TSDepart eiu = commonDao.findByProperty(TSDepart.class, "departname",
				"信息部").get(0);
		TSDepart RAndD = commonDao.findByProperty(TSDepart.class, "departname",
				"研发室").get(0);
		TSUser admin = new TSUser();
		admin.setSignatureFile("images/renfang/qm/licf.gif");
		admin.setStatus((short) 1);
		admin.setRealName("管理员");
		admin.setUserName("admin");
		admin.setPassword("c44b01947c9e6e3f");
//		admin.setTSDepart(eiu);
		admin.setActivitiSync((short) 1);
		commonDao.saveOrUpdate(admin);
        TSUserOrg adminUserOrg = new TSUserOrg();
        adminUserOrg.setTsUser(admin);
        adminUserOrg.setTsDepart(eiu);
        commonDao.save(adminUserOrg);

		TSUser scott = new TSUser();
		scott.setMobilePhone("13426432910");
		scott.setOfficePhone("7496661");
		scott.setEmail("zhangdaiscott@163.com");
		scott.setStatus((short) 1);
		scott.setRealName("张代浩");
		scott.setUserName("scott");
		scott.setPassword("97c07a884bf272b5");
//		scott.setTSDepart(RAndD);
		scott.setActivitiSync((short) 0);
		commonDao.saveOrUpdate(scott);
        TSUserOrg scottUserOrg = new TSUserOrg();
        scottUserOrg.setTsUser(scott);
        scottUserOrg.setTsDepart(eiu);
        commonDao.save(scottUserOrg);

		TSUser buyer = new TSUser();
		buyer.setStatus((short) 1);
		buyer.setRealName("采购员");
		buyer.setUserName("cgy");
		buyer.setPassword("f2322ec2fb9f40d1");
//		buyer.setTSDepart(eiu);
		buyer.setActivitiSync((short) 0);
		commonDao.saveOrUpdate(buyer);
        TSUserOrg buyerUserOrg = new TSUserOrg();
        buyerUserOrg.setTsUser(buyer);
        buyerUserOrg.setTsDepart(eiu);
        commonDao.save(buyerUserOrg);

		TSUser approver = new TSUser();
		approver.setStatus((short) 1);
		approver.setRealName("采购审批员");
		approver.setUserName("cgspy");
		approver.setPassword("a324509dc1a3089a");
//		approver.setTSDepart(eiu);
		approver.setActivitiSync((short) 1);
		commonDao.saveOrUpdate(approver);
        TSUserOrg approverUserOrg = new TSUserOrg();
        approverUserOrg.setTsUser(approver);
        approverUserOrg.setTsDepart(eiu);
        commonDao.save(approverUserOrg);
    }

	/**
	 * @Description 修复用户角色表
	 * @author tanghan 2013-7-23
	 */
	private void repairUserRole() {
		TSRole admin = commonDao.findByProperty(TSRole.class, "roleCode",
				"admin").get(0);
		TSRole manager = commonDao.findByProperty(TSRole.class, "roleCode",
				"manager").get(0);
		List<TSUser> user = commonDao.loadAll(TSUser.class);
		for (int i = 0; i < user.size(); i++) {
			if (user.get(i).getEmail() != null) {
				TSRoleUser roleuser = new TSRoleUser();
				roleuser.setTSUser(user.get(i));
				roleuser.setTSRole(manager);
				commonDao.saveOrUpdate(roleuser);
			} else {
				TSRoleUser roleuser = new TSRoleUser();
				roleuser.setTSUser(user.get(i));
				roleuser.setTSRole(admin);
				commonDao.saveOrUpdate(roleuser);
			}
			if (user.get(i).getSignatureFile() != null) {
				TSRoleUser roleuser = new TSRoleUser();
				roleuser.setTSUser(user.get(i));
				roleuser.setTSRole(admin);
				commonDao.saveOrUpdate(roleuser);
			}
		}

	}

	/**
	 * @Description 修复角色权限表
	 * @author tanghan 2013-7-23
	 */
	private void repairRoleFunction() {
		TSRole admin = commonDao.findByProperty(TSRole.class, "roleCode",
				"admin").get(0);
		TSRole manager = commonDao.findByProperty(TSRole.class, "roleCode",
				"manager").get(0);
		List<TSFunction> list = commonDao.loadAll(TSFunction.class);
		for (int i = 0; i < list.size(); i++) {
			TSRoleFunction adminroleFunction = new TSRoleFunction();
			TSRoleFunction managerFunction = new TSRoleFunction();
			adminroleFunction.setTSFunction(list.get(i));
			managerFunction.setTSFunction(list.get(i));
			adminroleFunction.setTSRole(admin);
			managerFunction.setTSRole(manager);
			if (list.get(i).getFunctionName().equals("Demo示例")) {
				adminroleFunction.setOperation("add,szqm,");
			}
			commonDao.saveOrUpdate(adminroleFunction);
			commonDao.saveOrUpdate(managerFunction);
		}
	}

	/**
	 * @Description 修复操作按钮表
	 * @author tanghan 2013-7-23
	 */
	private void repairOperation() {
		TSIcon back = commonDao.findByProperty(TSIcon.class, "iconName", "返回")
				.get(0);
		TSFunction function = commonDao.findByProperty(TSFunction.class,
				"functionName", "Demo示例").get(0);

		TSOperation add = new TSOperation();
		add.setOperationname("录入");
		add.setOperationcode("add");
		add.setTSIcon(back);
		add.setTSFunction(function);
		commonDao.saveOrUpdate(add);

		TSOperation edit = new TSOperation();
		edit.setOperationname("编辑");
		edit.setOperationcode("edit");
		edit.setTSIcon(back);
		edit.setTSFunction(function);
		commonDao.saveOrUpdate(edit);

		TSOperation del = new TSOperation();
		del.setOperationname("删除");
		del.setOperationcode("del");
		del.setTSIcon(back);
		del.setTSFunction(function);
		commonDao.saveOrUpdate(del);

		TSOperation szqm = new TSOperation();
		szqm.setOperationname("审核");
		szqm.setOperationcode("szqm");
		szqm.setTSIcon(back);
		szqm.setTSFunction(function);
		commonDao.saveOrUpdate(szqm);
	}

	/**
	 * @Description 修复类型分组表
	 * @author tanghan 2013-7-20
	 */
	private void repairTypeAndGroup() {
		TSTypegroup icontype = new TSTypegroup();
		icontype.setTypegroupname("图标类型");
		icontype.setTypegroupcode("icontype");
		commonDao.saveOrUpdate(icontype);

		TSTypegroup ordertype = new TSTypegroup();
		ordertype.setTypegroupname("订单类型");
		ordertype.setTypegroupcode("order");
		commonDao.saveOrUpdate(ordertype);

		TSTypegroup custom = new TSTypegroup();
		custom.setTypegroupname("客户类型");
		custom.setTypegroupcode("custom");
		commonDao.saveOrUpdate(custom);

		TSTypegroup servicetype = new TSTypegroup();
		servicetype.setTypegroupname("服务项目类型");
		servicetype.setTypegroupcode("service");
		commonDao.saveOrUpdate(servicetype);

		TSTypegroup searchMode = new TSTypegroup();
		searchMode.setTypegroupname("查询模式");
		searchMode.setTypegroupcode("searchmode");
		commonDao.saveOrUpdate(searchMode);

		TSTypegroup yesOrno = new TSTypegroup();
		yesOrno.setTypegroupname("逻辑条件");
		yesOrno.setTypegroupcode("yesorno");
		commonDao.saveOrUpdate(yesOrno);

		TSTypegroup fieldtype = new TSTypegroup();
		fieldtype.setTypegroupname("字段类型");
		fieldtype.setTypegroupcode("fieldtype");
		commonDao.saveOrUpdate(fieldtype);

		TSTypegroup datatable = new TSTypegroup();
		datatable.setTypegroupname("数据表");
		datatable.setTypegroupcode("database");
		commonDao.saveOrUpdate(datatable);

		TSTypegroup filetype = new TSTypegroup();
		filetype.setTypegroupname("文档分类");
		filetype.setTypegroupcode("fieltype");
		commonDao.saveOrUpdate(filetype);

		TSTypegroup sex = new TSTypegroup();
		sex.setTypegroupname("性别类");
		sex.setTypegroupcode("sex");
		commonDao.saveOrUpdate(sex);
	}

	/**
	 * @Description 修复类型表
	 * @author tanghan 2013-7-22
	 */
	private void repairType() {
		TSTypegroup icontype = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "图标类型").get(0);
		TSTypegroup ordertype = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "订单类型").get(0);
		TSTypegroup custom = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "客户类型").get(0);
		TSTypegroup servicetype = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "服务项目类型").get(0);
		TSTypegroup datatable = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "数据表").get(0);
		TSTypegroup filetype = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "文档分类").get(0);
		TSTypegroup sex = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "性别类").get(0);
		TSTypegroup searchmode = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "查询模式").get(0);
		TSTypegroup yesorno = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "逻辑条件").get(0);
		TSTypegroup fieldtype = commonDao.findByProperty(TSTypegroup.class,
				"typegroupname", "字段类型").get(0);

		TSType menu = new TSType();
		menu.setTypename("菜单图标");
		menu.setTypecode("2");
		menu.setTSTypegroup(icontype);
		commonDao.saveOrUpdate(menu);

		TSType systemicon = new TSType();
		systemicon.setTypename("系统图标");
		systemicon.setTypecode("1");
		systemicon.setTSTypegroup(icontype);
		commonDao.saveOrUpdate(systemicon);

		TSType file = new TSType();
		file.setTypename("附件");
		file.setTypecode("files");
		file.setTSTypegroup(filetype);
		commonDao.saveOrUpdate(file);

		TSType goodorder = new TSType();
		goodorder.setTypename("优质订单");
		goodorder.setTypecode("1");
		goodorder.setTSTypegroup(ordertype);
		commonDao.saveOrUpdate(goodorder);

		TSType general = new TSType();
		general.setTypename("普通订单");
		general.setTypecode("2");
		general.setTSTypegroup(ordertype);
		commonDao.saveOrUpdate(general);

		TSType sign = new TSType();
		sign.setTypename("签约客户");
		sign.setTypecode("1");
		sign.setTSTypegroup(custom);
		commonDao.saveOrUpdate(sign);

		TSType commoncustom = new TSType();
		commoncustom.setTypename("普通客户");
		commoncustom.setTypecode("2");
		commoncustom.setTSTypegroup(custom);
		commonDao.saveOrUpdate(commoncustom);

		TSType vipservice = new TSType();
		vipservice.setTypename("特殊服务");
		vipservice.setTypecode("1");
		vipservice.setTSTypegroup(servicetype);
		commonDao.saveOrUpdate(vipservice);

		TSType commonservice = new TSType();
		commonservice.setTypename("普通服务");
		commonservice.setTypecode("2");
		commonservice.setTSTypegroup(servicetype);
		commonDao.saveOrUpdate(commonservice);

		// TSType leave = new TSType();
		// leave.setTypename("请假流程");
		// leave.setTypecode("leave");
		// commonDao.saveOrUpdate(leave);

		TSType single = new TSType();
		single.setTypename("单条件查询");
		single.setTypecode("single");
		single.setTSTypegroup(searchmode);
		commonDao.saveOrUpdate(single);

		TSType group = new TSType();
		group.setTypename("范围查询");
		group.setTypecode("group");
		group.setTSTypegroup(searchmode);
		commonDao.saveOrUpdate(group);

		TSType yes = new TSType();
		yes.setTypename("是");
		yes.setTypecode("Y");
		yes.setTSTypegroup(yesorno);
		commonDao.saveOrUpdate(yes);

		TSType no = new TSType();
		no.setTypename("否");
		no.setTypecode("N");
		no.setTSTypegroup(yesorno);
		commonDao.saveOrUpdate(no);

		TSType type_integer = new TSType();
		type_integer.setTypename("Integer");
		type_integer.setTypecode("Integer");
		type_integer.setTSTypegroup(fieldtype);
		commonDao.saveOrUpdate(type_integer);

		TSType type_date = new TSType();
		type_date.setTypename("Date");
		type_date.setTypecode("Date");
		type_date.setTSTypegroup(fieldtype);
		commonDao.saveOrUpdate(type_date);

		TSType type_string = new TSType();
		type_string.setTypename("String");
		type_string.setTypecode("String");
		type_string.setTSTypegroup(fieldtype);
		commonDao.saveOrUpdate(type_string);

		TSType type_long = new TSType();
		type_long.setTypename("Long");
		type_long.setTypecode("Long");
		type_long.setTSTypegroup(fieldtype);
		commonDao.saveOrUpdate(type_long);

		TSType workflow = new TSType();
		workflow.setTypename("工作流引擎表");
		workflow.setTypecode("act");
		workflow.setTSTypegroup(datatable);
		commonDao.saveOrUpdate(workflow);

		TSType systable = new TSType();
		systable.setTypename("系统基础表");
		systable.setTypecode("t_s");
		systable.setTSTypegroup(datatable);
		commonDao.saveOrUpdate(systable);

		TSType business = new TSType();
		business.setTypename("业务表");
		business.setTypecode("t_b");
		business.setTSTypegroup(datatable);
		commonDao.saveOrUpdate(business);

		TSType customwork = new TSType();
		customwork.setTypename("自定义引擎表");
		customwork.setTypecode("t_p");
		customwork.setTSTypegroup(datatable);
		commonDao.saveOrUpdate(customwork);

		TSType news = new TSType();
		news.setTypename("新闻");
		news.setTypecode("news");
		news.setTSTypegroup(filetype);
		commonDao.saveOrUpdate(news);

		TSType man = new TSType();
		man.setTypename("男性");
		man.setTypecode("0");
		man.setTSTypegroup(sex);
		commonDao.saveOrUpdate(man);

		TSType woman = new TSType();
		woman.setTypename("女性");
		woman.setTypecode("1");
		woman.setTSTypegroup(sex);
		commonDao.saveOrUpdate(woman);
	}

	/**
	 * @Description 修复角色表
	 * @author tanghan 2013-7-20
	 */
	private void repairRole() {
		TSRole admin = new TSRole();
		admin.setRoleName("管理员");
		admin.setRoleCode("admin");
		commonDao.saveOrUpdate(admin);

		TSRole manager = new TSRole();
		manager.setRoleName("普通用户");
		manager.setRoleCode("manager");
		commonDao.saveOrUpdate(manager);

	}

	/**
	 * @Description 修复部门表
	 * @author tanghan 2013-7-20
	 */
	private void repairDepart() {
		TSDepart eiu = new TSDepart();
		eiu.setDepartname("信息部");
		eiu.setDescription("12");
		commonDao.saveOrUpdate(eiu);

		TSDepart desgin = new TSDepart();
		desgin.setDepartname("设计部");
		commonDao.saveOrUpdate(desgin);

		TSDepart RAndD = new TSDepart();
		RAndD.setDepartname("研发室");
		RAndD.setDescription("研发技术难题");
		RAndD.setTSPDepart(desgin);
		commonDao.saveOrUpdate(RAndD);
	}

	/**
	 * @Description 修复附件表
	 * @author tanghan 2013-7-20
	 */
	private void repairAttachment() {
		TSAttachment jro = new TSAttachment();
		jro.setAttachmenttitle("JR079839867R90000001000");
		jro.setRealpath("JR079839867R90000001000");
		jro.setSwfpath("upload/files/20130719201109hDr31jP1.swf");
		jro.setExtend("doc");
		commonDao.saveOrUpdate(jro);

		TSAttachment treaty = new TSAttachment();
		treaty.setAttachmenttitle("JEECG平台协议");
		treaty.setRealpath("JEECG平台协议");
		treaty.setSwfpath("upload/files/20130719201156sYHjSFJj.swf");
		treaty.setExtend("docx");
		commonDao.saveOrUpdate(treaty);

		TSAttachment analyse = new TSAttachment();
		analyse.setAttachmenttitle("分析JEECG与其他的开源项目的不足和优势");
		analyse.setRealpath("分析JEECG与其他的开源项目的不足和优势");
		analyse.setSwfpath("upload/files/20130719201727ZLEX1OSf.swf");
		analyse.setExtend("docx");
		commonDao.saveOrUpdate(analyse);

		TSAttachment DMS = new TSAttachment();
		DMS.setAttachmenttitle("DMS-T3第三方租赁业务接口开发说明");
		DMS.setRealpath("DMS-T3第三方租赁业务接口开发说明");
		DMS.setSwfpath("upload/files/20130719201841LzcgqUek.swf");
		DMS.setExtend("docx");
		commonDao.saveOrUpdate(DMS);

		TSAttachment sap = new TSAttachment();
		sap.setAttachmenttitle("SAP-需求说明书-金融服务公司-第三方租赁业务需求V1.7-研发");
		sap.setRealpath("SAP-需求说明书-金融服务公司-第三方租赁业务需求V1.7-研发");
		sap.setSwfpath("upload/files/20130719201925mkCrU47P.swf");
		sap.setExtend("doc");
		commonDao.saveOrUpdate(sap);

		TSAttachment standard = new TSAttachment();
		standard.setAttachmenttitle("JEECG团队开发规范");
		standard.setRealpath("JEECG团队开发规范");
		standard.setSwfpath("upload/files/20130724103633fvOTwNSV.swf");
		standard.setExtend("txt");
		commonDao.saveOrUpdate(standard);

		TSAttachment temple = new TSAttachment();
		temple.setAttachmenttitle("第一模板");
		temple.setRealpath("第一模板");
		temple.setSwfpath("upload/files/20130724104603pHDw4QUT.swf");
		temple.setExtend("doc");
		commonDao.saveOrUpdate(temple);

		TSAttachment githubhelp = new TSAttachment();
		githubhelp.setAttachmenttitle("github入门使用教程");
		githubhelp.setRealpath("github入门使用教程");
		githubhelp.setSwfpath("upload/files/20130704200345EakUH3WB.swf");
		githubhelp.setExtend("doc");
		commonDao.saveOrUpdate(githubhelp);

		TSAttachment githelp = new TSAttachment();
		githelp.setAttachmenttitle("github入门使用教程");
		githelp.setRealpath("github入门使用教程");
		githelp.setSwfpath("upload/files/20130704200651IE8wPdZ4.swf");
		githelp.setExtend("doc");
		commonDao.saveOrUpdate(githelp);

		TSAttachment settable = new TSAttachment();
		settable.setAttachmenttitle("（张代浩）-金融服务公司机构岗位职责与任职资格设置表(根据模板填写）");
		settable.setRealpath("（张代浩）-金融服务公司机构岗位职责与任职资格设置表(根据模板填写）");
		settable.setSwfpath("upload/files/20130704201022KhdRW1Gd.swf");
		settable.setExtend("xlsx");
		commonDao.saveOrUpdate(settable);

		TSAttachment eim = new TSAttachment();
		eim.setAttachmenttitle("EIM201_CN");
		eim.setRealpath("EIM201_CN");
		eim.setSwfpath("upload/files/20130704201046JVAkvvOt.swf");
		eim.setExtend("pdf");
		commonDao.saveOrUpdate(eim);

		TSAttachment github = new TSAttachment();
		github.setAttachmenttitle("github入门使用教程");
		github.setRealpath("github入门使用教程");
		github.setSwfpath("upload/files/20130704201116Z8NhEK57.swf");
		github.setExtend("doc");
		commonDao.saveOrUpdate(github);

		TSAttachment taghelp = new TSAttachment();
		taghelp.setAttachmenttitle("JEECGUI标签库帮助文档v3.2");
		taghelp.setRealpath("JEECGUI标签库帮助文档v3.2");
		taghelp.setSwfpath("upload/files/20130704201125DQg8hi2x.swf");
		taghelp.setExtend("pdf");
		commonDao.saveOrUpdate(taghelp);
	}

	/**
	 * @Description 修复图标表
	 * @author tanghan 2013-7-19
	 */
	private void repaireIcon() {
		org.jeecgframework.core.util.LogUtil.info("修复图标中");

		TSIcon defaultIcon = new TSIcon();
		defaultIcon.setIconName("默认图");
		defaultIcon.setIconType((short) 1);
		defaultIcon.setIconPath("plug-in/accordion/images/default.png");
		defaultIcon.setIconClas("default");
		defaultIcon.setExtend("png");
		commonDao.saveOrUpdate(defaultIcon);

		TSIcon back = new TSIcon();
		back.setIconName("返回");
		back.setIconType((short) 1);
		back.setIconPath("plug-in/accordion/images/back.png");
		back.setIconClas("back");
		back.setExtend("png");
		commonDao.saveOrUpdate(back);

		TSIcon pie = new TSIcon();

		pie.setIconName("饼图");
		pie.setIconType((short) 1);
		pie.setIconPath("plug-in/accordion/images/pie.png");
		pie.setIconClas("pie");
		pie.setExtend("png");
		commonDao.saveOrUpdate(pie);

		TSIcon pictures = new TSIcon();
		pictures.setIconName("图片");
		pictures.setIconType((short) 1);
		pictures.setIconPath("plug-in/accordion/images/pictures.png");
		pictures.setIconClas("pictures");
		pictures.setExtend("png");
		commonDao.saveOrUpdate(pictures);

		TSIcon pencil = new TSIcon();
		pencil.setIconName("笔");
		pencil.setIconType((short) 1);
		pencil.setIconPath("plug-in/accordion/images/pencil.png");
		pencil.setIconClas("pencil");
		pencil.setExtend("png");
		commonDao.saveOrUpdate(pencil);

		TSIcon map = new TSIcon();
		map.setIconName("地图");
		map.setIconType((short) 1);
		map.setIconPath("plug-in/accordion/images/map.png");
		map.setIconClas("map");
		map.setExtend("png");
		commonDao.saveOrUpdate(map);

		TSIcon group_add = new TSIcon();
		group_add.setIconName("组");
		group_add.setIconType((short) 1);
		group_add.setIconPath("plug-in/accordion/images/group_add.png");
		group_add.setIconClas("group_add");
		group_add.setExtend("png");
		commonDao.saveOrUpdate(group_add);

		TSIcon calculator = new TSIcon();
		calculator.setIconName("计算器");
		calculator.setIconType((short) 1);
		calculator.setIconPath("plug-in/accordion/images/calculator.png");
		calculator.setIconClas("calculator");
		calculator.setExtend("png");
		commonDao.saveOrUpdate(calculator);

		TSIcon folder = new TSIcon();
		folder.setIconName("文件夹");
		folder.setIconType((short) 1);
		folder.setIconPath("plug-in/accordion/images/folder.png");
		folder.setIconClas("folder");
		folder.setExtend("png");
		commonDao.saveOrUpdate(folder);
	}
    /**
     * 修复桌面默认图标
     * @param iconName 图标名称
     * @param iconLabelName 图标展示名称
     * @return 图标实体
     */
    private TSIcon repairInconForDesk(String iconName, String iconLabelName) {
        String iconPath = "plug-in/sliding/icon/" + iconName + ".png";
        TSIcon deskIncon = new TSIcon();
        deskIncon.setIconName(iconLabelName);
        deskIncon.setIconType((short) 3);
        deskIncon.setIconPath(iconPath);
        deskIncon.setIconClas("deskIcon");
        deskIncon.setExtend("png");
        commonDao.saveOrUpdate(deskIncon);

        return deskIncon;
    }

	/**
	 * @Description 修复菜单权限
	 * @author tanghan 2013-7-19
	 */
	private void repairMenu() {
		TSIcon defaultIcon = commonDao.findByProperty(TSIcon.class, "iconName", "默认图")
				.get(0);
		TSIcon group_add = commonDao.findByProperty(TSIcon.class, "iconName",
				"组").get(0);
		TSIcon pie = commonDao.findByProperty(TSIcon.class, "iconName", "饼图")
				.get(0);
		TSIcon folder = commonDao.findByProperty(TSIcon.class, "iconName",
				"文件夹").get(0);
		org.jeecgframework.core.util.LogUtil.info(defaultIcon.getIconPath());
		TSFunction autoinput = new TSFunction();
		autoinput.setFunctionName("Online 开发");
		autoinput.setFunctionUrl("");
		autoinput.setFunctionLevel((short) 0);
		autoinput.setFunctionOrder("1");
		autoinput.setTSIcon(folder);
		commonDao.saveOrUpdate(autoinput);

		TSFunction sys = new TSFunction();
		sys.setFunctionName("系统管理");
		sys.setFunctionUrl("");
		sys.setFunctionLevel((short) 0);
		sys.setFunctionOrder("5");
		sys.setTSIcon(group_add);
		commonDao.saveOrUpdate(sys);

		TSFunction state = new TSFunction();
		state.setFunctionName("统计查询");
		state.setFunctionUrl("");
		state.setFunctionLevel((short) 0);
		state.setFunctionOrder("3");
		state.setTSIcon(folder);
		commonDao.saveOrUpdate(state);

		TSFunction commondemo = new TSFunction();
		commondemo.setFunctionName("常用示例");
		commondemo.setFunctionUrl("");
		commondemo.setFunctionLevel((short) 0);
		commondemo.setFunctionOrder("8");
		commondemo.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(commondemo);

		TSFunction syscontrol = new TSFunction();
		syscontrol.setFunctionName("系统监控");
		syscontrol.setFunctionUrl("");
		syscontrol.setFunctionLevel((short) 0);
		syscontrol.setFunctionOrder("11");
		syscontrol.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(syscontrol);
		TSFunction user = new TSFunction();
		user.setFunctionName("用户管理");
		user.setFunctionUrl("userController.do?user");
		user.setFunctionLevel((short) 1);
		user.setFunctionOrder("5");
		user.setTSFunction(sys);
		user.setTSIcon(defaultIcon);
		user.setTSIconDesk(repairInconForDesk("Finder", "用户管理"));
		commonDao.saveOrUpdate(user);

		TSFunction role = new TSFunction();
		role.setFunctionName("角色管理");
		role.setFunctionUrl("roleController.do?role");
		role.setFunctionLevel((short) 1);
		role.setFunctionOrder("6");
		role.setTSFunction(sys);
		role.setTSIcon(defaultIcon);
		role.setTSIconDesk(repairInconForDesk("friendgroup", "角色管理"));
		commonDao.saveOrUpdate(role);

		TSFunction menu = new TSFunction();
		menu.setFunctionName("菜单管理");
		menu.setFunctionUrl("functionController.do?function");
		menu.setFunctionLevel((short) 1);
		menu.setFunctionOrder("7");
		menu.setTSFunction(sys);
		menu.setTSIcon(defaultIcon);
		menu.setTSIconDesk(repairInconForDesk("kaikai", "菜单管理"));
		commonDao.saveOrUpdate(menu);

		TSFunction typegroup = new TSFunction();
		typegroup.setFunctionName("数据字典");
		typegroup.setFunctionUrl("systemController.do?typeGroupList");
		typegroup.setFunctionLevel((short) 1);
		typegroup.setFunctionOrder("6");
		typegroup.setTSFunction(sys);
		typegroup.setTSIcon(defaultIcon);
		typegroup.setTSIconDesk(repairInconForDesk("friendnear", "数据字典"));
		commonDao.saveOrUpdate(typegroup);

		TSFunction icon = new TSFunction();
		icon.setFunctionName("图标管理");
		icon.setFunctionUrl("iconController.do?icon");
		icon.setFunctionLevel((short) 1);
		icon.setFunctionOrder("18");
		icon.setTSFunction(sys);
		icon.setTSIcon(defaultIcon);
        icon.setTSIconDesk(repairInconForDesk("kxjy", "图标管理"));
		commonDao.saveOrUpdate(icon);

		TSFunction depart = new TSFunction();
		depart.setFunctionName("部门管理");
		depart.setFunctionUrl("departController.do?depart");
		depart.setFunctionLevel((short) 1);
		depart.setFunctionOrder("22");
		depart.setTSFunction(sys);
		depart.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(depart);
		
		TSFunction territory = new TSFunction();
		territory.setFunctionName("地域管理");
		territory.setFunctionUrl("territoryController.do?territory");
		territory.setFunctionLevel((short) 1);
		territory.setFunctionOrder("22");
		territory.setTSFunction(sys);
		territory.setTSIcon(pie);
		commonDao.saveOrUpdate(territory);
		TSFunction useranalyse = new TSFunction();
		useranalyse.setFunctionName("用户分析");
		useranalyse.setFunctionUrl("logController.do?statisticTabs&isIframe");
		useranalyse.setFunctionLevel((short) 1);
		useranalyse.setFunctionOrder("17");
		useranalyse.setTSFunction(state);
		useranalyse.setTSIcon(pie);
		useranalyse.setTSIconDesk(repairInconForDesk("User", "用户分析"));
		commonDao.saveOrUpdate(useranalyse);
		TSFunction formconfig = new TSFunction();
		formconfig.setFunctionName("表单配置");
		formconfig.setFunctionUrl("cgFormHeadController.do?cgFormHeadList");
		formconfig.setFunctionLevel((short) 1);
		formconfig.setFunctionOrder("1");
		formconfig.setTSFunction(autoinput);
		formconfig.setTSIcon(defaultIcon);
		formconfig.setTSIconDesk(repairInconForDesk("Applications Folder", "表单配置"));
		commonDao.saveOrUpdate(formconfig);
		TSFunction formconfig1 = new TSFunction();
		formconfig1.setFunctionName("动态报表配置");
		formconfig1.setFunctionUrl("cgreportConfigHeadController.do?cgreportConfigHead");
		formconfig1.setFunctionLevel((short) 1);
		formconfig1.setFunctionOrder("2");
		formconfig1.setTSFunction(autoinput);
		formconfig1.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(formconfig1);
		TSFunction druid = new TSFunction();
		druid.setFunctionName("数据监控");
		druid.setFunctionUrl("dataSourceController.do?goDruid&isIframe");
		druid.setFunctionLevel((short) 1);
		druid.setFunctionOrder("11");
		druid.setTSFunction(syscontrol);
		druid.setTSIcon(defaultIcon);
        druid.setTSIconDesk(repairInconForDesk("Super Disk", "数据监控"));
		commonDao.saveOrUpdate(druid);

		TSFunction log = new TSFunction();
		log.setFunctionName("系统日志");
		log.setFunctionUrl("logController.do?log");
		log.setFunctionLevel((short) 1);
		log.setFunctionOrder("21");
		log.setTSFunction(syscontrol);
		log.setTSIcon(defaultIcon);
		log.setTSIconDesk(repairInconForDesk("fastsearch", "系统日志"));
		commonDao.saveOrUpdate(log);
		
		TSFunction timeTask = new TSFunction();
		timeTask.setFunctionName("定时任务");
		timeTask.setFunctionUrl("timeTaskController.do?timeTask");
		timeTask.setFunctionLevel((short) 1);
		timeTask.setFunctionOrder("21");
		timeTask.setTSFunction(syscontrol);
		timeTask.setTSIcon(defaultIcon);
		timeTask.setTSIconDesk(repairInconForDesk("Utilities", "定时任务"));
		commonDao.saveOrUpdate(timeTask);
		TSFunction formcheck = new TSFunction();
		formcheck.setFunctionName("表单验证");
		formcheck.setFunctionUrl("demoController.do?formTabs");
		formcheck.setFunctionLevel((short) 1);
		formcheck.setFunctionOrder("1");
		formcheck.setTSFunction(commondemo);
		formcheck.setTSIcon(defaultIcon);
		formcheck.setTSIconDesk(repairInconForDesk("qidianzhongwen", "表单验证"));
		commonDao.saveOrUpdate(formcheck);

		TSFunction demo = new TSFunction();
		demo.setFunctionName("Demo示例");
		demo.setFunctionUrl("jeecgDemoController.do?jeecgDemo");
		demo.setFunctionLevel((short) 1);
		demo.setFunctionOrder("2");
		demo.setTSFunction(commondemo);
		demo.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(demo);

		TSFunction minidao = new TSFunction();
		minidao.setFunctionName("Minidao例子");
		minidao.setFunctionUrl("jeecgMinidaoController.do?jeecgMinidao");
		minidao.setFunctionLevel((short) 1);
		minidao.setFunctionOrder("2");
		minidao.setTSFunction(commondemo);
		minidao.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(minidao);

		TSFunction onetable = new TSFunction();
		onetable.setFunctionName("单表模型");
		onetable.setFunctionUrl("jeecgNoteController.do?jeecgNote");
		onetable.setFunctionLevel((short) 1);
		onetable.setFunctionOrder("3");
		onetable.setTSFunction(commondemo);
		onetable.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(onetable);

		TSFunction onetoMany = new TSFunction();
		onetoMany.setFunctionName("一对多模型");
		onetoMany.setFunctionUrl("jeecgOrderMainController.do?jeecgOrderMain");
		onetoMany.setFunctionLevel((short) 1);
		onetoMany.setFunctionOrder("4");
		onetoMany.setTSFunction(commondemo);
		onetoMany.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(onetoMany);

		TSFunction excel = new TSFunction();
		excel.setFunctionName("Excel导入导出");
		excel.setFunctionUrl("courseController.do?course");
		excel.setFunctionLevel((short) 1);
		excel.setFunctionOrder("5");
		excel.setTSFunction(commondemo);
		excel.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(excel);

		TSFunction uploadownload = new TSFunction();
		uploadownload.setFunctionName("上传下载");
		uploadownload
				.setFunctionUrl("commonController.do?listTurn&turn=system/document/filesList");
		uploadownload.setFunctionLevel((short) 1);
		uploadownload.setFunctionOrder("6");
		uploadownload.setTSFunction(commondemo);
		uploadownload.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(uploadownload);
		
		TSFunction jqueryFileUpload = new TSFunction();
		jqueryFileUpload.setFunctionName("JqueryFileUpload示例");
		jqueryFileUpload.setFunctionUrl("fileUploadController.do?fileUploadSample&isIframe");
		jqueryFileUpload.setFunctionLevel((short) 1);
		jqueryFileUpload.setFunctionOrder("6");
		jqueryFileUpload.setTSFunction(commondemo);
		jqueryFileUpload.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(jqueryFileUpload);

		TSFunction nopaging = new TSFunction();
		nopaging.setFunctionName("无分页列表");
		nopaging.setFunctionUrl("userNoPageController.do?user");
		nopaging.setFunctionLevel((short) 1);
		nopaging.setFunctionOrder("7");
		nopaging.setTSIcon(defaultIcon);
		nopaging.setTSFunction(commondemo);
		commonDao.saveOrUpdate(nopaging);

		TSFunction jdbcdemo = new TSFunction();
		jdbcdemo.setFunctionName("jdbc示例");
		jdbcdemo.setFunctionUrl("jeecgJdbcController.do?jeecgJdbc");
		jdbcdemo.setFunctionLevel((short) 1);
		jdbcdemo.setFunctionOrder("8");
		jdbcdemo.setTSFunction(commondemo);
		jdbcdemo.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(jdbcdemo);
		
		TSFunction sqlsep = new TSFunction();
		sqlsep.setFunctionName("SQL分离");
		sqlsep.setFunctionUrl("jeecgJdbcController.do?dictParameter");
		sqlsep.setFunctionLevel((short) 1);
		sqlsep.setTSIcon(defaultIcon);
		sqlsep.setFunctionOrder("9");
		sqlsep.setTSFunction(commondemo);
		commonDao.saveOrUpdate(sqlsep);

		TSFunction dicttag = new TSFunction();
		dicttag.setFunctionName("字典标签");
		dicttag.setFunctionUrl("demoController.do?dictSelect");
		dicttag.setFunctionLevel((short) 1);
		dicttag.setFunctionOrder("10");
		dicttag.setTSFunction(commondemo);
		dicttag.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(dicttag);

		TSFunction demomaintain = new TSFunction();
		demomaintain.setFunctionName("表单弹出风格");
		demomaintain.setFunctionUrl("demoController.do?demoList");
		demomaintain.setFunctionLevel((short) 1);
		demomaintain.setFunctionOrder("11");
		demomaintain.setTSFunction(commondemo);
		demomaintain.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(demomaintain);

		TSFunction democlassify = new TSFunction();
		democlassify.setFunctionName("特殊布局");
		democlassify.setFunctionUrl("demoController.do?demoIframe");
		democlassify.setFunctionLevel((short) 1);
		democlassify.setFunctionOrder("12");
		democlassify.setTSFunction(commondemo);
		democlassify.setTSIcon(defaultIcon);
		democlassify.setTSIconDesk(repairInconForDesk("xiami", "特殊布局"));
		commonDao.saveOrUpdate(democlassify);

		TSFunction notag1 = new TSFunction();
		notag1.setFunctionName("单表例子(无Tag)");
		notag1.setFunctionUrl("jeecgEasyUIController.do?jeecgEasyUI");
		notag1.setFunctionLevel((short) 1);
		notag1.setFunctionOrder("13");
		notag1.setTSFunction(commondemo);
		notag1.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(notag1);

		TSFunction notag2 = new TSFunction();
		notag2.setFunctionName("一对多例子(无Tag)");
		notag2.setFunctionUrl("jeecgOrderMainNoTagController.do?jeecgOrderMainNoTag");
		notag2.setFunctionLevel((short) 1);
		notag2.setFunctionOrder("14");
		notag2.setTSFunction(commondemo);
		notag2.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(notag2);

		TSFunction htmledit = new TSFunction();
		htmledit.setFunctionName("HTML编辑器");
		htmledit.setFunctionUrl("jeecgDemoController.do?ckeditor&isIframe");
		htmledit.setFunctionLevel((short) 1);
		htmledit.setFunctionOrder("15");
		htmledit.setTSFunction(commondemo);
		htmledit.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(htmledit);

		TSFunction weboffice = new TSFunction();
		weboffice.setFunctionName("在线word(IE)");
		weboffice.setFunctionUrl("webOfficeController.do?webOffice");
		weboffice.setFunctionLevel((short) 1);
		weboffice.setFunctionOrder("16");
		weboffice.setTSFunction(commondemo);
		weboffice.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(weboffice);

		TSFunction Office = new TSFunction();
		Office.setFunctionName("WebOffice官方例子");
		Office.setFunctionUrl("webOfficeController.do?webOfficeSample&isIframe");
		Office.setFunctionLevel((short) 1);
		Office.setFunctionOrder("17");
		Office.setTSIcon(defaultIcon);
		Office.setTSFunction(commondemo);
		commonDao.saveOrUpdate(Office);

		TSFunction finance = new TSFunction();
		finance.setFunctionName("多附件管理");
		finance.setFunctionUrl("tFinanceController.do?tFinance");
		finance.setFunctionLevel((short) 1);
		finance.setFunctionOrder("18");
		finance.setTSFunction(commondemo);
		finance.setTSIcon(defaultIcon);
        finance.setTSIconDesk(repairInconForDesk("vadio", "多附件管理"));
		commonDao.saveOrUpdate(finance);

		TSFunction userdemo = new TSFunction();
		userdemo.setFunctionName("Datagrid手工Html");
		userdemo.setFunctionUrl("userController.do?userDemo");
		userdemo.setFunctionLevel((short) 1);
		userdemo.setFunctionOrder("19");
		userdemo.setTSFunction(commondemo);
		userdemo.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(userdemo);
		TSFunction matterBom = new TSFunction();
		matterBom.setFunctionName("物料Bom");
		matterBom.setFunctionUrl("jeecgMatterBomController.do?goList");
		matterBom.setFunctionLevel((short) 1);
		matterBom.setFunctionOrder("20");
		matterBom.setTSFunction(commondemo);
		matterBom.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(matterBom);
		TSFunction reportdemo = new TSFunction();
		reportdemo.setFunctionName("报表示例");
		reportdemo.setFunctionUrl("reportDemoController.do?studentStatisticTabs&isIframe");
		reportdemo.setFunctionLevel((short) 1);
		reportdemo.setFunctionOrder("21");
		reportdemo.setTSFunction(state);
		reportdemo.setTSIcon(pie);
		commonDao.saveOrUpdate(reportdemo);
		
		TSFunction ckfinder = new TSFunction();
		ckfinder.setFunctionName("ckfinder例子");
		ckfinder.setFunctionUrl("jeecgDemoCkfinderController.do?jeecgDemoCkfinder");
		ckfinder.setFunctionLevel((short) 1);
		ckfinder.setFunctionOrder("100");
		ckfinder.setTSFunction(commondemo);
		ckfinder.setTSIcon(defaultIcon);
		commonDao.saveOrUpdate(ckfinder);
	}

	/**
	 * 修复报表统计demo
	 *@Author fancq
	 *@date   2013-11-14
	 */
	private void repairReportEntity() {
		TSStudent entity=null;
		entity = new TSStudent();
		entity.setName("张三");
		entity.setSex("f");
		entity.setClassName("1班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("1班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("1班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("f");
		entity.setClassName("1班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("张三");
		entity.setSex("f");
		entity.setClassName("2班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("2班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("2班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("f");
		entity.setClassName("2班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("张三");
		entity.setSex("f");
		entity.setClassName("3班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("3班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("3班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("3班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("3班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("f");
		entity.setClassName("3班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("张三");
		entity.setSex("f");
		entity.setClassName("4班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("4班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("4班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("f");
		entity.setClassName("4班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("张三");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("李四");
		entity.setSex("f");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("王五");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
		entity = new TSStudent();
		entity.setName("赵六");
		entity.setSex("m");
		entity.setClassName("5班");
		commonDao.save(entity);
		
	}
}
