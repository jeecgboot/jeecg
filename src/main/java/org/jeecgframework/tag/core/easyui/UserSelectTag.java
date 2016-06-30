package org.jeecgframework.tag.core.easyui;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.MutiLangUtil;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * 
 * 部门选择弹出框
 * 
 * @author: wangkun
 * @date： 日期：2015-3-27
 * @version 1.0
 */
public class UserSelectTag extends TagSupport {

	private static final long serialVersionUID = 1;
    
	private String readonly;// 只读属性
    public String getReadonly() {
		return readonly;
	}
	public void setReadonly(String readonly) {
		this.readonly = readonly;
	}

	private String title;//弹出框标头

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	private String lblName;//组件名称

	public String getLblName() {
		return lblName;
	}

	public void setLblName(String lblName) {
		this.lblName = lblName;
	}

	private String selectedNamesInputId; // 用于记录已选择用户名称的input的id
	public String getSelectedNamesInputId() {
		return selectedNamesInputId;
	}

	public void setSelectedNamesInputId(String _selectedNamesInputId) {
		this.selectedNamesInputId = _selectedNamesInputId;
	}
	
	private String userNameInputWidth; //已选择机构输入框宽度
	public String getUserNameInputWidth() {
		return userNameInputWidth;
	}

	public void setUserNameInputWidth(String userNameInputWidth) {
		
		this.userNameInputWidth = userNameInputWidth;
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

	private String userName;

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
			selectedNamesInputId = "realName"; // 默认id
		}
		//String lblDepartment = MutiLangUtil.getMutiLangInstance().getLang("common.department");
		if(StringUtils.isBlank(lblName)){
			lblName = "真实姓名";
		}
		
		if(StringUtils.isBlank(userNameInputWidth)){
			userNameInputWidth = "80px";
		}
		
		if(StringUtils.isBlank(windowWidth)){
			windowWidth = "400px";
		}
		
		if(StringUtils.isBlank(windowHeight)){
			windowHeight = "350px";
		}
		
		sb.append("<span style=\"display:-moz-inline-box;display:inline-block;\">");
		sb.append("<span style=\"vertical-align:middle;display:-moz-inline-box;display:inline-block;width: " + userNameInputWidth + ";text-align:right;\" title=\"" + lblName + "\"/>");
		sb.append(lblName + "：");
		sb.append("</span>");
		sb.append("<input readonly=\"true\" type=\"text\" id=\"" + selectedNamesInputId + "\" name=\"" + selectedNamesInputId + "\" style=\"width: 200px\" onclick=\"openUserSelect()\" ");
		/*if(StringUtils.isNotBlank(departId)){
			sb.append(" value=\""+departName+"\"");
		}*/
		//sb.append(" />");
		//sb.append("<input id=\"" + selectedIdsInputId + "\" name=\"" + selectedIdsInputId + "\" type=\"hidden\" ");
		/*if(StringUtils.isNotBlank(departName)){
			sb.append(" value=\""+departId+"\"");
		}*/
		//sb.append(">");
		sb.append("</span>");		
		
		//String commonDepartmentList = MutiLangUtil.getMutiLangInstance().getLang("common.department.list");
		String commonConfirm = MutiLangUtil.getMutiLangInstance().getLang("common.confirm");
		String commonCancel = MutiLangUtil.getMutiLangInstance().getLang("common.cancel");
		
		sb.append("<script type=\"text/javascript\">");
		sb.append("function openUserSelect() {");
		sb.append("    $.dialog.setting.zIndex = 9999; ");
		sb.append("    $.dialog({content: 'url:userController.do?userSelect', zIndex: 2100, title: '" + title + "', lock: true, width: '" + windowWidth + "', height: '" + windowHeight + "', opacity: 0.4, button: [");
		sb.append("       {name: '" + commonConfirm + "', callback: callbackUserSelect, focus: true},");
		sb.append("       {name: '" + commonCancel + "', callback: function (){}}");
		sb.append("   ]}).zindex();");
		sb.append("}");
		
		sb.append("function callbackUserSelect() {");
		sb.append("var iframe = this.iframe.contentWindow;");
		//var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
		sb.append("var rowsData = iframe.$('#userList1').datagrid('getSelections');");
		sb.append("if (!rowsData || rowsData.length==0) {");
		sb.append("tip('<t:mutiLang langKey=\"common.please.select.edit.item\"/>');");
		sb.append("return;");
		sb.append("}");
		sb.append("var names=rowsData[0].realName;");
		sb.append("$('#" + selectedNamesInputId + "').val(names);");
		sb.append("$('#" + selectedNamesInputId + "').blur();");
		//sb.append(" $('#" + selectedIdsInputId + "').val(ids);");
		sb.append("}");
		sb.append("</script>");
		return sb;
	}
}
