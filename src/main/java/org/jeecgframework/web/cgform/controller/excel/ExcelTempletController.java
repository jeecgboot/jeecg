package org.jeecgframework.web.cgform.controller.excel;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.service.autolist.CgTableServiceI;
import org.jeecgframework.web.cgform.service.autolist.ConfigServiceI;
import org.jeecgframework.web.cgform.service.build.DataBaseService;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.jeecgframework.web.cgform.service.excel.ExcelTempletService;
import org.jeecgframework.web.cgform.service.impl.config.util.FieldNumComparator;
import org.jeecgframework.web.cgform.util.QueryParamUtil;
import org.jeecgframework.web.system.pojo.base.DictEntity;
import org.jeecgframework.web.system.service.SystemService;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.UUIDGenerator;
import org.jeecgframework.core.util.oConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName: excelTempletController
 * @Description: excel模版处理
 * @author huiyong
 */
@Scope("prototype")
@Controller
@RequestMapping("/excelTempletController")
public class ExcelTempletController extends BaseController {
	private static final Logger logger = Logger
			.getLogger(ExcelTempletController.class);
	private String message;
	@Autowired
	private ConfigServiceI configService;
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;
	@Autowired
	private DataBaseService dataBaseService;
	@Autowired
	private CgTableServiceI cgTableService;
	@Autowired
	private SystemService systemService;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * 导出excel模版
	 * 
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("all")
	@RequestMapping(params = "exportXls")
	public void exportXls(HttpServletRequest request,
			HttpServletResponse response,String field, DataGrid dataGrid) {

		String codedFileName = "文件";
		String sheetName="导出信息";
		List<CgFormFieldEntity> lists = null;
		if (StringUtil.isNotEmpty(request.getParameter("tableName"))) {
			String configId = request.getParameter("tableName");
			String jversion = cgFormFieldService.getCgFormVersionByTableName(configId);
			Map<String, Object> configs = configService.queryConfigs(configId,jversion);
			Map params =  new HashMap<String,Object>();
			//step.2 获取查询条件以及值
			List<CgFormFieldEntity> beans = (List<CgFormFieldEntity>) configs.get(CgAutoListConstant.FILEDS);
			for(CgFormFieldEntity b:beans){
//				if(CgAutoListConstant.BOOL_TRUE.equals(b.getIsQuery())){
					QueryParamUtil.loadQueryParams(request,b,params);
//				}
			}
			List<Map<String, Object>> result=cgTableService.querySingle(configId, field.toString(), params,null,null, 1,99999 );
			
			//表单列集合
			lists = (List<CgFormFieldEntity>) configs.get(CgAutoListConstant.FILEDS);
			for (int i = lists.size() - 1; i >= 0; i--) {
				if(!field.contains(lists.get(i).getFieldName())){
					lists.remove(i);
				}
			}
			
			//处理页面中若存在checkbox只能显示code值而不能显示text值问题
			Map<String, Object> dicMap = new HashMap<String, Object>();
			for(CgFormFieldEntity b:beans){
				loadDic(dicMap, b);
				List<DictEntity> dicList = (List<DictEntity>)dicMap.get(CgAutoListConstant.FIELD_DICTLIST);
				if(dicList.size() > 0){
					for(Map<String, Object> resultMap:result){
						StringBuffer sb = new StringBuffer();
						String value = (String)resultMap.get(b.getFieldName());
						if(oConvertUtils.isEmpty(value)){continue;}
						String[] arrayVal = value.split(",");
						if(arrayVal.length > 1){
							for(String val:arrayVal){
								for(DictEntity dictEntity:dicList){
									if(val.equals(dictEntity.getTypecode())){
										sb.append(dictEntity.getTypename());
										sb.append(",");
									}
									
								}
							}
							resultMap.put(b.getFieldName(), sb.toString().substring(0, sb.toString().length()-1));
						}
						
					}
				}
			}
			dealDic(result,beans);
			// 对字段列按顺序排序
			Collections.sort(lists, new FieldNumComparator());
			//表的中文名称
			sheetName = (String)configs.get(CgAutoListConstant.CONFIG_NAME);
			//表的英文名称
			String tableName = (String)configs.get(CgAutoListConstant.TABLENAME);
			//导出文件名称 form表单中文名-v版本号.xsl
			codedFileName = sheetName+"_"+tableName+"-v"+(String)configs.get(CgAutoListConstant.CONFIG_VERSION);
			// 生成提示信息，
			response.setContentType("application/vnd.ms-excel");

			OutputStream fOut = null;
			try {

				// 根据浏览器进行转码，使其支持中文文件名
				String browse = BrowserUtils.checkBrowse(request);
				if ("MSIE".equalsIgnoreCase(browse.substring(0, 4))) {
					response.setHeader("content-disposition",
							"attachment;filename="
									+ java.net.URLEncoder.encode(codedFileName,
											"UTF-8") + ".xls");
				} else {
					String newtitle = new String(codedFileName.getBytes("UTF-8"),
							"ISO8859-1");
					response.setHeader("content-disposition",
							"attachment;filename=" + newtitle + ".xls");
				}
				// 产生工作簿对象
				HSSFWorkbook workbook = null;
				workbook = ExcelTempletService.exportExcel(sheetName, lists,result);
				fOut = response.getOutputStream();
				workbook.write(fOut);
			} catch (UnsupportedEncodingException e1) {

			} catch (Exception e) {

			} finally {
				try {
					fOut.flush();
					fOut.close();
				} catch (IOException e) {

				}
			}
		} else {
			throw new BusinessException("参数错误");
		}
		
	}

	@RequestMapping(params = "goImplXls" , method = RequestMethod.GET)
    public ModelAndView goImplXls(HttpServletRequest request) {
		request.setAttribute("tableName", request.getParameter("tableName"));
	    return  new ModelAndView("jeecg/cgform/excel/upload");
    }
	
	/**
	 * 上传模版数据
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings("all")
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		String message = "上传成功";
		AjaxJson j = new AjaxJson();
		String configId = request.getParameter("tableName");
		String jversion = cgFormFieldService.getCgFormVersionByTableName(configId);
		Map<String, Object> configs = configService.queryConfigs(configId,jversion);
		//数据库中版本号
		String version = (String)configs.get(CgAutoListConstant.CONFIG_VERSION);
		List<CgFormFieldEntity> lists = (List<CgFormFieldEntity>) configs.get(CgAutoListConstant.FILEDS);
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			//上传文件的版本号
			String docVersion = getDocVersion(file.getOriginalFilename());
			if (docVersion.equals(version)) {
				List<Map<String, Object>> listDate;
				try {
					//读取excel模版数据
					listDate = (List<Map<String, Object>>) ExcelTempletService.importExcelByIs(file.getInputStream(), lists);
					if (listDate==null) {
						message = "识别模版数据错误";
						logger.error(message);
					}else{
						for (Map<String, Object> map : listDate) {
							map.put("id", UUIDGenerator.generate());
							int num = dataBaseService.insertTable(configId, map);
						}
						message = "文件导入成功！";
					}
				} catch (IOException e) {
					message = "文件导入失败！";
					logger.error(ExceptionUtil.getExceptionMessage(e));
				}
			}else{
				message = "模版文件版本和表达不匹配，请重新下载模版";
				logger.error(message);
			}
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 返回模版文件的版本号
	 * 默认文件名是： form表单中文名-v版本号.xsl
	 * 也有可能是： form表单中文名-v版本号(1).xsl
	 * @param docName
	 * @return
	 */
	private static String  getDocVersion(String docName){
		if(docName.indexOf("(")>0){
			return docName.substring(docName.indexOf("-v")+2, docName.indexOf("("));
		}else {
			return docName.substring(docName.indexOf("-v")+2, docName.indexOf("."));
		}
	}
	
	private void loadDic(Map m, CgFormFieldEntity bean) {
		String dicT = bean.getDictTable();//字典Table
		String dicF = bean.getDictField();//字典Code
		String dicText = bean.getDictText();//字典Text
		if(StringUtil.isEmpty(dicT)&& StringUtil.isEmpty(dicF)){
			//如果这两个字段都为空，则没有数据字典
			m.put(CgAutoListConstant.FIELD_DICTLIST, new ArrayList(0));
			return;
		}
		if(!bean.getShowType().equals("popup")){
			List<DictEntity> dicDatas = queryDic(dicT, dicF,dicText);
			m.put(CgAutoListConstant.FIELD_DICTLIST, dicDatas);
		}else{
			m.put(CgAutoListConstant.FIELD_DICTLIST, new ArrayList(0));
		}
	}
	
	private List<DictEntity> queryDic(String dicTable, String dicCode,String dicText) {
		return this.systemService.queryDict(dicTable, dicCode, dicText);
	}
	
	/**
	 * 处理数据字典
	 * @param result 查询的结果集
	 * @param beans 字段配置
	 */
	@SuppressWarnings("unchecked")
	private void dealDic(List<Map<String, Object>> result,
			List<CgFormFieldEntity> beans) {
		for(CgFormFieldEntity bean:beans){
			String dicTable = bean.getDictTable();//字典Table
			String dicCode = bean.getDictField();//字典Code
			String dicText= bean.getDictText();//字典text
			if(StringUtil.isEmpty(dicTable)&& StringUtil.isEmpty(dicCode)){
				//不需要处理字典
				continue;
			}else{
				if(!bean.getShowType().equals("popup")){
					List<DictEntity> dicDataList = queryDic(dicTable, dicCode,dicText);
					for(Map r:result){
						String value = String.valueOf(r.get(bean.getFieldName()));
						for(DictEntity dictEntity:dicDataList){
							if(value.equalsIgnoreCase(dictEntity.getTypecode())){
								r.put(bean.getFieldName(),MutiLangUtil.getMutiLangInstance().getLang(dictEntity.getTypename()));
							}
						}
					}
				}
			}
		}
	}
}
