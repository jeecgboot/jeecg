package org.jeecgframework.web.onlinedocsort.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.jeecgframework.web.onlinedocsort.entity.OnlineDocSortEntity;
import org.jeecgframework.web.onlinedocsort.service.OnlineDocSortServiceI;
import org.jeecgframework.web.system.pojo.base.TSCategoryEntity;
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
 * @Description: 在线文档分类
 * @author onlineGenerator
 * @date 2016-03-20 11:46:20
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/onlineDocSortController")
public class OnlineDocSortController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(OnlineDocSortController.class);

	@Autowired
	private OnlineDocSortServiceI onlineDocSortService;
	@Autowired
	private SystemService systemService;


	/**
	 * 在线文档分类列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("jeecg/onlinedocsort/onlineDocSortList");
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
	@ResponseBody
	public List<TreeGrid> datagrid(OnlineDocSortEntity onlineDocSort,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(OnlineDocSortEntity.class, dataGrid);
		if (onlineDocSort.getId() == null || StringUtils.isEmpty(onlineDocSort.getId())) {
			cq.isNull("parent");
		} else {
			cq.eq("parent.id", onlineDocSort.getId());
			onlineDocSort.setId(null);
		}
		// 查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, onlineDocSort, request.getParameterMap());
		List<TSCategoryEntity> list = this.onlineDocSortService.getListByCriteriaQuery(cq, false);
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setIdField("id");
		treeGridModel.setSrc("id");
		treeGridModel.setTextField("name");
		treeGridModel.setParentText("parent_name");
		treeGridModel.setParentId("parent_id");
		treeGridModel.setChildList("list");
		treeGrids = systemService.treegrid(list, treeGridModel);
		return treeGrids;
	}
	
	@RequestMapping(params = "tree")
	@ResponseBody
	public List<ComboTree> tree(String selfCode,ComboTree comboTree, boolean isNew) {
		CriteriaQuery cq = new CriteriaQuery(OnlineDocSortEntity.class);
		cq.isNull("parent");
		cq.add();
		List<OnlineDocSortEntity> categoryList = systemService.getListByCriteriaQuery(cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		for (int i = 0; i < categoryList.size(); i++) {
			comboTrees.add(onlineDocSortEntityConvertToTree(categoryList.get(i)));
		}
		return comboTrees;
	}

	private ComboTree onlineDocSortEntityConvertToTree(OnlineDocSortEntity entity) {
		ComboTree tree = new ComboTree();
		tree.setId(entity.getId());
		tree.setText(entity.getName());
		if (entity.getList() != null && entity.getList().size() > 0) {
			List<ComboTree> comboTrees = new ArrayList<ComboTree>();
			for (int i = 0; i < entity.getList().size(); i++) {
				comboTrees.add(onlineDocSortEntityConvertToTree(entity.getList().get(i)));
			}
			tree.setChildren(comboTrees);
		}
		return tree;
	}
	
	/**
	 * 删除在线文档分类
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(OnlineDocSortEntity onlineDocSort, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		onlineDocSort = systemService.getEntity(OnlineDocSortEntity.class, onlineDocSort.getId());
		message = "在线文档分类删除成功";
		try{
			onlineDocSortService.delete(onlineDocSort);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "在线文档分类删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除在线文档分类
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "在线文档分类删除成功";
		try{
			for(String id:ids.split(",")){
				OnlineDocSortEntity onlineDocSort = systemService.getEntity(OnlineDocSortEntity.class, 
				id
				);
				onlineDocSortService.delete(onlineDocSort);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "在线文档分类删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加在线文档分类
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(OnlineDocSortEntity onlineDocSort, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		boolean flag = StringUtil.isEmpty(onlineDocSort.getParent().getId());
		message = "在线文档分类添加成功";
		try{
			if (flag) {
				onlineDocSort.setParent(null);
			}
			onlineDocSortService.save(onlineDocSort);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "在线文档分类添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新在线文档分类
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(OnlineDocSortEntity onlineDocSort, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		boolean flag = StringUtil.isEmpty(onlineDocSort.getParent().getId());
		
		message = "在线文档分类更新成功";
		OnlineDocSortEntity t = onlineDocSortService.get(OnlineDocSortEntity.class, onlineDocSort.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(onlineDocSort, t);
			if (flag) {
				t.setParent(null);
			}
			onlineDocSortService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "在线文档分类更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 在线文档分类新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAddOrUpdate(OnlineDocSortEntity onlineDocSort,HttpServletRequest request) {
		
		String id = request.getParameter("id");
		
		if (StringUtil.isNotEmpty(id)) {
			onlineDocSort = onlineDocSortService.getEntity(OnlineDocSortEntity.class, id);
			request.setAttribute("onlineDocSortPage", onlineDocSort);
		}
		return new ModelAndView("jeecg/onlinedocsort/onlineDocSort-add");
	}
	/**
	 * 在线文档分类编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(OnlineDocSortEntity onlineDocSort, HttpServletRequest request) {
		
		String id = request.getParameter("id");
		
		if (StringUtil.isNotEmpty(id)) {
			onlineDocSort = onlineDocSortService.getEntity(OnlineDocSortEntity.class, id);
			request.setAttribute("onlineDocSortPage", onlineDocSort);
		}
		return new ModelAndView("jeecg/onlinedocsort/onlineDocSort-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","onlineDocSortController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(OnlineDocSortEntity onlineDocSort,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(OnlineDocSortEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, onlineDocSort, request.getParameterMap());
		List<OnlineDocSortEntity> onlineDocSorts = this.onlineDocSortService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"在线文档分类");
		modelMap.put(NormalExcelConstants.CLASS,OnlineDocSortEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("在线文档分类列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,onlineDocSorts);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(OnlineDocSortEntity onlineDocSort,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"在线文档分类");
    	modelMap.put(NormalExcelConstants.CLASS,OnlineDocSortEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("在线文档分类列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
    	"导出信息"));
    	modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
    	return NormalExcelConstants.JEECG_EXCEL_VIEW;
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
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<OnlineDocSortEntity> listOnlineDocSortEntitys = ExcelImportUtil.importExcel(file.getInputStream(),OnlineDocSortEntity.class,params);
				for (OnlineDocSortEntity onlineDocSort : listOnlineDocSortEntitys) {
					onlineDocSortService.save(onlineDocSort);
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
