package org.jeecgframework.tag.core.easyui;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.oConvertUtils;

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
	
	private String title;					//标题
	private String selectedNamesInputId; 	// 用于显示已选择用户的用户名  input的id
	private String selectedIdsInputId;		// 用于记录已选择用户的用户id input的id
	private boolean hasLabel = false;       //是否显示lable,默认不显示
	private String userNamesDefalutVal;    //用户名默认值
	private String userIdsDefalutVal;   	 //用户ID默认值
	private String readonly = "readonly";	// 只读属性
	private String inputWidth; 				//输入框宽度
	private String windowWidth; 			//弹出窗口宽度
	private String windowHeight; 			//弹出窗口高度

	private String callback;//自定义回掉函数

	
    public String getUserIdsDefalutVal() {
		return userIdsDefalutVal;
	}
	public void setUserIdsDefalutVal(String userIdsDefalutVal) {
		this.userIdsDefalutVal = userIdsDefalutVal;
	}
	public String getSelectedIdsInputId() {
		return selectedIdsInputId;
	}
	public void setSelectedIdsInputId(String selectedIdsInputId) {
		this.selectedIdsInputId = selectedIdsInputId;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSelectedNamesInputId() {
		return selectedNamesInputId;
	}

	public void setSelectedNamesInputId(String _selectedNamesInputId) {
		this.selectedNamesInputId = _selectedNamesInputId;
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
	
	public String getUserNamesDefalutVal() {
		return userNamesDefalutVal;
	}
	public void setUserNamesDefalutVal(String userNamesDefalutVal) {
		this.userNamesDefalutVal = userNamesDefalutVal;
	}

	public String getCallback() {
		if(oConvertUtils.isEmpty(callback)){
			callback = "callbackUserSelect";
		}
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
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
			selectedNamesInputId = "userNames"; // 默认id
		}
		if(StringUtils.isBlank(title)){
			title = "用户名称";
		}
		
		if(StringUtils.isBlank(inputWidth)){
			inputWidth = "150px";
		}
		
		if(StringUtils.isBlank(windowWidth)){
			windowWidth = "400px";
		}
		
		if(StringUtils.isBlank(windowHeight)){
			windowHeight = "350px";
		}
		if(hasLabel && oConvertUtils.isNotEmpty(title)){
			sb.append(title + "：");
		}
		sb.append("<input class=\"inuptxt\" readonly=\""+readonly+"\" type=\"text\" id=\"" + selectedNamesInputId + "\" name=\"" + selectedNamesInputId + "\" style=\"width: "+inputWidth+"\" onclick=\"openUserSelect()\" ");
		if(StringUtils.isNotBlank(userNamesDefalutVal)){
			sb.append(" value=\""+userNamesDefalutVal+"\"");
		}
		sb.append(" />");
		
		if(oConvertUtils.isNotEmpty(selectedIdsInputId)){
			sb.append("<input class=\"inuptxt\" id=\"" + selectedIdsInputId + "\" name=\"" + selectedIdsInputId + "\" type=\"hidden\" ");
			if(StringUtils.isNotBlank(userIdsDefalutVal)){
				sb.append(" value=\""+userIdsDefalutVal+"\"");
			}
			sb.append("/>");
		}
		
		String commonConfirm = MutiLangUtil.getMutiLangInstance().getLang("common.confirm");
		String commonCancel = MutiLangUtil.getMutiLangInstance().getLang("common.cancel");
		
		sb.append("<script type=\"text/javascript\">");
		sb.append("function openUserSelect() {");

		sb.append("    $.dialog({content: 'url:userController.do?userSelect', zIndex: getzIndex(), title: '" + title + "', lock: true, width: '" + windowWidth + "', height: '" + windowHeight + "', opacity: 0.4, button: [");

		sb.append("       {name: '" + commonConfirm + "', callback: "+getCallback()+", focus: true},");

		sb.append("       {name: '" + commonCancel + "', callback: function (){}}");
		sb.append("   ]});");

		sb.append("}");
		
		sb.append("function callbackUserSelect() {");
		sb.append("var iframe = this.iframe.contentWindow;");
		sb.append("var rowsData = iframe.$('#userList1').datagrid('getSelections');");
		sb.append("if (!rowsData || rowsData.length==0) {");
		sb.append("tip('<t:mutiLang langKey=\"common.please.select.edit.item\"/>');");
		sb.append("return;");
		sb.append("}");
		
		sb.append(" var ids='',names='';");
		sb.append("for(i=0;i<rowsData.length;i++){");
		sb.append(" var node = rowsData[i];");
		sb.append(" ids += node.id+',';");
		sb.append(" names += node.realName+',';");
		sb.append("}");
		
		sb.append("$('#" + selectedNamesInputId + "').val(names);");
		sb.append("$('#" + selectedNamesInputId + "').blur();");
		if(oConvertUtils.isNotEmpty(selectedIdsInputId)){
			sb.append("$('#" + selectedIdsInputId + "').val(ids);");
		}
		sb.append("}");
		sb.append("</script>");
		return sb;
	}
}
