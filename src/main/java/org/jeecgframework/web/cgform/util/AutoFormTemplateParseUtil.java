package org.jeecgframework.web.cgform.util;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.JSONHelper;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigHeadEntity;
import org.jeecgframework.web.cgreport.service.core.CgreportConfigHeadServiceI;
import org.jeecgframework.web.system.manager.ClientManager;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.web.system.pojo.base.TSTypegroup;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * 自定义表单解析
 * @author zhoujf
 *
 */
public class AutoFormTemplateParseUtil {
	
	
	/**
	 *  自定义表单操作方式模式
	 *  add :  表单填报添加提交模式
	 *  update ：表单填报更新提交模式
	 *  addorupdate：表单填报智能提交模式
	 *  view：表单预览查看模式
	 */
	public static String OP_ADD="add";
	public static String OP_UPDATE="update";
	public static String OP_ADD_OR_UPDATE="addorupdate";
	public static String OP_VIEW="view";
	private static MutiLangServiceI mutiLangService;
	private static CgreportConfigHeadServiceI cgreportConfigHeadService;
	
	/**
	 * 预览模式解析html
	 * @param ontent
	 * @param paras
	 * @return
	 */
	public static String parseHtmlForView(String content,Map<String, List<Map<String, Object>>> paras){
		JSONObject jsonObj  = JSONObject.fromObject(content);
		if(jsonObj.isNullObject()||jsonObj.isEmpty()){
			return "";
		}
		String html  = (String)jsonObj.get("parse");
		//1.取得所有的input标签属性信息
		List<Map<String,Object>> list=getAllInputAttr(jsonObj);
		if(list!=null&&list.size()>0){
			for(Map<String,Object> atrrMap:list){
				html = createHtml(html,atrrMap,paras);
			}
		}
		return html;
	}
	
	/**
	 * 表单填报添加提交模式解析html
	 * @param content
	 * @param paras
	 * @return
	 */
	public static String parseHtmlForAdd(String content,Map<String, List<Map<String, Object>>> paras){
		JSONObject jsonObj  = JSONObject.fromObject(content);
		if(jsonObj.isNullObject()||jsonObj.isEmpty()){
			return "";
		}
		String html  = (String)jsonObj.get("parse");
		//1.取得所有的input标签属性信息
		List<Map<String,Object>> list=getAllInputAttr(jsonObj);
		if(list!=null&&list.size()>0){
			for(Map<String,Object> atrrMap:list){
				html = createHtml(html,atrrMap,paras);
			}
		}
		return html;
	}
	
	/**
	 * 表单填报更新提交模式解析html
	 * @param content
	 * @param paras
	 * @return
	 */
	public static String parseHtmlForUpdate(String content,Map<String, List<Map<String, Object>>> paras){
		JSONObject jsonObj  = JSONObject.fromObject(content);
		if(jsonObj.isNullObject()||jsonObj.isEmpty()){
			return "";
		}
		String html  = (String)jsonObj.get("parse");
		//1.取得所有的input标签属性信息
		List<Map<String,Object>> list=getAllInputAttr(jsonObj);
		if(list!=null&&list.size()>0){
			for(Map<String,Object> atrrMap:list){
				html = createHtml(html,atrrMap,paras);
			}
		}
		return html;
	}
	
	/**
	 * 表单填报智能提交模式解析html
	 * @param content
	 * @param paras
	 * @return
	 */
	public static String parseHtmlForAddOrUpdate(String content,Map<String, List<Map<String, Object>>> paras){
		JSONObject jsonObj  = JSONObject.fromObject(content);
		if(jsonObj.isNullObject()||jsonObj.isEmpty()){
			return "";
		}
		String html  = (String)jsonObj.get("parse");
		//1.取得所有的input标签属性信息
		List<Map<String,Object>> list=getAllInputAttr(jsonObj);
		if(list!=null&&list.size()>0){
			for(Map<String,Object> atrrMap:list){
				html = createHtml(html,atrrMap,paras);
			}
		}
		return html;
	}
	
	
	/**
	 * 根据input属性配置生成html代码段
	 * @param html   html模板
	 * @param atrrMap input属性配置
	 * @param paras   数据源数据
	 * @return
	 */
	private static String createHtml(String html,Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String leipiplugins = (String)atrrMap.get("leipiplugins");
		String content = (String)atrrMap.get("content");
		if("listctrl".equals(leipiplugins)){
			String tempHtml = getListctrl(atrrMap,paras);
			html = html.replace(content, tempHtml);
		}else if("text".equals(leipiplugins)){
			String tempHtml = getText(atrrMap,paras);
			html = html.replace(content, tempHtml);
		}else if("textarea".equals(leipiplugins)){
			String tempHtml = getTextarea(atrrMap,paras);
			html = html.replace(content, tempHtml);
		} else if("select".equals(leipiplugins)){
			String tempHtml = getSelect(atrrMap,paras);
			html = html.replace(content, tempHtml);
		} else if("radios".equals(leipiplugins)){
			String tempHtml = getRadio(atrrMap,paras);
			html = html.replace(content, tempHtml);
		} else if("checkboxs".equals(leipiplugins)){
			String tempHtml = getCheckbox(atrrMap,paras);
			html = html.replace(content, tempHtml);
		} else if("popup".equals(leipiplugins)){
			String tempHtml = getPopup(atrrMap,paras);
			html = html.replace(content, tempHtml);
		} else if("macros".equals(leipiplugins)){
			String tempHtml = getMacros(atrrMap,paras);
			html = html.replace(content, tempHtml);
		} else if(leipiplugins==null){
			String tempHtml = getHiddenText(atrrMap,paras);
			html = html.replace(content, tempHtml);
		}
		return html;
	}
	
	/**
	 * 获取list列表代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getListctrl(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String name = (String)atrrMap.get("name");
//		String value = formData.get(name) == null ? null : formData.get(name)
//				.toString();
		String temp_html = "";
		String autofield = (String)atrrMap.get("autofield");
		String orgSum = (String)atrrMap.get("orgsum");
		String orgUnit = (String)atrrMap.get("orgunit");
		String orgTitle = (String)atrrMap.get("orgtitle");
		String title = (String)atrrMap.get("title");
		String style = (String)atrrMap.get("style");
		String orgcolvalue = (String)atrrMap.get("orgcolvalue");
		String orgcoltype = (String)atrrMap.get("orgcoltype");
		String pkid = (String)atrrMap.get("pkid");
		String fkdsid = (String)atrrMap.get("fkdsid");
		
		String isHides = (String)atrrMap.get("ishide");
		String ruletypes = (String)atrrMap.get("ruletype");
		String dicts = (String)atrrMap.get("dict");
		String lenths = (String)atrrMap.get("length");
		
		if(autofield==null){
			autofield = "";
		}
		List<String> listAutofield = Arrays.asList(autofield.split("`"));
		List<String> listTitle = Arrays.asList(orgTitle.split("`"));
		List<String> listSum = Arrays.asList(orgSum.split("`"));
		List<String> listUnit = Arrays.asList(orgUnit.split("`"));
		List<String> listValue = Arrays.asList(orgcolvalue.split("`"));
		List<String> listType = Arrays.asList(orgcoltype.split("`"));
		
		List<String> listIsHide = Arrays.asList(isHides.split("`"));
		List<String> listruletype = Arrays.asList(ruletypes.split("`"));
		List<String> listdict = Arrays.asList(dicts.split("`"));
		List<String> listlength = Arrays.asList(lenths.split("`"));
		
		int tdCount = listTitle.size();
		String tableId = name + "_table";
		String dsName = getListDsName(listAutofield);
		//是否有合计行
		boolean isExistSum = false;
		String listfk = "<input type=\"hidden\" name=\"listctrl_fk_"+dsName+"\" value=\""+pkid+"\">";
		String listfkdsid = "<input type=\"hidden\" name=\"listctrl_fkdsid_"+dsName+"\" value=\""+fkdsid+"\">";
		String rowTemplet = getListctrlRowTemplet(name,atrrMap);
		String temp = listfk+listfkdsid+rowTemplet+"<table id=\""
				+ name
				+ "_table\" bindTable=\"true\" cellspacing=\"0\" class=\"table table-bordered table-condensed\" style=\""
				+ style + "\"><thead>{0}</thead><tbody>{1}</tbody>{2}</table><input type=\"hidden\" id=\"tableId\" name=\"tableId\" value=\""+tableId+"\">";
		String btnAdd = "<span class=\"pull-right\"><button id='listAdd' class=\"btn btn-small btn-success listAdd\" type=\"button\" tbname=\""
				+ name + "\">添加一行</button></span>"; // 添加按钮
		String theader = "<tr><th colspan=\"{0}\">{1}{2}</th></tr>{3}";// 头部模版
		
		//1.拼接标题
		String trTitle = "";
		for (int i = 0; i < tdCount; i++) {
			String isHide = listIsHide.get(i);
			
			if(!"1".equals(isHide)){
				trTitle += MessageFormat.format("<th>{0}</th>", listTitle.get(i));
			}else{
				trTitle += MessageFormat.format("<th style=\"display:none\">{0}</th>", listTitle.get(i));
			}
            if ((i+1) == tdCount){
              //update start by renjie at 2015101 for:用span撑开th，使之变成块
        	  trTitle += MessageFormat.format("<th><span style='width:60px;display:block;'>{0}</span></th>", "操作");
        	//update end by renjie at 2015101 for:用span撑开th，使之变成块
		    }
		}
		trTitle = "<tr>" + trTitle + "</tr>";
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(StringUtil.isNotEmpty(dsName)){
			 list = paras.get(dsName);
		}

		int rowCount = list != null ? list.size() : 1;
		if(rowCount<1){
			rowCount = 1;
		}

		StringBuilder sbTr = new StringBuilder();
		String tdSum = "";// 如果有统计增加一行

		TreeMap<Integer, Float> SumValueDic = new TreeMap<Integer, Float>();
		int headerColspan = tdCount;
		for (int row = 0; row < rowCount; row++) {

//			JSONArray rowValue = (dataValue != null && dataValue
//					.has(name + row)) ? dataValue.getJSONArray(name + row)
//					: null;
			Map<String, Object> dataMap = null;
			if(list != null&&list.size()>0){
				dataMap = list.get(row);
			}else{
//				dataMap = new HashMap<String, Object>();
				continue;
			}
					
			String tr = "";// 默认一行
			String tdContent = "";
			for (int i = 0; i < tdCount; i++) {
				String rowName = listAutofield.get(i);
				Object rowValue = getListFieldValue(dataMap,listAutofield.get(i));
				
				String isHide = listIsHide.get(i);
				String ruletype = "0".equals(listruletype.get(i)) ?"":listruletype.get(i);
				String dict = "0".equals(listdict.get(i)) ?"":listdict.get(i);
				String length = "#".equals(listlength.get(i)) ?"":listlength.get(i);
				String unit = "";
				if(listUnit!=null&&listUnit.size()==tdCount&&!"#".equals(listUnit.get(i))){
					unit = getTypename("units",listUnit.get(i));
				} 
				
				String flag = "0";
				if("1".equals(isHide)){
					flag = "1";
				}
				
				String tdname = rowName + "[" + row + "]";
				String sum = "1".equals(listSum.get(i)) ? "sum=\"" + rowName
						+ "\"" : "";// 是否参与统计
				Object tdValue ="";
//				if(i<listValue.size()){ 
//					 tdValue = StringUtils.isBlank(listValue.get(i))?"":listValue.get(i);
//				}
//				String defaultValue = listValue.get(i);
				tdValue = rowValue != null ? rowValue:"";
				if(tdValue instanceof Date){
					SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					tdValue = DateUtils.date2Str((Date)tdValue, sformat);
				}
				String type = listType.get(i);// 类型

				if (sum != "")// 一次循环计算该列的值
				{
					// region 计算统计值
					float tempTdValue = 0;
					if (SumValueDic.containsKey(i))
						tempTdValue = SumValueDic.get(i);
					try {
						float resultTdTemp = 0;
						resultTdTemp = Float.parseFloat((String)tdValue);
						// float.TryParse(tdValue, out resultTdTemp);
						tempTdValue += resultTdTemp;
					} catch (Exception e) {
						tdValue = "0";
					}
					if (SumValueDic.containsKey(i)){
						SumValueDic.subMap(i, i);
					}else{
						SumValueDic.put(i, tempTdValue);
					}
					// endregion

				}
				//update begin by jg_renjie at:20151107 for:添加datatype属性
				//String ruletype = listruletype.size()==tdCount?listruletype.get(i):"";
				if(!"1".equals(flag)){
					if ("text".equals(type)){
						tdContent = "<td><input class=\"input-medium\" type=\"text\"";
						if(StringUtils.isNotBlank(ruletype)){
							tdContent += " datatype=\""+ruletype+"\" ";
						} else if(StringUtils.isNotBlank(length)){
							tdContent += " style=\"width:"+length+"px\"";
						}
						tdContent += "value=\"{0}\" name=\"{1}\" {2}>";
						if(!"#".equals(unit)){
							tdContent += unit;
						}
						tdContent += "</td>";
						tr += MessageFormat
								.format(
										tdContent,
										tdValue.toString(), tdname, sum);
					} else if ("int".equals(type)){
						
						tdContent = "<td><input class=\"input-medium\" type=\"text\"";
						if(StringUtils.isNotBlank(ruletype)){
							tdContent += " datatype=\""+ruletype+"\" ";
						} else if(StringUtils.isNotBlank(length)){
							tdContent += " style=\"width:"+length+"px\"";
						}
						tdContent += "value=\"{0}\" name=\"{1}\" {2}>";
						if(!"#".equals(unit)){
							tdContent += unit;
						}
						tdContent += "</td>";
						
						tr += MessageFormat
								.format(
										tdContent,
										tdValue, tdname, sum);
					} else if ("textarea".equals(type)){
						tdContent = "<td><textarea  ";
						if(StringUtils.isNotBlank(ruletype)){
							tdContent += " datatype=\""+ruletype+"\" ";
						} else if(StringUtils.isNotBlank(length)){
							tdContent += " style=\"width:"+length+"px\"";
						}
						tdContent += " name=\"{1}\" {2}>{0}</textarea></td>";
						
//						tdContent = "<td><input class=\"input-medium\" type=\"text\"";
//						if(StringUtils.isNotBlank(ruletype)){
//							tdContent += " datatype=\""+ruletype+"\" ";
//						} else if(StringUtils.isNotBlank(length)){
//							tdContent += " maxlength=\""+length+"\"";
//						}
//						tdContent += "value=\"{0}\" name=\"{1}\" {2}></td>";
						
						tr += MessageFormat
								.format(
										tdContent,
										tdValue.toString(), tdname, sum);
					} else if ("calc".equals(type)){
						
						tdContent = "<td><input class=\"input-medium\" type=\"text\"";
						if(StringUtils.isNotBlank(ruletype)){
							tdContent += " datatype=\""+ruletype+"\" ";
						} else if(StringUtils.isNotBlank(length)){
							tdContent += " style=\"width:"+length+"px\"";
						}
						tdContent += "value=\"{0}\" name=\"{1}\" {2}></td>";
						
						tr += MessageFormat
								.format(
										tdContent,
										tdValue, tdname, sum);
					}//add start by renjie  at 20151111 for:配合字典类型生成对应的type类型
					else if("radio".equals(type)){
						StringBuffer radioBuff = new StringBuffer();
						if(StringUtils.isNotBlank(dict)){//字段组不为空时
							radioBuff.append("<td>");
							radioBuff.append(getDicts(dict,"radio",tdValue));
							radioBuff.append("</td>");
							tr += MessageFormat.format(radioBuff.toString(), tdname);
						} else {
							radioBuff.append("<td><input class=\"input-medium\" type=\"radio\" value=\"{0}\" name=\"{1}\"></td>");
							tr += MessageFormat.format(radioBuff.toString(), tdValue, tdname);
						}
					}
					else if("select".equals(type)){
						StringBuffer selectBuff = new StringBuffer();
						if(StringUtils.isNotBlank(dict)){//字段组不为空时
							selectBuff.append("<td><select name=\"{0}\">");
							selectBuff.append(getDicts(dict,"select",tdValue));
							selectBuff.append("</select></td>");
						} else {
							selectBuff.append("<td><select class=\"input-medium\" name=\"{0}\"></select></td>");
						}
						tr += MessageFormat
						.format(
								selectBuff.toString(), tdname);				
					}
					else if("checkbox".equals(type)){
						StringBuffer checkboxBuff = new StringBuffer();
						if(StringUtils.isNotBlank(dict)){//字段组不为空时
							checkboxBuff.append("<td>");
							checkboxBuff.append(getDicts(dict,"checkbox",tdValue));
							checkboxBuff.append("</td>");
							tr += MessageFormat.format(checkboxBuff.toString(), tdname);
						} else {
							checkboxBuff.append("<td><input class=\"input-medium\" type=\"checkbox\" value=\"{0}\" name=\"{1}\"></td>");
							tr += MessageFormat.format(checkboxBuff.toString(),tdValue, tdname);
						}
					}
					else if("popup".equals(type)){
						CgreportConfigHeadEntity cgreportConfigHeadEntity = getCgreportConfigHeadEntity(dict);
						if(cgreportConfigHeadEntity!=null){
							StringBuffer radioBuff = new StringBuffer();
								radioBuff.append("<td><input id=\"{0}\" name=\"{0}\" type=\"text\"  class=\"input-medium\" style=\"background: url(plug-in/easyui/themes/default/images/searchbox_button.png) 100% 50% no-repeat rgb(255, 255, 255);\" onClick='inputClick(this,\""+cgreportConfigHeadEntity.getReturnValField()+"\",\""+dict+"\");'  value=\"{1}\"></td>");
							tr += MessageFormat
							.format(radioBuff.toString(),tdname,tdValue);
						}
					}
					//add end by renjie  at 20151111 for:配合字典类型生成对应的type类型
				}
				else{
					    headerColspan = headerColspan-1;
						tr += MessageFormat
								.format(
										"<td style=\"display:none\"><input class=\"input-medium\" type=\"hidden\" value=\"{0}\" name=\"{1}\" {2}></td>",
										tdValue, tdname, sum);
				}
				
				//update end by jg_renjie at:20151107 for:添加datatype属性
				
				if ((i+1) == tdCount)// 最后一列不显示
				{
//					if(row == 0){
//						tr += "<td></td>";
//					} else {
						tr += "<td><button class=\"btn btn-small btn-success delrow\" type=\"button\">删除</button></td>";
//					}
				}

				if (row == 0)// 统计的行只有一行
				{
					// region
					if(!"1".equals(flag)){
						if (sum != "") {
							    isExistSum = true;
							    tdSum += MessageFormat
									.format(
											"<td>合计：<input class=\"input-small\" type=\"text\" value=\"value{0}\" name=\"{1}[total]\" {2}\">{3}</td>",
											i, tdname, sum, "");
						} else {
							tdSum += "<td></td>";
						}
					}
				}

			}
			sbTr.append(MessageFormat.format("<tr class=\"template\">{0}</tr>",
					tr));

		}

		if (!StringUtils.isBlank(tdSum)) {
			for (Integer i : SumValueDic.keySet()) {
				tdSum = tdSum.replace("value" + i, SumValueDic.get(i)
						.toString());
				tdSum = MessageFormat.format(
						"<tbody class=\"sum\"><tr>{0}</tr></tbody>", tdSum);
			}
		}
		theader = MessageFormat.format(theader, headerColspan+1, title, btnAdd,trTitle);

		temp_html = MessageFormat.format(temp, theader, sbTr.toString(), tdSum);
		String divId = name+"_row_templet";
		temp_html += "<script type=\"text/javascript\">";
		temp_html += "$(function(){";
		temp_html += "$(\"#listAdd\").click(function(){";
//		temp_html += "var tbHtml ='<tr>'+ $(\"#"+tableId+" tbody\").eq(0).find(\"tr\").eq(0).html().replace('<td></td>',\"<td><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>\")+'</tr>';";
		temp_html += "var tbHtml ='<tr>'+ $(\"#"+divId+"\").val().replace(/#textarea#/g,'textarea')+'</tr>';";
		if(isExistSum){//存在合计行，则将行插入到倒数第二行的后面
			temp_html +="$(\"#"+tableId+" tbody\").eq(0).append(tbHtml);";
			//temp_html +="$(\"#"+tableId+" tbody\").eq(0).find(\"tr:first\").find(\"input\").each(function(){$(this).val(\"\");});";
		} else {//不存在合计行，则将行插入到最后一行
			temp_html +="$(\"#"+tableId+" tbody\").eq(0).append(tbHtml);";
			//temp_html +="$(\"#"+tableId+" tbody\").eq(0).find(\"tr:first\").find(\"input\").each(function(){$(this).val(\"\");});";
		}
		//为新增的行绑定删除方法，不然新增的行不会绑定
		temp_html += "$(\".delrow\").die().live(\"click\",function(){$(this).parent().parent().remove();resetTrNum();});resetTrNum();";
		temp_html += "});";
	    //添加删除按钮的方法
		temp_html +="$(\".delrow\").click(function(){$(this).parent().parent().remove();resetTrNum();});";
		temp_html += "});";
		temp_html +="function resetTrNum() {";
		temp_html +="var tableId = $(\"#tableId\").val();";
		temp_html +="$(\"#"+tableId + " tbody tr\").each(function(i) {";
	    temp_html +="	$(':input, select,a', this).each(function() {";
	    temp_html +="	var $this = $(this), name = $this.attr('name'), val = $this.val();";
		temp_html +="	if (name != null) {";
		temp_html +="	    if(name.indexOf('[')){"; 
		temp_html +="            var subnames = name.split('[');";
		temp_html +="            var newname = subnames[0]+'['+(i)+']';";
		temp_html +="            $this.attr('name',newname); ";
		temp_html +=		"}else{";
		temp_html +="         var newname = name+  '['+i+']';";
		temp_html +="         $this.attr('name',newname);";
		temp_html +="      }";
		temp_html +="	 }";
		temp_html +=" });";
		temp_html +="});";
		temp_html +="}";
		temp_html +="</script>";
		return temp_html;
	}
	

	private static String getListctrlRowTemplet(String name,Map<String,Object> atrrMap){
		String autofield = (String)atrrMap.get("autofield");
		String orgcoltype = (String)atrrMap.get("orgcoltype");
		String isHides = (String)atrrMap.get("ishide");
		String ruletypes = (String)atrrMap.get("ruletype");
		String dicts = (String)atrrMap.get("dict");
		String lenths = (String)atrrMap.get("length");
		String orgUnit = (String)atrrMap.get("orgunit");
		
		if(autofield==null){
			autofield = "";
		}
		List<String> listAutofield = Arrays.asList(autofield.split("`"));
		List<String> listType = Arrays.asList(orgcoltype.split("`"));
		
		List<String> listIsHide = Arrays.asList(isHides.split("`"));
		List<String> listruletype = Arrays.asList(ruletypes.split("`"));
		List<String> listdict = Arrays.asList(dicts.split("`"));
		List<String> listlength = Arrays.asList(lenths.split("`"));
		List<String> listUnit = Arrays.asList(orgUnit.split("`"));
		
		StringBuilder rowTempletDiv = new StringBuilder();
		Map<String, Object> dataMap =  new HashMap<String, Object>();
		String tr = "";// 默认一行
		int tdCount = listAutofield.size();
		for (int i = 0; i < tdCount; i++) {
			String rowName = listAutofield.get(i);
			Object rowValue = getListFieldValue(dataMap,listAutofield.get(i));
			String ruletype = "0".equals(listruletype.get(i)) ?"":listruletype.get(i);
			String isHide = listIsHide.get(i);
			String flag = "0";
			if("1".equals(isHide)){
				flag = "1";
			}
			
			String length = "#".equals(listlength.get(i)) ?"":listlength.get(i);
			String dict = "0".equals(listdict.get(i)) ?"":listdict.get(i);
			String unit = "";
			if(listUnit!=null&&listUnit.size()==tdCount&&!"#".equals(listUnit.get(i))){
				unit = getTypename("units",listUnit.get(i));
			} 
			String tdname = rowName + "[#index#]";
			String sum =  "";
			Object tdValue ="";
			tdValue = rowValue != null ? rowValue:"";
			if(tdValue instanceof Date){
				SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				tdValue = DateUtils.date2Str((Date)tdValue, sformat);
			}
			String type = listType.get(i);// 类型
			String tdContent = "";
			if(!"1".equals(flag)){
				if ("text".equals(type)){
					tdContent += "<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}\" {2}";
					if(StringUtils.isNotBlank(ruletype)){
						tdContent += " datatype=\""+ruletype+"\" ";
					} else if(StringUtils.isNotBlank(length)){
						tdContent += " style=\"width:"+length+"px\"";
					}
					tdContent += ">";
					if(!"#".equals(unit)){
						tdContent += unit;
					}
					tdContent += "</td>";
					tr += MessageFormat
							.format(tdContent,
									tdValue.toString(), tdname, sum);
				} else if ("int".equals(type)){
					tdContent += "<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}\" {2}";
					if(StringUtils.isNotBlank(ruletype)){
						tdContent += " datatype=\""+ruletype+"\" ";
					} else if(StringUtils.isNotBlank(length)){
						tdContent += " style=\"width:"+length+"px\"";
					}
					tdContent += ">";
					if(!"#".equals(unit)){
						tdContent += unit;
					}
					tdContent += "</td>";
					
					tr += MessageFormat
							.format(tdContent,
									tdValue.toString(), tdname, sum);
				} else if ("textarea".equals(type)){
//					tdContent += "<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}\" {2}";
//					if(StringUtils.isNotBlank(ruletype)){
//						tdContent += " datatype=\""+ruletype+"\" ";
//					} else if(StringUtils.isNotBlank(length)){
//						tdContent += " maxlength=\""+length+"\"";
//					}
//					tdContent += "></td>";
					
					tdContent = "<td><#textarea#  ";
					if(StringUtils.isNotBlank(ruletype)){
						tdContent += " datatype=\""+ruletype+"\" ";
					} else if(StringUtils.isNotBlank(length)){
						tdContent += " style=\"width:"+length+"px\"";
					}
					tdContent += " name=\"{1}\" {2}>{0}</#textarea#></td>";
					
					tr += MessageFormat
							.format(tdContent,
									tdValue.toString(), tdname, sum);
				} else if ("calc".equals(type)){
					tdContent += "<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}\" {2}";
					if(StringUtils.isNotBlank(ruletype)){
						tdContent += " datatype=\""+ruletype+"\" ";
					} else if(StringUtils.isNotBlank(length)){
						tdContent += " style=\"width:"+length+"px\"";
					}
					tdContent += "></td>";
					
					tr += MessageFormat
							.format(tdContent,
									tdValue.toString(), tdname, sum);
				}else if("radio".equals(type)){
					StringBuffer radioBuff = new StringBuffer();
					if(StringUtils.isNotBlank(dict)){//字段组不为空时
						radioBuff.append("<td>");
						radioBuff.append(getDicts(dict,"radio",null));
						radioBuff.append("</td>");
						tr += MessageFormat.format(radioBuff.toString(), tdname);
					} else {
						radioBuff.append("<td><input class=\"input-medium\" type=\"radio\" value=\"{0}\" name=\"{1}\"></td>");
						tr += MessageFormat.format(radioBuff.toString(), tdValue, tdname);
					}
				}
				else if("select".equals(type)){
					StringBuffer selectBuff = new StringBuffer();
					if(StringUtils.isNotBlank(dict)){//字段组不为空时
						selectBuff.append("<td><select name=\"{0}\">");
						selectBuff.append(getDicts(dict,"select",null));
						selectBuff.append("</select></td>");
					} else {
						selectBuff.append("<td><select class=\"input-medium\" name=\"{0}\"></select></td>");
					}
					tr += MessageFormat
					.format(
							selectBuff.toString(), tdname);				
				}
				else if("checkbox".equals(type)){
					StringBuffer checkboxBuff = new StringBuffer();
					if(StringUtils.isNotBlank(dict)){//字段组不为空时
						checkboxBuff.append("<td>");
						checkboxBuff.append(getDicts(dict,"checkbox",null));
						checkboxBuff.append("</td>");
						tr += MessageFormat.format(checkboxBuff.toString(), tdname);
					} else {
						checkboxBuff.append("<td><input class=\"input-medium\" type=\"checkbox\" value=\"{0}\" name=\"{1}\"></td>");
						tr += MessageFormat.format(checkboxBuff.toString(),tdValue, tdname);
					}
				}
				else if("popup".equals(type)){
					CgreportConfigHeadEntity cgreportConfigHeadEntity = getCgreportConfigHeadEntity(dict);
					if(cgreportConfigHeadEntity!=null){
						StringBuffer radioBuff = new StringBuffer();
							radioBuff.append("<td><input id=\"{0}\" name=\"{0}\" type=\"text\"  class=\"input-medium\" style=\"background: url(plug-in/easyui/themes/default/images/searchbox_button.png) 100% 50% no-repeat rgb(255, 255, 255);\" onClick='inputClick(this,\""+cgreportConfigHeadEntity.getReturnValField()+"\",\""+dict+"\");' value=\"\"></td>");
						tr += MessageFormat
						.format(radioBuff.toString(),tdname);
					}
				}
			}else{
					tr += MessageFormat
							.format(
									"<td style=\"display:none\"><input class=\"input-medium\" type=\"hidden\" value=\"{0}\" name=\"{1}\" {2}></td>",
									tdValue, tdname, sum);
			}
			if ((i+1) == tdCount)// 最后一列不显示
			{
				
				    tr += "<td><button class=\"btn btn-small btn-success delrow\" type=\"button\">删除</button></td>";
			}
		}
		String divId = name+"_row_templet";
		rowTempletDiv.append(MessageFormat.format("<textarea id=\""+divId+"\" style=\"display:none\" disabled=\"true\" >{0}</textarea>",tr));
		return rowTempletDiv.toString();
	}
	
	
	/**
	 * 解析生成input type="text"的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getText(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
		String style = (String)atrrMap.get("style");
		String title = (String)atrrMap.get("title");
//		String value = (String)atrrMap.get("value");
		String name = (String)atrrMap.get("name");
//		String orgheight = (String)atrrMap.get("orgheight");
//		String orgwidth = (String)atrrMap.get("orgwidth");
//		String orgalign = (String)atrrMap.get("orgalign");
//		String orgfontsize = (String)atrrMap.get("orgfontsize");
		String orghide = (String)atrrMap.get("orghide");
//		String leipiplugins = (String)atrrMap.get("leipiplugins");
		String orgtype = (String)atrrMap.get("orgtype");
		String autofield = (String)atrrMap.get("autofield");
		String datatype = (String)atrrMap.get("datatype");
		StringBuilder sb = new StringBuilder();
		//add by jg_renjie at 20151029 for:自定义单行文本控件实现日历选项及datatype无值时提示错误
		sb.append("<input ");
		if("1".equals(orghide)){
			sb.append(" type=").append("\"").append("hidden").append("\"");
		}else if("standardDate".equals(orgtype) || "fullDate".equals(orgtype)){//实现日期控件
			sb.append(" type=").append("\"text\"");
			if("fullDate".equals(orgtype)){
				sb.append(" class=\"Wdate\" onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});\"");
			} else if("standardDate".equals(orgtype)){
				sb.append(" class=\"Wdate\" onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd'});\"");
			}
		}else{
			sb.append(" type=").append("\"").append(orgtype).append("\"");
		}
		//add by jg_renjie at 20151029 for:自定义单行文本控件实现日历选项及datatype无值时提示错误
		sb.append(" style=").append("\"").append(style).append("\"");
		sb.append(" title=").append("\"").append(title).append("\"");
		sb.append(" name=").append("\"").append(name).append("\"");
		sb.append(" value=").append("\"").append(getSingleValue(autofield,paras)).append("\"");
		if(StringUtils.isNotBlank(datatype)){
			sb.append(" datatype=").append("\"").append(datatype).append("\"");
		}
		sb.append(" />");
		html = sb.toString();
		return html;
	}
	
	/**
	 * 解析生成<textarea></textarea>的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getTextarea(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
		String style = (String)atrrMap.get("style");
		String title = (String)atrrMap.get("title");
//		String value = (String)atrrMap.get("value");
//		String name = (String)atrrMap.get("name");
//		String orgheight = (String)atrrMap.get("orgheight");
//		String orgwidth = (String)atrrMap.get("orgwidth");
//		String orgalign = (String)atrrMap.get("orgalign");
//		String orgfontsize = (String)atrrMap.get("orgfontsize");
//		String orghide = (String)atrrMap.get("orghide");
//		String leipiplugins = (String)atrrMap.get("leipiplugins");
//		String orgtype = (String)atrrMap.get("orgtype");
		String autofield = (String)atrrMap.get("autofield");
		String datatype = (String)atrrMap.get("datatype");
		StringBuilder sb = new StringBuilder();
		sb.append("<textarea ");
		sb.append(" style=").append("\"").append(style).append("\"");
		sb.append(" title=").append("\"").append(title).append("\"");
		sb.append(" name=").append("\"").append(autofield).append("\"");
		if(StringUtils.isNotBlank(datatype)){
			sb.append(" datatype=").append("\"").append(datatype).append("\"");
		}
		sb.append(" >");
		sb.append(getSingleValue(autofield,paras));
		sb.append("</textarea>");
		html = sb.toString();
		return html;
	}
	
	/**
	 * 解析生成input type="hidden"的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getHiddenText(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
		String name = (String)atrrMap.get("name");
		String autofield = (String)atrrMap.get("autofield");
		StringBuilder sb = new StringBuilder();
		sb.append("<input ");
		sb.append(" type=").append("\"").append("hidden").append("\"");
		sb.append(" name=").append("\"").append(name).append("\"");
		sb.append(" value=").append("\"").append(getSingleValue(autofield,paras)).append("\"");
		sb.append(" />");
		html = sb.toString();
		return html;
	}
	
	/**
	 * 解析生成input type="text"  popup的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getPopup(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
		String style = (String)atrrMap.get("style");
		String title = (String)atrrMap.get("title");
//		String value = (String)atrrMap.get("value");
		String name = (String)atrrMap.get("name");
//		String orgheight = (String)atrrMap.get("orgheight");
		String orgwidth = (String)atrrMap.get("orgwidth");
//		String orgalign = (String)atrrMap.get("orgalign");
//		String orgfontsize = (String)atrrMap.get("orgfontsize");
		String autofield = (String)atrrMap.get("autofield");
		String datatype = (String)atrrMap.get("datatype");
		String dictionary = (String)atrrMap.get("dictionary");
		String [] dicts = dictionary.split(",");
		StringBuilder sb = new StringBuilder();
		sb.append("<input ");
		sb.append(" type=").append("\"text\"");
		sb.append(" style=").append("\"").append("width: auto; background: url(plug-in/easyui/themes/default/images/searchbox_button.png) 100% 50% no-repeat rgb(255, 255, 255);").append("\"");
		sb.append(" title=").append("\"").append(title).append("\"");
		sb.append(" name=").append("\"").append(name).append("\"");
		sb.append(" value=").append("\"").append(getSingleValue(autofield,paras)).append("\"");
		if(StringUtils.isNotBlank(datatype)){
			sb.append(" datatype=").append("\"").append(datatype).append("\"");
		}
		if(dicts.length==3){
			sb.append(" onClick=").append("\"").append("inputClick(this,'"+dicts[1]+"','"+dicts[0]+"');").append("\"");
		}
		sb.append(" />");
		html = sb.toString();
		return html;
	}
	
	/**
	 * 解析生成input type="checkbox"的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getCheckbox(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
//		String title = (String)atrrMap.get("title");
		String autofield = (String)atrrMap.get("autofield");
		String datatype = (String)atrrMap.get("datatype");
		StringBuilder sb = new StringBuilder();
		JSONArray options = (JSONArray)atrrMap.get("options");
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		list = JSONHelper.toList(options);
		for(Map<String,Object> map :list){
			String checkedtext = (String)map.get("checkedtext");
			String value = (String)map.get("value");
			sb.append("<input type=\"checkbox\"");
			sb.append(" name=\"").append(autofield).append("\"");
			sb.append(" value=\"").append(value).append("\"");
			if(StringUtils.isNotBlank(datatype)){
				sb.append(" datatype=").append("\"").append(datatype).append("\"");
			}
			Object datavalue = getSingleValue(autofield,paras);
			if(datavalue!=null&&datavalue.equals(value)){
				sb.append(" checked=\"checked\"");
			}
			sb.append(">").append(checkedtext).append("&nbsp;");
		}
		html = sb.toString();
		return html;
	}
	
	/**
	 * 解析生成input type="radio"的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getRadio(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
//		String title = (String)atrrMap.get("title");
		String autofield = (String)atrrMap.get("autofield");
		String datatype = (String)atrrMap.get("datatype");
		StringBuilder sb = new StringBuilder();
		JSONArray options = (JSONArray)atrrMap.get("options");
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		list = JSONHelper.toList(options);
		for(Map<String,Object> map :list){
			String checkedtext = (String)map.get("checkedtext");
			String value = (String)map.get("value");
			sb.append("<input type=\"radio\"");
			sb.append(" name=\"").append(autofield).append("\"");
			sb.append(" value=\"").append(value).append("\"");
			if(StringUtils.isNotBlank(datatype)){
				sb.append(" datatype=").append("\"").append(datatype).append("\"");
			}
			Object datavalue = getSingleValue(autofield,paras);
			if(datavalue!=null&&datavalue.equals(value)){
				sb.append(" checked=\"checked\"");
			}
			sb.append(">").append(checkedtext).append("&nbsp;");
		}
		html = sb.toString();
		return html;
	}
	
	/**
	 * 解析生成<select></select>的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getSelect(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
		String style = (String)atrrMap.get("style");
		String title = (String)atrrMap.get("title");
		String size = (String)atrrMap.get("size");
//		String name = (String)atrrMap.get("name");
//		String orgheight = (String)atrrMap.get("orgheight");
//		String orgwidth = (String)atrrMap.get("orgwidth");
//		String orgalign = (String)atrrMap.get("orgalign");
//		String orgfontsize = (String)atrrMap.get("orgfontsize");
//		String orghide = (String)atrrMap.get("orghide");
//		String leipiplugins = (String)atrrMap.get("leipiplugins");
//		String orgtype = (String)atrrMap.get("orgtype");
		String autofield = (String)atrrMap.get("autofield");
		String datatype = (String)atrrMap.get("datatype");
		StringBuilder sb = new StringBuilder();
		String content = (String)atrrMap.get("content");
		sb.append("<select ");
		sb.append("style=").append("\"").append(style).append("\"");
		sb.append(" size=").append("\"").append(size).append("\"");
		sb.append(" title=").append("\"").append(title).append("\"");
		sb.append(" name=").append("\"").append(autofield).append("\"");
		//sb.append("value=").append("\"").append(getSingleValue(autofield,paras)).append("\"");
		if(StringUtils.isNotBlank(datatype)){
			sb.append(" datatype=").append("\"").append(datatype).append("\"");
		}
		sb.append(">");
		sb.append(getSelectOption(content,(String)getSingleValue(autofield,paras)));
		sb.append("</select>");
		html = sb.toString();
		return html;
	}
	
	private static String getSelectOption(String content,String value){
		StringBuilder option = new StringBuilder();
		Document doc = Jsoup.parse(content);
		Elements selectElements = doc.getElementsByTag("select").select("option");
		for (Element el: selectElements) {
			if(el.attr("value").equals(value)){
				option.append(" <option value=\"").append(el.attr("value")).append("\" selected>")
				.append(el.text()).append("</option>");
			}else{
				option.append(" <option value=\"").append(el.attr("value")).append("\">")
				.append(el.text()).append("</option>");
			}
			
		}
		return option.toString();
	}
	
	//update start by jg_renjie at 20151028 for: 解析生成input type="macros"的代码段
	
	/**
	 * 解析生成input type="macros"的代码段
	 * @param atrrMap
	 * @param paras
	 * @return
	 */
	private static String getMacros(Map<String,Object> atrrMap,Map<String, List<Map<String, Object>>> paras){
		String html = "";
		String orgtype = (String)atrrMap.get("orgtype");//类型
		String title = (String)atrrMap.get("title");
		String orghide = (String)atrrMap.get("orghide");
		String name = (String)atrrMap.get("name");
		String style = (String)atrrMap.get("style");
		
		StringBuilder sb = new StringBuilder();
		sb.append("<input ");
		
		if("1".equals(orghide)){
			sb.append("type=").append("\"").append("hidden").append("\"");
		}else{
			sb.append("type=").append("\"text\"");
		}
		sb.append("style=").append("\"").append(style).append("\"");
		sb.append("title=").append("\"").append(title).append("\"");
		sb.append("name=").append("\"").append(name).append("\"");
		
		sb.append("value=").append("\"").append(getFormat(orgtype)).append("\"");
		
		sb.append(" readonly=\"true\" />");
		html = sb.toString();
		return html;
	}
	
	//根据类型，返回日期格式
	private static String getFormat(String orgtype){
		
		String orgName= "";
		
		TSUser user = ClientManager.getInstance().getClient().getUser();
		
		SimpleDateFormat format = null;
		if("sys_datetime".equals(orgtype)){
			format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			orgName = format.format(new Date());
		} else if("sys_date".equals(orgtype)){
			format = new SimpleDateFormat("yyyy-MM-dd");
			orgName = format.format(new Date());
		}else if("sys_date_cn".equals(orgtype)){
			format = new SimpleDateFormat("yyyy年MM月dd日");
			orgName = format.format(new Date());
		}else if("sys_date_cn_short1".equals(orgtype)){
			format = new SimpleDateFormat("yyyy年MM月");
			orgName = format.format(new Date());
		}else if("sys_date_cn_short4".equals(orgtype)){
			format = new SimpleDateFormat("yyyy");
			orgName = format.format(new Date());
		}else if("sys_date_cn_short3".equals(orgtype)){
			format = new SimpleDateFormat("yyyy年");
			orgName = format.format(new Date());
		}else if("sys_date_cn_short2".equals(orgtype)){
			format = new SimpleDateFormat("MM月dd日");
			orgName = format.format(new Date());
		}else if("sys_time".equals(orgtype)){
			format = new SimpleDateFormat("HH:mm:ss");
			orgName = format.format(new Date());
		}else if("sys_week".equals(orgtype)){
			orgName = getWeekDay();
		} else if("sys_userid".equals(orgtype)){
			orgName = user.getUserName();
		} else if("sys_realname".equals(orgtype)){
			orgName = user.getRealName();
		} else if("sys_dept".equals(orgtype)){
			orgName = user.getCurrentDepart().getDepartname();
		}
		return orgName;
	}
	//获取星期
	private static String getWeekDay() {
		  Calendar c = Calendar.getInstance();
		  c.setTime(new Date(System.currentTimeMillis()));
		  int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
		  String day = "";
		  switch (dayOfWeek) {
		  case 1:
			  day= "星期日";
		  case 2:
			  day= "星期一";
		  case 3:
			  day= "星期二";
		  case 4:
			  day= "星期三";
		  case 5:
			  day= "星期四";
		  case 6:
			  day= "星期五";
		  case 7:
			  day= "星期六";
		  }
		return day;
	}
	
	//update start by jg_renjie at 20151028 for: 解析生成input type="macros"的代码段
	
	/**
	 * 获取所有input标签的属性信息
	 * @param jsonObj
	 * @return
	 */
	private static List<Map<String,Object>> getAllInputAttr(JSONObject jsonObj){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		list = JSONHelper.toList(jsonObj.get("data"));
		return list;
	}
	
	
	/**
	 * 获取input type="text"的value【多条数据时获取第一条数据对应的值】
	 * @param autofield
	 * @param paras
	 * @param type
	 * @return
	 */
	private static Object getSingleValue(String autofield,Map<String, List<Map<String, Object>>> paras){
		Object value = "";
		if(autofield==null){
			autofield="";
		}
		String [] name = autofield.split("\\.");
		if(name.length==2){
			List<Map<String, Object>> list = paras.get(name[0]);
			if(list!=null&&list.size()>0){
				Map<String, Object> map = list.get(0);
				if(map!=null){
					value = map.get(name[1]);
					if(value==null){
						value = "";
					}
				}
			}
		}
		return value;
	}
	
	
	
	
	
	
	/**
	 * 获取列表控件配置的数据源名称
	 * @param listAutofield
	 * @return
	 */
	private static String getListDsName(List<String> listAutofield){
		String dsName = null;
		if(listAutofield!=null&&listAutofield.size()>0){
			for(String dsAtrr:listAutofield){
				if(StringUtil.isNotEmpty(dsAtrr)){
					String [] dsNames = dsAtrr.split("\\.");
					if(dsNames.length==2){
						dsName = dsNames[0];
						break;
					}
				}
			}
		}
		return dsName;
	}
	
	/**
	 * 获取列表控件每列对应的字段名
	 * @param field
	 * @return
	 */
	private static String getListFieldName(String field){
		String name = null;
		if(StringUtil.isNotEmpty(field)){
			String [] names = field.split("\\.");
			if(names.length==2){
				name = names[1];
			}
		}
		return name;
	}
	
	/**
	 * 列表控件  根据每列对应的字段名获取列表对应位置的值
	 * @param dataMap
	 * @param field
	 * @return
	 */
	private static Object getListFieldValue(Map<String, Object> dataMap,String field){
		Object obj = "";
		String fieldName = getListFieldName(field);
		if(fieldName!=null){
			obj = dataMap.get(fieldName);
			if(obj==null){
				obj = "";
			}
		}
		return obj;
	}
   
	private static String getDicts(String typeGroupCode,String type,Object tdValue){
		
		List<TSType> types = TSTypegroup.allTypes.get(typeGroupCode.toLowerCase());
		
		StringBuffer content = new StringBuffer();
		
		if(types.size()>0){
			for(TSType tSType:types){
				if("select".equals(type)){
					content.append("<option value=\"").append(tSType.getTypecode()).append("\"");
					if(tdValue!=null&&tdValue.equals(tSType.getTypecode())){
						content.append(" selected=\"selected\"");
					}
					content.append(">");
					content.append(getMutiLang(tSType.getTypename())).append("</option>");
				} else if("radio".equals(type)){
					content.append("<input type=\"radio\" name=\"{0}\" value=\"").append(tSType.getTypecode()).append("\"");
					if(tdValue!=null&&tdValue.equals(tSType.getTypecode())){
						content.append(" checked=\"checked\"");
					}
					content.append(">").append(getMutiLang(tSType.getTypename()));
				} else if("checkbox".equals(type)){
					content.append("<input type=\"checkbox\" name=\"{0}\" value=\"").append(tSType.getTypecode()).append("\"");
					if(tdValue!=null&&tdValue.equals(tSType.getTypecode())){
						content.append(" checked=\"checked\"");
					}
					content.append(">").append(getMutiLang(tSType.getTypename()));
				}
			}
		}
		return content.toString();
	}
	
	private static String getMutiLang(String key){
		//add by Rocky, 处理多语言
		if(mutiLangService == null)
		{
			mutiLangService = ApplicationContextUtil.getContext().getBean(MutiLangServiceI.class);	
		}
		String lang_context = mutiLangService.getLang(key);
		return lang_context;
	}
	
	private static String getTypename(String typeGroupCode,String code){
		
		TSTypegroup typeGroup = TSTypegroup.allTypeGroups.get(typeGroupCode.toLowerCase());
		List<TSType> types = TSTypegroup.allTypes.get(typeGroupCode.toLowerCase());
		
		String codename = "";
		for(TSType tSType:types){
			if(tSType.getTypecode().equals(code)){
				codename = tSType.getTypename();
				break;
			}
		}
		return codename;
	}
	
	private static CgreportConfigHeadEntity getCgreportConfigHeadEntity(String code){
		CgreportConfigHeadEntity cgreportConfigHeadEntity = null;
		if(cgreportConfigHeadService == null)
		{
			cgreportConfigHeadService = ApplicationContextUtil.getContext().getBean(CgreportConfigHeadServiceI.class);	
		}
		cgreportConfigHeadEntity = cgreportConfigHeadService.findUniqueByProperty(CgreportConfigHeadEntity.class, "code", code);
		return cgreportConfigHeadEntity;
	}
}