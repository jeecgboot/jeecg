package org.jeecgframework.web.demo.controller.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.jeecgframework.web.demo.entity.test.CKEditorEntity;
import org.jeecgframework.web.demo.entity.test.JeecgDemo;
import org.jeecgframework.web.demo.entity.test.JeecgDemoPage;
import org.jeecgframework.web.demo.service.test.JeecgDemoServiceI;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.annotation.config.AutoMenu;
import org.jeecgframework.core.annotation.config.AutoMenuOperation;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller
 * @Description: 单表模型（DEMO）
 * @author 张代浩
 * @date 2013-01-23 17:12:40
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/jeecgDemoController")
@AutoMenu(name = "常用Demo", url = "jeecgDemoController.do?jeecgDemo")
public class JeecgDemoController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JeecgDemoController.class);

	@Autowired
	private JeecgDemoServiceI jeecgDemoService;
	@Autowired
	private SystemService systemService;
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	/**
	 * popup 例子
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "popup")
	public ModelAndView popup(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/jeecgDemo/popup");
	}
	/**
	 * popup 例子
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "selectUserList")
	public ModelAndView selectUserList(HttpServletRequest request) {
		String departsReplace = "";
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		for (TSDepart depart : departList) {
			if (departsReplace.length() > 0) {
				departsReplace += ",";
			}
			departsReplace += depart.getDepartname() + "_" + depart.getId();
		}
		request.setAttribute("departsReplace", departsReplace);
		return new ModelAndView("jeecg/demo/jeecgDemo/selectUserList");
	}
	
	/**
	 * ckeditor 例子
	 * 
	 * @return
	 */
	@RequestMapping(params = "ckeditor")
	public ModelAndView ckeditor(HttpServletRequest request) {
//		CKEditorEntity t = jeecgDemoService.get(CKEditorEntity.class, "1");
		CKEditorEntity t = jeecgDemoService.loadAll(CKEditorEntity.class).get(0);
		request.setAttribute("cKEditorEntity", t);
		if(t.getContents() == null ){
			request.setAttribute("contents", "");
		}else {
			request.setAttribute("contents", new String (t.getContents()));
		}
		return new ModelAndView("jeecg/demo/jeecgDemo/ckeditor");
	}
	/**
	 * ckeditor saveCkeditor
	 * 
	 * @return
	 */
	@RequestMapping(params = "saveCkeditor")
	@ResponseBody
	public AjaxJson saveCkeditor(HttpServletRequest request,CKEditorEntity cKEditor , String contents) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(cKEditor.getId())) {
			CKEditorEntity t =jeecgDemoService.get(CKEditorEntity.class, cKEditor.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(cKEditor, t);
				t.setContents(contents.getBytes());
				jeecgDemoService.saveOrUpdate(t);
				j.setMsg("更新成功");
			} catch (Exception e) {
				e.printStackTrace();
				j.setMsg("更新失败");
			}
		} else {
			cKEditor.setContents(contents.getBytes());
			jeecgDemoService.save(cKEditor);
		}
		return j;
	}

	/**
	 * JeecgDemo 打印预览跳转
	 * @param jeecgDemo
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "print")
	public ModelAndView print(JeecgDemo jeecgDemo, HttpServletRequest req) {
		// 获取部门信息
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);

		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemo.class, jeecgDemo
					.getId());
			req.setAttribute("jgDemo", jeecgDemo);
			if ("0".equals(jeecgDemo.getSex()))
				req.setAttribute("sex", "男");
			if ("1".equals(jeecgDemo.getSex()))
				req.setAttribute("sex", "女");
		}
		return new ModelAndView("jeecg/demo/jeecgDemo/jeecgDemoPrint");
	}

	/**
	 * JeecgDemo例子列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgDemo")
	public ModelAndView jeecgDemo(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/jeecgDemo/jeecgDemoList");
	}
	/**
	 * JeecgDemo例子列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgDemo2")
	public ModelAndView jeecgDemo2(HttpServletRequest request) {
		//request.setAttribute("sex", "1");
		request.setAttribute("status", "1");
		return new ModelAndView("jeecg/demo/jeecgDemo/jeecgDemoList2");
	}
	/**
	 * easyuiAJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(JeecgDemo jeecgDemo,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemo.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgDemo,request.getParameterMap());
		this.jeecgDemoService.getDataGridReturn(cq, true);
		String total_salary = String.valueOf(jeecgDemoService.findOneForJdbc("select sum(salary) as ssum from jeecg_demo").get("ssum"));
		/*
		 * 说明：格式为 字段名:值(可选，不写该值时为分页数据的合计) 多个合计 以 , 分割
		 */
		dataGrid.setFooter("salary:"+(total_salary.equalsIgnoreCase("null")?"0.0":total_salary)+",age,email:合计");
		TagUtil.datagrid(response, dataGrid);
	}

	@RequestMapping(params = "datagrid2")
	public void datagrid2(JeecgDemo jeecgDemo,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemo.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgDemo,request.getParameterMap());
		this.jeecgDemoService.getDataGridReturn(cq, true);
		//String total_salary = String.valueOf(jeecgDemoService.findOneForJdbc("select sum(salary) as ssum from jeecg_demo").get("ssum"));
		//request.setAttribute("maptest", "1");
		/*
		 * 说明：格式为 字段名:值(可选，不写该值时为分页数据的合计) 多个合计 以 , 分割
		 */
		//dataGrid.setFooter("salary:"+(total_salary.equalsIgnoreCase("null")?"0.0":total_salary)+",age,email:合计");
		
		TagUtil.datagrid(response, dataGrid);
	}
	/**
	 * 权限列表
	 */
	@RequestMapping(params = "combox")
	@ResponseBody
	public List<JeecgDemo> combox(HttpServletRequest request, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemo.class);
		List<JeecgDemo> ls = this.jeecgDemoService.getListByCriteriaQuery(cq, false);
		return ls;
	}
	/**
	 * 删除JeecgDemo例子
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(JeecgDemo jeecgDemo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		jeecgDemo = systemService.getEntity(JeecgDemo.class, jeecgDemo.getId());
		message = "JeecgDemo例子: " + jeecgDemo.getUserName() + "被删除 成功";
		jeecgDemoService.delete(jeecgDemo);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加JeecgDemo例子
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	@AutoMenuOperation(name="添加",code = "add")
	public AjaxJson save(JeecgDemo jeecgDemo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			message = "JeecgDemo例子: " + jeecgDemo.getUserName() + "被更新成功";
			JeecgDemo t =jeecgDemoService.get(JeecgDemo.class, jeecgDemo.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(jeecgDemo, t);
				jeecgDemoService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "JeecgDemo例子: " + jeecgDemo.getUserName() + "被添加成功";
			jeecgDemo.setStatus("0");
			jeecgDemoService.save(jeecgDemo);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		
		return j;
	}
	
	
	/**
	 * 审核报错
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(params = "saveAuthor")
	@ResponseBody
	public AjaxJson saveAuthor(JeecgDemo jeecgDemo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			message = "测试-用户申请成功";
			JeecgDemo t =jeecgDemoService.get(JeecgDemo.class, jeecgDemo.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(jeecgDemo, t);
				t.setStatus("1");
				jeecgDemoService.saveOrUpdate(t);
				j.setMsg(message);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return j;
	}

	/**
	 * JeecgDemo例子列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(JeecgDemo jeecgDemo, HttpServletRequest req) {
		//获取部门信息
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);
		
		Map sexMap = new HashMap();
		sexMap.put(0, "男");
		sexMap.put(1, "女");
		req.setAttribute("sexMap", sexMap);
		
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemo.class, jeecgDemo.getId());
			req.setAttribute("jgDemo", jeecgDemo);
		}
		return new ModelAndView("jeecg/demo/jeecgDemo/jeecgDemo");
	}

	/**
	 * JeecgDemo例子列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdatemobile")
	public ModelAndView addorupdatemobile(JeecgDemo jeecgDemo, HttpServletRequest req) {
		//获取部门信息
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);
		
		Map sexMap = new HashMap();
		sexMap.put(0, "男");
		sexMap.put(1, "女");
		req.setAttribute("sexMap", sexMap);
		
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemo.class, jeecgDemo.getId());
			req.setAttribute("jgDemo", jeecgDemo);
		}
		return new ModelAndView("jeecg/demo/jeecgDemo/jeecgDemomobile");
	}
	
	/**
	 * 设置签名跳转页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "doCheck")
	public ModelAndView doCheck(HttpServletRequest request) {
		String id = request.getParameter("id");
		request.setAttribute("id", id);
		if (StringUtil.isNotEmpty(id)) {
			JeecgDemo jeecgDemo = jeecgDemoService.getEntity(JeecgDemo.class,id);
			request.setAttribute("jeecgDemo", jeecgDemo);
		}
		return new ModelAndView("jeecg/demo/jeecgDemo/jeecgDemo-check");
	}

	/**
	 * 全选删除Demo实例管理
	 * 
	 * @return
	 * @author tanghan
	 * @date 2013-07-13 14:53:00
	 */
	@RequestMapping(params = "doDeleteALLSelect")
	@ResponseBody
	public AjaxJson doDeleteALLSelect(JeecgDemo jeecgDemo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String ids = request.getParameter("ids");
		String[] entitys = ids.split(",");
	    List<JeecgDemo> list = new ArrayList<JeecgDemo>();
		for(int i=0;i<entitys.length;i++){
			jeecgDemo = systemService.getEntity(JeecgDemo.class, entitys[i]);
            list.add(jeecgDemo);			
		}
		message = "删除成功";
		jeecgDemoService.deleteAllEntitie(list);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}
	@RequestMapping(params = "goDemo")
	public ModelAndView goDemo(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/jeecgDemo/"+request.getParameter("demoPage"));
	}

	/**
	 * 保存新增/更新的行数据
	 * @param page
	 * @return
	 */
	@RequestMapping(params = "saveRows")
	@ResponseBody
	public AjaxJson saveRows(JeecgDemoPage page){
		List<JeecgDemo> demos=page.getDemos();
		AjaxJson j = new AjaxJson();
		if(CollectionUtils.isNotEmpty(demos)){
			for(JeecgDemo jeecgDemo:demos){
				if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
					JeecgDemo t =jeecgDemoService.get(JeecgDemo.class, jeecgDemo.getId());
					try {
						message = "JeecgDemo例子: " + jeecgDemo.getUserName() + "被更新成功";
						MyBeanUtils.copyBeanNotNull2Bean(jeecgDemo, t);
						jeecgDemoService.saveOrUpdate(t);
						systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					message = "JeecgDemo例子: " + jeecgDemo.getUserName() + "被添加成功";
					jeecgDemo.setStatus("0");
					jeecgDemoService.save(jeecgDemo);
					systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
				}
			}
		}
		return j;
	}
}
