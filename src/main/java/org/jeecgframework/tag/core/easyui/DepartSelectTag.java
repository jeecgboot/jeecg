package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.MutiLangUtil;

/**
 * 
 * 部门选择弹出框
 * 
 * @author: lijun
 * @date： 日期：2015-3-1
 * @version 1.0
 */
public class DepartSelectTag extends TagSupport {

	private static final long serialVersionUID = 1;
    
	private String readonly;// 只读属性
    public String getReadonly() {
		return readonly;
	}
	public void setReadonly(String readonly) {
		this.readonly = readonly;
	}

	private String selectedNamesInputId; // 用于记录已选择部门编号的input的id
	public String getSelectedNamesInputId() {
		return selectedNamesInputId;
	}

	public void setSelectedNamesInputId(String _selectedNamesInputId) {
		this.selectedNamesInputId = _selectedNamesInputId;
	}

	private String selectedIdsInputId; // 用于显示已选择部门名称的input的id
	public String getSelectedIdsInputId() {
		return selectedIdsInputId;
	}

	public void setSelectedIdsInputId(String _selectedIdsInputId) {
		this.selectedIdsInputId = _selectedIdsInputId;
	}
	
	private String departNameInputWidth; //已选择机构输入框宽度
	public String getDepartNameInputWidth() {
		return departNameInputWidth;
	}

	public void setDepartNameInputWidth(String departNameInputWidth) {
		
		this.departNameInputWidth = departNameInputWidth;
	}
	
	private String windowWidth; //窗口宽度
	public String getWindowWidth() {
		return windowWidth;
	}

	public void setWindowWidth(String windowWidth) {
		this.windowWidth = windowWidth;
	}
	
	private String windowHeight; //窗口高度
	public String getWindowHeight() {
		return windowHeight;
	}

	public void setWindowHeight(String windowHeight) {
		this.windowHeight = windowHeight;
	}
	
	private String departId;
	private String departName;

	public String getDepartId() {
		return departId;
	}
	public void setDepartId(String departId) {
		this.departId = departId;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
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
			} catch (Exception e2) {
			}
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		
		StringBuffer sb = new StringBuffer();
		if (StringUtils.isBlank(selectedNamesInputId)) {
			selectedNamesInputId = "departname"; // 默认id
		}
		if (StringUtils.isBlank(selectedIdsInputId)) {
			selectedIdsInputId = "orgIds"; // 默认id
		}
		String lblDepartment = MutiLangUtil.getMutiLangInstance().getLang("common.department");
		if(StringUtils.isBlank(lblDepartment)){
			lblDepartment = "组织机构";
		}
		
		if(StringUtils.isBlank(departNameInputWidth)){
			departNameInputWidth = "80px";
		}
		
		if(StringUtils.isBlank(windowWidth)){
			windowWidth = "400px";
		}
		
		if(StringUtils.isBlank(windowHeight)){
			windowHeight = "350px";
		}
		
		sb.append("<span style=\"display:-moz-inline-box;display:inline-block;\">");
		sb.append("<span style=\"vertical-align:middle;display:-moz-inline-box;display:inline-block;width: " + departNameInputWidth + ";text-align:right;\" title=\"" + lblDepartment + "\"/>");
		sb.append(lblDepartment + "：");
		sb.append("</span>");
		sb.append("<input readonly=\"true\" type=\"text\" id=\"" + selectedNamesInputId + "\" name=\"" + selectedNamesInputId + "\" style=\"width: 300px\" onclick=\"openDepartmentSelect()\" ");
		if(StringUtils.isNotBlank(departId)){
			sb.append(" value=\""+departName+"\"");
		}
		sb.append(" />");
		sb.append("<input id=\"" + selectedIdsInputId + "\" name=\"" + selectedIdsInputId + "\" type=\"hidden\" ");
		if(StringUtils.isNotBlank(departName)){
			sb.append(" value=\""+departId+"\"");
		}
		sb.append(">");
		sb.append("</span>");		
		
		String commonDepartmentList = MutiLangUtil.getMutiLangInstance().getLang("common.department.list");
		String commonConfirm = MutiLangUtil.getMutiLangInstance().getLang("common.confirm");
		String commonCancel = MutiLangUtil.getMutiLangInstance().getLang("common.cancel");
		
		sb.append("<script type=\"text/javascript\">");
		sb.append("function openDepartmentSelect() {");
		sb.append("    $.dialog.setting.zIndex = 9999; ");
		sb.append("    $.dialog({content: 'url:departController.do?departSelect', zIndex: 2100, title: '" + commonDepartmentList + "', lock: true, width: '" + windowWidth + "', height: '" + windowHeight + "', opacity: 0.4, button: [");
		sb.append("       {name: '" + commonConfirm + "', callback: callbackDepartmentSelect, focus: true},");
		sb.append("       {name: '" + commonCancel + "', callback: function (){}}");
		sb.append("   ]}).zindex();");
		sb.append("}");
		
		sb.append("function callbackDepartmentSelect() {");
		sb.append("    var iframe = this.iframe.contentWindow;");

		//sb.append("    var departname = iframe.getdepartListSelections('text');");
		sb.append(" var treeObj = iframe.$.fn.zTree.getZTreeObj(\"departSelect\");");
		sb.append(" var nodes = treeObj.getCheckedNodes(true);");
		sb.append(" if(nodes.length>0){");
		sb.append(" var ids='',names='';");
		sb.append("for(i=0;i<nodes.length;i++){");
		sb.append(" var node = nodes[i];");
		sb.append(" ids += node.id+',';");
		sb.append(" names += node.name+',';");
		sb.append("}");
		sb.append(" $('#" + selectedNamesInputId + "').val(names);");
		sb.append(" $('#" + selectedNamesInputId + "').blur();");		
		sb.append(" $('#" + selectedIdsInputId + "').val(ids);");
		sb.append("}");

		sb.append("}");
		sb.append("</script>");
		return sb;
	}
}
