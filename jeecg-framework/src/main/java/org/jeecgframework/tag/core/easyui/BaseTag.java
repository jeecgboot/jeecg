package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import jodd.util.StringUtil;

import org.apache.log4j.Logger;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.JeecgTag;

/**
 * 
 * @author  张代浩
 *
 */
public class BaseTag extends JeecgTag {
	private static Logger log = Logger.getLogger(BaseTag.class);
	private static final long serialVersionUID = 1L;
	protected String type = "default";// 加载类型
	protected String cssTheme ;
	
	public String getCssTheme() {
		return cssTheme;
	}


	public void setCssTheme(String cssTheme) {
		this.cssTheme = cssTheme;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	public int doStartTag() throws JspException {
		return EVAL_PAGE;
	}

	
	public int doEndTag() throws JspException {
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
					out.clearBuffer();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return EVAL_PAGE;
	}

	public StringBuffer end(){
		StringBuffer sb = this.getTagCache();
		if(sb != null){
			return sb;
		}
		sb = new StringBuffer();
		String types[] = type.split(",");
		SysThemesEnum sysThemesEnum = null;
		if(StringUtil.isEmpty(cssTheme)||"null".equals(cssTheme)){
			sysThemesEnum = SysThemesUtil.getSysTheme((HttpServletRequest) super.pageContext.getRequest());
		}else{
			sysThemesEnum = SysThemesEnum.toEnum(cssTheme);
		}
		
		//插入多语言脚本
		HttpServletRequest request =(HttpServletRequest) this.pageContext.getRequest();
		String lang = (String)request.getSession().getAttribute("lang");
		String basePath = ResourceUtil.getBasePath();
		if(lang==null){lang="zh-cn";}
		String langjs = StringUtil.replace("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/mutiLang/{0}.js\"></script>", "{0}", lang);
		sb.append(langjs);
		if (oConvertUtils.isIn("jquery-webos", types)) {
            sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/sliding/js/jquery-1.7.1.min.js\"></script>");
            
		} else if (oConvertUtils.isIn("jquery", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery/jquery-1.8.3.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery/jquery.cookie.js\" ></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-plugs/storage/jquery.storageapi.min.js\" ></script>");
		}
		if (oConvertUtils.isIn("ckeditor", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/ckeditor/ckeditor.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/ckeditorTool.js\"></script>");
		}
		if (oConvertUtils.isIn("easyui", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/dataformat.js\"></script>");
			sb.append(SysThemesUtil.getEasyUiTheme(sysThemesEnum));
			sb.append(SysThemesUtil.getEasyUiMainTheme(sysThemesEnum));
			sb.append(SysThemesUtil.getEasyUiIconTheme(sysThemesEnum));
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\""+basePath+"/plug-in/accordion/css/accordion.css\">");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\""+basePath+"/plug-in/accordion/css/icons.css\">");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/easyui/jquery.easyui.min.1.3.2.js\"></script>");
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/easyui/locale/{0}.js\"></script>", "{0}", lang)); 
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/syUtil.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/easyui/extends/datagrid-scrollview.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/mutitables/datagrid-filter.js\"></script>");
		}
		if (oConvertUtils.isIn("DatePicker", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/My97DatePicker/WdatePicker.js\"></script>");
		}
		if (oConvertUtils.isIn("jqueryui", types)) {
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/jquery-ui/css/ui-lightness/jquery-ui-1.9.2.custom.min.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-ui/js/jquery-ui-1.9.2.custom.min.js\"></script>");
		}
		if (oConvertUtils.isIn("jqueryui-sortable", types)) {
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/jquery-ui/css/ui-lightness/jquery-ui-1.9.2.custom.min.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-ui/js/ui/jquery.ui.core.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-ui/js/ui/jquery.ui.widget.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-ui/js/ui/jquery.ui.mouse.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-ui/js/ui/jquery.ui.sortable.js\"></script>");
		}
		if (oConvertUtils.isIn("prohibit", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/prohibitutil.js\"></script>");		}
		if (oConvertUtils.isIn("tools", types)) {
			sb.append(SysThemesUtil.getCommonTheme(sysThemesEnum));
			sb.append(SysThemesUtil.getLhgdialogTheme(sysThemesEnum));
			sb.append(SysThemesUtil.getBootstrapTabTheme(sysThemesEnum));
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/layer/layer.js\"></script>");
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/curdtools_{0}.js\"></script>", "{0}", lang));
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/easyuiextend.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery-plugs/hftable/jquery-hftable.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/json2.js\" ></script>");
		}
		if (oConvertUtils.isIn("toptip", types)) {
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/toptip/css/css.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/toptip/manhua_msgTips.js\"></script>");
		}
		if (oConvertUtils.isIn("autocomplete", types)) {
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/jquery/jquery-autocomplete/jquery.autocomplete.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery/jquery-autocomplete/jquery.autocomplete.min.js\"></script>");
		}
		if (oConvertUtils.isIn("jeasyuiextensions", types)) {
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/release/jquery.jdirk.min.js\" type=\"text/javascript\"></script>");
			sb.append("<link href=\""+basePath+"/plug-in/jquery-extensions/icons/icon-all.css\" rel=\"stylesheet\" type=\"text/css\" />");
			sb.append("<link href=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.css\" rel=\"stylesheet\" type=\"text/css\" />");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.js\" type=\"text/javascript\"></script>");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.linkbutton.js\" type=\"text/javascript\"></script>");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.menu.js\" type=\"text/javascript\"></script>");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.panel.js\" type=\"text/javascript\"></script>");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.window.js\" type=\"text/javascript\"></script>");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.dialog.js\" type=\"text/javascript\"></script>");
			sb.append("<script src=\""+basePath+"/plug-in/jquery-extensions/jeasyui-extensions/jeasyui.extensions.datagrid.js\" type=\"text/javascript\"></script>");
		}
		if (oConvertUtils.isIn("ztree", types)) {
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/ztree/css/zTreeStyle.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/ztree/js/jquery.ztree.core-3.5.min.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\"></script>");
		}

		if (oConvertUtils.isIn("bootstrap", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/jquery/jquery-1.9.1.js\"></script>");
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/bootstrap3.3.5/css/bootstrap.min.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/bootstrap3.3.5/js/bootstrap.min.js\"></script>");
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/bootstrap3.3.5/css/default.css\" type=\"text/css\"></link>");
		}
		if (oConvertUtils.isIn("bootstrap-table", types)) {
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/bootstrap-table/bootstrap-table.min.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/bootstrap-table/bootstrap-table.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/themes/bootstrap-ext/js/common.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/tools/dataformat.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/lhgDialog/lhgdialog.min.js?skin=metrole\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/themes/bootstrap-ext/js/bootstrap-lhgdialog-curdtools_zh-cn.js\"></script>");

			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/tools/css/metrole/common.css\" type=\"text/css\"></link>");
			sb.append("<link rel=\"stylesheet\" href=\""+basePath+"/plug-in/ace/css/font-awesome.css\" type=\"text/css\"></link>");

		}
		if (oConvertUtils.isIn("layer", types)) {
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/layer/layer.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\""+basePath+"/plug-in/laydate/laydate.js\"></script>");
		}

		types = null;
		this.putTagCache(sb);
		return sb;
	}


	public String toString() {
		return new StringBuffer().append("BaseTag [type=").append(type)
				.append(",sysTheme=").append(SysThemesUtil.getSysTheme(ContextHolderUtils.getRequest()).getStyle())
				.append(",brower_type=").append(ContextHolderUtils.getSession().getAttribute("brower_type"))
				.append(",cssTheme=").append(cssTheme)
				.append("]").toString();
	}
	
}
