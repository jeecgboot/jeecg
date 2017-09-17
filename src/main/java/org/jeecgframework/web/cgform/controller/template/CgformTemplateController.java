package org.jeecgframework.web.cgform.controller.template;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jodd.io.StreamUtil;
import jodd.io.ZipUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.FileUtils;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.p3.core.util.oConvertUtils;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgform.entity.template.CgformTemplateEntity;
import org.jeecgframework.web.cgform.service.template.CgformTemplateServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


/**
 * @Title: Controller
 * @Description: 自定义模板
 * @author onlineGenerator
 * @date 2015-06-15 11:04:12
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/cgformTemplateController")
public class CgformTemplateController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CgformTemplateController.class);

	@Autowired
	private CgformTemplateServiceI cgformTemplateService;
	@Autowired
	private SystemService systemService;


	/**
	 * 自定义模板列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgformTemplate")
	public ModelAndView cgformTemplate(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgform/template/cgformTemplateList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(CgformTemplateEntity cgformTemplate,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgformTemplateEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, cgformTemplate, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.cgformTemplateService.getDataGridReturn(cq, true);
		List<CgformTemplateEntity> dataList=dataGrid.getResults();
		if(dataList!=null&&dataList.size()>0){
			for(CgformTemplateEntity entity:dataList){
				entity.setTemplatePic("cgformTemplateController.do?showPic&code="+entity.getTemplateCode()+"&path="+entity.getTemplatePic());
			}
		}
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除自定义模板
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(CgformTemplateEntity cgformTemplate, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		cgformTemplate = systemService.getEntity(CgformTemplateEntity.class, cgformTemplate.getId());
		message = "自定义模板删除成功";
		try{
			cgformTemplateService.delete(cgformTemplate);
			if(cgformTemplate.getTemplateCode()!=null){
				delTemplate(request,cgformTemplate.getTemplateCode());
			}
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "自定义模板删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	private void delTemplate(HttpServletRequest request,String code){
		String dirPath=getUploadBasePath(request)+File.separator+code;
		try {
			org.apache.commons.io.FileUtils.deleteDirectory(new File(dirPath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 批量删除自定义模板
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "自定义模板删除成功";
		try{
			for(String id:ids.split(",")){
				CgformTemplateEntity cgformTemplate = systemService.getEntity(CgformTemplateEntity.class, 
				id
				);
				cgformTemplateService.delete(cgformTemplate);
				if(cgformTemplate.getTemplateCode()!=null){
					delTemplate(request,cgformTemplate.getTemplateCode());
				}
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "自定义模板删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加自定义模板
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(CgformTemplateEntity cgformTemplate, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "自定义模板添加成功";
		try{
			cgformTemplateService.save(cgformTemplate);
			String basePath=getUploadBasePath(request);
			File templeDir=new File(basePath+File.separator+cgformTemplate.getTemplateCode());
			if(!templeDir.exists())
				templeDir.mkdirs();
			removeZipFile(basePath+File.separator+"temp"+File.separator+cgformTemplate.getTemplateZipName(),templeDir.getAbsolutePath());
			removeIndexFile(basePath + File.separator + "temp" + File.separator + cgformTemplate.getTemplatePic(), templeDir.getAbsolutePath());
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "自定义模板添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	//将预览图从临时文件夹移入模板图片文件夹
	private void removeIndexFile(String templateIndexPath,String templateDir){
		File indexFile=new File(templateIndexPath);
		if(indexFile.exists()&&!indexFile.isDirectory()){
			File destDir=new File(templateDir+File.separator+"images");
			if(!destDir.exists()){
				destDir.mkdirs();
			}
			File destIndexFile=new File(destDir,indexFile.getName());
			if(destIndexFile.exists()){
				FileUtils.delete(destIndexFile.getAbsolutePath());
			}
			try {
				FileCopyUtils.copy(indexFile, destIndexFile);
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				FileUtils.delete(indexFile.getAbsolutePath());
			}

		}
	}
	//将压缩文件从临时文件夹解压到模板目录下
	private void removeZipFile(String zipFilePath,String templateDir){
		File zipFile=new File(zipFilePath);
		if(zipFile.exists()&&!zipFile.isDirectory()){
			try {
				unZipFiles(zipFile, templateDir);
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				FileUtils.delete(zipFilePath);
			}
		}
	}
	/**
	 * 更新自定义模板
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(CgformTemplateEntity cgformTemplate, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "自定义模板更新成功";
		CgformTemplateEntity t = cgformTemplateService.get(CgformTemplateEntity.class, cgformTemplate.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(cgformTemplate, t);
			String basePath=getUploadBasePath(request);
			File templeDir=new File(basePath+File.separator+t.getTemplateCode());
			if(!templeDir.exists())
				templeDir.mkdirs();
			removeZipFile(basePath+File.separator+"temp"+File.separator+t.getTemplateZipName(),templeDir.getAbsolutePath());
			removeIndexFile(basePath + File.separator + "temp" + File.separator + t.getTemplatePic(), templeDir.getAbsolutePath());
			cgformTemplateService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "自定义模板更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 自定义模板新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(CgformTemplateEntity cgformTemplate, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgformTemplate.getId())) {
			cgformTemplate = cgformTemplateService.getEntity(CgformTemplateEntity.class, cgformTemplate.getId());
			req.setAttribute("cgformTemplatePage", cgformTemplate);
		}
		return new ModelAndView("jeecg/cgform/template/cgformTemplate-add");
	}
	/**
	 * 自定义模板编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(CgformTemplateEntity cgformTemplate, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgformTemplate.getId())) {
			cgformTemplate = cgformTemplateService.getEntity(CgformTemplateEntity.class, cgformTemplate.getId());
			req.setAttribute("cgformTemplatePage", cgformTemplate);
		}
		return new ModelAndView("jeecg/cgform/template/cgformTemplate-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name", "cgformTemplateController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(CgformTemplateEntity cgformTemplate,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(CgformTemplateEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, cgformTemplate, request.getParameterMap());
		List<CgformTemplateEntity> cgformTemplates = this.cgformTemplateService.getListByCriteriaQuery(cq, false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"自定义模板");
		modelMap.put(NormalExcelConstants.CLASS,CgformTemplateEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("自定义模板列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST, cgformTemplates);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}

	/**
	 * 检查模板是否存在
	 * @param id
	 * @return
	 */
	@RequestMapping(params = "checkTemplate")
	@ResponseBody
	public boolean checkTemplate(String id,HttpServletRequest request){
		boolean flag=false;
		if(StringUtils.isNotBlank(id)) {
			CgformTemplateEntity entity = cgformTemplateService.getEntity(CgformTemplateEntity.class, id);
			if (entity != null && entity.getTemplateCode() != null) {
				File dirFile=new File(getUploadBasePath(request)+File.separator+entity.getTemplateCode());
				if(dirFile.exists()&&dirFile.isDirectory()){
					flag=true;
				}
			}
		}
		return flag;

	}
	/**
	 * 下载模板
	 * 
	 * @param id
	 */
	@RequestMapping(params = "downloadTemplate")
	public void downloadTemplate(String id,HttpServletRequest request,HttpServletResponse response) {
		if(StringUtils.isNotBlank(id)){
			CgformTemplateEntity entity=cgformTemplateService.getEntity(CgformTemplateEntity.class,id);
			if(entity!=null&&entity.getTemplateCode()!=null){
				File zipFile=zipFile(entity.getTemplateCode(),request);
				if(zipFile!=null&&zipFile.exists()){
					FileInputStream inputStream=null;
					try {
						inputStream=new FileInputStream(zipFile);
						downLoadFile(inputStream,entity.getTemplateName()+".zip",zipFile.length(),response);
					} catch (FileNotFoundException e) {
						e.printStackTrace();
					}finally {
						if(inputStream!=null){
							try {
								inputStream.close();
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
						FileUtils.delete(zipFile.getAbsolutePath());
					}
				}
			}
		}else{
			return ;
		}
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
				List<CgformTemplateEntity> listCgformTemplateEntitys = ExcelImportUtil.importExcel(file.getInputStream(),CgformTemplateEntity.class,params);
				for (CgformTemplateEntity cgformTemplate : listCgformTemplateEntitys) {
					cgformTemplateService.save(cgformTemplate);
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

	/**
	 * 上传预览图片
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "uploadPic")
	@ResponseBody
	public AjaxJson uploadPic(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		File picTempFile=null;
		File tempDir=new File(getUploadBasePath(request),"temp");
		if(!tempDir.exists())
			tempDir.mkdirs();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();
			picTempFile=new File(tempDir.getAbsolutePath(),File.separator+"index_"+request.getSession().getId()+"."+FileUtils.getExtend(file.getOriginalFilename()));
			try{
				if(picTempFile.exists())
					org.apache.commons.io.FileUtils.forceDelete(picTempFile);
				FileCopyUtils.copy(file.getBytes(),picTempFile);
			}catch (Exception e){
				e.printStackTrace();
				j.setMsg("预览图上传失败！");
				j.setSuccess(false);
			}
			j.setObj(picTempFile.getName());
		}
		j.setMsg("图片上传成功！");
		j.setSuccess(true);
		return j;
	}

	/**
	 * 上传zip文件
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "uploadZip")
	@ResponseBody
	public AjaxJson uploadZip(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		File picTempFile=null;
		File tempDir=new File(getUploadBasePath(request),"temp");
		if(!tempDir.exists())
			tempDir.mkdirs();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();
			picTempFile=new File(tempDir.getAbsolutePath(),File.separator+"zip_"+request.getSession().getId()+"."+ FileUtils.getExtend(file.getOriginalFilename()));
			try{
				if(picTempFile.exists())
					org.apache.commons.io.FileUtils.forceDelete(picTempFile);
				FileCopyUtils.copy(file.getBytes(),picTempFile);
			}catch (Exception e){
				e.printStackTrace();
				j.setMsg("模板文件上传失败！");
				j.setSuccess(false);
			}
			j.setObj(picTempFile.getName());
		}
		j.setMsg("模板文件上传成功！");
		j.setSuccess(true);
		return j;
	}

	/**
	 * 查看图片
	 * @param request
	 * @param code
	 * @param path
	 * @param response
	 */
	@RequestMapping(params = "showPic")
	public void showPic(HttpServletRequest request,String code, String path,HttpServletResponse response){
		String defaultPath="default.jpg";
		String defaultCode="default/images/";
		//无图片情况

		if(oConvertUtils.isEmpty(path)){
			path=defaultPath;
			code=defaultCode;
		}else{
			//临时图片
			if(oConvertUtils.isEmpty(code)){
				code="temp/";
			}else{
				code+="/images/";
			}
		}

		FileInputStream fis = null;
		OutputStream out = null;
		response.setContentType("image/" + FileUtils.getExtend(path));
		try {
			out = response.getOutputStream();
			File file = new File(getUploadBasePath(request),code+path);
			if(!file.exists()||file.isDirectory()){
				file=new File(getUploadBasePath(request),defaultCode+defaultPath);
			}
			fis = new FileInputStream(file);
			byte[] b = new byte[fis.available()];
			fis.read(b);
			out.write(b);

			//out.flush();

		} catch (Exception e) {
			logger.error(e.toString());
//			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
					out.close();
				} catch (IOException e) {
					logger.info(e.toString());
				}
			}
		}
	}
	//获取上传根路径
	private String getUploadBasePath(HttpServletRequest request){

//		String path=request.getSession().getServletContext().getRealPath("/WEB-INF/classes/online/template");

		ClassLoader classLoader = this.getClass().getClassLoader();  
        URL resource = classLoader.getResource("sysConfig.properties");  
        String path = resource.getPath(); 
        path = path.substring(0,path.indexOf("sysConfig.properties"))+"online/template";
//		String path= this.getClass().getResource("/").getPath()+"online/template";

        path = path.replaceAll("%20", " ");//解决tomcat安装路径包含空格的问题
		return path;
	}

	/**
	 * 检查编码是否存在
	 * @param param
	 * @return
	 */
	@RequestMapping(params = "checkCode")
	@ResponseBody
	public AjaxJson checkCode(String param){
		org.springframework.util.Assert.notNull(param);
		AjaxJson j=new AjaxJson();
	 	Long count=cgformTemplateService.getCountForJdbcParam("select count(id) from cgform_template where template_code=?  ", new Object[]{param});
	 	if(count==null||count<=0){
		 	j.setSuccess(true);
	 	}else {
		 	j.setSuccess(false);
	 	}
		return j;
	}

	/**
	 * 查询指定类型的风格
	 * @param type
	 * @return
	 */
	@RequestMapping(params = "getTemplate")
	@ResponseBody
	public AjaxJson getTemplate(String type){
		org.springframework.util.Assert.notNull(type);
		AjaxJson j=new AjaxJson();
		j.setSuccess(true);
		j.setObj(cgformTemplateService.getTemplateListByType(type));
		return j;
	}
	//解压zip文件
	private  void unZipFiles(File zipFile,String descDir)throws IOException{
		ZipUtil.unzip(zipFile, new File(descDir));
	}
	//压缩文件并返回文件信息
	private File zipFile(String templateCode,HttpServletRequest request){
		String dirPath=getUploadBasePath(request)+"/"+templateCode;
		ZipOutputStream zos = null;
		File zipFile=null;
		try {
			File dir=new File(dirPath);
			if(dir.exists()&&dir.isDirectory()){
				zipFile=new File(dir+"_"+request.getSession().getId()+".zip");
				File[] files=dir.listFiles();
				if(files!=null){
					zos=ZipUtil.createZip(zipFile);
					for(File file: files){
						ZipUtil.addToZip(zos,file);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			if(zos!=null){
				StreamUtil.close(zos);
			}
		}
		return zipFile;
	}
	//下载文件
	private  void downLoadFile(InputStream inputStream,String fileName,long size,HttpServletResponse response){
		try{

			String userAgent =ContextHolderUtils.getRequest().getHeader("user-agent").toLowerCase();
			if (userAgent.contains("msie") || userAgent.contains("like gecko") ) {
				fileName = URLEncoder.encode(fileName, "UTF-8");
			}else {  
				fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
			} 

		}catch (Exception e){
			e.printStackTrace();
		}
		response.setContentType("application/octet-stream; charset=utf-8");
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		if(size>0)
			response.addHeader("Content-Length",size+"");
		OutputStream stream= null;
		try {
			stream = response.getOutputStream();
			FileCopyUtils.copy(inputStream, stream);
			stream.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			if(stream!=null){
				try {
					stream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

	}
}
