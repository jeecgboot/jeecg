package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.model.json.ComboBox;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.util.ReflectHelper;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.vo.datatable.DataTableReturn;
import org.jeecgframework.tag.vo.easyui.Autocomplete;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 * 类描述：标签工具类
 * 
 * @author: 张代浩   
 * @date： 日期：2012-12-28 时间：上午09:58:00
 * @version 1.1
 */
public class TagUtil {
	private static final Logger log = LoggerFactory.getLogger(TagUtil.class);
	
	/**
	 * <b>Summary: </b> getFiled(获得实体Bean中所有属性)
	 * 
	 * @param objClass
	 * @return
	 * @throws ClassNotFoundException
	 */
	public static Field[] getFiled(Class<?> objClass) throws ClassNotFoundException {
		Field[] field = null;
		if (objClass != null) {
			Class<?> class1 = Class.forName(objClass.getName());
			field = class1.getDeclaredFields();// 这里便是获得实体Bean中所有属性的方法
			return field;
		} else {
			return field;
		}
	}

	/**
	 * 
	 * 获取对象内对应字段的值
	 * @param fields
	 */
	public static Object fieldNametoValues(String FiledName, Object o){
		Object value = "";
		String fieldName = "";
		String childFieldName = null;
		ReflectHelper reflectHelper=new ReflectHelper(o);
		if (FiledName.indexOf("_") == -1) {
			if(FiledName.indexOf(".") == -1){
				fieldName = FiledName;
			}else{
				fieldName = FiledName.substring(0, FiledName.indexOf("."));//外键字段引用名
				childFieldName = FiledName.substring(FiledName.indexOf(".") + 1);//外键字段名
			}
		} else {
			fieldName = FiledName.substring(0, FiledName.indexOf("_"));//外键字段引用名
			childFieldName = FiledName.substring(FiledName.indexOf("_") + 1);//外键字段名
		}
		value = reflectHelper.getMethodValue(fieldName)==null?"":reflectHelper.getMethodValue(fieldName);
		if (oConvertUtils.isNotEmpty(value) && (FiledName.indexOf("_") != -1||FiledName.indexOf(".") != -1)) {
			// 功能增强，添加处理对象中List<Object>属性字段的解析
            if(value instanceof List) {
                Object tempValue = "";
                for (Object listValue : (List)value) {
                    tempValue = tempValue.toString() + fieldNametoValues(childFieldName, listValue) + ",";
                }
                value = tempValue;
            } else {
                value = fieldNametoValues(childFieldName, value);
            }
		}
		return value.toString();
	}
	
	/**
	 * 循环LIST对象拼接EASYUI格式的JSON数据
	 * @param fields
	 * @param total
	 * @param list
	 * @param dataStyle 
	 * @param page 
	 */
	private static String listtojson(String[] fields, int total, List<?> list, String[] footers, String dataStyle, int pageSize) throws Exception {
		StringBuffer jsonTemp = new StringBuffer();
		if("jqgrid".equals(dataStyle)){
			//支持jqgrid列表 json格式
			int totalPage = total % pageSize > 0 ? total / pageSize + 1 : total / pageSize;
			if(totalPage == 0) totalPage = 1;
			jsonTemp.append("{\"total\":" + totalPage );
		}else{
			jsonTemp.append("{\"total\":" + total );
		}
		jsonTemp.append(",\"rows\":[");
		
		int i;
		String fieldName;
		
		//list为null问题处理-------
		if(list==null){
			list = new ArrayList();
		}
		
		for (int j = 0; j < list.size(); ++j) {
			//树最末层，图标显示节点
			jsonTemp.append("{\"state\":\"closed\",");
			Object fieldValue = null;
			for (i = 0; i < fields.length; ++i) {
				fieldName = fields[i].toString();
				if (list.get(j) instanceof Map)
					fieldValue = ((Map<?, ?>) list.get(j)).get(fieldName);
				else {
					fieldValue = fieldNametoValues(fieldName, list.get(j));
				}
				jsonTemp.append("\"" + fieldName + "\"" + ":\"" + oConvertUtils.escapeJava(fieldValue) + "\"");
				if (i != fields.length - 1) {
					jsonTemp.append(",");
				}
			}
			if (j != list.size() - 1)
				jsonTemp.append("},");
			else {
				jsonTemp.append("}");
			}
		}
		jsonTemp.append("]");
		if (footers != null&&footers.length>0) {
			jsonTemp.append(",");
			jsonTemp.append("\"footer\":[");
			jsonTemp.append("{");
			for(i=0;i<footers.length;i++){
				String footerFiled = footers[i].split(":")[0];
				Object value = null;
				if (footers[i].split(":").length == 2)
					value = footers[i].split(":")[1];
				else {
					value = getTotalValue(footerFiled, list);
				}
				if(i==0){
					jsonTemp.append("\"" + footerFiled + "\":\"" + value + "\"");
				}else{
					jsonTemp.append(",\"" + footerFiled + "\":\"" + value + "\"");
				}
			}
			jsonTemp.append("}");
			jsonTemp.append("]");
		}
		jsonTemp.append("}");
		return jsonTemp.toString();
	}

	/**
	 * 循环LIST对象拼接EASYUI格式的JSON数据Footers是json格式的数据
	 * @param fields
	 * @param total
	 * @param list
	 * @param dataStyle 
	 * @param page 
	 */
	private static String listtojsonByFootersJson(String[] fields, int total, List<?> list,String footers, String dataStyle, int pageSize) throws Exception {
		StringBuffer jsonTemp = new StringBuffer();
		if("jqgrid".equals(dataStyle)){
			int totalPage = total % pageSize > 0 ? total / pageSize + 1 : total / pageSize;
			if(totalPage == 0) totalPage = 1;
			jsonTemp.append("{\"total\":" + totalPage );
		}else{
			jsonTemp.append("{\"total\":" + total );
		}
		jsonTemp.append(",\"rows\":[");
		int i;
		String fieldName;
		if(list==null){
			list = new ArrayList();
		}
		for (int j = 0; j < list.size(); ++j) {
			jsonTemp.append("{\"state\":\"closed\",");
			Object fieldValue = null;
			for (i = 0; i < fields.length; ++i) {
				fieldName = fields[i].toString();
				if (list.get(j) instanceof Map)
					fieldValue = ((Map<?, ?>) list.get(j)).get(fieldName);
				else {
					fieldValue = fieldNametoValues(fieldName, list.get(j));
				}
				jsonTemp.append("\"" + fieldName + "\"" + ":\"" + oConvertUtils.escapeJava(fieldValue) + "\"");
				if (i != fields.length - 1) {
					jsonTemp.append(",");
				}
			}
			if (j != list.size() - 1)
				jsonTemp.append("},");
			else {
				jsonTemp.append("}");
			}
		}
		jsonTemp.append("]");
		if (footers != null) {
			jsonTemp.append(",");
			jsonTemp.append("\"footer\":[");
			JSONArray js=JSONArray.parseArray(footers);
			for(int f=0;f<js.size();f++){
				jsonTemp.append("{");
				Map <String,Object>map=(Map) js.get(f);
				for(String key:map.keySet()){
					if(StringUtil.isEmpty(map.get(key).toString())){
						jsonTemp.append("\"" + key + "\":\"" + getTotalValue(key, list) + "\",");
					}else{
						jsonTemp.append("\"" + key + "\":\"" + map.get(key).toString() + "\",");
					}
				}
				jsonTemp.append("},");
			}
			jsonTemp.append("]");
		}
		jsonTemp.append("}");
		return jsonTemp.toString();
	}

	
	/**
	 * 计算指定列的合计
	 * @param filed 字段名
	 * @param list 列表数据
	 * @return
	 */
	private static Object getTotalValue(String fieldName, List list) {
		Double sum = 0D;
		try {
			for (int j = 0; j < list.size(); j++) {
				Double v = 0d;
				String vstr = String.valueOf(fieldNametoValues(fieldName, list.get(j)));
				if (!StringUtil.isEmpty(vstr)) {
					v = Double.valueOf(vstr);
				} else {

				}
				sum += v;
			}
		} catch (Exception e) {
			return "";
		}
		return sum;
	}
	/**
	 * 循环LIST对象拼接自动完成控件数据
	 * @param fields
	 * @param total
	 * @param list
	 * @throws Exception 
	 */
	public static String getAutoList(Autocomplete autocomplete, List list) throws Exception {
		String field = autocomplete.getLabelField() + "," + autocomplete.getValueField();
		String[] fields = field.split(",");
		Object[] values = new Object[fields.length];
		StringBuffer jsonTemp = new StringBuffer();
		jsonTemp.append("{\"totalResultsCount\":\"1\",\"geonames\":[");
		if (list.size() > 0) {
			for (int j = 0; j < list.size(); j++) {
				jsonTemp.append("{'nodate':'yes',");
				for (int i = 0; i < fields.length; i++) {
					String fieldName = fields[i].toString();
					values[i] = fieldNametoValues(fieldName, list.get(j));
					jsonTemp.append("\"").append(fieldName).append("\"").append(":\"").append(oConvertUtils.escapeJava(values[i])).append("\"");
					if (i != fields.length - 1) {
						jsonTemp.append(",");
					}
				}
				if (j != list.size() - 1) {
					jsonTemp.append("},");
				} else {
					jsonTemp.append("}");
				}
			}
		} else {
			jsonTemp.append("{'nodate':'数据不存在'}");
		}
		jsonTemp.append("]}");
		return jsonTemp.toString();
	}
	
	
	/**
	 * 返回列表JSONObject对象
	 * @param field
	 * @param dataGrid
	 * @return
	 */
	private static String getJson(DataGrid dg) {
		String jsonStr = null;
		try {

			if(!StringUtil.isEmpty(dg.getFooter())){

				if(dg.getFooter().startsWith("[")){
					jsonStr = listtojsonByFootersJson(dg.getField().split(","), dg.getTotal(), dg.getResults(),dg.getFooter(),dg.getDataStyle(),dg.getRows());
				}else{
					jsonStr = listtojson(dg.getField().split(","), dg.getTotal(), dg.getResults(),dg.getFooter().split(","),dg.getDataStyle(),dg.getRows());
				}

			}else{
				jsonStr = listtojson(dg.getField().split(","), dg.getTotal(), dg.getResults(),null,dg.getDataStyle(),dg.getRows());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonStr;

	}
	/**
	 * 返回列表JSONObject对象 【DataTable】
	 * @param field
	 * @param dataGrid
	 * @return
	 */
	private static JSONObject getJson(DataTableReturn dataTable,String field) {
		JSONObject jObject = null;
		try {
			jObject = JSONObject.parseObject(datatable(field, dataTable.getiTotalDisplayRecords(), dataTable.getAaData()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jObject;

	}
	/**
	 * 循环LIST对象拼接DATATABLE格式的JSON数据 【DataTable】
	 * @param fields
	 * @param total
	 * @param list
	 */
	private static String datatable(String field, int total, List list) throws Exception {
		String[] fields = field.split(",");
		Object[] values = new Object[fields.length];
		StringBuffer jsonTemp = new StringBuffer();
		jsonTemp.append("{\"iTotalDisplayRecords\":" + total + ",\"iTotalRecords\":" + total + ",\"aaData\":[");
		for (int j = 0; j < list.size(); j++) {
			jsonTemp.append("{");
			for (int i = 0; i < fields.length; i++) {
				String fieldName = fields[i].toString();
				values[i] = fieldNametoValues(fieldName, list.get(j));
				jsonTemp.append("\"" + fieldName + "\"" + ":\"" + oConvertUtils.escapeJava(values[i]) + "\"");
				if (i != fields.length - 1) {
					jsonTemp.append(",");
				}
			}
			if (j != list.size() - 1) {
				jsonTemp.append("},");
			} else {
				jsonTemp.append("}");
			}
		}
		jsonTemp.append("]}");
		return jsonTemp.toString();
	}


	/**
	 * 获取指定字段类型 <b>Summary: </b> getColumnType(请用一句话描述这个方法的作用)
	 * 
	 * @param fileName
	 * @param fields
	 * @return
	 */
	public static String getColumnType(String fileName, Field[] fields) {
		String type = "";
		if (fields.length > 0) {
			for (int i = 0; i < fields.length; i++) {
				String name = fields[i].getName(); // 获取属性的名字
				String filedType = fields[i].getGenericType().toString(); // 获取属性的类型
				if (fileName.equals(name)) {
					if (filedType.equals("class java.lang.Integer")) {
						filedType = "int";
						type = filedType;
					}else if (filedType.equals("class java.lang.Short")) {
						filedType = "short";
						type = filedType;
					}else if (filedType.equals("class java.lang.Double")) {
						filedType = "double";
						type = filedType;
					}else if (filedType.equals("class java.util.Date")) {
						filedType = "date";
						type = filedType;
					}else if (filedType.equals("class java.lang.String")) {
						filedType = "string";
						type = filedType;
					}else if (filedType.equals("class java.sql.Timestamp")) {
						filedType = "Timestamp";
						type = filedType;
					}else if (filedType.equals("class java.lang.Character")) {
						filedType = "character";
						type = filedType;
					}else if (filedType.equals("class java.lang.Boolean")) {
						filedType = "boolean";
						type = filedType;
					}else if (filedType.equals("class java.lang.Long")) {
						filedType = "long";
						type = filedType;
					}
				}
			}
		}
		return type;
	}

	/**
	 * 
	 * <b>Summary: </b> getSortColumnIndex(获取指定字段索引)
	 * 
	 * @param fileName
	 * @param fieldString
	 * @return
	 */
	protected static String getSortColumnIndex(String fileName, String[] fieldString) {
		String index = "";
		if (fieldString.length > 0) {
			for (int i = 0; i < fieldString.length; i++) {
				if (fileName.equals(fieldString[i])) {
					int j = i + 1;
					index = oConvertUtils.getString(j);
				}
			}
		}
		return index;

	}

	// JSON返回页面MAP方式
	public static void ListtoView(HttpServletResponse response, PageList pageList) {
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", pageList.getCount());
		map.put("rows", pageList.getResultList());
		ObjectMapper mapper = new ObjectMapper();
//		JSONObject jsonObject = JSONObject.fromObject(map);
		try {
			mapper.writeValue(response.getWriter(), map);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				response.getWriter().close();
			} catch (IOException e) {
			}
		}
	}

	/**
	 * 控件类型：easyui
	 * 返回datagrid JSON数据
	 * @param response
	 * @param dataGrid
	 */
	public static void datagrid(HttpServletResponse response,DataGrid dg) {
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		String jsonStr = TagUtil.getJson(dg);
		try {
			PrintWriter pw = response.getWriter();
			pw.write(jsonStr.toString());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				jsonStr = null;
				dg.clear();
				dg = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 控件类型：easyui
	 * 返回treegrid JSON数据
	 * @param response
	 * @param dataGrid
	 */
	public static void treegrid(HttpServletResponse response,DataGrid dg) {
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		String jsonStr = TagUtil.getJson(dg);
		JSONObject object = JSONObject.parseObject(jsonStr);
		JSONArray rows = object.getJSONArray("rows");
		try {
			PrintWriter pw = response.getWriter();
			pw.write(rows.toString());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				jsonStr = null;
				object.clear();
				dg.clear();
				dg = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 控件类型：easyui
	 * 返回datagrid JSON数据
	 * @param response
	 * @param dataGrid
	 * @param extMap 数据列表的扩展
	 */
	public static void datagrid(HttpServletResponse response,DataGrid dg,Map<String,Map<String,Object>>  extMap) {
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		String jsonStr = TagUtil.getJson(dg);
		JSONObject object = JSONObject.parseObject(jsonStr);
		JSONArray r =  object.getJSONArray("rows");
		for (Object object2 : r) {
			JSONObject o =(JSONObject) object2;
			o.putAll(extMap.get(o.get("id")));
		}
		
		try {
			PrintWriter pw = response.getWriter();
			pw = response.getWriter();
			pw.write(object.toString());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				object.clear();
				dg.clear();
				jsonStr = null;
				dg = null;
				extMap = null;
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
	
//	/**
//	 * 控件类型：datatable
//	 * 返回datatable JSON数据
//	 * @param response
//	 * @param datatable
//	 */
//	public static void datatable(HttpServletResponse response, DataTableReturn dataTableReturn,String field) {
//		response.setContentType("application/json");
//		response.setHeader("Cache-Control", "no-store");
//		JSONObject object = TagUtil.getJson(dataTableReturn,field);
//		try {
//			response.getWriter().write(object.toString());
//			response.getWriter().flush();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}finally{
//			try {
//				response.getWriter().close();
//			} catch (Exception e2) {
//				// TODO: handle exception
//			}
//		}
//	}

	/**
	 * 手工拼接JSON
	 */
	public static String getComboBoxJson(List<TSRole> list, List<TSRole> roles) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		for (TSRole node : list) {
			if (roles.size() > 0) {
				buffer.append("{\"id\":" + node.getId() + ",\"text\":\"" + node.getRoleName() + "\"");
				for (TSRole node1 : roles) {
					if (node.getId() == node1.getId()) {
						buffer.append(",\"selected\":true");
					}
				}
				buffer.append("},");
			} else {
				buffer.append("{\"id\":" + node.getId() + ",\"text\":\"" + node.getRoleName() + "\"},");
			}

		}
		buffer.append("]");

		// 将,\n]替换成\n]

		String tmp = buffer.toString();
		tmp = tmp.replaceAll(",]", "]");
		return tmp;

	}

	/**
	 * 根据模型生成JSON
	 * @param all 全部对象
	 * @param in  已拥有的对象
	 * @param comboBox 模型
	 * @return
	 */
	public static List<ComboBox> getComboBox(List all, List in, ComboBox comboBox) {
		List<ComboBox> comboxBoxs = new ArrayList<ComboBox>();
		String[] fields = new String[] { comboBox.getId(), comboBox.getText() };
		Object[] values = new Object[fields.length];
		for (Object node : all) {
			ComboBox box = new ComboBox();
			ReflectHelper reflectHelper=new ReflectHelper(node);
			for (int i = 0; i < fields.length; i++) {
				String fieldName = fields[i].toString();
				values[i] = reflectHelper.getMethodValue(fieldName);
			}
			box.setId(values[0].toString());
			box.setText(values[1].toString());
			if (in != null) {
				for (Object node1 : in) {
					ReflectHelper reflectHelper2=new ReflectHelper(node);
					if (node1 != null) {
						String fieldName = fields[0].toString();
						String	test = reflectHelper2.getMethodValue(fieldName).toString();
						if (values[0].toString().equals(test)) {
							box.setSelected(true);
						}
					}
				}
			}
			comboxBoxs.add(box);
		}
		return comboxBoxs;

	}
	/**
	 * 获取自定义函数名
	 * 
	 * @param functionname
	 * @return
	 */
	public static String getFunction(String functionname) {
		int index = functionname.indexOf("(");
		if (index == -1) {
			return functionname;
		} else {
			return functionname.substring(0, functionname.indexOf("("));
		}
	}

	/**
	 * 获取自定义函数的参数
	 * 
	 * @param functionname
	 * @return
	 */
	public static String getFunParams(String functionname) {
		int index = functionname.indexOf("(");
		String param = "";
		if (index != -1) {
			String testparam = functionname.substring(
					functionname.indexOf("(") + 1, functionname.length() - 1);
			if (StringUtil.isNotEmpty(testparam)) {
				String[] params = testparam.split(",");
				for (String string : params) {
					param += (string.indexOf("{") != -1) ? ("'\"+"
							+ string.substring(1, string.length() - 1) + "+\"',")
							: ("'\"+rec." + string + "+\"',");
				}
			}
		}
		param += "'\"+index+\"'";// 传出行索引号参数
		return param;
	}

	public static String getJson(List fields,List datas){
		if(datas!=null && datas.size()>0){
			StringBuffer sb = new StringBuffer();
			sb.append("{\"total\":\""+datas.size()+"\",\"rows\":[");
			for(int i=0;i<datas.size();i++){
				Object[] values = (Object[]) datas.get(i);
				sb.append("{");
				for(int j=0;j<values.length;j++){
					sb.append("\""+fields.get(j)+"\":\""+(values[j]==null?"":values[j])+"\""+(j==values.length-1?"":","));
				}
				sb.append("}"+(i==datas.size()-1?"":","));
			}
			sb.append("]}");
			
			return sb.toString();
		}else{
			return "{\"total\":\"0\",\"rows\":[]}";
		}
	}


	public static String getJsonByMap(List fields,List<Map<String,Object>> datas){
		if(datas!=null && datas.size()>0){
			StringBuffer sb = new StringBuffer();
			sb.append("{\"total\":\""+datas.size()+"\",\"rows\":[");
			for(int i=0;i<datas.size();i++){
				Map<String,Object> values = (Map<String,Object>) datas.get(i);
				sb.append("{");
				//for(int j=0;j<values.size();){
				int j=0;
				for (Object value : values.values()) {
					sb.append("\""+fields.get(j)+"\":\""+(value==null?"":value)+"\""+(j==values.size()-1?"":","));
					j++;
				}
					//sb.append("\""+fields.get(j)+"\":\""+(values.get(j)==null?"":values.get(j))+"\""+(j==values.size()-1?"":","));
				//}

				sb.append("}"+(i==datas.size()-1?"":","));
			}

			sb.append("]}");

			return sb.toString();
		}else{
			return "{\"total\":\"0\",\"rows\":[]}";
		}
	}
}
