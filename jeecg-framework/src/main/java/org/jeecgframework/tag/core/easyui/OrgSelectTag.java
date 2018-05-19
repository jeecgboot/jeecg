package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.oConvertUtils;

/**
 * 
 * 部门选择弹出框
 * 
 * @author: lijun
 * @date： 日期：2015-3-1
 * @version 1.0
 */
public class OrgSelectTag extends TagSupport {

	private static final long serialVersionUID = 1;
	private String selectedIdsInputId;      // 用于记录已选择部门编号的input的id
	private String selectedNamesInputId;    // 用于显示已选择部门名称的input的name
	private String inputWidth;     			//输入框宽度
	private String windowWidth; 			//弹出窗口宽度
	private String windowHeight; 			//弹出窗口高度
	private String departIdsDefalutVal; 	//部门ids 默认值
	private String departNamesDefalutVal;	//部门names 默认值
	private String readonly = "readonly";	// 只读属性
	private boolean hasLabel = false;       //是否显示lable,默认不显示
	private String title;			   		// 标题

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public boolean isHasLabel() {
		return hasLabel;
	}
	public void setHasLabel(boolean hasLabel) {
		this.hasLabel = hasLabel;
	}
	public String getReadonly() {
		return readonly;
	}
	public void setReadonly(String readonly) {
		this.readonly = readonly;
	}
	
	public String getSelectedNamesInputId() {
		return selectedNamesInputId;
	}

	public void setSelectedNamesInputId(String _selectedNamesInputId) {
		this.selectedNamesInputId = _selectedNamesInputId;
	}

	public String getSelectedIdsInputId() {
		return selectedIdsInputId;
	}

	public void setSelectedIdsInputId(String _selectedIdsInputId) {
		this.selectedIdsInputId = _selectedIdsInputId;
	}
	
	public String getInputWidth() {
		return inputWidth;
	}
	public void setInputWidth(String inputWidth) {
		this.inputWidth = inputWidth;
	}
	public String getWindowWidth() {
		return windowWidth;
	}

	public void setWindowWidth(String windowWidth) {
		this.windowWidth = windowWidth;
	}
	
	public String getWindowHeight() {
		return windowHeight;
	}

	public void setWindowHeight(String windowHeight) {
		this.windowHeight = windowHeight;
	}
	
	public String getDepartIdsDefalutVal() {
		return departIdsDefalutVal;
	}
	public void setDepartIdsDefalutVal(String departIdsDefalutVal) {
		this.departIdsDefalutVal = departIdsDefalutVal;
	}
	public String getDepartNamesDefalutVal() {
		return departNamesDefalutVal;
	}
	public void setDepartNamesDefalutVal(String departNamesDefalutVal) {
		this.departNamesDefalutVal = departNamesDefalutVal;
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
			selectedNamesInputId = "orgNames"; // 默认id
		}
		if (StringUtils.isBlank(selectedIdsInputId)) {
			selectedIdsInputId = "orgIds"; // 默认id
		}
		if(StringUtils.isBlank(title)){
			title = "选择部门";
		}
		
		if(StringUtils.isBlank(inputWidth)){
			inputWidth = "150px";
		}

		if(StringUtils.isBlank(windowWidth)){
			windowWidth = "660px";
		}

		
		if(StringUtils.isBlank(windowHeight)){
			windowHeight = "350px";
		}
		if(hasLabel && oConvertUtils.isNotEmpty(title)){
			sb.append(title + "：");
		}
		sb.append("<input readonly=\"true\" type=\"text\" id=\"" + selectedNamesInputId + "\" name=\"" + selectedNamesInputId + "\" style=\"width: "+inputWidth+"\" onclick=\"openOrgSelect()\" ");
		if(StringUtils.isNotBlank(departNamesDefalutVal)){
			sb.append(" value=\""+departNamesDefalutVal+"\"");
		}
		sb.append(" />");
		
		String orgIds = "";
		
		sb.append("<input id=\"" + selectedIdsInputId + "\" name=\"" + selectedIdsInputId + "\" type=\"hidden\" ");
		if(StringUtils.isNotBlank(departIdsDefalutVal)){
			sb.append(" value=\""+departIdsDefalutVal+"\"");
			orgIds = "&orgIds=" + departIdsDefalutVal;
		}
		sb.append("/>");
		
		String commonDepartmentList = MutiLangUtil.getLang("common.department.list");
		String commonConfirm = MutiLangUtil.getLang("common.confirm");
		String commonCancel = MutiLangUtil.getLang("common.cancel");
		
		sb.append("<script type=\"text/javascript\">");
		sb.append("function openOrgSelect() {");
		sb.append("    $.dialog.setting.zIndex = 9999; ");//TODO
		sb.append("    $.dialog({content: 'url:departController.do?orgSelect" + orgIds + "', zIndex: 2100, title: '" + commonDepartmentList + "', lock: true, width: '" + windowWidth + "', height: '" + windowHeight + "', opacity: 0.4, button: [");
		sb.append("       {name: '" + commonConfirm + "', callback: callbackOrgSelect, focus: true},");
		sb.append("       {name: '" + commonCancel + "', callback: function (){}}");
		sb.append("   ]}).zindex();");
		sb.append("}");
			
		sb.append("function callbackOrgSelect() {");
		sb.append("    var iframe = this.iframe.contentWindow;");	
		sb.append("var nodes = iframe.document.getElementsByClassName(\"departId\");");		
		sb.append(" if(nodes.length>0){");
		sb.append(" var ids='',names='';");
		sb.append("for(i=0;i<nodes.length;i++){");
		sb.append(" var node = nodes[i];");
		sb.append(" if(node.checked){");
		sb.append("   ids += node.value+',';");
		sb.append("   names += node.name+',';");
		sb.append(" }");
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
