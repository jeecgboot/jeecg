package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.enums.MenuButtonsEnum;
import org.jeecgframework.core.online.util.FreemarkerHelper;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.service.SystemService;
/**
 * 
 * @Title:MenuButtonTag
 * @description:新权限JSP标签，通过标签的 “权限标示” 控制代码片段是否加载
 * @version V1.0
 * 【船舶专用】
 * 权限判断 name-code
 * 1.没有配置权限规则 则直接加载
 * 2.配置了但是没有勾选 不加载
 * 3.配置了且勾选了 加载
 */
public class MenuButtonsTag extends TagSupport{
	private static final long serialVersionUID = 1L;
	
	/**控件name-唯一标识*/
	private String name;
	/**
	 * 逗号隔开 配置ALL则加载所有
	 */
	private String codes;
	/**
	 * 是否取反
	 */
	private boolean notIn = false;
	/**
	 * 是否主表菜单mainMenu
	 */
	private boolean mm = false;
	
	private boolean group = false;
	
	private boolean superQuery = false;
	
	private SystemService systemService;
	
	public int doStartTag() throws JspException {
		return super.doStartTag();
	}
	
	public int doEndTag() throws JspTagException {
		JspWriter out = null;
		try {
			out = this.pageContext.getOut();
			out.print(end());
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
	
	private String end(){
		if(oConvertUtils.isEmpty(codes)){
			return "";
		}
		StringBuffer sb = new StringBuffer();
		List<String> optcodes = null;
		boolean flag = false;
		if(ResourceUtil.getSessionUser().getUserName().equals("admin")|| !Globals.BUTTON_AUTHORITY_CHECK){
			flag = true;
		}else{
			optcodes= getOperationcodes();
			if(optcodes==null || optcodes.size()<=0){
				flag = true;
			}
		}
		if(superQuery){
			addAdvancedQuery(sb, codes, name);
		}
		
		if(codes.equals("ALL")){
			//所有菜单均加载
			MenuButtonsEnum[] menuArr = MenuButtonsEnum.values();
			for (int k = menuArr.length;k>0;k--) {
				MenuButtonsEnum menu = menuArr[k-1];
				if(flag){
					initMenu(sb, menu);
				}else{
					if(hasAuth(menu.getCode(), optcodes)){
						initMenu(sb, menu);
					}
				}
			}
		}else{
			if(isNotIn()){
				//加载非
				MenuButtonsEnum[] menuArr = MenuButtonsEnum.values();
				for (int k = menuArr.length;k>0;k--) {
					MenuButtonsEnum menu = menuArr[k-1];
					//TODO 用的是indexOf有隐患
					if(codes.indexOf(menu.getCode())<0){
						if(flag){
							initMenu(sb, menu);
						}else{
							if(hasAuth(menu.getCode(), optcodes)){
								initMenu(sb, menu);
							}
						}
					}
				}
			}else{
				String[] codeArr = codes.split(",");
				for (int i = codeArr.length;i>0;i--) {
					String c = codeArr[i-1];
					MenuButtonsEnum menu = MenuButtonsEnum.getMenuByCode(c);
					if(menu==null){
						continue;
					}
					if(flag){
						initMenu(sb, menu);
					}else{
						if(hasAuth(c , optcodes)){
							initMenu(sb, menu);
						}
					}
				}
			}
		}
		//System.out.println(name+"--"+sb.toString());
		if(this.group){
			loadGroupJs(sb);
		}
		return sb.toString();
		
	}
	/**
	 * 加载单个菜单HTML片段
	 * @param sb
	 * @param menu
	 */
	private void initMenu(StringBuffer sb,MenuButtonsEnum menu){
		if(!"superQuery".equals(menu.getFun())){
			String arg = mm?"1":"";
			if(menu.getCode().contains("group")){
				this.group=true;
				String funs[] = menu.getFun().split("&");
				String titles[] = menu.getTitle().split("&");
				String icons[] = menu.getIcon().split("&");
				sb.append("<div class='awesome-group'>");
				sb.append("<a onclick='"+funs[0]+"("+arg+")' href='####' class='withicon group-btn lefticon "+icons[icons.length-1]+"'></a>");
				//<a onclick='showTabDorpdownMenuty(this)' href='####' class='withicon group-btn righticon fa fa-caret-down'></a>
				sb.append("<ul class='awe-group-dropdown'>");
				for (int i=0;i<funs.length;i++) {
					sb.append("<li><a onclick='"+funs[i]+"("+arg+")' href='####' title='"+titles[i]+"' class='withmenu group-btn "+icons[i]+"'></a></li>");
				}
				sb.append("</ul></div>");
			}else{
				sb.append("<a onclick=\""+menu.getFun()+"("+arg+")\" href=\"####\" class=\"btn-menu "+menu.getIcon()+" menu-more\" title=\""+menu.getTitle()+"\"></a>");
			}
		}
	}

	/**
	 * 加载组和菜单js
	 * @param sb
	 */
	private void loadGroupJs(StringBuffer sb){
		//sb.append("<script>function showTabDorpdownMenuty(obj){$(obj).parent('.awesome-group').addClass('dropdown');}$('.awesome-group .righticon').hover(function(){$(this).parent('.awesome-group').addClass('dropdown');");
		sb.append("<script>$('.awesome-group .lefticon').hover(function(){$(this).parent('.awesome-group').addClass('dropdown');");
		sb.append("},function(){});$('.awesome-group').hover(function(){$(this).addClass('active');},function(){$(this).removeClass('active');$(this).removeClass('dropdown');});</script>");
	}
	/**
	 * 判断该code是否有权限
	 * @param code
	 * @param optcodes
	 * @return
	 */
	public boolean hasAuth(String code,List<String> optcodes) {
		//该request中获取的code list是配置了但未经授权的 所以这里要取反
		return !optcodes.contains(name+"-"+code);
    }
	
	/**
	 * 获取操作按钮的的code
	 * @return
	 */
	private List<String> getOperationcodes(){
		//权限判断
		List<String> list = new ArrayList<String>();
		Set<String> operationCodeIds = (Set<String>) super.pageContext.getRequest().getAttribute(Globals.OPERATIONCODES);
		systemService = ApplicationContextUtil.getContext().getBean(SystemService.class);
		if (null!=operationCodeIds) {
			for (String operationCodeId : operationCodeIds) {
				if (oConvertUtils.isEmpty(operationCodeId))
					continue;
				TSOperation operation = systemService.getEntity(TSOperation.class, operationCodeId);
				if(operation!=null){
					list.add(operation.getOperationcode());
				}
			}
		}
		return list;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the codes
	 */
	public String getCodes() {
		return codes;
	}

	/**
	 * @param codes the codes to set
	 */
	public void setCodes(String codes) {
		this.codes = codes;
	}

	/**
	 * @return the notIn
	 */
	public boolean isNotIn() {
		return notIn;
	}

	/**
	 * @param notIn the notIn to set
	 */
	public void setNotIn(boolean notIn) {
		this.notIn = notIn;
	}

	/**
	 * @return the mm
	 */
	public boolean isMm() {
		return mm;
	}

	/**
	 * @param mm the mm to set
	 */
	public void setMm(boolean mm) {
		this.mm = mm;
	}

	/**
	 * @return the group
	 */
	public boolean isGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(boolean group) {
		this.group = group;
	}
	
	/**
	 * @return the superQuery
	 */
	public boolean isSuperQuery() {
		return superQuery;
	}

	/**
	 * @param superQuery the superQuery to set
	 */
	public void setSuperQuery(boolean superQuery) {
		this.superQuery = superQuery;
	}

	
	/**
	 * 高级查询构造器
	 * @param sb
	 */
	private void addAdvancedQuery(StringBuffer sb,String queryCode,String tableName) {
		MenuButtonsEnum menu = MenuButtonsEnum.getMenuByCode("superQuery");
		sb.append("<a title=\""+menu.getTitle()+"\" onclick=\"superQuery()\" href=\"####\" class=\"btn-menu "+menu.getIcon()+" menu-more\" ></a>");
		//onclick=\"superQuery('"+codes+"','"+tableName+"')\"
		/*FreemarkerHelper free = new FreemarkerHelper();
		Map<String, Object> mainConfig = new HashMap<String, Object>();
		mainConfig.put("queryCode", queryCode);
		mainConfig.put("tableName", tableName);
		String complexSuperQuery = free.parseTemplate("/org/jeecgframework/tag/ftl/complexSuperQueryForPage.ftl", mainConfig);
		appendLine(sb,complexSuperQuery);*/
	}
	private void appendLine(StringBuffer sb,String str) {
		String format = "\r\n"; //调试  格式化
		sb.append(str).append(format);
	}
}
