package org.jeecgframework.web.cgform.util;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.entity.template.CgformTemplateEntity;

/**
 * Created by zzl on 2015/6/19.
 * online 自定义模板工具类
 * 提供获取模板路径方法
 */
public class TemplateUtil {
    public static final String BASE_DIR = "online/template/";
    public static final String TEMPLET_CODE_DEFAULT = "default"; //Online默认样式：default(easyui)  | Online默认样式：ledefault(ace)
    public static final String TEMPLET_ONE_DEFAULT = "jform.ftl";
    public static final String TEMPLET_ONE_MANY_DEFAULT = "jformunion.ftl";
    public static final String TEMPLET_VIEW_DIR_DEFAULT = "html";
    public static final String TEMPLET_LIST = "autolist.ftl";
    public  enum TemplateType{
        ADD("add"),UPDATE("update"),LIST("list"),DETAIL("detail");
        private String name;
        TemplateType(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
        public static TemplateType getVal(String type){
            if("add".equals(type)){
                return ADD;
            }else if("update".equals(type)){
                return UPDATE;
            }else if("detail".equals(type)){
                return DETAIL;
            }else if("list".equals(type)){
                return LIST;
            }else {
                return null;
            }
        }
    }
    /**
     * 获取模板路径
     * @param entity 模板编码
     * @param formType 表单类型  1-单表,2-主表,3-从表 ，0-数据列表
     * @param type 模板类型
     * @return
     */
    public static String getTempletPath(CgformTemplateEntity entity,Integer formType,TemplateType type){
        if(entity==null||StringUtils.isBlank(entity.getTemplateCode())){
            entity=new CgformTemplateEntity();
            entity.setTemplateCode(TEMPLET_CODE_DEFAULT);
            entity.setTemplateListName(TEMPLET_LIST);
            if(CgAutoListConstant.JFORM_TYPE_MAIN_TALBE==formType){
                entity.setTemplateAddName(TEMPLET_ONE_MANY_DEFAULT);
                entity.setTemplateUpdateName(TEMPLET_ONE_MANY_DEFAULT);
                entity.setTemplateDetailName(TEMPLET_ONE_MANY_DEFAULT);
            }else{
                entity.setTemplateAddName(TEMPLET_ONE_DEFAULT);
                entity.setTemplateUpdateName(TEMPLET_ONE_DEFAULT);
                entity.setTemplateDetailName(TEMPLET_ONE_DEFAULT);
            }

        }
        String templateCode=entity.getTemplateCode();
        String templateName=null;

        switch (type){
            case ADD:
//                templateName=entity.getTemplateAddName();
            	if(CgAutoListConstant.JFORM_TYPE_MAIN_TALBE==formType){
            		templateName="jformunion.ftl";
            	}else{
            		templateName="jform.ftl";
            	}
                break;
            case UPDATE:
//                templateName=entity.getTemplateUpdateName();
            	if(CgAutoListConstant.JFORM_TYPE_MAIN_TALBE==formType){
            		templateName="jformunion.ftl";
            	}else{
            		templateName="jform.ftl";
            	}
                break;
            case LIST:
                templateName=entity.getTemplateListName();
                templateName="autolist.ftl";
                break;
            case DETAIL:
//                templateName=entity.getTemplateDetailName();
            	if(CgAutoListConstant.JFORM_TYPE_MAIN_TALBE==formType){
            		templateName="jformunion.ftl";
            	}else{
            		templateName="jform.ftl";
            	}
                break;
            default:
                templateName=entity.getTemplateListName();
        }

        StringBuffer buffer=new StringBuffer(BASE_DIR+templateCode+"/");
        buffer.append(TEMPLET_VIEW_DIR_DEFAULT+"/");
        buffer.append(templateName);
        return buffer.toString();
    }

    /**
     * 解析经过leipiFormDesign.parse_form()格式化的表单模板html
     * @param content
     * @return
     */
	public Map<String,Object> processor(String content) {
			
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			JSONObject jsonObj = JSONObject.fromObject(content);
			String template  = (String)jsonObj.get("template");
			String parseHtml = (String)jsonObj.get("parse");
			JSONArray jsonArray = new JSONArray().fromObject(jsonObj.get("data"));
			map.put("template", template);
			//1.利用正则，取得所有的input标签
			String rexEg = "(<input[^>]*>)";
			Pattern p = Pattern.compile(rexEg);
			Matcher m = p.matcher(parseHtml);
			List<String> result=new ArrayList<String>();
			while(m.find()){
				result.add(m.group());
			}
			Map<String, Object> tableData = null;
			int index = 0;
			for(int i=0;i<result.size();i++){
				//2,利用正则，匹配标签中是否含有listctrl字段
				String ctrlExp = "(listctrl)";
				Pattern ctrlP = Pattern.compile(ctrlExp);
				Matcher ctrlM = ctrlP.matcher(result.get(i));
				//2.1 如果含有，则插入解析data.生成html后，讲html替换
				if(ctrlM.find()){
					tableData = new HashMap<String, Object>();
					for(int j=index;j<jsonArray.size();j++){
						JSONObject item = jsonArray.getJSONObject(j);
						if("listctrl".equals(item.getString("leipiplugins"))){
							String tempHtml = GetListctrl(jsonArray.getJSONObject(j),tableData,"");
							parseHtml = parseHtml.replace(result.get(i), tempHtml);
							index =j+1;
						}
					}
				}
			}
			
			map.put("parseHtml",parseHtml);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	private static String GetListctrl(JSONObject item,
			Map<String, Object> formData, String action) {
		String valuetest = "{\"data_110\":[\"1\",\"2\"],\"data_111\":[\"21\",\"22\",\"22\"]}";

		String name = item.getString("name").toString();
		String value = formData.get(name) == null ? null : formData.get(name)
				.toString();
		String temp_html = "";
		String orgSum = item.getString("orgsum").toString();
		String orgUnit = item.getString("orgunit").toString();
		String orgTitle = item.getString("orgtitle").toString();
		String title = item.getString("title").toString();
		String style = item.getString("style").toString();
		String orgcolvalue = item.getString("orgcolvalue").toString();
		String orgcoltype = item.getString("orgcoltype").toString();
		List<String> listTitle = Arrays.asList(orgTitle.split("`"));
		List<String> listSum = Arrays.asList(orgSum.split("`"));
		List<String> listUnit = Arrays.asList(orgUnit.split("`"));
		List<String> listValue = Arrays.asList(orgcolvalue.split("`"));
		List<String> listType = Arrays.asList(orgcoltype.split("`"));
		int tdCount = listTitle.size();
		
		String tableNm = name + "_table";
		String temp = "<table id=\""
				+ tableNm
				+ "\" bindTable=\"true\" cellspacing=\"0\" class=\"table table-bordered table-condensed\" style=\""
				+ style + "\"><thead>{0}</thead><tbody>{1}</tbody>{2}</table>";
		String btnAdd = "<span class=\"pull-right\"><button id='listAdd' class=\"btn btn-small btn-success listAdd\" type=\"button\" tbname=\""
				+ name + "\">添加一行</button></span>"; // 添加按钮
		String theader = "<tr><th colspan=\"{0}\">{1}{2}</th></tr>{3}";// 头部模版
		
		//是否有合计行
		boolean isExistSum = false;
		
		//1.拼接标题
		String trTitle = "";
		for (int i = 0; i < tdCount; i++) {
			trTitle += MessageFormat.format("<th>{0}</th>", listTitle.get(i));
            if ((i+1) == tdCount){
        	  trTitle += MessageFormat.format("<th>{0}</th>", "操作");
		    }
		}
		trTitle = "<tr>" + trTitle + "</tr>";

		JSONObject dataValue = JSONObject.fromObject(valuetest);

		int rowCount = dataValue != null ? dataValue.size() : 1;

		StringBuilder sbTr = new StringBuilder();
		String tdSum = "";// 如果有统计增加一行

		TreeMap<Integer, Float> SumValueDic = new TreeMap<Integer, Float>();
		for (int row = 0; row < rowCount; row++) {

			JSONArray rowValue = (dataValue != null && dataValue
					.has(name + row)) ? dataValue.getJSONArray(name + row)
					: null;

			String tr = "";// 默认一行
			for (int i = 0; i < tdCount; i++) {
				String tdname = name + "[" + i + "]";
				String sum = "1".equals(listSum.get(i)) ? "sum=\"" + tdname
						+ "\"" : "";// 是否参与统计
				String tdValue ="";
				if(i<listValue.size()){ 
					 tdValue = StringUtils.isBlank(listValue.get(i))?"":listValue.get(i);
				}
				tdValue = (rowValue != null && rowValue.size() > i) ? rowValue.getString(i).toString():tdValue ;
				String type = listType.get(i);// 类型

				if (sum != "")// 一次循环计算该列的值
				{
					// region 计算统计值
					float tempTdValue = 0;
					if (SumValueDic.containsKey(i))
						tempTdValue = SumValueDic.get(i);
					try {
						float resultTdTemp = 0;
						resultTdTemp = Float.parseFloat(tdValue);
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
				
				if ("text".equals(type)){
					tr += MessageFormat
							.format(
									"<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}[]\" {2}></td>",
									tdValue, tdname, sum);
				} else if ("int".equals(type)){
					tr += MessageFormat
							.format(
									"<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}[]\" {2}></td>",
									tdValue, tdname, sum);
				} else if ("textarea".equals(type)){
					tr += MessageFormat
							.format(
									"<td><textarea class=\"input-medium\" name=\"{0}\" >{1}</textarea></td>",
									tdname, tdValue, sum);
				} else if ("calc".equals(type)){
					tr += MessageFormat
							.format(
									"<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}[]\" {2}></td>",
									tdValue, tdname, sum);
				}
				if ((i+1) == tdCount)// 最后一列不显示 && 第一列也不显示
				{   

					if(row == 0){
						tr += "<td></td>";
					} else {
						tr += "<td><a href=\"javascript:void(0);\" class=\"delrow \">删除</a></td>";
					}

				}
				if (row == 0)// 统计的行只有一行
				{
					// region
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
		theader = MessageFormat.format(theader, tdCount+1, title, btnAdd,trTitle);

		temp_html = MessageFormat.format(temp, theader, sbTr.toString(), tdSum);
		
		temp_html += "<script type=\"text/javascript\">";
		temp_html += "$(function(){";
		temp_html += "$(\"#listAdd\").click(function(){";
		temp_html += "var tbHtml ='<tr>'+ $(\"#"+tableNm+" tr\").eq(2).html().replace('<td></td>',\"<td><a href='javascript:void(0);' class='delrow'>删除</a></td>\")+'</tr>';";
		//因为获取的第一行没有删除功能，需加上
		if(isExistSum){//存在合计行，则将行插入到倒数第二行的后面
			temp_html +="$(\"#"+tableNm+" tr\").eq(-2).after(tbHtml);";
		} else {//不存在合计行，则将行插入到最后一行
			temp_html +="$(\"#"+tableNm+" tr:last\").after(tbHtml);";
		}
		temp_html += "$(\".delrow\").die().live(\"click\",function(){$(this).parent().parent().remove();});";
		temp_html += "});";
	    //添加删除按钮的方法
		temp_html +="$(\".delrow\").click(function(){$(this).parent().parent().remove();});";
		temp_html += "});</script>";
		
		return temp_html;
	}

}
