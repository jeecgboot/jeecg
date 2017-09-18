package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.EhcacheUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.tag.core.JeecgTag;

/**
 * 
 * @author  张代浩
 *
 */
public class FormValidationTag extends JeecgTag {
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
//	update-start--Author:longjb  Date:20150317 for：修改增加css样式类属性
	protected String styleClass ;//table 样式
//	update-start--Author:longjb  Date:20150323 for：修改增加css主题类属性
	protected String cssTheme;//主题样式目录默认为空
	
	public String getCssTheme() {
		return cssTheme;
	}

	public void setCssTheme(String cssTheme) {
		this.cssTheme = cssTheme;
	}
//	update-end--Author:longjb  Date:20150323 for：修改增加css主题类属性
	public String getStyleClass() {
		return styleClass;
	}

	public void setStyleClass(String styleClass) {
		this.styleClass = styleClass;
	}
//	update-end--Author:longjb  Date:20150317 for：修改增加css样式类属性
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
	//add-start--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
	/**
	 * 根据key获取缓存
	 * @param key
	 * @return
	 */
	public StringBuffer getTagCache(String key){
		return (StringBuffer) EhcacheUtil.get(EhcacheUtil.TagCache, key);
	}
	/**
	 * 存放缓存
	 * @param key
	 * @param tagCache
	 */
	public void putTagCache(String key, StringBuffer tagCache){
		EhcacheUtil.put(EhcacheUtil.TagCache, key, tagCache);
	}
	//add-end--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
	
	public int doStartTag() throws JspException {
		JspWriter out = null;
		//update-start--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
		StringBuffer sb = this.getTagCache("doStartTag"+"_"+toString());
		try {
			out = this.pageContext.getOut();
			if(sb != null){
				out.print(sb.toString());
				out.flush();
				return EVAL_PAGE;
			}
		//update-end--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
				sb = new StringBuffer();
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
				sb.append("<div id=\"wrapper\">");
				sb.append("<div id=\"steps\">");
			}
			sb.append("<form id=\"" + formid + "\" " );
//			update-start--Author:longjb  Date:20150317 for：修改增加css样式类属性
			if(this.getStyleClass()!=null){
				sb.append("class=\""+this.getStyleClass()+"\" ");
			}
//			update-end--Author:longjb  Date:20150317 for：修改增加css样式类属性
					sb.append(" action=\"" + action + "\" name=\"" + formid + "\" method=\"post\">");
			if ("btn_sub".equals(btnsub) && dialog)
				sb.append("<input type=\"hidden\" id=\"" + btnsub + "\" class=\"" + btnsub + "\"/>");
			
			//update-start--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
			this.putTagCache("doStartTag"+"_"+toString(), sb);
			//update-end--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
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
		return EVAL_PAGE;
	}

	
	public int doEndTag() throws JspException {
		String lang = (String)((HttpServletRequest) this.pageContext.getRequest()).getSession().getAttribute("lang");
		//update-start--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
		StringBuffer sb = this.getTagCache("doEndTag"+"_"+lang+"_"+toString());
		JspWriter out = null;
		try {
			out = this.pageContext.getOut();
			if(sb != null){
				out.print(sb.toString());
				out.flush();
				return EVAL_PAGE;
			}
		//update-end--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
			SysThemesEnum sysThemesEnum = null;
			if(StringUtil.isEmpty(cssTheme)||"null".equals(cssTheme)){
				sysThemesEnum = SysThemesUtil.getSysTheme((HttpServletRequest) super.pageContext.getRequest());
			}else{
				sysThemesEnum = SysThemesEnum.toEnum(cssTheme);
			}
			sb = new StringBuffer();
			if (layout.equals("div")) {
			//	update-start--Author:longjb  Date:20150323 for：修改增加css主题类属性
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
			
			//	update-end--Author:longjb  Date:20150323 for：修改增加css主题类属性
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/Validform/js/Validform_v5.3.1_min_{0}.js\"></script>", "{0}", lang));
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/Validform/js/Validform_Datatype_{0}.js\"></script>", "{0}", lang));
			sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/Validform/js/datatype_{0}.js\"></script>", "{0}", lang));
			
			if (usePlugin != null) {
				if (usePlugin.indexOf("jqtransform") >= 0) {
					sb.append("<SCRIPT type=\"text/javascript\" src=\"plug-in/Validform/plugin/jqtransform/jquery.jqtransform.js\"></SCRIPT>");
					sb.append("<LINK rel=\"stylesheet\" href=\"plug-in/Validform/plugin/jqtransform/jqtransform.css\" type=\"text/css\"></LINK>");
				}
				if (usePlugin.indexOf("password") >= 0) {
					sb.append("<SCRIPT type=\"text/javascript\" src=\"plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js\"></SCRIPT>");
				}
			}
			//update--begin---author:zhangjiaqiang date:20170223 for:提示弹出框修订
			sb.append("<script src=\"plug-in/layer/layer.js\"></script>");
			//update--begin---author:zhangjiaqiang date:20170223 for:提示弹出框修订
			sb.append("<script type=\"text/javascript\">");
			//update--begin--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
			sb.append("var subDlgIndex = null;");
			//update--end--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
			sb.append("$(function(){");
			sb.append("$(\"#" + formid + "\").Validform({");
			if(this.getTiptype()!=null && !"".equals(this.getTiptype())){	
				//update--begin---author:zhangjiaqiang date:20170223 for:提示弹出框修订
				if(tiptype.equals("1")){
					sb.append("tiptype:function(msg,o,cssctl){");
					sb.append("if(o.type == 3){");
					sb.append("layer.open({");
					sb.append("title:'提示信息',");
					//update--begin--author:zhangjiaqiang date:20170320 for:修订提示框去除阴影，显示时间5秒
					sb.append("content:msg,icon:5,shift:6,btn:false,shade:false,time:5000,");
					//update--end--author:zhangjiaqiang date:20170320 for:修订提示框去除阴影，显示时间5秒
					sb.append("cancel:function(index){o.obj.focus();layer.close(index);},");
					//update--begin--author:zhangjiaqiang date:20170509 for:修订IE浏览器下面js异常
					sb.append("yes:function(index){o.obj.focus();layer.close(index);}");
					//update--end--author:zhangjiaqiang date:20170509 for:修订IE浏览器下面js异常
					sb.append("})");
					sb.append("}},");
				}else{
					sb.append("tiptype:"+this.getTiptype()+",");
				}
				//update--end---author:zhangjiaqiang date:20170223 for:提示弹出框修订
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
				sb.append("beforeSubmit:function(curform){var tag=false;");
				//update--begin--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
				submitLoading(sb);
				//update--end--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
				sb.append("return " + beforeSubmit );
				if(beforeSubmit.indexOf("(") < 0){
					sb.append("(curform);");
				}
				sb.append("},");
				//update--begin--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
			}else{
				sb.append("beforeSubmit:function(curform){var tag=false;");
				submitLoading(sb);
				sb.append("},");
			}
			//update--end--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
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
//				 update-start--Author:gaofeng  Date:20140711 for：修改在使用jptransform时的逗号","拼接错误
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
//				update-end--Author:gaofeng  Date:20140711 for：修改在使用jptransform时的逗号","拼接错误
				if (usePlugin.indexOf("jqtransform") >= 0) {
					sb.append(jqsb);
				}
				sb.append("},");
			}
			sb.append("callback:function(data){");
			//update--begin--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
			sb.append("if(subDlgIndex && subDlgIndex != null){");
			sb.append("$('#infoTable-loading').hide();");
			sb.append("subDlgIndex.close();");
			sb.append("}");
			//update--end--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
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
			//update-start--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
			this.putTagCache("doEndTag"+"_"+lang+"_"+toString(), sb);
			//update-end--Author:yugwu  Date:20170828 for:TASK #2258 【优化系统】jeecg的jsp页面，采用标签方式，每次都生成html，很慢----
			out.print(sb.toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				//update-begin--Author:scott  Date:20160530 for：清空降低缓存占用
//				sb.setLength(0);
//				sb = null;
				//update-end--Author:scott  Date:20160530 for：清空降低缓存占用
				out.clearBuffer();
			} catch (Exception e2) {
			}
		}
		return EVAL_PAGE;
	}
	
	//update--begin--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
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
	//update--end--author:zhangjiaqiang Date:20170424 for:修订页面加载数据
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

	//update-start--Author:yugwu  Date:20170830 for:key生成逻辑重新编写----
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
	//update-end--Author:yugwu  Date:20170830 for:key生成逻辑重新编写----
	
}
