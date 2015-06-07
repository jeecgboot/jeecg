package org.jeecgframework.web.demo.controller.test;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.demo.entity.test.JeecgBlobDataEntity;
import org.jeecgframework.web.demo.service.test.JeecgBlobDataServiceI;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller
 * @Description: Blob型数据操作例子
 * @author Quainty
 * @date 2013-06-07 14:46:08
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/jeecgBlobDataController")
public class JeecgBlobDataController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JeecgBlobDataController.class);

	@Autowired
	private JeecgBlobDataServiceI jeecgBlobDataService;
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
	 * Blob型数据操作例子列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgBlobData")
	public ModelAndView jeecgBlobData(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/test/jeecgBlobDataList");
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
	public void datagrid(JeecgBlobDataEntity jeecgBlobData,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgBlobDataEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgBlobData);
		this.jeecgBlobDataService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除Blob型数据操作例子
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(JeecgBlobDataEntity jeecgBlobData, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		jeecgBlobData = systemService.getEntity(JeecgBlobDataEntity.class, jeecgBlobData.getId());
		message = "删除成功";
		jeecgBlobDataService.delete(jeecgBlobData);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}
	
	@RequestMapping(params = "download")
	public void exportXls(HttpServletRequest request, String fileId, HttpServletResponse response) {
		// 从数据库取得数据
		JeecgBlobDataEntity obj = systemService.getEntity(JeecgBlobDataEntity.class, fileId);
	    try {      
	    	Blob attachment = obj.getAttachmentcontent();
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String((obj.getAttachmenttitle()+"."+obj.getExtend()).getBytes("GBK"), "ISO8859-1"));
	        //从数据库中读取出来    , 输出给下载用
	        InputStream bis = attachment.getBinaryStream();      
	        BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			long lTotalLen = 0;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
				lTotalLen += bytesRead;
			}
			response.setHeader("Content-Length", String.valueOf(lTotalLen));
			bos.flush();
			bos.close();
	    } catch (Exception  e){      
	        e.printStackTrace();      
	    }                 
	}
	@RequestMapping(params = "upload")
	@ResponseBody
    public AjaxJson upload(HttpServletRequest request, String documentTitle, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			try {
				jeecgBlobDataService.saveObj(documentTitle, file);
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}
			//break; // 不支持多个文件导入？
		}

		return j;
    }


	/**
	 * 添加Blob型数据操作例子
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(JeecgBlobDataEntity jeecgBlobData, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(jeecgBlobData.getId())) {
			message = "更新成功";
			JeecgBlobDataEntity t = jeecgBlobDataService.get(JeecgBlobDataEntity.class, jeecgBlobData.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(jeecgBlobData, t);
				jeecgBlobDataService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "添加成功";
			jeecgBlobDataService.save(jeecgBlobData);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		
		return j;
	}

	/**
	 * Blob型数据操作例子列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(JeecgBlobDataEntity jeecgBlobData, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgBlobData.getId())) {
			jeecgBlobData = jeecgBlobDataService.getEntity(JeecgBlobDataEntity.class, jeecgBlobData.getId());
			req.setAttribute("jeecgBlobDataPage", jeecgBlobData);
		}
		return new ModelAndView("jeecg/demo/test/jeecgBlobData");
	}
}
