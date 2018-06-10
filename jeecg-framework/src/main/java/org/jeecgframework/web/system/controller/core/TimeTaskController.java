package org.jeecgframework.web.system.controller.core;
import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.client.ClientProtocolException;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.timer.DynamicTask;
import org.jeecgframework.core.util.HttpRequest;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSTimeTaskEntity;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.TimeTaskServiceI;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;


/**   
 * @Title: Controller
 * @Description: 定时任务管理
 * @author jueyue
 * @date 2013-09-21 20:47:43
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/timeTaskController")
public class TimeTaskController extends BaseController {

	@Autowired
	private TimeTaskServiceI timeTaskService;
	@Autowired(required=false)
	private DynamicTask dynamicTask;
	@Autowired
	private SystemService systemService;


	/**
	 * 定时任务管理列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "timeTask")
	public ModelAndView timeTask(HttpServletRequest request) {
		return new ModelAndView("system/timetask/timeTaskList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(TSTimeTaskEntity timeTask,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSTimeTaskEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, timeTask, request.getParameterMap());
		this.timeTaskService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除定时任务管理
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSTimeTaskEntity timeTask, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		timeTask = systemService.getEntity(TSTimeTaskEntity.class, timeTask.getId());
		if("1".equals(timeTask.getIsStart())){
			message = "任务运行中不能删除，请先停止任务";
		}else{
			message = "定时任务管理删除成功";
			timeTaskService.delete(timeTask);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);			
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加定时任务管理
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TSTimeTaskEntity timeTask, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();

		CronTriggerImpl trigger = new CronTriggerImpl();

		try {
			trigger.setCronExpression(timeTask.getCronExpression());
		} catch (ParseException e) {
			j.setMsg("Cron表达式错误");
			return j;
		}
		if (StringUtil.isNotEmpty(timeTask.getId())) {
			TSTimeTaskEntity t = timeTaskService.get(TSTimeTaskEntity.class, timeTask.getId());
			if ("1".equals(t.getIsStart())) {
				message = "任务运行中不可编辑，请先停止任务";
			}else{
				message = "定时任务管理更新成功";
				try {
					if(!timeTask.getCronExpression().equals(t.getCronExpression())){
						timeTask.setIsEffect("0");
					}
					MyBeanUtils.copyBeanNotNull2Bean(timeTask, t);
					timeTaskService.saveOrUpdate(t);
					systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
				} catch (Exception e) {
					e.printStackTrace();
					message = "定时任务管理更新失败";
				}
			}
			
		} else {
			message = "定时任务管理添加成功";
			timeTaskService.save(timeTask);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 定时任务管理列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TSTimeTaskEntity timeTask, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(timeTask.getId())) {
			timeTask = timeTaskService.getEntity(TSTimeTaskEntity.class, timeTask.getId());
			req.setAttribute("timeTaskPage", timeTask);
		}
		return new ModelAndView("system/timetask/timeTask");
	}
	
	/**
	 * 更新任务时间使之生效
	 */
	@RequestMapping(params = "updateTime")
	@ResponseBody
	public AjaxJson updateTime(TSTimeTaskEntity timeTask, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		boolean isUpdate = dynamicTask.updateCronExpression(timeTask);
		j.setMsg(isUpdate?"定时任务管理更新成功":"定时任务管理更新失败");
		return j;
	}
	
	/**
	 * 启动或者停止任务
	 */
	@RequestMapping(params = "startOrStopTask")
	@ResponseBody
	public AjaxJson startOrStopTask(TSTimeTaskEntity timeTask, HttpServletRequest request) {
		
		AjaxJson j = new AjaxJson();
		boolean isStart = timeTask.getIsStart().equals("1");
		timeTask = timeTaskService.get(TSTimeTaskEntity.class, timeTask.getId());		
		boolean isSuccess = false;
		
		if ("0".equals(timeTask.getIsEffect())) {
			j.setMsg("该任务为禁用状态，请解除禁用后重新启动");
			return j;
		}
		if (isStart && "1".equals(timeTask.getIsStart())) {
			j.setMsg("该任务当前已经启动，请停止后再试");
			return j;
		}
		if (!isStart && "0".equals(timeTask.getIsStart())) {
			j.setMsg("该任务当前已经停止，重复操作");
			return j;
		}
		//String serverIp = InetAddress.getLocalHost().getHostAddress();
		List<String> ipList = IpUtil.getLocalIPList();
		String runServerIp = timeTask.getRunServerIp();

		if((ipList.contains(runServerIp) || StringUtil.isEmpty(runServerIp) || "本地".equals(runServerIp)) && (runServerIp.equals(timeTask.getRunServer()))){//当前服务器IP匹配成功

			isSuccess = dynamicTask.startOrStop(timeTask ,isStart);	
		}else{
			try {
				String url = "http://"+timeTask.getRunServer()+"/timeTaskController.do?remoteTask";//spring-mvc.xml
				String param = "id="+timeTask.getId()+"&isStart="+(isStart ? "1" : "0");
				String jsonstr = HttpRequest.httpPost(url, param, false);
				if (null != jsonstr && jsonstr.length() > 0) {
					JSONObject json = (JSONObject) JSONObject.parse(jsonstr);
					isSuccess = json.getBooleanValue("success");
				}
			} catch (ClientProtocolException e) {
				j.setMsg("远程主机‘"+timeTask.getRunServer()+"’响应超时");
				return j;
			} catch (IOException e) {
				j.setMsg("远程主机‘"+timeTask.getRunServer()+"’响应超时");
				return j;
			}
		}		
		j.setMsg(isSuccess?"定时任务管理更新成功":"定时任务管理更新失败");
		return j;
	}
	
	
	/**
	 * 远程启动或者停止任务
	 */
	@RequestMapping(params = "remoteTask")
	@ResponseBody
	public JSONObject remoteTask(TSTimeTaskEntity timeTask, HttpServletRequest request) {
		
		JSONObject json = new JSONObject();
		boolean isStart = timeTask.getIsStart().equals("1");
		timeTask = timeTaskService.get(TSTimeTaskEntity.class, timeTask.getId());		
		boolean isSuccess = true;
		
		if ("0".equals(timeTask.getIsEffect())) {
			isSuccess = false;
		}else if (isStart && "1".equals(timeTask.getIsStart())) {
			isSuccess = false;
		}else if (!isStart && "0".equals(timeTask.getIsStart())) {
			isSuccess = false;
		}else{

			try {
				isSuccess = dynamicTask.startOrStop(timeTask ,isStart);
			} catch (Exception e) {
				e.printStackTrace();
				json.put("success", false);
				return json;
			}

		}
		json.put("success", isSuccess);
		return json;
	}

}
