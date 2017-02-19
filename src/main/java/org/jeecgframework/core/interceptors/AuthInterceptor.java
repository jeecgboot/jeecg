package org.jeecgframework.core.interceptors;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.extend.hqlsearch.SysContextSqlConvert;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.JeecgDataAutorUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.manager.ClientManager;
import org.jeecgframework.web.system.pojo.base.Client;
import org.jeecgframework.web.system.pojo.base.TSDataRule;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;


/**
 * 权限拦截器
 * 
 * @author  张代浩
 * 
 */
public class AuthInterceptor implements HandlerInterceptor {
	 
	private static final Logger logger = Logger.getLogger(AuthInterceptor.class);
	private SystemService systemService;
	private List<String> excludeUrls;
	private static List<TSFunction> functionList;


	public List<String> getExcludeUrls() {
		return excludeUrls;
	}

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	public SystemService getSystemService() {
		return systemService;
	}

	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	/**
	 * 在controller后拦截
	 */
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception exception) throws Exception {
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 在controller前拦截
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		String requestPath = ResourceUtil.getRequestPath(request);// 用户访问的资源地址
		//logger.info("-----authInterceptor----requestPath------"+requestPath);
		HttpSession session = ContextHolderUtils.getSession();
		Client client = ClientManager.getInstance().getClient(session.getId());
		if(client == null){ 
			client = ClientManager.getInstance().getClient(
					request.getParameter("sessionId"));
		}
		if (excludeUrls.contains(requestPath)) {
			//如果该请求不在拦截范围内，直接返回true
			return true;
		} else {
			if (client != null && client.getUser()!=null ) {
				if((!hasMenuAuth(request)) && !client.getUser().getUserName().equals("admin")){
					 response.sendRedirect("loginController.do?noAuth");
					//request.getRequestDispatcher("webpage/common/noAuth.jsp").forward(request, response);
					return false;
				} 
				//String functionId=oConvertUtils.getString(request.getParameter("clickFunctionId"));
				String functionId="";
				//update-begin--Author:JueYue  Date:20140831 for：onlinecodeing 的URL判断--------------------
				//onlinecoding的访问地址有规律可循，数据权限链接篡改
				if(requestPath.equals("cgAutoListController.do?datagrid")) {
					requestPath += "&configId=" +  request.getParameter("configId");
				}
				if(requestPath.equals("cgAutoListController.do?list")) {
					requestPath += "&id=" +  request.getParameter("id");
				}
				if(requestPath.equals("cgFormBuildController.do?ftlForm")) {
					requestPath += "&tableName=" +  request.getParameter("tableName");
				}
	
				//update-begin--Author:许国杰  Date:20151219 for：#813 【online表单】扩展出三个请求：独立的添加、查看、编辑请求，原来的保留
				if(requestPath.equals("cgFormBuildController.do?goAddFtlForm")) {
					requestPath += "&tableName=" +  request.getParameter("tableName");
				}
				if(requestPath.equals("cgFormBuildController.do?goUpdateFtlForm")) {
					requestPath += "&tableName=" +  request.getParameter("tableName");
				}
				if(requestPath.equals("cgFormBuildController.do?goDatilFtlForm")) {
					requestPath += "&tableName=" +  request.getParameter("tableName");
				}
				//update-end--Author:许国杰  Date:20151219 for：#813 【online表单】扩展出三个请求：独立的添加、查看、编辑请求，原来的保留
				
				//update-end--Author:JueYue  Date:20140831 for：onlinecodeing 的URL判断--------------------
				//这个地方用全匹配？应该是模糊查询吧
				//TODO
				//update-begin--Author:张忠亮  Date:20150717 for：解决rest风格下 权限失效问题
				String uri= request.getRequestURI().substring(request.getContextPath().length() + 1);
				String realRequestPath = null;
				if(uri.endsWith(".do")||uri.endsWith(".action")){
					realRequestPath=requestPath;
				}else {
					realRequestPath=uri;
				}
				List<TSFunction> functions = systemService.findByProperty(TSFunction.class, "functionUrl", realRequestPath);
				//update-end--Author:张忠亮  Date:20150717 for：解决rest风格下 权限失效问题
				if (functions.size()>0){
					functionId = functions.get(0).getId();
				}
				
				//Step.1 第一部分处理页面表单和列表的页面控件权限（页面表单字段+页面按钮等控件）
				if(!oConvertUtils.isEmpty(functionId)){
					//获取菜单对应的页面控制权限（包括表单字段和操作按钮）
					Set<String> operationCodes = systemService.getOperationCodesByUserIdAndFunctionId(client.getUser().getId(), functionId);
					request.setAttribute(Globals.OPERATIONCODES, operationCodes);
				}
				if(!oConvertUtils.isEmpty(functionId)){
					//update-begin--Author:anchao  Date:20140822 for：[bugfree号]字段级权限（表单，列表）--------------------
					//List<String> allOperation=this.systemService.findListbySql("SELECT operationcode FROM t_s_operation  WHERE functionid='"+functionId+"'"); 
					List<TSOperation> allOperation=this.systemService.findByProperty(TSOperation.class, "TSFunction.id", functionId);
					
					List<TSOperation> newall = new ArrayList<TSOperation>();
					if(allOperation.size()>0){
						for(TSOperation s:allOperation){ 
						    //s=s.replaceAll(" ", "");
							newall.add(s); 
						}
//---author:jg_xugj----start-----date:20151210--------for：#781  【oracle兼容】兼容问题fun.operation!='' 在oracle 数据下不正确
						String hasOperSql="SELECT operation FROM t_s_role_function fun, t_s_role_user role WHERE  " +
							"fun.functionid='"+functionId+"' AND fun.operation is not null  AND fun.roleid=role.roleid AND role.userid='"+client.getUser().getId()+"' ";
//---author:jg_xugj----end-----date:20151210--------for：#781  【oracle兼容】兼容问题fun.operation!='' 在oracle 数据下不正确
						List<String> hasOperList = this.systemService.findListbySql(hasOperSql); 
					    for(String operationIds:hasOperList){
							    for(String operationId:operationIds.split(",")){
							    	operationId=operationId.replaceAll(" ", "");
							        TSOperation operation =  new TSOperation();
							        operation.setId(operationId);
							    	newall.remove(operation);
							    } 
						} 
					}
					request.setAttribute(Globals.NOAUTO_OPERATIONCODES, newall);
					
					 //Step.2  第二部分处理列表数据级权限
					 //小川 -- 菜单数据规则集合(数据权限)
					 List<TSDataRule> MENU_DATA_AUTHOR_RULES = new ArrayList<TSDataRule>(); 
					 //小川 -- 菜单数据规则sql(数据权限)
					 String MENU_DATA_AUTHOR_RULE_SQL="";

					
				 	//数据权限规则的查询
				 	//查询所有的当前这个用户所对应的角色和菜单的datarule的数据规则id
					Set<String> dataruleCodes = systemService.getOperationCodesByUserIdAndDataId(client.getUser().getId(), functionId);
					request.setAttribute("dataRulecodes", dataruleCodes);
					for (String dataRuleId : dataruleCodes) {
						TSDataRule dataRule = systemService.getEntity(TSDataRule.class, dataRuleId);
						    MENU_DATA_AUTHOR_RULES.add(dataRule);
							MENU_DATA_AUTHOR_RULE_SQL += SysContextSqlConvert.setSqlModel(dataRule);
					
					}
					 JeecgDataAutorUtils.installDataSearchConditon(request, MENU_DATA_AUTHOR_RULES);//菜单数据规则集合
					 JeecgDataAutorUtils.installDataSearchConditon(request, MENU_DATA_AUTHOR_RULE_SQL);//菜单数据规则sql

				}
				return true;
			} else {
				//forword(request);
				forward(request, response);
				return false;
			}

		}
	}
	
	/**
	 * 判断用户是否有菜单访问权限
	 * @param request
	 * @return
	 */
	private boolean hasMenuAuth(HttpServletRequest request){
		String requestPath = ResourceUtil.getRequestPath(request);// 用户访问的资源地址
		// 是否是功能表中管理的url
		boolean bMgrUrl = false;
		if (functionList == null) {
//			functionList = systemService.loadAll(TSFunction.class);
//          update-start--Author:zhoujf  Date:20150521 for：只查询菜单类型的权限
			functionList = systemService.findHql("from TSFunction where functionType = ? ", (short)0);
//          update---end--Author:zhoujf  Date:20150521 for：只查询菜单类型的权限
		}
		for (TSFunction function : functionList) {
			if (function.getFunctionUrl() != null && function.getFunctionUrl().startsWith(requestPath)) {
				bMgrUrl = true;
				break;
			}
		}
		if (!bMgrUrl) {
			return true;
		}
		 
		String funcid=oConvertUtils.getString(request.getParameter("clickFunctionId"));
		if(!bMgrUrl && (requestPath.indexOf("loginController.do")!=-1||funcid.length()==0)){
			return true;
		} 
		TSUser currLoginUser = ClientManager.getInstance().getClient(ContextHolderUtils.getSession().getId()).getUser();
        String userid = currLoginUser.getId();
		//requestPath=requestPath.substring(0, requestPath.indexOf("?")+1);
		String sql = "SELECT DISTINCT f.id FROM t_s_function f,t_s_role_function  rf,t_s_role_user ru " +
					" WHERE f.id=rf.functionid AND rf.roleid=ru.roleid AND " +
					"ru.userid='"+userid+"' AND f.functionurl like '"+requestPath+"%'";
		List list = this.systemService.findListbySql(sql);
		if(list.size()==0){
//            update-start--Author:zhangguoming  Date:20140821 for：判断当前用户组织机构下角色所拥有的权限
//            update-start--Author:zhangguoming  Date:20140825 for：获取当前用户登录时选择的组织机构代码
            String orgId = currLoginUser.getCurrentDepart().getId();
//            update-end--Author:zhangguoming  Date:20140825 for：获取当前用户登录时选择的组织机构代码
            String functionOfOrgSql = "SELECT DISTINCT f.id from t_s_function f, t_s_role_function rf, t_s_role_org ro  " +
                    "WHERE f.ID=rf.functionid AND rf.roleid=ro.role_id " +
                    "AND ro.org_id='" +orgId+ "' AND f.functionurl like '"+requestPath+"%'";
            List functionOfOrgList = this.systemService.findListbySql(functionOfOrgSql);
			return functionOfOrgList.size() > 0;
//            update-end--Author:zhangguoming  Date:20140821 for：判断当前用户组织机构下角色所拥有的权限
        }else{
			return true;
		}
	}
	/**
	 * 转发
	 * 
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "forword")
	public ModelAndView forword(HttpServletRequest request) {
		return new ModelAndView(new RedirectView("loginController.do?login"));
	}

	private void forward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//update-start--Author:scott  Date:20160803 for：无登陆情况跳转登陆页
		//超时，未登陆页面跳转
		//response.sendRedirect(request.getServletContext().getContextPath()+"/loginController.do?login");
//      update-start--Author:chenjin  Date:20160828 for：TASK #1324 【bug】Session超时后，重新登录页面显示在标签里,让它重新显示登录页面
		response.sendRedirect(request.getSession().getServletContext().getContextPath()+"/webpage/login/timeout.jsp");
//      update-end--Author:chenjin  Date:20160828 for：TASK #1324 【bug】Session超时后，重新登录页面显示在标签里,让它重新显示登录页面
		//request.getRequestDispatcher("loginController.do?login").forward(request, response);
		//update-start--Author:scott  Date:20160803 for：无登陆情况跳转登陆页
	}

}
