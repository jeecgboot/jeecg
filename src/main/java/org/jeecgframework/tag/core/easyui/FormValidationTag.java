package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.SysThemesUtil;

/**
 * 
 * @author  张代浩
 *
 */
public class FormValidationTag extends TagSupport {
	private static final Logger logger = Logger.getLogger(FormValidationTag.class);
	private static final long serialVersionUID = 8360534826228271024L;
	
	protected String formid = "formobj";// 表单FORM ID
	protected Boolean refresh = true;
	protected String callback;// 回调函数
	protected String beforeSubmit;// 提交前处理函数
	protected String btnsub = "btn_sub";// 以ID为标记触发提交事件
	protected String btnreset = "btn_reset";// 以ID为标记触发提交事件
	protected String layout = "div";// 表单布局
	protected String usePlugin;// 外调插件
	protected boolean dialog = true;// 是否是弹出窗口模式
	protected String action;// 表单提交路径
	protected String tabtitle;// 表单选项卡
	protected String tiptype = "4";//校验方式

	protected String styleClass ;//table 样式

	protected String cssTheme;//主题样式目录默认为空
	
	public String getCssTheme() {
		return cssTheme;
	}

	public void setCssTheme(String cssTheme) {
		this.cssTheme = cssTheme;
	}

	public String getStyleClass() {
		return styleClass;
	}

	public void setStyleClass(String styleClass) {
		this.styleClass = styleClass;
	}

	public void setTabtitle(String tabtitle) {
		this.tabtitle = tabtitle;
	}

	public void setDialog(boolean dialog) {
		this.dialog = dialog;
	}

	public void setBtnsub(String btnsub) {
		this.btnsub = btnsub;
	}

	public void setRefresh(Boolean refresh) {
		this.refresh = refresh;
	}

	public void setBtnreset(String btnreset) {
		this.btnreset = btnreset;
	}

	public void setFormid(String formid) {
		this.formid = formid;
	}

	public void setAction(String action) {
		this.action = action;
	}
	
	public int doStartTag() throws JspException {
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//long start = System.currentTimeMillis();
		//logger.debug("=================Form=====doStartTag==========开始时间:" + sdf.format(new Date()) + "==============================");
		JspWriter out = null;
		try {
			out = this.pageContext.getOut();
			StringBuffer sb = new StringBuffer();
				/*//			if(cssTheme==null){//手工设置值优先
				Cookie[] cookies = ((HttpServletRequest) super.pageContext
						.getRequest()).getCookies();
				for (Cookie cookie : cookies) {
					if (cookie == null || StringUtils.isEmpty(cookie.getName())) {
						continue;
					}
					if (cookie.getName().equalsIgnoreCase("JEECGCSSTHEME")) {
						cssTheme = cookie.getValue();
					}
				}
//			}
			if(cssTheme==null||"default".equals(cssTheme))cssTheme="";*/
			if ("div".equals(layout)) {
				sb.append("<div id=\"content\">");

				sb.append("<div id=\"wrapper\" style=\"border-left:1px solid #ddd;\">");

				sb.append("<div id=\"steps\">");
			}
			sb.append("<form id=\"" + formid + "\" " );

			if(this.getStyleClass()!=null){
				sb.append("class=\""+this.getStyleClass()+"\" ");
			}

					sb.append(" action=\"" + action + "\" name=\"" + formid + "\" method=\"post\">");
			if ("btn_sub".equals(btnsub) && dialog)
				sb.append("<input type=\"hidden\" id=\"" + btnsub + "\" class=\"" + btnsub + "\"/>");
			
			out.print(sb.toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				out.clearBuffer();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		//long end = System.currentTimeMillis();
		//logger.debug("==============Form=====doStartTag=================结束时间:" + sdf.format(new Date()) + "==============================");
		//logger.debug("===============Form=====doStartTag=================耗时:" + (end - start) + "ms==============================");

		return EVAL_PAGE;
	}

	
	public int doEndTag() throws JspException {
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//long start = System.currentTimeMillis();
		//logger.debug("=================Form=====doEndTag==========开始时间:" + sdf.format(new Date()) + "==============================");
		StringBuffer sb = null;
		String lang = (String)((HttpServletRequest) this.pageContext.getRequest()).getSession().getAttribute("lang");

		JspWriter out = null;
		try {
			out = this.pageContext.getOut();
			SysThemesEnum sysThemesEnum = null;
			if(StringUtil.isEmpty(cssTheme)||"null".equals(cssTheme)){
				sysThemesEnum = SysThemesUtil.getSysTheme((HttpServletRequest) super.pageContext.getRequest());
			}else{
				sysThemesEnum = SysThemesEnum.toEnum(cssTheme);
			}
			sb = new StringBuffer();
			if (layout.equals("div")) {

//				if("metro".equals(cssTheme)){
//					sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/"+cssTheme+"/divfrom.css\" type=\"text/css\"/>");
//				}else{
//					sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/divfrom.css\" type=\"text/css\"/>");
//				}
				//divfrom.css
				sb.append(SysThemesUtil.getValidformDivfromTheme(sysThemesEnum));
				if (tabtitle != null)
					sb.append("<script type=\"text/javascript\" src=\"plug-in/Validform/js/form.js\"></script>");
			}
//			if("metro".equals(cssTheme)){
//				sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/"+cssTheme+"/style.css\" type=\"text/css\"/>");
//				sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/"+cssTheme+"/tablefrom.css\" type=\"text/css\"/>");
//			}else{
//				sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/style.css\" type=\"text/css\"/>");
//				sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/tablefrom.css\" type=\"text/css\"/>");
//			}
			//style.css
			sb.append(SysThemesUtil.getValidformStyleTheme(sysThemesEnum));
			//tablefrom.css
			sb.append(SysThemesUtil.getValidformTablefrom(sysThemesEnum));

			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/Validform/js/Validform_v5.3.1_min_{0}.js\"></script>", "{0}", lang));
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/Validform/js/Validform_Datatype_{0}.js\"></script>", "{0}", lang));
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/Validform/js/datatype_{0}.js\"></script>", "{0}", lang));

			if("6".equals(tiptype)){
				sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/tiptype.css\" type=\"text/css\"/>");
				sb.append("<script type=\"text/javascript\" src=\"plug-in/Validform/js/tiptype.js\"></script>");
			}

			if (usePlugin != null) {
				if (usePlugin.indexOf("jqtransform") >= 0) {
					sb.append("<SCRIPT type=\"text/javascript\" src=\"plug-in/Validform/plugin/jqtransform/jquery.jqtransform.js\"></SCRIPT>");
					sb.append("<LINK rel=\"stylesheet\" href=\"plug-in/Validform/plugin/jqtransform/jqtransform.css\" type=\"text/css\"></LINK>");
				}
				if (usePlugin.indexOf("password") >= 0) {
					sb.append("<SCRIPT type=\"text/javascript\" src=\"plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js\"></SCRIPT>");
				}
			}

			sb.append("<script src=\"plug-in/layer/layer.js\"></script>");

			sb.append("<script type=\"text/javascript\">");

			sb.append("var subDlgIndex = null;");

			sb.append("$(function(){");
			sb.append("$(\"#" + formid + "\").Validform({");
			if(this.getTiptype()!=null && !"".equals(this.getTiptype())){	

				if(tiptype.equals("1")){
					sb.append("tiptype:function(msg,o,cssctl){");
					sb.append("if(o.type == 3){");
					sb.append("layer.open({");
					sb.append("title:'提示信息',");

					sb.append("content:msg,icon:5,shift:6,btn:false,shade:false,time:5000,");

					sb.append("cancel:function(index){o.obj.focus();layer.close(index);},");

					sb.append("yes:function(index){o.obj.focus();layer.close(index);}");

					sb.append("})");
					sb.append("}},");

				}else if("6".equals(tiptype)){
					sb.append("tiptype:function(msg,o,cssctl){");
					sb.append("if(o.type==3){");
					sb.append(" ValidationMessage(o.obj,msg);");
					sb.append("}else{");
					sb.append("removeMessage(o.obj);");
					sb.append("}");
					sb.append("},");

				}else{
					sb.append("tiptype:"+this.getTiptype()+",");
				}

			}else{
				sb.append("tiptype:1,");
			}
//			sb.append("tiptype:function(msg,o,cssctl){");
//			sb.append("if(!o.obj.is(\"form\")){");
//			sb.append("	var objtip=o.obj.parent().find(\".Validform_checktip\");");
//			sb.append("	cssctl(objtip,o.type);");
//			sb.append("	objtip.text(msg);");
//			sb.append("	var infoObj=o.obj.parent().find(\".Validform_checktip\");");
//			sb.append("	if(o.type==2){");
//			sb.append("		infoObj.hide();infoObj.show();");
//			sb.append("		infoObj.fadeOut(8000);");
//			sb.append("	}else{");
//			sb.append("		infoObj.hide();");
//			sb.append("		var left=o.obj.offset().left;");
//			sb.append("		var top=o.obj.offset().top;");
//			sb.append("		infoObj.css({	");
//			sb.append("			left:left+85,");
//			sb.append("			top:top-10");
//			sb.append("		}).show().animate({");
//			sb.append("			top:top-5");
//			sb.append("		},200);infoObj.fadeOut(8000);");
//			sb.append("	}");
//			sb.append("}");
//			sb.append("},");
			sb.append("btnSubmit:\"#" + btnsub + "\",");
			sb.append("btnReset:\"#" + btnreset + "\",");
			sb.append("ajaxPost:true,");
			if (beforeSubmit != null) {
				sb.append("beforeSubmit:function(curform){var tag=true;");

				sb.append("tag = " + beforeSubmit );
				if(beforeSubmit.indexOf("(") < 0){
					sb.append("(curform);");
				}else if(!beforeSubmit.endsWith(";")){
					sb.append(";");
				}
				sb.append("if(tag || tag!=false){");

				submitLoading(sb);

				sb.append("}else{ return false;}");

			}else{
				sb.append("beforeSubmit:function(curform){var tag=false;");
				submitLoading(sb);
			}
			sb.append("},");

			if (usePlugin != null) {
				StringBuffer passsb = new StringBuffer();
				if (usePlugin.indexOf("password") >= 0) {
					passsb.append("passwordstrength:{");
					passsb.append("minLen:6,");
					passsb.append("maxLen:18,");
					passsb.append("trigger:function(obj,error)");
					passsb.append("{");
					passsb.append("if(error)");
					passsb.append("{");
					passsb.append("obj.parent().next().find(\".Validform_checktip\").show();");
					passsb.append("obj.find(\".passwordStrength\").hide();");
					passsb.append("}");
					passsb.append("else");
					passsb.append("{");
					passsb.append("$(\".passwordStrength\").show();");
					passsb.append("obj.parent().next().find(\".Validform_checktip\").hide();");
					passsb.append("}");
					passsb.append("}");// trigger结尾
					passsb.append("}");// passwordstrength结尾
				}

				sb.append("usePlugin:{");
				if (usePlugin.indexOf("password") >= 0) {
					sb.append(passsb);
				}
				StringBuffer jqsb = new StringBuffer();
				if (usePlugin.indexOf("jqtransform") >= 0) {
					if (usePlugin.indexOf("password") >= 0) {
						sb.append(",");
					}
					jqsb.append("jqtransform :{selector:\"select\"}");
				}

				if (usePlugin.indexOf("jqtransform") >= 0) {
					sb.append(jqsb);
				}
				sb.append("},");
			}
			sb.append("callback:function(data){");

			sb.append("if(subDlgIndex && subDlgIndex != null){");
			sb.append("$('#infoTable-loading').hide();");
			sb.append("subDlgIndex.close();");
			sb.append("}");

			if (dialog) {
				if(callback!=null&&callback.contains("@Override")){//复写默认callback
					sb.append(callback.replaceAll("@Override", "") + "(data);");
				}else{
					sb.append("var win = frameElement.api.opener;");
					//先判断是否成功，成功再刷新父页面，否则return false    
					// 如果不成功，返回值接受使用data.msg. 原有的data.responseText会报null 
					sb.append("if(data.success==true){frameElement.api.close();win.tip(data.msg);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+\"\");$.Hidemsg();}} return false;}");
					//
					if (refresh) {
						sb.append("win.reloadTable();");
					}
					if (StringUtil.isNotEmpty(callback)) {
						sb.append("win."+ callback + "(data);");
					}
				}
				//失败tip不提示
				//sb.append("win.tip(data.msg);");
			} else {
				sb.append("" + callback + "(data);");
			}
			sb.append("}" + "});" + "});" + "</script>");
			sb.append("");
			sb.append("</form>");
			if ("div".equals(layout)) {
				sb.append("</div>");
				if (tabtitle != null) {
					String[] tabtitles = tabtitle.split(",");
					sb.append("<div id=\"navigation\" style=\"display: none;\">");
					sb.append("<ul>");
					for (String string : tabtitles) {
						sb.append("<li>");
						sb.append("<a href=\"#\">" + string + "</a>");
						sb.append("</li>");
					}
					sb.append("</ul>");
					sb.append("</div>");
				}
				sb.append("</div></div>");
			}
			out.print(sb.toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				out.clearBuffer();
				if(sb!=null){
					sb.setLength(0); 
					sb=null;
				}
			} catch (Exception e2) {
			}
		}
		
		//long end = System.currentTimeMillis();
		//logger.debug("==============Form=====doEndTag=================结束时间:" + sdf.format(new Date()) + "==============================");
		//logger.debug("===============Form=====doEndTag=================耗时:" + (end - start) + "ms==============================");
		return EVAL_PAGE;
	}

	/**
	 * 增加显示加载图层
	 * @param sb
	 */
	private void submitLoading(StringBuffer sb) {
		sb.append("subDlgIndex = $.dialog({");
		sb.append("content: '正在加载中'");
		sb.append(",zIndex:19910320");
		sb.append(",lock:true");
		sb.append(",width:100");
		sb.append(",height:50");
		sb.append(",opacity:0.3");
		sb.append(",title:'提示'");
		sb.append(",cache:false");
		sb.append("");
		sb.append("});");
		sb.append("var infoTable = subDlgIndex.DOM.t.parent().parent().parent();");
		sb.append("infoTable.parent().append('<div id=\"infoTable-loading\" style=\"text-align:center;\"><img src=\"plug-in/layer/skin/default/loading-0.gif\"/></div>');");
		sb.append("infoTable.css('display','none');");
	}

	public void setUsePlugin(String usePlugin) {
		this.usePlugin = usePlugin;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	public void setBeforeSubmit(String beforeSubmit) {
		this.beforeSubmit = beforeSubmit;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getTiptype() {
		return tiptype;
	}

	public void setTiptype(String tiptype) {
		this.tiptype = tiptype;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("FormValidationTag [formid=").append(formid)
				.append(", refresh=").append(refresh).append(", callback=")
				.append(callback).append(", beforeSubmit=")
				.append(beforeSubmit).append(", btnsub=").append(btnsub)
				.append(", btnreset=").append(btnreset).append(", layout=")
				.append(layout).append(", usePlugin=").append(usePlugin)
				.append(", dialog=").append(dialog).append(", action=")
				.append(action).append(", tabtitle=").append(tabtitle)
				.append(", tiptype=").append(tiptype).append(", styleClass=")
				.append(styleClass).append(", cssTheme=").append(cssTheme)
				.append(",sysTheme=").append(SysThemesUtil.getSysTheme(ContextHolderUtils.getRequest()).getStyle())
				.append(",brower_type=").append(ContextHolderUtils.getSession().getAttribute("brower_type"))
				.append("]");
		return builder.toString();
	}

	
}
