package org.jeecgframework.tag.core.factory.util;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.DataGridTag;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.ColumnValue;
import org.jeecgframework.tag.vo.easyui.DataGridColumn;
import org.jeecgframework.tag.vo.easyui.DataGridUrl;
import org.jeecgframework.tag.vo.easyui.OptTypeDirection;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.web.system.service.SystemService;

public class ComponentTools {
	
	private static SystemService systemService;
	
	/**
	 * 拼装操作地址
	 * 
	 * @param sb
	 */
	public String getOptUrl(DataGridTag dataGridTag) {
		StringBuffer sb = new StringBuffer("");
		sb.append("if(!row.id){return '';}");
		sb.append("var href='';");
		List<DataGridUrl> list = dataGridTag.getUrlList();
		for (DataGridUrl dataGridUrl : list) {
			String url = dataGridUrl.getUrl();
			MessageFormat formatter = new MessageFormat("");
			if (dataGridUrl.getValue() != null) {
				String[] testvalue = dataGridUrl.getValue().split(",");
				List value = new ArrayList<Object>();
				for (String string : testvalue) {
					value.add("\"+row." + string + " +\"");
				}
				url = formatter.format(url, value.toArray());
			}
			if (url != null && dataGridUrl.getValue() == null) {

				url = formatUrlPlus(url);
			}
			String exp = dataGridUrl.getExp();// 判断显示表达式
			if (StringUtil.isNotEmpty(exp)) {
				String[] ShowbyFields = exp.split("&&");
				for (String ShowbyField : ShowbyFields) {
					int beginIndex = ShowbyField.indexOf("#");
					int endIndex = ShowbyField.lastIndexOf("#");
					String exptype = ShowbyField.substring(beginIndex + 1, endIndex);// 表达式类型
					String field = ShowbyField.substring(0, beginIndex);// 判断显示依据字段
					String[] values = ShowbyField.substring(endIndex + 1, ShowbyField.length()).split(",");// 传入字段值
					String value = "";
					for (int i = 0; i < values.length; i++) {
						value += "'" + "" + values[i] + "" + "'";
						if (i < values.length - 1) {
							value += ",";
						}
					}
					if ("eq".equals(exptype)) {
						sb.append("if($.inArray(row." + field + ",[" + value + "])>=0){");
					}
					if ("ne".equals(exptype)) {
						sb.append("if($.inArray(row." + field + ",[" + value + "])<0){");
					}
					if ("empty".equals(exptype) && value.equals("'true'")) {
						sb.append("if(row." + field + "==''){");
					}
					if ("empty".equals(exptype) && value.equals("'false'")) {
						sb.append("if(row." + field + "!=''){");
					}
				}
			}

			StringBuffer style = new StringBuffer();
			if (!StringUtil.isEmpty(dataGridUrl.getUrlStyle())) {
				style.append(" style=\'");
				style.append(dataGridUrl.getUrlStyle());
				style.append("\' ");
			}
			StringBuffer urlclass = new StringBuffer();
			if(!StringUtil.isEmpty(dataGridUrl.getUrlclass())){
				urlclass.append(" class=\'");
				urlclass.append(dataGridUrl.getUrlclass());
				urlclass.append("\'");
			}
			StringBuffer urlfont = new StringBuffer();

			if(!StringUtil.isEmpty(dataGridUrl.getUrlfont())){
				urlfont.append(" <i class=\'fa ");
				urlfont.append(dataGridUrl.getUrlfont());
				urlfont.append("\' aria-hidden=\'true\'></i>");			
			}
			if (OptTypeDirection.Confirm.equals(dataGridUrl.getType())) {
				if(!StringUtil.isEmpty(dataGridUrl.getUrlclass())){
					sb.append("href+=\"<a href=\'javascript:void(0);\' "+urlclass.toString()+"  onclick=confirm(\'" + url + "\',\'" + dataGridUrl.getMessage() + "\',\'"+dataGridTag.getName()+"\')" + style.toString() + "> "+urlfont.toString()+" \";");
				}else{
					sb.append("href+=\"<a href=\'javascript:void(0);\' class='btn btn-primary btn-xs' onclick=confirm(\'" + url + "\',\'" + dataGridUrl.getMessage() + "\',\'"+dataGridTag.getName()+"\')" + style.toString() + "> \";");
				}
			}
			if (OptTypeDirection.Del.equals(dataGridUrl.getType())) {
				if(!StringUtil.isEmpty(dataGridUrl.getUrlclass())){//倘若urlclass不为空，则去掉链接前面的"[";
					sb.append("href+=\"<a href=\'javascript:void(0);\' "+urlclass.toString()+"  onclick=delObj(\'" + url + "\',\'"+dataGridTag.getName()+"\')" + style.toString() + "> "+urlfont.toString()+" \";");
				}else{
					sb.append("href+=\"<a href=\'javascript:void(0);\' class='btn btn-danger btn-xs' onclick=delObj(\'" + url + "\',\'"+dataGridTag.getName()+"\')" + style.toString() + ">\";");
				}
				
			}
			if (OptTypeDirection.Fun.equals(dataGridUrl.getType())) {
				String name = TagUtil.getFunction(dataGridUrl.getFunname());
				String parmars = getFunParams(dataGridUrl.getFunname());
				if(!StringUtil.isEmpty(dataGridUrl.getUrlclass())){//倘若urlclass不为空，则去掉链接前面的"[";
					sb.append("href+=\"<a href=\'javascript:void(0);\' "+urlclass.toString()+"  onclick=" + name + "(" + parmars + ")" + style.toString() + ">  "+urlfont.toString()+" \";");
				}else{
					sb.append("href+=\"<a href=\'javascript:void(0);\' class='btn btn-info btn-xs'   onclick=" + name + "(" + parmars + ")" + style.toString() + ">\";");
				}
				
			}
			if (OptTypeDirection.OpenWin.equals(dataGridUrl.getType())) {
				if(!StringUtil.isEmpty(dataGridUrl.getUrlclass())){//倘若urlclass不为空，则去掉链接前面的"[";
					sb.append("href+=\"<a href=\'javascript:void(0);\' "+urlclass.toString()+" onclick=openwindow('" + dataGridUrl.getTitle() + "','" + url + "','"+dataGridTag.getName()+"'," + dataGridUrl.getWidth() + "," + dataGridUrl.getHeight() + ")" + style.toString() + "> "+urlfont.toString()+" \";");
				}else{
					sb.append("href+=\"<a href=\'javascript:void(0);\' class='btn btn-success btn-xs' onclick=openwindow('" + dataGridUrl.getTitle() + "','" + url + "','"+dataGridTag.getName()+"'," + dataGridUrl.getWidth() + "," + dataGridUrl.getHeight() + ")" + style.toString() + ">\";");
				}
			}															//update-end--Author:liuht  Date:20130228 for：弹出窗口设置参数不生效
			if (OptTypeDirection.Deff.equals(dataGridUrl.getType())) {
				if(!StringUtil.isEmpty(dataGridUrl.getUrlclass())){
					sb.append("href+=\"<a href=\'javascript:void(0);\' onclick=\'location.href=" + url + "' "+urlclass.toString()+" title=\'"+dataGridUrl.getTitle()+"\'" + style.toString() + "> "+urlfont.toString()+" \";");
				}else{
					sb.append("href+=\"<a href=\'javascript:void(0);\' class='btn btn-default btn-xs' onclick=\'location.href=" + url + "' title=\'"+dataGridUrl.getTitle()+"\'" + style.toString() + ">\";");
				}
			}
			if (OptTypeDirection.OpenTab.equals(dataGridUrl.getType())) {
				sb.append("href+=\"<a href=\'javascript:void(0);\' class='btn btn-primary btn-xs' onclick=addOneTab('" + dataGridUrl.getTitle() + "','" + url  + "')>\";");
			}
			sb.append("href+=\"" + dataGridUrl.getTitle() + "</a>&nbsp;\";");


			if (StringUtil.isNotEmpty(exp)) {
				for (int i = 0; i < exp.split("&&").length; i++) {
					sb.append("}");
				}

			}
		}
		sb.append("return href;");
		return sb.toString();
	}
	
	/**
	 * 获取自定义函数的参数
	 * 
	 * @param functionname
	 * @return
	 */
	public  String getFunParams(String functionname) {
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
							: ("'\"+row." + string + "+\"',");
				}
			}
		}
		param += "'\"+index+\"'";// 传出行索引号参数
		return param;
	}
	
	
	/**
	 * formatUrl增强写法
	 * 支持#{}、{}、##三种传参方式
	 * @param url
	 * @return
	 */
	public String formatUrlPlus(String url) {
		boolean isTrans = false;
		if(url.indexOf("#{") >= 0){
			isTrans = true;
			url = url.replace("#{", "\"+row.");
			url = url.replace("}", "+\"");
		}
		if(url.indexOf("{") >= 0 && !isTrans){
			url = url.replace("{", "\"+row.");
			url = url.replace("}", "+\"");
		}
		if(url.indexOf("#") > 0 && !isTrans){
			Pattern p = Pattern.compile("#", Pattern.CASE_INSENSITIVE);
			StringBuffer sb = new StringBuffer();
			Matcher m = p.matcher(url);
			int i = 0;
			while(m.find()) {
				i++;
				if(i %2 == 0){
					m.appendReplacement(sb, "+\"");
				} else {
					m.appendReplacement(sb, "\"+row.");
				}
			}
			m.appendTail(sb);
			url = sb.toString();
		}
		return url;
	}
	
	
	public String getCellStyle(ColumnValue columnValue) {
		StringBuffer sb = new StringBuffer("");
		String testString = "";
		String[] value = columnValue.getValue().split(",");
		String[] text = columnValue.getText().split(",");
		sb.append(",cellStyle:function(value,row,index){");
		if((value.length == 0||StringUtils.isEmpty(value[0]))&&text.length==1){
			if(text[0].indexOf("(")>-1){
				testString = " return \'" + text[0].replace("(", "(value,row,index") + "\'";
			}else{
				testString = " return \'" + text[0] + "\'";
			}
		}else{
			for (int j = 0; j < value.length; j++) {
				testString += "if(value=='" + value[j] + "'){return \'" + text[j] + "\'}";
			}
		}
		sb.append(testString);
		sb.append("}");
		return sb.toString();
	}
	
	public List<TSType> getDictData(DataGridColumn col){
		Map<String, List<TSType>> typedatas = ResourceUtil.allTypes;
		List<TSType> types = typedatas.get(col.getDictionary().toLowerCase());
		return types;
	}
	
	public List<Map<String, Object>> getTableDictData(DataGridColumn col){
		String[] dic = col.getDictionary().split(",");
		String sql;
		if(!StringUtil.isEmpty(col.getDictCondition())){
			sql = "select " + dic[1] + " as field," + dic[2]+ " as text from " + dic[0]+" "+col.getDictCondition();
		}else{
			sql = "select " + dic[1] + " as field," + dic[2]+ " as text from " + dic[0];
		}
		systemService = ApplicationContextUtil.getContext().getBean(
				SystemService.class);
		List<Map<String, Object>> list = systemService.findForJdbc(sql);
		return list;
	}
}
