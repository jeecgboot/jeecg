package org.jeecgframework.web.demo.controller.test;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.util.FileUtils;
import org.jeecgframework.web.demo.entity.test.FileMeta;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * 类 名 称： FileUploadController 类 描 述： jQuery File Upload 例子 创 建 人： yiming.zhang
 * 联系方式： 1374250553@qq.com 创建时间： 2014-2-19 下午11:25:22
 * 
 * 修 改 人： Administrator 操作时间： 2014-2-19 下午11:25:22 操作原因：
 * 
 */
@Scope("prototype")
@Controller
@RequestMapping("/fileUploadController")
public class FileUploadController extends BaseController {
 
	private static final Logger logger = Logger.getLogger(FileUploadController.class);

	private String message;
	/**
	 * update-begin--Author:huangzq  Date:20151125 for：[732]【常用示例】上传文件下载报错
	 */
	private static LinkedList<FileMeta> files = new LinkedList<FileMeta>();
	/**
	 * update-end--Author:huangzq  Date:20151125 for：[732]【常用示例】上传文件下载报错
	 */
	FileMeta fileMeta = null;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * 方法描述:  (这里用一句话描述这个方法的作用)
	 * 作    者： yiming.zhang
	 * 日    期： 2014-2-20-下午10:27:45
	 * @param request
	 * @return 
	 * 返回类型： ModelAndView
	 */
	@RequestMapping(params = "fileUploadSample")
	public ModelAndView webOfficeSample(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/test/fileUploadSample");
	}

	@RequestMapping(params = "upload", method = RequestMethod.POST)
	@ResponseBody
	public LinkedList<FileMeta> upload(MultipartHttpServletRequest request, HttpServletResponse response) {
		logger.info("upload-》1. build an iterator");
		Iterator<String> itr = request.getFileNames();
		MultipartFile mpf = null;
		logger.info("upload-》2. get each file");
		while (itr.hasNext()) {
			logger.info("upload-》2.1 get next MultipartFile");
			mpf = request.getFile(itr.next());
			logger.info(mpf.getOriginalFilename() + " uploaded! " + files.size());
			System.out.println(mpf.getOriginalFilename() + " uploaded! " + files.size());
			logger.info("2.2 if files > 10 remove the first from the list");
			if (files.size() >= 10)
				files.pop();
			logger.info("2.3 create new fileMeta");
			fileMeta = new FileMeta();
			fileMeta.setFileName(mpf.getOriginalFilename());
			fileMeta.setFileSize(mpf.getSize() / 1024 + " Kb");
			fileMeta.setFileType(mpf.getContentType());
			try {
				fileMeta.setBytes(mpf.getBytes());
				String path ="upload/";
				String realPath = request.getSession().getServletContext().getRealPath("/") + "/" + path ;// 文件的硬盘真实路径
				logger.info("upload-》文件的硬盘真实路径"+realPath);
				String savePath = realPath + mpf.getOriginalFilename();// 文件保存全路径
				logger.info("upload-》文件保存全路径"+savePath);
				FileCopyUtils.copy(mpf.getBytes(),new File(savePath));
				logger.info("copy file to local disk (make sure the path e.g. D:/temp/files exists)");
			} catch (IOException e) {
				e.printStackTrace();
			}
			logger.info("2.4 add to files");
			files.add(fileMeta);
			logger.info("success uploaded="+files.size());
		}
		// result will be like this
		// [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
		return files;
	}
	
	@RequestMapping(params = "view", method = {RequestMethod.GET,RequestMethod.POST})
	 public void get(HttpServletResponse response,String index){
		 logger.info("get =》uploaded="+files.size());
		 FileMeta getFile = files.get(Integer.parseInt(index));
		 try {		
			 	response.setContentType(getFile.getFileType());
			 	String fileName= StringUtils.trim(getFile.getFileName());
			 	logger.info("fileUploadController->get—>下载文件名："+fileName);
			 	String formatFileName =FileUtils.encodingFileName(fileName);
			 	logger.info("fileUploadController->get—>处理中文乱码及文件名有空格："+fileName);
			 	response.setHeader("Content-disposition", "attachment; filename=\""+formatFileName+"\"");
		        FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
		 }catch (IOException e) {
			e.printStackTrace();
		 }
	 }


}
