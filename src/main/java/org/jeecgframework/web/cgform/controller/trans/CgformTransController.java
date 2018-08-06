package org.jeecgframework.web.cgform.controller.trans;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.jeecgframework.codegenerate.database.JeecgReadTable;
import org.jeecgframework.codegenerate.pojo.Columnt;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.consts.DataBaseConst;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 自定义表单逆向生成
 * 
 * @author Alexander
 * @date 20130927
 */
@Controller
@RequestMapping("/cgformTransController")
public class CgformTransController {
	private static final Logger logger = Logger.getLogger(CgformTransController.class);
	private static String GENERATE_FORM_IDS;
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;

	/**
	 * 自动生成表属性列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "trans")
	public ModelAndView trans(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgform/trans/transList");
	}

	@RequestMapping(params = "datagrid")
	public void datagrid(HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		String tableName = request.getParameter("id");

		List<String> list = new ArrayList<String>();
		try {
			list = new JeecgReadTable().readAllTableNames();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		String html = "";

		Collections.sort(list,new StringSort(SortDirection.toEnum(dataGrid.getOrder())));

		List<String> tables = cgFormFieldService.findByQueryString("select tableName from CgFormHeadEntity");
		list.removeAll(tables);
		List<String> index = new ArrayList<String>();
		if (StringUtil.isNotEmpty(tableName)) {
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).contains(tableName))
					index.add(list.get(i));
			}
			html = getJson(index, index.size());
		} else
			html = getJson(list, list.size());
		PrintWriter writer = null;
		try {
			response.setContentType("text/html");
			response.setHeader("Cache-Control", "no-store");
			writer = response.getWriter();
			writer.println(html);
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				writer.close();
			} catch (Exception e2) {
			}
		}
	}

	@RequestMapping(params = "transEditor")
	@ResponseBody
	public AjaxJson transEditor(HttpServletRequest request, String id)
			throws Exception {
		AjaxJson j = new AjaxJson();

		//TODO 1.存在缺陷，表单移除再点击生成违法生成
		//TODO 2.重复提醒，在前段没提示信息
		if(GENERATE_FORM_IDS!=null && GENERATE_FORM_IDS.equals(id)){
			j.setMsg("不允许重复生成!");
			j.setSuccess(false);
			return j;
		}else{
			GENERATE_FORM_IDS = id;
		}

		String ids[] = id.split(",");
		String no = "";
		String yes = "";
		for (int i = 0; i < ids.length; i++) {
			if (StringUtil.isNotEmpty(ids[i])) {
				List<CgFormHeadEntity> cffList = cgFormFieldService.findByProperty(CgFormHeadEntity.class, "tableName",ids[i]);
				if (cffList.size() > 0) {
					if (no != "")
						no += ",";
					no += ids[i];
					continue;
				}
				logger.info("["+IpUtil.getIpAddr(request)+"] [online数据库导入表] "+"  --表名："+ids[i]);
				List<Columnt> list = new JeecgReadTable().readOriginalTableColumn(ids[i]);
				CgFormHeadEntity cgFormHead = new CgFormHeadEntity();
				cgFormHead.setJformType(1);
				cgFormHead.setIsCheckbox("Y");
				cgFormHead.setIsDbSynch("Y");
				cgFormHead.setIsTree("N");
				cgFormHead.setQuerymode("group");
				cgFormHead.setTableName(ids[i].toLowerCase());
				cgFormHead.setIsPagination("Y");
				cgFormHead.setContent(ids[i]);
				cgFormHead.setJformVersion("1");
				List<CgFormFieldEntity> columnsList = new ArrayList<CgFormFieldEntity>();
				for (int k = 0; k < list.size(); k++) {
					Columnt columnt = list.get(k);
					logger.info("  columnt : "+ columnt.toString());
					String fieldName = columnt.getFieldDbName();
					CgFormFieldEntity cgFormField = new CgFormFieldEntity();

					cgFormField.setOldFieldName(columnt.getFieldDbName().toLowerCase());

					cgFormField.setFieldName(columnt.getFieldDbName()
							.toLowerCase());
					if (StringUtil.isNotEmpty(columnt.getFiledComment()))
						cgFormField.setContent(columnt.getFiledComment());
					else
						cgFormField.setContent(columnt.getFieldName());
					cgFormField.setIsKey("N");
					cgFormField.setIsShow("Y");
					cgFormField.setIsShowList("Y");
					cgFormField.setOrderNum(k + 2);
					cgFormField.setQueryMode("group");
					cgFormField.setLength(oConvertUtils.getInt(columnt.getPrecision()));
					cgFormField.setFieldLength(120);
					cgFormField.setPointLength(oConvertUtils.getInt(columnt.getScale()));
					cgFormField.setShowType("text");
					cgFormField.setIsNull(columnt.getNullable());
					if("id".equalsIgnoreCase(fieldName)){
						String[] pkTypeArr = {"java.lang.Integer","java.lang.Long"};
						String idFiledType = columnt.getFieldType();
						if(Arrays.asList(pkTypeArr).contains(idFiledType)){
							//如果主键是数字类型,则设置为自增长
							cgFormHead.setJformPkType("NATIVE");
						}else{
							//否则设置为UUID
							cgFormHead.setJformPkType("UUID");
						}
						cgFormField.setIsKey("Y");
						cgFormField.setIsShow("N");
						cgFormField.setIsShowList("N");
					}
					if ("java.lang.Integer".equalsIgnoreCase(columnt.getFieldType())){
						cgFormField.setType(DataBaseConst.INT);
					}else if ("java.lang.Long".equalsIgnoreCase(columnt.getFieldType())) {
						cgFormField.setType(DataBaseConst.INT);
					} else if ("java.util.Date".equalsIgnoreCase(columnt.getFieldType())) {
						cgFormField.setType(DataBaseConst.DATE);
						cgFormField.setShowType("date");
					} else if ("java.lang.Double".equalsIgnoreCase(columnt.getFieldType())
							||"java.lang.Float".equalsIgnoreCase(columnt.getFieldType())) {
						cgFormField.setType(DataBaseConst.DOUBLE);
					} else if ("java.math.BigDecimal".equalsIgnoreCase(columnt.getFieldType()) || "BigDecimal".equalsIgnoreCase(columnt.getFieldType())) {
						cgFormField.setType(DataBaseConst.BIGDECIMAL);
					} else if ("byte[]".equalsIgnoreCase(columnt.getFieldType()) || columnt.getFieldType().contains("blob")) {
						cgFormField.setType(DataBaseConst.BLOB);
						columnt.setCharmaxLength(null);
					} else {
						cgFormField.setType(DataBaseConst.STRING);
					}
					if (oConvertUtils.isEmpty(columnt.getPrecision()) && StringUtil.isNotEmpty(columnt.getCharmaxLength())) {
						if (Long.valueOf(columnt.getCharmaxLength()) >= 3000) {
							cgFormField.setType(DataBaseConst.TEXT);
							cgFormField.setShowType(DataBaseConst.TEXTAREA);
							try{//有可能长度超出int的长度
								cgFormField.setLength(Integer.valueOf(columnt.getCharmaxLength()));
							}catch(Exception e){}
						} else {
							cgFormField.setLength(Integer.valueOf(columnt.getCharmaxLength()));
						}
					} else {
						if (StringUtil.isNotEmpty(columnt.getPrecision())) {
							cgFormField.setLength(Integer.valueOf(columnt.getPrecision()));
						}

						else{
							if(cgFormField.getType().equals(DataBaseConst.INT)){
								cgFormField.setLength(10);
							}
						}

						if (StringUtil.isNotEmpty(columnt.getScale()))
							cgFormField.setPointLength(Integer.valueOf(columnt.getScale()));

					}
					columnsList.add(cgFormField);
				}
				cgFormHead.setColumns(columnsList);

				if(oConvertUtils.isEmpty(cgFormHead.getJformCategory())){
					cgFormHead.setJformCategory("bdfl_include");
				}

				cgFormFieldService.saveTable(cgFormHead, "");
				if (yes != "")
					yes += ",";
				yes += ids[i];
			}
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("no", no);
		map.put("yes", yes);
		j.setObj(map);
		GENERATE_FORM_IDS = null;
		return j;
	}

	public static String getJson(List<String> result, Integer size) {
		JSONObject main = new JSONObject();
		JSONArray rows = new JSONArray();
		main.put("total", size);
		for (String m : result) {
			JSONObject item = new JSONObject();
			item.put("id", m);
			rows.add(item);
		}
		main.put("rows", rows);
		return main.toString();
	}
	private class StringSort implements Comparator<String>{
		
		private SortDirection sortOrder;
		
		public StringSort(SortDirection sortDirection){
			this.sortOrder = sortDirection;
		}

		
		public int compare(String prev, String next) {
			return sortOrder.equals(SortDirection.asc)?
					prev.compareTo(next):next.compareTo(prev);
		}
		
	}

}
