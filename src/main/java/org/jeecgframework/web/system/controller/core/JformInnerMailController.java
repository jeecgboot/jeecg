package org.jeecgframework.web.system.controller.core;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.common.UploadFile;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.manager.ClientManager;
import org.jeecgframework.web.system.pojo.base.JformInnerMailAttach;
import org.jeecgframework.web.system.pojo.base.JformInnerMailEntity;
import org.jeecgframework.web.system.pojo.base.JformInnerMailReceiverEntity;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.JformInnerMailServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



/**   
 * @Title: Controller
 * @Description: 内部邮件
 * @author onlineGenerator
 * @date 2016-03-12 14:43:11
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/jformInnerMailController")
public class JformInnerMailController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JformInnerMailController.class);

	@Autowired
	private JformInnerMailServiceI jformInnerMailService;
	@Autowired
	private SystemService systemService;


	/**
	 * 保存内部邮件
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doSave")
	@ResponseBody
	public AjaxJson doSave(JformInnerMailEntity jformInnerMail,HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "内部邮件添加成功";
		//更新
		try {
			if(!StringUtils.isEmpty(jformInnerMail.getId())){
				JformInnerMailEntity t = jformInnerMailService.get(JformInnerMailEntity.class, jformInnerMail.getId());
				MyBeanUtils.copyBeanNotNull2Bean(jformInnerMail, t);
				jformInnerMailService.saveOrUpdate(t);
			}
			//新增
			else{
				jformInnerMailService.save(jformInnerMail);
			}
			//更新收件人
			this.saveMailReceiver(jformInnerMail);
		} catch (Exception e) {
			e.printStackTrace();
			message = "内部邮件保存失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		j.setObj(jformInnerMail);
		return j;
	}
	
	/**
	 * 选择收件人跳转页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "receivers")
	public ModelAndView roles(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("system/mail/selectReceiver");
		String ids = oConvertUtils.getString(request.getParameter("ids"));
		mv.addObject("ids", ids);
		return mv;
	}
	
	/**保存邮件接收人信息
	 * 先删除原来的，再添加新的记录。
	 * @param mail
	 */
	protected void saveMailReceiver(JformInnerMailEntity mail) {
		String[] userids = mail.getReceiverIds().split(",");
		//先删除原来的邮件 收件人 记录
		systemService.deleteAllEntitie(systemService.findByProperty(JformInnerMailReceiverEntity.class, "JMail.id", mail.getId()));
		for (int i = 0; i < userids.length; i++) {
			JformInnerMailReceiverEntity mailReceiver = new JformInnerMailReceiverEntity();
			mailReceiver.setJMail(mail);
			mailReceiver.setCreateDate(new Date());
			mailReceiver.setStatus(Globals.MAILRECEIVER_STATUS_UNREAD);
			TSUser tsUser = new TSUser(); 
			tsUser.setId(userids[i]);
			mailReceiver.setTSUser(tsUser);
			this.systemService.save(mailReceiver);
		}
	}
	
	/**
	 * 内部邮件 新增或者更新
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAddOrUpdate")
	public ModelAndView goAddOrUpdate(JformInnerMailEntity jformInnerMail, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jformInnerMail.getId())) {
			jformInnerMail = jformInnerMailService.getEntity(JformInnerMailEntity.class, jformInnerMail.getId());
			List<JformInnerMailAttach> documents = systemService.findByProperty(JformInnerMailAttach.class, "mailid", jformInnerMail.getId());
			req.setAttribute("documents", documents);
			req.setAttribute("jformInnerMailPage", jformInnerMail);
		}
		String clickFunctionId = req.getParameter("clickFunctionId");
		req.setAttribute("clickFunctionId", clickFunctionId);
		return new ModelAndView("system/mail/jformInnerMail-update");
	}

	/**
	 * 内部邮件 查看详情
	 * 
	 * @return
	 */
	@RequestMapping(params = "goDetail")
	public ModelAndView goDetail(JformInnerMailEntity jformInnerMail, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jformInnerMail.getId())) {
			jformInnerMail = jformInnerMailService.getEntity(JformInnerMailEntity.class, jformInnerMail.getId());
			List<JformInnerMailAttach> documents = systemService.findByProperty(JformInnerMailAttach.class, "mailid", jformInnerMail.getId());
			req.setAttribute("documents", documents);
			req.setAttribute("jformInnerMailPage", jformInnerMail);
		}
		return new ModelAndView("system/mail/jformInnerMail-detail");
	}
	
	/**
	 * 发信箱 邮件列表 页面跳转
	 * @return
	 */
	@RequestMapping(params = "goSendMails")
	public ModelAndView goSendMails(HttpServletRequest request,String type) {
		return new ModelAndView("system/mail/jformInnerMailSendList");
	}
	/**
	 * 发信箱   邮件列表 
	 * @return
	 */
	@RequestMapping(params = "getSendMails")
	@ResponseBody
	public List<Map<String,Object>> getSendMails(String title){
			String account = ClientManager.getInstance().getClient().getUser().getUserName();
			
			StringBuffer sqlb =new StringBuffer("from JformInnerMailEntity where status ='"+Globals.MAIL_STATUS_SEND+"' and  createBy ='"+account +"'");
			if(StringUtils.isNotEmpty(title)){
				sqlb.append(" and title like '%"+title+"%'");
			}
			
			List<JformInnerMailEntity> mails =this.systemService.findByQueryString(sqlb.toString());
			List<Map<String,Object>> ret = new ArrayList<Map<String,Object>>();
			for(int i=0;i< mails.size();i++){
				Map<String,Object> m = new HashMap<String, Object>();
				m.put("id", mails.get(i).getId());
				m.put("title", mails.get(i).getTitle());
				m.put("receiverNames", mails.get(i).getReceiverNames());
				m.put("createTime", DateUtils.date2Str(mails.get(i).getCreateDate(), DateUtils.time_sdf));
				m.put("status", mails.get(i).getStatus());
				ret.add(m);
			}
			return ret;
	}
	
	
	
	/**
	 * 草稿箱 邮件列表 页面跳转
	 * @return
	 */
	@RequestMapping(params = "goUnSendMails")
	public ModelAndView goUnSendMails(HttpServletRequest request,String type) {
		return new ModelAndView("system/mail/jformInnerMailUnSendList");
	}
	/**
	 * 草稿箱  邮件列表 
	 * @return
	 */
	@RequestMapping(params = "getUnSendMails")
	@ResponseBody
	public List<Map<String,Object>> getUnSendMails(String title){
			String account = ClientManager.getInstance().getClient().getUser().getUserName();
			
			StringBuffer sqlb =new StringBuffer("from JformInnerMailEntity where status ='"+Globals.MAIL_STATUS_UNSEND+"' and  createBy ='"+account +"'");
			if(StringUtils.isNotEmpty(title)){
				sqlb.append(" and title like '%"+title+"%'");
			}
			
			List<JformInnerMailEntity> mails =this.systemService.findByQueryString(sqlb.toString());
			List<Map<String,Object>> ret = new ArrayList<Map<String,Object>>();
			for(int i=0;i< mails.size();i++){
				Map<String,Object> m = new HashMap<String, Object>();
				m.put("id", mails.get(i).getId());
				m.put("title", mails.get(i).getTitle());
				m.put("receiverNames", mails.get(i).getReceiverNames());
				m.put("createTime", DateUtils.date2Str(mails.get(i).getCreateDate(), DateUtils.time_sdf));
				m.put("status", mails.get(i).getStatus());
				ret.add(m);
			}
			sqlb.setLength(0);
			return ret;
	}
	
	
	/**
	 * 删除草稿箱、发件箱  邮件
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDelMail")
	@ResponseBody
	public AjaxJson doDelMail(JformInnerMailEntity innerMailEntity, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		innerMailEntity = systemService.getEntity(JformInnerMailEntity.class, innerMailEntity.getId());
		message = "删除成功";
		try{
			// 未发送 直接删除
			if(innerMailEntity.getStatus().equals(Globals.MAIL_STATUS_UNSEND)){
				systemService.delete(innerMailEntity);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
			// 已经发送的 更新状态
			else{
				innerMailEntity.setStatus(Globals.MAIL_STATUS_DEL);
				systemService.updateEntitie(innerMailEntity);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 删除草稿箱、发件箱   邮件
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDelMails")
	@ResponseBody
	public AjaxJson doDelMails(String ids, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "删除成功";
		try{
			for(String id :ids.split(",")){
				JformInnerMailEntity innerMailEntity = systemService.getEntity(JformInnerMailEntity.class, id);
					// 未发送 直接删除
					if(innerMailEntity.getStatus().equals(Globals.MAIL_STATUS_UNSEND)){
						systemService.delete(innerMailEntity);
					}
					// 已经发送的 更新状态
					else{
						innerMailEntity.setStatus(Globals.MAIL_STATUS_DEL);
						systemService.updateEntitie(innerMailEntity);
					}
				}
		}
		catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	
	/**
	 * 收件箱 邮件列表 页面跳转
	 * @return
	 */
	@RequestMapping(params = "goReceivedMails")
	public ModelAndView goReceivedMails(HttpServletRequest request,String type) {
		return new ModelAndView("system/mail/jformInnerMailReceiveList");
	}
	
	/**
	 * 收件箱 邮件列表 
	 * @return
	 */
	@RequestMapping(params = "getReceivedMails")
	@ResponseBody
	public List<Map<String,Object>> getReceivedMails(HttpServletRequest request, String senderName,String title,DataGrid dataGrid){
			String userId = ClientManager.getInstance().getClient().getUser().getId();
			StringBuffer sqlb =new StringBuffer("from JformInnerMailReceiverEntity where TSUser.id ='"+userId +"'and JMail.status !='"+Globals.MAIL_STATUS_UNSEND+"'");

			if(StringUtils.isNotEmpty(senderName)){
				sqlb.append(" and JMail.createName like '%"+senderName+"%'");
			}
			
			if(StringUtils.isNotEmpty(title)){
				sqlb.append(" and JMail.title like '%"+title+"%'");
			}
			
			//收件状态不为删除，且邮件为已发送状态
			List<JformInnerMailReceiverEntity> receivers =this.systemService.findByQueryString(sqlb.toString());
			List<Map<String,Object>> ret = new ArrayList<Map<String,Object>>();
			for(int i=0;i< receivers.size();i++){
				Map<String,Object> m = new HashMap<String, Object>();
				m.put("id", receivers.get(i).getId());
				m.put("mailId", receivers.get(i).getJMail().getId());
				m.put("title", receivers.get(i).getJMail().getTitle());
				m.put("senderName", receivers.get(i).getJMail().getCreateName());
				m.put("senderAccount", receivers.get(i).getJMail().getCreateBy());
				m.put("sendTime", DateUtils.date2Str(receivers.get(i).getCreateDate(), DateUtils.time_sdf));
				m.put("status", receivers.get(i).getStatus());
				ret.add(m);
			}
			return ret;
	}
	
	/**
	 * 删除收件箱邮件
	 * @return
	 */
	@RequestMapping(params = "doDelReceivedMail")
	@ResponseBody
	public AjaxJson doDelReceivedMail(JformInnerMailReceiverEntity jformInnerMailReceiverEntity, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		jformInnerMailReceiverEntity = systemService.getEntity(JformInnerMailReceiverEntity.class, jformInnerMailReceiverEntity.getId());
		message = "删除成功";
		try{
			systemService.delete(jformInnerMailReceiverEntity);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 删除收件箱邮件
	 * @return
	 */
	@RequestMapping(params = "doDelReceivedMails")
	@ResponseBody
	public AjaxJson doDelReceivedMails(String ids, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "删除成功";

		for(String id :ids.split(",")){
			JformInnerMailReceiverEntity jformInnerMailReceiverEntity = systemService.getEntity(JformInnerMailReceiverEntity.class, id);
			systemService.delete(jformInnerMailReceiverEntity);
		}
		
		j.setMsg(message);
		return j;
	}
	
	
	/**
	 * 删除邮件附件
	 * 
	 * @return
	 */
	@RequestMapping(params = "delFile")
	@ResponseBody
	public AjaxJson delFile(JformInnerMailAttach jformInnerMailAttach, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		String id  = request.getParameter("id");
		JformInnerMailAttach file = systemService.getEntity(JformInnerMailAttach.class, id);
		message = "" + file.getAttachmenttitle() + "被删除成功";
		jformInnerMailService.deleteFile(file);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);
		j.setSuccess(true);
		j.setMsg(message);
		return j;
	}
	/**
	 * 上传邮件附件
	 * 
	 * @return
	 */
	@RequestMapping(params = "saveFile")
	@ResponseBody
	public AjaxJson saveFile(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		JformInnerMailAttach jformInnerMailAttach = new JformInnerMailAttach();

		String fileKey = oConvertUtils.getString(request.getParameter("fileKey"));// 文件ID
		
		String mailId = oConvertUtils.getString(request.getParameter("mailId"));//邮件id
		
		if (StringUtil.isNotEmpty(fileKey)) {
			jformInnerMailAttach.setId(fileKey);
			jformInnerMailAttach = systemService.getEntity(JformInnerMailAttach.class, fileKey);

		}
		jformInnerMailAttach.setMailid(mailId);
		
		UploadFile uploadFile = new UploadFile(request, jformInnerMailAttach);
		uploadFile.setCusPath("files");
		uploadFile.setSwfpath("swfpath");
		uploadFile.setByteField(null);//不存二进制内容
		jformInnerMailAttach = systemService.uploadFile(uploadFile);

		j.setMsg("文件添加成功");
		return j;
	}
	/**
	 * 删除内部邮件
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(JformInnerMailEntity jformInnerMail, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		jformInnerMail = systemService.getEntity(JformInnerMailEntity.class, jformInnerMail.getId());
		message = "内部邮件删除成功";
		try{
			jformInnerMailService.delete(jformInnerMail);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "内部邮件删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除内部邮件
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "内部邮件删除成功";
		try{
			for(String id:ids.split(",")){
				JformInnerMailEntity jformInnerMail = systemService.getEntity(JformInnerMailEntity.class, 
				id
				);
				jformInnerMailService.delete(jformInnerMail);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "内部邮件删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

}
