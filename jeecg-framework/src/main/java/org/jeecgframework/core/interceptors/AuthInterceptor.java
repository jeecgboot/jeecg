package org.jeecgframework.core.interceptors;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jeecgframework.web.system.manager.ClientManager;
import org.jeecgframework.web.system.pojo.base.Client;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
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
		HttpSession session = ContextHolderUtils.getSession();
		Client client = ClientManager.getInstance().getClient(session.getId());
		if(client == null){ 
			client = ClientManager.getInstance().getClient(
					request.getParameter("sessionId"));
		}
		if (excludeUrls.contains(requestPath)) {
			return true;
		} else {
			if (client != null && client.getUser()!=null ) {
				 if(!hasMenuAuth(request)){
					 response.sendRedirect("loginController.do?noAuth");
					//request.getRequestDispatcher("webpage/common/noAuth.jsp").forward(request, response);
					return false;
				} 
				String functionId=oConvertUtils.getString(request.getParameter("clickFunctionId"));
				if(!oConvertUtils.isEmpty(functionId)){
					Set<String> operationCodes = systemService.getOperationCodesByUserIdAndFunctionId(client.getUser().getId(), functionId);
					request.setAttribute("operationCodes", operationCodes);
				 
				}
				if(!oConvertUtils.isEmpty(functionId)){
					List<String> allOperation=this.systemService.findListbySql("SELECT operationcode FROM t_s_operation  WHERE functionid='"+functionId+"'"); 
					  
					List<String> newall = new ArrayList<String>();
					if(allOperation.size()>0){
						for(String s:allOperation){ 
						    s=s.replaceAll(" ", "");
							newall.add(s); 
						}						 
						String hasOperSql="SELECT operation FROM t_s_role_function fun, t_s_role_user role WHERE  " +
							"fun.functionid='"+functionId+"' AND fun.operation!=''  AND fun.roleid=role.roleid AND role.userid='"+client.getUser().getId()+"' ";
						List<String> hasOperList = this.systemService.findListbySql(hasOperSql); 
					    for(String strs:hasOperList){
							    for(String s:strs.split(",")){
							        s=s.replaceAll(" ", "");
							    	newall.remove(s);
							    } 
						} 
					}
					 request.setAttribute("noauto_operationCodes", newall);
				}
				return true;
			} else {
				//forword(request);
				forward(request, response);
				return false;
			}

		}
	}
	private boolean hasMenuAuth(HttpServletRequest request){
		String requestPath = ResourceUtil.getRequestPath(request);// 用户访问的资源地址
		String funcid=oConvertUtils.getString(request.getParameter("clickFunctionId"));
		 
		if(requestPath.indexOf("loginController.do")!=-1||funcid.length()==0){
			return true;
		} 
		String userid = ClientManager.getInstance().getClient(
				ContextHolderUtils.getSession().getId()).getUser().getId();
		//requestPath=requestPath.substring(0, requestPath.indexOf("?")+1);
		String sql = "SELECT DISTINCT f.id FROM t_s_function f,t_s_role_function  rf,t_s_role_user ru " +
					" WHERE f.id=rf.functionid AND rf.roleid=ru.roleid AND " +
					"ru.userid='"+userid+"' AND f.functionurl like '"+requestPath+"%'"; 
		List list = this.systemService.findListbySql(sql);
		if(list.size()==0){
			return false;
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
		request.getRequestDispatcher("webpage/login/timeout.jsp").forward(request, response);
	}

}
