package org.jeecgframework.web.image.controller;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.image.entity.ImagesEntity;
import org.jeecgframework.web.image.service.ImagesServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;



/**   
 * @Title: Controller
 * @Description: 图片表
 * @author onlineGenerator
 * @date 2016-03-09 16:15:51
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/imagesController")
public class ImagesController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ImagesController.class);

	@Autowired
	private ImagesServiceI imagesService;
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
	 * 图片表列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("jeecg/image/imagesList");
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
	public void datagrid(ImagesEntity images,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(ImagesEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, images, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.imagesService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除图片表
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(ImagesEntity images, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		images = systemService.getEntity(ImagesEntity.class, images.getId());
		message = "图片表删除成功";
		try{
			imagesService.delete(images);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "图片表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除图片表
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "图片表删除成功";
		try{
			for(String id:ids.split(",")){
				ImagesEntity images = systemService.getEntity(ImagesEntity.class, 
				id
				);
				imagesService.delete(images);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "图片表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加图片表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(ImagesEntity images, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "图片表添加成功";
		try{
			images.setExtensions(images.getImageAddress().substring(images.getImageAddress().lastIndexOf(".") + 1));
			String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ request.getContextPath() + "/" + images.getImageAddress();
			images.setUrlAddress(url);
			imagesService.save(images);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "图片表添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新图片表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(ImagesEntity images, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "图片表更新成功";
		ImagesEntity t = imagesService.get(ImagesEntity.class, images.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(images, t);
			t.setExtensions(images.getImageAddress().substring(images.getImageAddress().lastIndexOf(".") + 1));
			String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ request.getContextPath() + "/" + images.getImageAddress();
			t.setUrlAddress(url);
			imagesService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "图片表更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 图片表新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(ImagesEntity images, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(images.getId())) {
			images = imagesService.getEntity(ImagesEntity.class, images.getId());
			req.setAttribute("imagesPage", images);
		}
		return new ModelAndView("jeecg/image/images-add");
	}
	/**
	 * 图片表编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(ImagesEntity images, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(images.getId())) {
			images = imagesService.getEntity(ImagesEntity.class, images.getId());
			req.setAttribute("imagesPage", images);
		}
		return new ModelAndView("jeecg/image/images-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","imagesController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(ImagesEntity images,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(ImagesEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, images, request.getParameterMap());
		List<ImagesEntity> imagess = this.imagesService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"图片表");
		modelMap.put(NormalExcelConstants.CLASS,ImagesEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("图片表列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,imagess);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(ImagesEntity images,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"图片表");
    	modelMap.put(NormalExcelConstants.CLASS,ImagesEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("图片表列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
    	"导出信息"));
    	modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
    	return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<ImagesEntity> listImagesEntitys = ExcelImportUtil.importExcel(file.getInputStream(),ImagesEntity.class,params);
				for (ImagesEntity images : listImagesEntitys) {
					imagesService.save(images);
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}
	
	//上传文件方法
	@RequestMapping(params="ajaxUpload")
	@ResponseBody
	public String ajaxUpload(HttpServletRequest request) throws IllegalStateException, IOException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String fileName = "";
		String uploadPath = "upload/";
		String path =request.getSession().getServletContext().getRealPath("/")+uploadPath;  
		String realPath = "";
		String oldName = "";
		for (Iterator<String> it = multipartRequest.getFileNames(); it.hasNext();) {
			String key = it.next();
			MultipartFile mulfile = multipartRequest.getFile(key);
			fileName = mulfile.getOriginalFilename();
			oldName = fileName.substring(0,fileName.lastIndexOf("."));
			fileName = rewriteFileName(fileName);
			File file = new File(path + fileName);
			mulfile.transferTo(file);
		}
		realPath = "{\"imagePath\":\""+uploadPath+fileName+"\",\"oldName\":\"" + oldName + "\"}";
		return realPath;
	}

	//文件名称处理
	private String rewriteFileName(String fileName) {
		int pointIndex = fileName.lastIndexOf(".");
		StringBuffer fileNameBuffer = new StringBuffer();
		fileNameBuffer.append((new Date()).getTime()+"_"+fileName.substring(0,pointIndex));
		fileNameBuffer.append(fileName.substring(pointIndex));
		return fileNameBuffer.toString();
	}

	//预览，获取图片流
	@RequestMapping(params="readImage", produces = "text/plain;charset=UTF-8")
	public void readImage(HttpServletRequest request, HttpServletResponse response){
		String imagePath = request.getSession().getServletContext().getRealPath("/")+request.getParameter("imagePath");
		try{
			File file = new File(imagePath);
			if (file.exists()) {
				DataOutputStream temps = new DataOutputStream(response.getOutputStream());
				DataInputStream in = new DataInputStream(new FileInputStream(imagePath));
				byte[] b = new byte[2048];
				while ((in.read(b)) != -1) {
					temps.write(b);
					temps.flush();
				}
				in.close();
				temps.close();
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
