package org.jeecgframework.web.demo.controller.test;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.vo.TemplateExcelConstants;
import org.jeecgframework.poi.excel.entity.vo.TemplateWordConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.TemplateExportParams;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.demo.entity.test.CourseEntity;
import org.jeecgframework.web.demo.service.test.CourseServiceI;

/**
 * @Title: Controller
 * @Description: 课程,Excel导入导出Demo
 * @author jueyue
 * @date 2013-08-31 22:53:07
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/courseController")
public class CourseController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CourseController.class);
    //列表界面
    private static final String COURSE_LIST_PAGE = "jeecg/demo/test/courseList";
    //新增界面
    private static final String COURSE_ADD_OR_UPDATE_PAGE = "jeecg/demo/test/course";
    //学生列表
    private static final String STUDENT_LIST_PAGE = "jeecg/demo/test/CourseStudentList";
    //上传界面
    private static final String COURSE_UPLOAD_PAGE = "jeecg/demo/test/courseUpload";

	@Autowired
	private CourseServiceI courseService;
	@Autowired
	private SystemService systemService;
	/**
	 * 课程列表 页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "course")
	public String course(HttpServletRequest request) {
		return COURSE_LIST_PAGE;
	}

	/**
	 * easyui AJAX请求数据
	 *
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(CourseEntity course,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CourseEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, course, request.getParameterMap());
		this.courseService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除课程
	 *
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(CourseEntity course, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		course = systemService.getEntity(CourseEntity.class, course.getId());
        j.setMsg("课程删除成功");
        courseService.delete(course);
        systemService.addLog(j.getMsg(), Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		return j;
	}


	/**
	 * 添加课程
	 *
	 * @param course
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(CourseEntity course, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(course.getId())) {
            j.setMsg("课程更新成功");
			try {
				courseService.updateCourse(course);
				systemService.addLog(j.getMsg(), Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
                j.setMsg("课程更新失败");
			}
		} else {
            j.setMsg("课程添加成功");
			courseService.saveCourse(course);
			systemService.addLog(j.getMsg(), Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		return j;
	}

	/**
	 * 课程列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public String addorupdate(CourseEntity course, ModelMap map) {
		if (StringUtil.isNotEmpty(course.getId())) {
			course = courseService.getEntity(CourseEntity.class, course.getId());
            map.put("coursePage", course);
		}
		return COURSE_ADD_OR_UPDATE_PAGE;
	}
	/**
	 * 学生列表
	 *
	 * @return
	 */
	@RequestMapping(params = "studentsList")
	public String studentsList(CourseEntity course, ModelMap map) {
		if (StringUtil.isNotEmpty(course.getId())) {
			course = courseService.getEntity(CourseEntity.class, course.getId());
            map.put("studentsList", course.getStudents());
		}
		return STUDENT_LIST_PAGE;
	}
	/**
	 * 学生列表
	 *
	 * @return
	 */
	@RequestMapping(params = "upload")
	public String upload(HttpServletRequest req) {
		return COURSE_UPLOAD_PAGE;
	}

	/**
	 * 导出excel
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(CourseEntity course,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap map) {

        CriteriaQuery cq = new CriteriaQuery(CourseEntity.class, dataGrid);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, course, request.getParameterMap());
        List<CourseEntity> courses = this.courseService.getListByCriteriaQuery(cq,false);

        map.put(NormalExcelConstants.FILE_NAME,"用户信息");
        map.put(NormalExcelConstants.CLASS,CourseEntity.class);
        map.put(NormalExcelConstants.PARAMS,new ExportParams("课程列表", "导出人:Jeecg",
                "导出信息"));
        map.put(NormalExcelConstants.DATA_LIST,courses);
        return NormalExcelConstants.JEECG_EXCEL_VIEW;

	}
	/**
	 * 导出excel 使模板
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByTest")
	public String exportXlsByTest(CourseEntity course,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("month", 10);
        Map<String,Object> temp;
        for(int i = 1;i<8;i++){
            temp = new HashMap<String, Object>();
            temp.put("per", i*10);
            temp.put("mon", i*1000);
            temp.put("summon", i*10000);
            map.put("i"+i, temp);
        }
        modelMap.put(TemplateExcelConstants.FILE_NAME,"工资统计信息");
        modelMap.put(TemplateExcelConstants.PARAMS,new TemplateExportParams("export/template/exportTemp.xls",1));
        modelMap.put(TemplateExcelConstants.MAP_DATA,map);
        return TemplateExcelConstants.JEECG_TEMPLATE_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(CourseEntity course,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
        CriteriaQuery cq = new CriteriaQuery(CourseEntity.class, dataGrid);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, course, request.getParameterMap());
        List<CourseEntity> courses = this.courseService.getListByCriteriaQuery(cq,false);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("year", "2013");
        map.put("sunCourses", courses.size());
        Map<String,Object> obj = new HashMap<String, Object>();
        map.put("obj", obj);
        obj.put("name", courses.size());
        modelMap.put(TemplateExcelConstants.FILE_NAME,"课程信息");
        modelMap.put(TemplateExcelConstants.PARAMS,new TemplateExportParams("export/template/exportTemp.xls"));
        modelMap.put(TemplateExcelConstants.MAP_DATA,map);
        modelMap.put(TemplateExcelConstants.CLASS,CourseEntity.class);
        modelMap.put(TemplateExcelConstants.LIST_DATA,courses);
        return TemplateExcelConstants.JEECG_TEMPLATE_EXCEL_VIEW;
	}
	/**
	 * 导出Word 使模板
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportDocByT")
	public String exportDocByT(CourseEntity course,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(CourseEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, course, request.getParameterMap());
		List<CourseEntity> courses = this.courseService.getListByCriteriaQuery(cq,false);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("Q1", "289782002");
		map.put("Q2", "106259349");
		map.put("Q3", "106838471");
		map.put("w1", "175449166");
		map.put("w2", "287090836");
		map.put("Author", "scott");
		map.put("email", "scott@jeecg.org");
		map.put("list", courses);
		modelMap.put(TemplateWordConstants.FILE_NAME,"Word测试");
		modelMap.put(TemplateWordConstants.MAP_DATA,map);
		modelMap.put(TemplateWordConstants.URL,"export/template/test.docx");
		return TemplateWordConstants.JEECG_TEMPLATE_WORD_VIEW;
	}

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
			params.setHeadRows(2);
			params.setNeedSave(true);
			try {
				List<CourseEntity> listCourses =  ExcelImportUtil.importExcel(file.getInputStream(),CourseEntity.class,params);
				for (CourseEntity course : listCourses) {
					if(course.getName()!=null){
						courseService.saveCourse(course);
					}
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
}
