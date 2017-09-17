package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * 下拉选择菜单框
 * 
 * @author: gengjiajia
 * @date： 日期：2016-7-25
 * @version 1.0
 */
public class SelectZTreeTag extends TagSupport {

	private static final long serialVersionUID = 1;
    
	private String id;
	private String url;
	private String windowWidth; //窗口宽度
	private String windowHeight; //窗口高度
	public String getUrl() {
		return url;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setUrl(String url) {
		this.url = url;
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
			if(out!=null){
				try {
					out.clear();
					out.close();
				} catch (Exception e) {
				}
			}
			
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		
		StringBuffer sb = new StringBuffer();
		if (StringUtils.isBlank(url)) {
			url = "url"; 
		}
		
		if(StringUtils.isBlank(windowWidth)){
			windowWidth = "200px";
		}
		
		if(StringUtils.isBlank(windowHeight)){
			windowHeight = "30px";
		}
		sb.append("<link rel=\"stylesheet\" href=\"plug-in/ztree/css/zTreeStyle.css\" type=\"text/css\"></link>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/ztree/js/jquery.ztree.core-3.5.min.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\"></script>");

		sb.append("<script type=\"text/javascript\">"
		+"function beforeClick(treeId, treeNode) {"
		+ "   var zTree = $.fn.zTree.getZTreeObj('treeDemo');"
		+ "   zTree.checkNode(treeNode, !treeNode.checked, null, true);"
		+ "   return false;"
		+ "}"
		+ "function onCheck(e, treeId, treeNode) {"
		+ "		var zTree = $.fn.zTree.getZTreeObj('treeDemo'),"
		+ "		nodes = zTree.getCheckedNodes(true),"
		+ "		v = '';"
		+ "		for (var i=0, l=nodes.length; i<l; i++) {"
		+ "			v += nodes[i].name + ',';"
		+ "		}"
		+ "		if (v.length > 0 ) v = v.substring(0, v.length-1);"
		+ "		var cityObj = $('#"+id+"');"
		+ "		cityObj.attr('value', v);"
		+ "} "
		+ " function showMenu() {"
		+ "		var cityObj = $('#"+id+"');"
		+ "		var cityOffset = $('#"+id+"').offset();"
		+ " $('#menuContent').css({left:cityOffset.left + 'px', top:cityOffset.top + cityObj.outerHeight() + 'px'}).slideDown('fast');"		
		+ "    $('body').bind('mousedown', onBodyDown);"
		+ "} "
		+ " function hideMenu() {"
		+ "		$('#menuContent').fadeOut('fast');"
		+ "		$('body').unbind('blur', onBodyDown);"
		+ "} "
		+ " function onBodyDown(event) {"
		+ "		if (!(event.target.id == 'menuBtn' || event.target.id == 'citySel' || event.target.id == 'menuContent' || $(event.target).parents('#menuContent').length>0)) {"
		+ "		hideMenu();"
		+ "	 }"
		+ "} "
		+ " var setting = {"
		+ "		async: {"
		+ "		enable: true,"
		+ "}, "
		+ "		check: {"
		+ "			enable: true,"
		+ "			chkboxType: {'Y':'', 'N':''}"
		+ "		},"
		+ "		view: {"
		+ "			dblClickExpand: false"
		+ "		},"
		+ "		data: {"
		+ "			simpleData: {"
		+ "				enable: true"
		+ "			}"
		+ "		},"
		+ "		callback: {"
		+ "			beforeClick: beforeClick,"
		+ "			onCheck: onCheck"
		+ "			}"
		+ "		};"
		+ " $(function(){"
		+ "		$.post("
		+ "			'"+url+"',"
		+ "		function(data){"
		+ "			var d = $.parseJSON(data);"
		+ "			if (d.success) {"
		+ "				var datas = eval(d.obj);"
		+ "				$.fn.zTree.init($('#treeDemo'), setting, datas);"
		+ "				}"
		+ "			}"
		+ "		);"
		+ "});"
		+ "</script>");

		sb.append("		   <input id=\""+id+"\" name=\""+id+"\"  type=\"text\" readonly value=\"\" style=\"width:"+windowWidth+";height:"+windowHeight+"\" class=\"form-control\" onclick=\"showMenu();\" />");
		sb.append("<div id=\"menuContent\" class=\"menuContent\" style=\"display:none; position: absolute;\" >");
		sb.append("		<ul id=\"treeDemo\" class=\"ztree\" style=\"margin-top:0; width:100%;background-color:#f9f9f9\"></ul>");
		sb.append("</div>");
		return sb;
	}
}
