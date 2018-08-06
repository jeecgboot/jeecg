package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.system.pojo.base.TSCategoryEntity;
import org.jeecgframework.web.system.service.SystemService;
import org.openxmlformats.schemas.drawingml.x2006.chart.impl.STScatterStyleImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 树选择插件 
 * @author 张加强
 * 
 * @Date 20170909
 */
public class TreeSelectTag extends TagSupport {
	
	private static final long serialVersionUID = -7715140680053001649L;
	
	private String id;
	private String field;//字段值
	private String defaultVal;//选中的值
	private String divClass;//默认的class名称
	private String inputClass;//input输入框对应的样式
	
	private boolean multiCheck = true;//是否可以多选
	
	private String code;
	
	private String formStyle;//表单风格 ace default
	
	@Autowired
	private SystemService systemService;
	
	/**
	 * 构建标签对应的HTML代码
	 * @return
	 */
	public StringBuffer end() {
		StringBuffer resultSb = new StringBuffer();
		//text  input
		textInput(resultSb);
		//code input
		codeInput(resultSb);
		//tree div
		tree(resultSb);
		//js
		initScriptResource(resultSb);
		return resultSb;
	}

	private void tree(StringBuffer resultSb) {
		resultSb.append("<div id=\"");
		resultSb.append("show" + StringUtil.firstUpperCase(field) + "TreeContent\" ");
		if(StringUtil.isNotEmpty(divClass)){
			resultSb.append("class=\""+divClass+"\"  ");
		}else{
			resultSb.append("class=\"menuContent\"  ");
		}
		resultSb.append("  style=\"display: none; position: absolute; border: 1px #CCC solid; background-color: #F0F6E4;z-index:9999;\"> ");
		resultSb.append("<ul id=\"show" +  StringUtil.firstUpperCase(field) + "Tree\" class=\"ztree\" style=\"margin-top:0;\"></ul></div>");
	}
	
	/**
	 * 显示的文本输入框
	 * @param resultSb
	 */
	private void textInput(StringBuffer resultSb) {

		resultSb.append("<input type=\"text\" ");

		if(StringUtil.isNotEmpty(inputClass)){
			resultSb.append("class=\""+inputClass+"\"  ");
		}else{
			resultSb.append("class=\"inputxt\" ");
		}
		if(StringUtil.isEmpty(field)){
			throw new BusinessException("field字段不能为空");
		}
		resultSb.append(" name=\"");
		resultSb.append(field);
		resultSb.append("Text\" id=\"");
		if(StringUtil.isEmpty(id)){
			resultSb.append(field);
		}else{
			resultSb.append(id);
		}
		resultSb.append("Text\" ");
		resultSb.append(" onclick=\"");
		resultSb.append("show" + StringUtil.firstUpperCase(field) + "Tree();");
		resultSb.append("\" ");
		if(StringUtil.isNotEmpty(defaultVal)){
			resultSb.append(" value = \"");
			resultSb.append(parseDefaultVal());
			resultSb.append("\" ");
		}
		
		resultSb.append("/>");
	}
	
	/**
	 *  code input
	 * @param resultSb
	 */
	private void codeInput(StringBuffer resultSb) {
		resultSb.append("<input type=\"hidden\" ");
		resultSb.append(" name=\"");
		resultSb.append(field);
		resultSb.append("\" id=\"");
		if(StringUtil.isEmpty(id)){
			resultSb.append(field);
		}else{
			resultSb.append(id);
		}
		resultSb.append("\" ");
		if(StringUtil.isNotEmpty(defaultVal)){
			resultSb.append(" value=\"");
			resultSb.append(defaultVal);
			resultSb.append("\" ");
		}
		resultSb.append("/>");
	}
	
	/**
	 * js 脚本组合
	 * @param resultSb
	 */
	private void initScriptResource(StringBuffer resultSb) {
		resultSb.append("<script>");
		resultSb.append("$(function(){");
		//是否已引入ztree资源
		zTreeInit(resultSb);
		
		resultSb.append("$(\"body\").bind(\"mousedown\", onBodyDownBy"+StringUtil.firstUpperCase(field)+");");
		resultSb.append("});");
		//setting资源
		getZTreeSeting(resultSb);
		//checkFunction
		getCheckFunction(resultSb);
		
		//click function
		resultSb.append("function "+field+"OnClick(e, treeId, treeNode) { ");
		resultSb.append(" var zTree = $.fn.zTree.getZTreeObj(\"show"+StringUtil.firstUpperCase(field)+"Tree\");");
		resultSb.append("zTree.checkNode(treeNode, !treeNode.checked, true,true);");
		resultSb.append("e.stopPropagation();");
		resultSb.append("}");
		
		//show tree function
		showTreeFunction(resultSb);
		
		//body down
		resultSb.append("function onBodyDownBy"+StringUtil.firstUpperCase(field)+"(event){");
		resultSb.append("if(event.target.id == '' || (event.target.id.indexOf('switch') == -1 ");
		resultSb.append("&& event.target.id.indexOf('check') == -1 && event.target.id.indexOf('span') == -1 ");
		resultSb.append("&& event.target.id.indexOf('ico') == -1)){  ");
		resultSb.append("$(\"#show"+StringUtil.firstUpperCase(field)+"TreeContent\").fadeOut(\"fast\");");
		resultSb.append("}}");
		
		resultSb.append("</script>");
	}

	/**
	 * 显示树
	 * @param resultSb
	 */
	private void showTreeFunction(StringBuffer resultSb) {
		resultSb.append("function show"+StringUtil.firstUpperCase(field)+"Tree(){");
		resultSb.append("if($(\"#show"+StringUtil.firstUpperCase(field)+"TreeContent\").is(\":hidden\")){");
		resultSb.append("$.ajax({ ");
		resultSb.append("url:'categoryController.do?tree',");
		resultSb.append("type:'POST',   dataType:'JSON', async:false,  ");
		if(StringUtil.isNotEmpty(code)){
			resultSb.append("data:{selfCode:\"" + code + "\"},");
		}
		resultSb.append("success:function(res){");
		resultSb.append(" var obj = res;");
		resultSb.append("$.fn.zTree.init($(\"#show"+StringUtil.firstUpperCase(field)+"Tree\"),"+field+"Setting, obj);  ");
		if(StringUtil.isNotEmpty(id)){
			resultSb.append("var deptObj = $(\"#" + id + "Text\");  ");
			resultSb.append("var deptOffset = $(\"#"+id+"Text\").offset();");
		}else{
			resultSb.append("var deptObj = $(\"#" + field + "Text\");  ");
			resultSb.append("var deptOffset = $(\"#"+field+"Text\").offset();");
		}

		if("ace".equals(formStyle)){
			resultSb.append(" $(\"#show"+StringUtil.firstUpperCase(field)+"TreeContent\").css({top:(deptObj[0].offsetTop + deptObj.outerHeight()) + \"px\"}).slideDown(\"fast\");  ");
			resultSb.append("$('#show"+StringUtil.firstUpperCase(field)+"Tree').css({width:deptObj.outerWidth() - 2 + \"px\"});  ");
		}else{
			resultSb.append(" $(\"#show"+StringUtil.firstUpperCase(field)+"TreeContent\").css({left:deptOffset.left + 'px', top:deptOffset.top + deptObj.outerHeight() + 'px'}).slideDown(\"fast\");  ");
			resultSb.append("$('#show"+StringUtil.firstUpperCase(field)+"Tree').css({width:deptObj.outerWidth() - 12 + \"px\"});  ");
		}

		
		resultSb.append(" var zTree = $.fn.zTree.getZTreeObj(\"show"+StringUtil.firstUpperCase(field)+"Tree\"); ");
		if(StringUtil.isNotEmpty(id)){
			resultSb.append("var idVal =  $(\"#"+id+"\").val();");
		}else{
			resultSb.append("var idVal =  $(\"#"+field+"\").val();");
		}
		resultSb.append("if(idVal != null && idVal != ''){");
		resultSb.append("if(idVal.indexOf(\",\") > -1){");
		resultSb.append("var idArray = idVal.split(\",\");");
		resultSb.append("for(var i = 0; i < idArray.length; i++){");
		resultSb.append("var node = zTree.getNodeByParam(\"id\", idArray[i], null);");
		resultSb.append("zTree.checkNode(node, true, true);");
		resultSb.append("}}else{");
		resultSb.append("var node = zTree.getNodeByParam(\"id\", idVal, null);");
		resultSb.append("zTree.checkNode(node, true, true);");
		resultSb.append("}");
		resultSb.append("}");
		resultSb.append("}");
		resultSb.append("});");
		resultSb.append("}");
		resultSb.append("}");
	}

	private void getCheckFunction(StringBuffer resultSb) {

		resultSb.append("function " + field + "OnCheck(e, treeId, treeNode) {");
		resultSb.append(" var myTree = $.fn.zTree.getZTreeObj(\"show"+StringUtil.firstUpperCase(field)+"Tree\"); ");
		resultSb.append("var nodes = myTree.getCheckedNodes(true);var tempId='',tempText='';");

		resultSb.append("if(nodes && nodes.length>0){for(var i = 0;i<nodes.length;i++){tempId+=nodes[i].id+',';tempText+=nodes[i].text+',';}}");    

		resultSb.append("if(tempId ==''){");
		if(StringUtil.isEmpty(id)){
			resultSb.append("$('#"+field+"').val(''); }else{$('#"+field+"').val(tempId.substring(0,tempId.length - 1));}");
		}else{
			resultSb.append("$('#"+id+"').val(''); }else{$('#"+id+"').val(tempId.substring(0,tempId.length - 1));}");
		}   
		resultSb.append("if(tempText ==''){");
		if(StringUtil.isEmpty(id)){
			resultSb.append("$('#"+field+"Text').val(''); }else{$('#"+field+"Text').val(tempText.substring(0,tempText.length - 1));}");
		}else{
			resultSb.append("$('#"+id+"Text').val(''); }else{$('#"+id+"Text').val(tempText.substring(0,tempText.length - 1));}");
		}   
		
		/*if(StringUtil.isNotEmpty(id)){
			resultSb.append("var idVal = $(\"#"+id+"\").val();");
			resultSb.append(" var textVal = $(\"#"+id+"Text\").val();");
		}else{
			resultSb.append("var idVal = $(\"#"+field+"\").val();");
			resultSb.append(" var textVal = $(\"#"+field+"Text\").val();");
		}
		resultSb.append(" if(treeNode.checked){");
		resultSb.append("if(idVal != null && idVal != ''){");
		if(StringUtil.isNotEmpty(id)){
			resultSb.append("$(\"#"+id+"\").val(idVal + ',' +treeNode.id); ");
		}else{
			resultSb.append("$(\"#"+field+"\").val(idVal + ',' +treeNode.id); ");
		}
		resultSb.append("}else{");
		if (StringUtil.isNotEmpty(id)) {
			resultSb.append(" $(\"#"+id+"\").val(treeNode.id); ");
		}else{
			resultSb.append(" $(\"#"+field+"\").val(treeNode.id); ");
		}
		resultSb.append("}");
		resultSb.append("if(textVal != null && textVal != ''){");
		if(StringUtil.isNotEmpty(id)){
			resultSb.append("$(\"#"+id+"Text\").val(textVal + ',' + treeNode.text); ");
		}else{
			resultSb.append("$(\"#"+field+"Text\").val(textVal + ',' + treeNode.text); ");
		}
		resultSb.append("}else{");
		if(StringUtil.isNotEmpty(id)){
			resultSb.append("$(\"#"+id+"Text\").val(treeNode.text); ");
		}else{
			resultSb.append("$(\"#"+field+"Text\").val(treeNode.text); ");
		}
		resultSb.append("}");
		resultSb.append("}else{");
		resultSb.append("idVal = idVal.replace(treeNode.id,'');");
		resultSb.append("if(idVal.indexOf(',') == 0){");
		resultSb.append("idVal = idVal.substring(1);");
		resultSb.append("}else if(idVal.indexOf(',,') > -1){");
		resultSb.append("idVal = idVal.replace(',,',',');");
		resultSb.append("}else if(idVal.indexOf(',') == idVal.length -1){");
		resultSb.append("idVal = idVal.substring(0,idVal.length - 1);");
		resultSb.append("}");
		resultSb.append("textVal = textVal.replace(treeNode.text,'');");
		resultSb.append("if(textVal.indexOf(',') == 0){");
		resultSb.append("textVal = textVal.substring(1);");
		resultSb.append("}else if(textVal.indexOf(',,') > -1){");
		resultSb.append("textVal = textVal.replace(',,',',');");
		resultSb.append("}else if(textVal.indexOf(',') == textVal.length -1){");
		resultSb.append("textVal = textVal.substring(0,textVal.length - 1);");
		resultSb.append("}");
		if(StringUtil.isNotEmpty(id)){
			resultSb.append("$(\"#"+id+"Text\").val(textVal);");
			resultSb.append(" $(\"#"+id+"\").val(idVal);");
		}else{
			resultSb.append("$(\"#"+field+"Text\").val(textVal);");
			resultSb.append(" $(\"#"+field+"\").val(idVal);");
		}
		resultSb.append("}");*/

		resultSb.append(" e.stopPropagation();");
		resultSb.append("}");
	}

	private void zTreeInit(StringBuffer resultSb) {
		resultSb.append("if(!$.fn.zTree){");
		resultSb.append("$('head').append('<link rel=\"stylesheet\" href=\"plug-in/ztree/css/zTreeStyle.css\"/>');");
		resultSb.append("$('head').append('<script type=\\\"text/javascript\\\" src=\\\"plug-in/ztree/js/jquery.ztree.core-3.5.min.js\\\"><\\/script>');");
		resultSb.append("$('head').append('<script type=\\\"text/javascript\\\" src=\\\"plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\\\"><\\/script>');");
		resultSb.append("}");
	}

	private void getZTreeSeting(StringBuffer resultSb) {
		resultSb.append("var "+field+"Setting = {");
		resultSb.append("check: {");
		resultSb.append("enable: true");

		resultSb.append(",chkStyle:'checkbox',chkboxType: { 'Y': '', 'N': '' }");

		 
		resultSb.append("},");
		resultSb.append("view: {dblClickExpand: false},");
		resultSb.append("data: {simpleData: { enable: true }, key:{name:'text' }},");
		resultSb.append("callback: {");
		resultSb.append("onClick: " + field + "OnClick,");
		resultSb.append("onCheck: " + field + "OnCheck");
		resultSb.append("}");
		resultSb.append("};");
	}
	
	/**
	 * 解析默认值
	 * @return
	 */
	private String parseDefaultVal() {
		if(StringUtil.isNotEmpty(defaultVal)){
			String result = "";
			if(systemService == null){
				systemService = ApplicationContextUtil.getContext().getBean(SystemService.class);
			}
			if(defaultVal.indexOf(",") > -1){
				String[] defaultValArray = defaultVal.split(",");
				for (int i = 0; i < defaultValArray.length; i++) {
					if(StringUtil.isNotEmpty(defaultValArray[i])){
						List<TSCategoryEntity> categoryList = systemService.findByProperty(TSCategoryEntity.class, "code", defaultValArray[i]);
						if(categoryList != null && !categoryList.isEmpty()){
							TSCategoryEntity categoryEntity = categoryList.get(0);
							if(StringUtil.isEmpty(result)){
								result = categoryEntity.getName();
							}else{
								result += "," + categoryEntity.getName();
							}
						}
					}
				}
			}else{
				List<TSCategoryEntity> categoryList = systemService.findByProperty(TSCategoryEntity.class, "code", defaultVal);
				if(categoryList != null && !categoryList.isEmpty()){
					TSCategoryEntity categoryEntity = categoryList.get(0);
					result = categoryEntity.getName();
				}
			}
			return result;
		}
		return null;
	}

	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		JspWriter out = null;
		try {
			out = this.pageContext.getOut();
			out.print(end().toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				out.clear();
				out.close();
				end().setLength(0);
			} catch (Exception e2) {
			}
		}
		return EVAL_PAGE;
	}
	
	public boolean isMultiCheck() {
		return multiCheck;
	}

	public void setMultiCheck(boolean multiCheck) {
		this.multiCheck = multiCheck;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getDefaultVal() {
		return defaultVal;
	}
	public void setDefaultVal(String defaultVal) {
		this.defaultVal = defaultVal;
	}
	public String getDivClass() {
		return divClass;
	}
	public void setDivClass(String divClass) {
		this.divClass = divClass;
	}
	public String getInputClass() {
		return inputClass;
	}
	public void setInputClass(String inputClass) {
		this.inputClass = inputClass;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getFormStyle() {
		return formStyle;
	}

	public void setFormStyle(String formStyle) {
		this.formStyle = formStyle;
	}

}
