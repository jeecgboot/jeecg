package org.jeecgframework.web.system.controller.core;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.JSONHelper;
import org.jeecgframework.core.util.ListtoMenu;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.NumberComparator;
import org.jeecgframework.core.util.PasswordUtil;
import org.jeecgframework.core.util.PropertiesUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.manager.ClientManager;
import org.jeecgframework.web.system.pojo.base.Client;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSPasswordResetkey;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.jeecgframework.web.system.pojo.base.TSRoleFunction;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;
import org.jeecgframework.web.system.sms.util.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.baomidou.kisso.SSOHelper;
import com.baomidou.kisso.SSOToken;
import com.baomidou.kisso.common.util.HttpUtil;



/**
 * 登陆初始化控制器
 * @author 张代浩
 * 
 */
//@Scope("prototype")
@Controller
@RequestMapping("/loginController")
public class LoginController extends BaseController{
	private Logger log = Logger.getLogger(LoginController.class);
	private SystemService systemService;
	private UserService userService;

	@Autowired
	private MutiLangServiceI mutiLangService;
	
	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	@Autowired
	public void setUserService(UserService userService) {

		this.userService = userService;
	}

	/**
	 * 跳转到密码重置界面
	 * @param key
	 * @return
	 */
	@RequestMapping(params = "goResetPwd")
	public ModelAndView goResetPwd(String key){
		return new ModelAndView("login/resetPwd")
				.addObject("key", key);
	}
	
	/**
	 * 密码重置
	 * @param key
	 * @param password
	 * @return
	 */
	@RequestMapping(params = "resetPwd")
	@ResponseBody
	public AjaxJson resetPwd(String key,String password){
		AjaxJson ajaxJson = new AjaxJson();
		TSPasswordResetkey passwordResetkey = systemService.get(TSPasswordResetkey.class, key);
		Date now = new Date();
		if(passwordResetkey != null && passwordResetkey.getIsReset() != 1 && (now.getTime() - passwordResetkey.getCreateDate().getTime()) < 1000*60*60*3){
			TSUser user = systemService.findUniqueByProperty(TSUser.class, "userName", passwordResetkey.getUsername());
			user.setPassword(PasswordUtil.encrypt(user.getUserName(), password, PasswordUtil.getStaticSalt()));
			systemService.updateEntitie(user);
			passwordResetkey.setIsReset(1);
			systemService.updateEntitie(passwordResetkey);
			ajaxJson.setMsg("密码重置成功");
		}else{
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("无效重置密码KEY");
		}
		
		return ajaxJson;
	}
	
	/**
	 * 跳转到密码重置填写邮箱界面
	 * @return
	 */
	@RequestMapping(params="goResetPwdMail")
	public ModelAndView goResetPwdMail(){
		return new ModelAndView("login/goResetPwdMail");
	}
	
	/**
	 * 发送重置密码邮件
	 * @return
	 */
	@RequestMapping(params="sendResetPwdMail")
	@ResponseBody
	public AjaxJson sendResetPwdMail(String email,HttpServletRequest request){
		AjaxJson ajaxJson = new AjaxJson();
		try {
			
			if(StringUtils.isEmpty(email)){
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("邮件地址不能为空");
				return ajaxJson;
			}
			TSUser user = systemService.findUniqueByProperty(TSUser.class, "email", email);
			if(user == null){
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户名对应的用户信息不存在");
				return ajaxJson;
			}
			
			//保存重置密码数据信息
			String hql = "from TSPasswordResetkey bean where bean.username = '" + user.getUserName() + "' and bean.isReset = 0 order by bean.createDate desc limit 1";
			List<TSPasswordResetkey> resetKeyList = systemService.findHql(hql);
			if(resetKeyList != null && !resetKeyList.isEmpty()){
				TSPasswordResetkey resetKey = resetKeyList.get(0);
				Date now = new Date();
				if(resetKey.getEmail().equals(email) && (now.getTime() - resetKey.getCreateDate().getTime()) < (1000*60*60*3 - 1000*60*5)){
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("已发送重置密码邮件，请稍候再次尝试发送");
					return ajaxJson;
					
				}
			}
			
			TSPasswordResetkey passwordResetKey = new TSPasswordResetkey();
			passwordResetKey.setEmail(email);
			passwordResetKey.setUsername(user.getUserName());
			passwordResetKey.setCreateDate(new Date());
			passwordResetKey.setIsReset(0);
			userService.save(passwordResetKey);
			
			
			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
			StringBuffer contentBuffer = new StringBuffer();
			contentBuffer.append("<div id=\"contentDiv\" onmouseover=\"getTop().stopPropagation(event);\" onclick=\"getTop().preSwapLink(event, 'spam', 'ZC4218-CzCkK82QMqgXIghRxZ93S79');\"");
			contentBuffer.append("style=\"position:relative;font-size:14px;height:auto;padding:15px 15px 10px 15px;z-index:1;zoom:1;line-height:1.7;\" class=\"body\">");
			contentBuffer.append("<div id=\"qm_con_body\"><div id=\"mailContentContainer\" class=\"qmbox qm_con_body_content qqmail_webmail_only\" style=\"\">");
			contentBuffer.append("<table style=\"margin: 25px auto;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"648\" align=\"center\">");
			String title = util.readProperty("resetpwd.mail.title");
			contentBuffer.append("<tbody><tr><td style=\"color:#40AA53;\"><h1 style=\"margin-bottom:10px;\">"+title +"</h1></td></tr>");
			contentBuffer.append("<tr><td style=\"border-left: 1px solid #D1FFD1; padding: 20px 20px 0px; background: none repeat scroll 0% 0% #ffffff; border-top: 5px solid #40AA53; border-right: 1px solid #D1FFD1;\">");
			contentBuffer.append("<p>你好 </p></td></tr>");
			contentBuffer.append("<tr><td style=\"border-left: 1px solid #D1FFD1; padding: 0px 45px 0px; background: none repeat scroll 0% 0% #ffffff; border-right: 1px solid #D1FFD1;\">");
			String content = util.readProperty("resetpwd.mail.content");
			if(content.indexOf("${username}") > -1){
				content = content.replace("${username}", user.getUserName());
			}
			contentBuffer.append("<p>"+content+"</p></td></tr>");
			contentBuffer.append("<tr><td style=\"border-left: 1px solid #D1FFD1; padding: 10px 20px; background: none repeat scroll 0% 0% #ffffff; border-right: 1px solid #D1FFD1;\">");
			contentBuffer.append("<p style=\"font-weight:bold\">请点击下面链接进行密码重置：<br><br>");
			String url = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath() +"/loginController.do?goResetPwd&key=" + passwordResetKey.getId();
			contentBuffer.append("<a href=\"" + url + "\" target=\"_blank\">");
			contentBuffer.append(url);
			contentBuffer.append("</a></p></td></tr>");
			contentBuffer.append("<tr><td style=\"border-bottom: 1px solid #D1FFD1; border-left: 1px solid #D1FFD1; padding: 0px 20px 20px; background: none repeat scroll 0% 0% #ffffff; border-right: 1px solid #D1FFD1;\">");
			contentBuffer.append("<hr style=\"color:#ccc;\">");
			String commentUrl = "http://www.jeecg.org";
			contentBuffer.append("<p style=\"color:#060;font-size:9pt;\">想了解更多信息，请访问 <a href=\""+commentUrl+"\" target=\"_blank\">"+commentUrl+"</a></p>");
			contentBuffer.append("</td></tr></tbody></table>");
			contentBuffer.append("<br><br><div style=\"width:1px;height:0px;overflow:hidden\"><img style=\"width:0;height:0\" src=\"javascript:;\"></div>");
			contentBuffer.append("<style type=\"text/css\">.qmbox style, .qmbox script, .qmbox head, .qmbox link, .qmbox meta {display: none !important;}</style></div></div><!-- --><style>#mailContentContainer .txt {height:auto;}</style> ");
			MailUtil.sendEmail(util.readProperty("mail.smtpHost"), email,"邮箱重置密码", 
					contentBuffer.toString(), util.readProperty("mail.sender"), 
					util.readProperty("mail.user"), util.readProperty("mail.pwd"));
			ajaxJson.setMsg("成功发送密码重置邮件");

			
		} catch (Exception e) {
			if("javax.mail.AuthenticationFailedException".equals(e.getClass().getName())){
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发送邮件失败：邮箱账号信息设置错误" );
				log.error("重置密码发送邮件失败：邮箱账号信息设置错误",e);
			}else{
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发送邮件失败：" + e.getMessage());
				log.error("发送邮件失败：" + e.getMessage(),e);
			}
				
		}
		return ajaxJson;
	}

	@RequestMapping(params = "goPwdInit")
	public String goPwdInit() {
		return "login/pwd_init";
	}


	/**
	 * 检查用户名称
	 * 
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "checkuser")
	@ResponseBody
	public AjaxJson checkuser(TSUser user, HttpServletRequest req) {
		HttpSession session = req.getSession();
		AjaxJson j = new AjaxJson();
		//语言选择
		if (req.getParameter("langCode")!=null) {
			req.getSession().setAttribute("lang", req.getParameter("langCode"));
		}

		//单点登录（返回链接）
		String returnURL = req.getParameter("ReturnURL");
		if(StringUtils.isNotEmpty(returnURL)){
			req.getSession().setAttribute("ReturnURL", returnURL);
		}

		
		//验证码
		String randCode = req.getParameter("randCode");
		if (StringUtils.isEmpty(randCode)) {
			j.setMsg(mutiLangService.getLang("common.enter.verifycode"));
			j.setSuccess(false);
		} else if (!randCode.equalsIgnoreCase(String.valueOf(session.getAttribute("randCode")))) {
			j.setMsg(mutiLangService.getLang("common.verifycode.error"));
			j.setSuccess(false);
		} else if (isInBlackList(IpUtil.getIpAddr(req))){
			j.setMsg(mutiLangService.getLang("common.blacklist.error"));
			j.setSuccess(false);
		}
		else {
			//用户登录验证逻辑
			TSUser u = userService.checkUserExits(user);
			if (u == null) {
				u = userService.findUniqueByProperty(TSUser.class, "email", user.getUserName());
				if(u == null || u.getPassword().equals(PasswordUtil.encrypt(u.getUserName(), u.getPassword(), PasswordUtil.getStaticSalt()))){
					j.setMsg(mutiLangService.getLang("common.username.or.password.error"));
					j.setSuccess(false);
					return j;
				}
			}
			if (u != null && u.getStatus() != 0) {
				// 处理用户有多个组织机构的情况，以弹出框的形式让用户选择
				Map<String, Object> attrMap = new HashMap<String, Object>();
				j.setAttributes(attrMap);

				String orgId = req.getParameter("orgId");
				if (oConvertUtils.isEmpty(orgId)) {
					// 没有传组织机构参数，则获取当前用户的组织机构
					Long orgNum = systemService.getCountForJdbc("select count(1) from t_s_user_org where user_id = '" + u.getId() + "'");
					if (orgNum > 1) {
						attrMap.put("orgNum", orgNum);
						attrMap.put("user", u);
					} else {
						Map<String, Object> userOrgMap = systemService.findOneForJdbc("select org_id as orgId from t_s_user_org where user_id=?", u.getId());
						saveLoginSuccessInfo(req, u, (String) userOrgMap.get("orgId"));
					}
				} else {
					attrMap.put("orgNum", 1);
					saveLoginSuccessInfo(req, u, orgId);
				}
			} else {

				j.setMsg(mutiLangService.getLang("common.lock.user"));

				j.setSuccess(false);
			}
		}
		return j;
	}
	private boolean isInBlackList(String ip){
		Long orgNum =systemService.getCountForJdbc("select count(*) from t_s_black_list where ip =  '" + ip + "'");
		return orgNum!=0?true:false;
	}
	/**
	 * 变更在线用户组织
	 * 
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "changeDefaultOrg")
	@ResponseBody
	public AjaxJson changeDefaultOrg(TSUser user, HttpServletRequest req) {
		AjaxJson j = new AjaxJson();
		Map<String, Object> attrMap = new HashMap<String, Object>();
		String orgId = req.getParameter("orgId");
		TSUser u = userService.checkUserExits(user);
		if(u == null){
			u = userService.findUniqueByProperty(TSUser.class, "email", user.getUserName());
		}
		if (oConvertUtils.isNotEmpty(orgId)) {
			attrMap.put("orgNum", 1);
			saveLoginSuccessInfo(req, u, orgId);
		}
		return j;
	}

    /**
     * 保存用户登录的信息，并将当前登录用户的组织机构赋值到用户实体中；
     * @param req request
     * @param user 当前登录用户
     * @param orgId 组织主键
     */
    private void saveLoginSuccessInfo(HttpServletRequest req, TSUser user, String orgId) {
    	String message = null;
        TSDepart currentDepart = systemService.get(TSDepart.class, orgId);
        user.setCurrentDepart(currentDepart);

        HttpSession session = ContextHolderUtils.getSession();

		user.setDepartid(orgId);

		session.setAttribute(ResourceUtil.LOCAL_CLINET_USER, user);
        message = mutiLangService.getLang("common.user") + ": " + user.getUserName() + "["+ currentDepart.getDepartname() + "]" + mutiLangService.getLang("common.login.success");

        String browserType = "";
        Cookie[] cookies = req.getCookies();
        for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if("BROWSER_TYPE".equals(cookie.getName())){
				browserType = cookie.getValue();
			}
		}
        session.setAttribute("brower_type", browserType);

        //当前session为空 或者 当前session的用户信息与刚输入的用户信息一致时，则更新Client信息
        Client clientOld = ClientManager.getInstance().getClient(session.getId());
		if(clientOld == null || clientOld.getUser() ==null ||user.getUserName().equals(clientOld.getUser().getUserName())){
			Client client = new Client();
	        client.setIp(IpUtil.getIpAddr(req));
	        client.setLogindatetime(new Date());
	        client.setUser(user);
	        ClientManager.getInstance().addClinet(session.getId(), client);
		} else {//如果不一致，则注销session并通过session=req.getSession(true)初始化session
			ClientManager.getInstance().removeClinet(session.getId());
			session.invalidate();
			session = req.getSession(true);//session初始化
			session.setAttribute(ResourceUtil.LOCAL_CLINET_USER, user);
			session.setAttribute("randCode",req.getParameter("randCode"));//保存验证码
			checkuser(user,req);
		}

        
        
        // 添加登陆日志
        systemService.addLog(message, Globals.Log_Type_LOGIN, Globals.Log_Leavel_INFO);
    }


    /**
	 * 用户登录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "login")
	public String login(ModelMap modelMap,HttpServletRequest request,HttpServletResponse response) {
		TSUser user = ResourceUtil.getSessionUser();
		String roles = "";
		if (user != null) {
			List<TSRoleUser> rUsers = systemService.findByProperty(TSRoleUser.class, "TSUser.id", user.getId());
			for (TSRoleUser ru : rUsers) {
				TSRole role = ru.getTSRole();
				roles += role.getRoleName() + ",";
			}
			if (roles.length() > 0) {
				roles = roles.substring(0, roles.length() - 1);
			}
			
            modelMap.put("roleName", roles.length()>3?roles.substring(0,3)+"...":roles);
            modelMap.put("userName", user.getUserName().length()>5?user.getUserName().substring(0, 5)+"...":user.getUserName());
            modelMap.put("portrait", user.getPortrait());

            modelMap.put("currentOrgName", ClientManager.getInstance().getClient().getUser().getCurrentDepart().getDepartname());

			
			SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
			if("fineui".equals(sysTheme.getStyle())|| "ace".equals(sysTheme.getStyle())||"diy".equals(sysTheme.getStyle())||"acele".equals(sysTheme.getStyle())||"hplus".equals(sysTheme.getStyle())){
				request.setAttribute("menuMap", getFunctionMap(user));
			}

			Cookie cookie = new Cookie("JEECGINDEXSTYLE", sysTheme.getStyle());
			//设置cookie有效期为一个月
			cookie.setMaxAge(3600*24*30);
			response.addCookie(cookie);

			Cookie zIndexCookie = new Cookie("ZINDEXNUMBER", "1990");
			zIndexCookie.setMaxAge(3600*24);//一天
			response.addCookie(zIndexCookie);

			/*
			 * 单点登录 - 登录需要跳转登录前页面，自己处理 ReturnURL 使用 
			 * HttpUtil.decodeURL(xx) 解码后重定向
			 */
			String returnURL = (String)request.getSession().getAttribute("ReturnURL");
			log.info("login 资源路径returnURL："+returnURL);
			if(StringUtils.isNotEmpty(returnURL)){
				SSOToken st = new SSOToken(request);
				st.setId(UUID.randomUUID().getMostSignificantBits());
				st.setUid(user.getUserName());
				st.setType(1);
				//request.setAttribute(SSOConfig.SSO_COOKIE_MAXAGE, maxAge);
				// 可以动态设置 Cookie maxAge 超时时间 ，优先于配置文件的设置，无该参数 - 默认读取配置文件数据 。
				//  maxAge 定义：-1 浏览器关闭时自动删除 0 立即删除 120 表示Cookie有效期2分钟(以秒为单位)
//				request.setAttribute(SSOConfig.SSO_COOKIE_MAXAGE, 60);
				SSOHelper.setSSOCookie(request, response, st, true);
				returnURL = HttpUtil.decodeURL(returnURL);
				log.info("login 资源路径returnURL："+returnURL);
				request.getSession().removeAttribute("ReturnURL");
				try {
					response.sendRedirect(returnURL);
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}

			return sysTheme.getIndexPath();
		} else {

			//单点登录 - 返回链接
			String returnURL = (String)request.getSession().getAttribute("ReturnURL");
			if(StringUtils.isNotEmpty(returnURL)){
				request.setAttribute("ReturnURL", returnURL);
			}

			return "login/login";
		}

	}

	/**
	 * 退出系统
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "logout")
	public ModelAndView logout(HttpServletRequest request) {
		HttpSession session = ContextHolderUtils.getSession();
		TSUser user = ResourceUtil.getSessionUser();

		try {
			systemService.addLog("用户" + user!=null?user.getUserName():"" + "已退出",Globals.Log_Type_EXIT, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			LogUtil.error(e.toString());
		}

		ClientManager.getInstance().removeClinet(session.getId());
		session.invalidate();
		ModelAndView modelAndView = new ModelAndView(new RedirectView("loginController.do?login"));
		return modelAndView;
	}

	/**
	 * 菜单跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "left")
	public ModelAndView left(HttpServletRequest request) {
		TSUser user = ResourceUtil.getSessionUser();
		HttpSession session = ContextHolderUtils.getSession();
        ModelAndView modelAndView = new ModelAndView();
		// 登陆者的权限
		if (user.getId() == null) {
			session.removeAttribute(Globals.USER_SESSION);
            modelAndView.setView(new RedirectView("loginController.do?login"));
		}else{
            modelAndView.setViewName("main/left");
            request.setAttribute("menuMap", getFunctionMap(user));
        }
		return modelAndView;
	}

	/**
	 * 获取权限的map
	 * 
	 * @param user
	 * @return
	 */
	private Map<Integer, List<TSFunction>> getFunctionMap(TSUser user) {
		HttpSession session = ContextHolderUtils.getSession();
		Client client = ClientManager.getInstance().getClient(session.getId());
		if (client.getFunctionMap() == null || client.getFunctionMap().size() == 0) {
			Map<Integer, List<TSFunction>> functionMap = new HashMap<Integer, List<TSFunction>>();
			Map<String, TSFunction> loginActionlist = getUserFunction(user);
			if (loginActionlist.size() > 0) {
				Collection<TSFunction> allFunctions = loginActionlist.values();
				for (TSFunction function : allFunctions) {
		            if(function.getFunctionType().intValue()==Globals.Function_TYPE_FROM.intValue()){
						//如果为表单或者弹出 不显示在系统菜单里面
						continue;
					}
					if (!functionMap.containsKey(function.getFunctionLevel() + 0)) {
						functionMap.put(function.getFunctionLevel() + 0,
								new ArrayList<TSFunction>());
					}
					functionMap.get(function.getFunctionLevel() + 0).add(function);
				}
				// 菜单栏排序
				Collection<List<TSFunction>> c = functionMap.values();
				for (List<TSFunction> list : c) {

					for (TSFunction function : list) {
						//如果有子级菜单 则地址设为空
						if(function.hasSubFunction(functionMap))function.setFunctionUrl("");
					}

					Collections.sort(list, new NumberComparator());
				}
			}
			client.setFunctionMap(functionMap);

			//清空变量，降低内存使用
			loginActionlist.clear();

			return functionMap;
		}else{
			return client.getFunctionMap();
		}
	}

	/**
	 * 首页菜单搜索框自动补全
	 */
	@RequestMapping(params = "getAutocomplete",method ={RequestMethod.GET, RequestMethod.POST})
	public void getAutocomplete(HttpServletRequest request, HttpServletResponse response) {
		String searchVal = request.getParameter("q");
		//获取到session中的菜单列表
		HttpSession session = ContextHolderUtils.getSession();
		Client client = ClientManager.getInstance().getClient(session.getId());
		//获取到的是一个map集合
		Map<Integer, List<TSFunction>> map=client.getFunctionMap();
		//声明list用来存储菜单
		List<TSFunction>autoList = new ArrayList<TSFunction>();
		//循环map集合取到菜单
		for(int t=0;t<map.size();t++){
			//根据map键取到菜单的TSFuction 用List接收
			List<TSFunction> list = map.get(t);
			//循环List取到TSFuction中的functionname
			for(int i =0;i<list.size();i++){
				//由于functionname中的一些参数没有被国际化，所以还是字母，需要MutiLangUtil中的getLang()方法来
				String name=MutiLangUtil.getLang(list.get(i).getFunctionName());
				if(name.indexOf(searchVal)!= -1 ){
					TSFunction  ts =new TSFunction();
					ts.setFunctionName(MutiLangUtil.getLang(list.get(i).getFunctionName()));
					autoList.add(ts);
				}
			}
		}		
		try {
			response.setContentType("application/json;charset=UTF-8");
			response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.getWriter().write(JSONHelper.listtojson(new String[]{"functionName"},1,autoList));
            response.getWriter().flush();
		} catch (Exception e1) {
			e1.printStackTrace();
		}finally{
			try {
				response.getWriter().close();
			} catch (IOException e) {
			}
		}
	}
	/**
	 * 获取请求路径
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "getUrlpage")
	@ResponseBody
	public String getUrlpage(HttpServletRequest request,HttpServletResponse response) {
		String urlname = request.getParameter("urlname");
		HttpSession session = ContextHolderUtils.getSession();
		Client client = ClientManager.getInstance().getClient(session.getId());
		Map<Integer, List<TSFunction>> map=client.getFunctionMap();
		List<TSFunction>autoList = new ArrayList<TSFunction>();
		for(int t=0;t<map.size();t++){
			List<TSFunction> list = map.get(t);
			for(int i =0;i<list.size();i++){
				String funname=MutiLangUtil.getLang(list.get(i).getFunctionName());
				if(urlname.equals(funname)){
					TSFunction ts =new TSFunction();
					ts.setFunctionUrl(list.get(i).getFunctionUrl());
					autoList.add(ts);
				}
			}
		}
		if(autoList.size()==0){
			return null;
		}else{
			String name =autoList.get(0).getFunctionUrl();
			return name;
		}
		
	}

	
	/**
	 * 获取用户菜单列表
	 * 
	 * @param user
	 * @return
	 */
	private Map<String, TSFunction> getUserFunction(TSUser user) {
		HttpSession session = ContextHolderUtils.getSession();
		Client client = ClientManager.getInstance().getClient(session.getId());

		if (client.getFunctions() == null || client.getFunctions().size() == 0) {

			Map<String, TSFunction> loginActionlist = new HashMap<String, TSFunction>();

			 /*String hql="from TSFunction t where t.id in  (select d.TSFunction.id from TSRoleFunction d where d.TSRole.id in(select t.TSRole.id from TSRoleUser t where t.TSUser.id ='"+
	           user.getId()+"' ))";
	           String hql2="from TSFunction t where t.id in  ( select b.tsRole.id from TSRoleOrg b where b.tsDepart.id in(select a.tsDepart.id from TSUserOrg a where a.tsUser.id='"+
	           user.getId()+"'))";
	           List<TSFunction> list = systemService.findHql(hql);
	           log.info("role functions:  "+list.size());
	           for(TSFunction function:list){
	              loginActionlist.put(function.getId(),function);
	           }
	           List<TSFunction> list2 = systemService.findHql(hql2);
	           log.info("org functions: "+list2.size());
	           for(TSFunction function:list2){
	              loginActionlist.put(function.getId(),function);
	           }*/

	           StringBuilder hqlsb1=new StringBuilder("select distinct f from TSFunction f,TSRoleFunction rf,TSRoleUser ru  ").append("where ru.TSRole.id=rf.TSRole.id and rf.TSFunction.id=f.id and ru.TSUser.id=? ");

	           StringBuilder hqlsb2=new StringBuilder("select distinct c from TSFunction c,TSRoleFunction rf,TSRoleOrg b,TSUserOrg a ")
	           							.append("where a.tsDepart.id=b.tsDepart.id and b.tsRole.id=rf.TSRole.id and rf.TSFunction.id=c.id and a.tsUser.id=?");
	           //TODO hql执行效率慢 为耗时最多地方

	           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	           log.info("================================开始时间:"+sdf.format(new Date())+"==============================");
	           long start = System.currentTimeMillis();
	           List<TSFunction> list1 = systemService.findHql(hqlsb1.toString(),user.getId());
	           List<TSFunction> list2 = systemService.findHql(hqlsb2.toString(),user.getId());
	           long end = System.currentTimeMillis();
	           log.info("================================结束时间:"+sdf.format(new Date())+"==============================");
	           log.info("================================耗时:"+(end-start)+"ms==============================");
	           for(TSFunction function:list1){
		              loginActionlist.put(function.getId(),function);
		       }
	           for(TSFunction function:list2){
		              loginActionlist.put(function.getId(),function);
		       }
            client.setFunctions(loginActionlist);

            //清空变量，降低内存使用
            list2.clear();
            list1.clear();

		}
		return client.getFunctions();
	}

    /**
     * 根据 角色实体 组装 用户权限列表
     * @param loginActionlist 登录用户的权限列表
     * @param role 角色实体
     * @deprecated
     */
    private void assembleFunctionsByRole(Map<String, TSFunction> loginActionlist, TSRole role) {
        List<TSRoleFunction> roleFunctionList = systemService.findByProperty(TSRoleFunction.class, "TSRole.id", role.getId());
        for (TSRoleFunction roleFunction : roleFunctionList) {
            TSFunction function = roleFunction.getTSFunction();
            if(function.getFunctionType().intValue()==Globals.Function_TYPE_FROM.intValue()){
				//如果为表单或者弹出 不显示在系统菜单里面
				continue;
			}
            loginActionlist.put(function.getId(), function);
        }
    }


    /**
	 * 首页跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "home")
	public ModelAndView home(HttpServletRequest request) {

		SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
		//ACE ACE2 DIY时需要在home.jsp头部引入依赖的js及css文件
		if("ace".equals(sysTheme.getStyle())||"diy".equals(sysTheme.getStyle())||"acele".equals(sysTheme.getStyle())){
			request.setAttribute("show", "1");
		} else {//default及shortcut不需要引入依赖文件，所有需要屏蔽
			request.setAttribute("show", "0");
		}

		return new ModelAndView("main/home");
	}
	
	  /**
	 * ACE首页跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "acehome")
	public ModelAndView acehome(HttpServletRequest request) {

		SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
		//ACE ACE2 DIY时需要在home.jsp头部引入依赖的js及css文件
		if("ace".equals(sysTheme.getStyle())||"diy".equals(sysTheme.getStyle())||"acele".equals(sysTheme.getStyle())){
			request.setAttribute("show", "1");
		} else {//default及shortcut不需要引入依赖文件，所有需要屏蔽
			request.setAttribute("show", "0");
		}

		return new ModelAndView("main/acehome");
	}
	/**
	 * HPLUS首页跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "hplushome")
	public ModelAndView hplushome(HttpServletRequest request) {

		SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
		//ACE ACE2 DIY时需要在home.jsp头部引入依赖的js及css文件
		/*if("ace".equals(sysTheme.getStyle())||"diy".equals(sysTheme.getStyle())||"acele".equals(sysTheme.getStyle())){
			request.setAttribute("show", "1");
		} else {//default及shortcut不需要引入依赖文件，所有需要屏蔽
			request.setAttribute("show", "0");
		}*/

		return new ModelAndView("main/hplushome");
	}

	/**
	 * fineUI首页跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "fineuiHome")
	public ModelAndView fineuiHome(HttpServletRequest request) {
		return new ModelAndView("main/fineui_home");
	}

	/**
	 * 无权限页面提示跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "noAuth")
	public ModelAndView noAuth(HttpServletRequest request) {
		return new ModelAndView("common/noAuth");
	}
	/**
	 * @Title: top
	 * @Description: bootstrap头部菜单请求
	 * @param request
	 * @return ModelAndView
	 * @throws
	 */
	@RequestMapping(params = "top")
	public ModelAndView top(HttpServletRequest request) {
		TSUser user = ResourceUtil.getSessionUser();
		HttpSession session = ContextHolderUtils.getSession();
		// 登陆者的权限
		if (user.getId() == null) {
			session.removeAttribute(Globals.USER_SESSION);
			return new ModelAndView(
					new RedirectView("loginController.do?login"));
		}
		request.setAttribute("menuMap", getFunctionMap(user));
		return new ModelAndView("main/bootstrap_top");
	}
	/**
	 * @Title: top
	 * @author gaofeng
	 * @Description: shortcut头部菜单请求
	 * @param request
	 * @return ModelAndView
	 * @throws
	 */
	@RequestMapping(params = "shortcut_top")
	public ModelAndView shortcut_top(HttpServletRequest request) {
		TSUser user = ResourceUtil.getSessionUser();
		HttpSession session = ContextHolderUtils.getSession();
		// 登陆者的权限
		if (user.getId() == null) {
			session.removeAttribute(Globals.USER_SESSION);
			return new ModelAndView(
					new RedirectView("loginController.do?login"));
		}
		request.setAttribute("menuMap", getFunctionMap(user));
		return new ModelAndView("main/shortcut_top");
	}
	
	/**
	 * @Title: top
	 * @author:gaofeng
	 * @Description: shortcut头部菜单一级菜单列表，并将其用ajax传到页面，实现动态控制一级菜单列表
	 * @return AjaxJson
	 * @throws
	 */
    @RequestMapping(params = "primaryMenu")
    @ResponseBody
	public String getPrimaryMenu() {
		List<TSFunction> primaryMenu = getFunctionMap(ResourceUtil.getSessionUser()).get(0);
        String floor = "";

        if (primaryMenu == null) {
            return floor;
        }

        for (TSFunction function : primaryMenu) {
            if(function.getFunctionLevel() == 0) {
            	String lang_key = function.getFunctionName();
            	String lang_context = mutiLangService.getLang(lang_key);
            	lang_context=lang_context.trim();

            	if("业务申请".equals(lang_context)){

                	String ss = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
                    floor += " <li style='position: relative;'>"+ss+"<img class='imag1' src='plug-in/login/images/ywsq.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/ywsq-up.png' style='display: none;' /></li> ";
                }else if("个人办公".equals(lang_context)){

                	String ss = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
                    floor += " <li style='position: relative;'>"+ss+"<img class='imag1' src='plug-in/login/images/grbg.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/grbg-up.png' style='display: none;' /></li> ";
                }else if("流程管理".equals(lang_context)){

                	String ss = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
                    floor += " <li style='position: relative;'>"+ss+"<img class='imag1' src='plug-in/login/images/lcsj.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/lcsj-up.png' style='display: none;' /></li> ";
                }else if("Online 开发".equals(lang_context)){

                    floor += " <li><img class='imag1' src='plug-in/login/images/online.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/online_up.png' style='display: none;' />" + " </li> ";
                }else if("自定义表单".equals(lang_context)){

                	String ss = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
                    floor += " <li style='position: relative;'>"+ss+"<img class='imag1' src='plug-in/login/images/zdybd.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/zdybd-up.png' style='display: none;' /></li> ";
                }else if("系统监控".equals(lang_context)){

                    floor += " <li><img class='imag1' src='plug-in/login/images/xtjk.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/xtjk_up.png' style='display: none;' />" + " </li> ";
                }else if("统计报表".equals(lang_context)){

                    floor += " <li><img class='imag1' src='plug-in/login/images/tjbb.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/tjbb_up.png' style='display: none;' />" + " </li> ";
                }else if("消息中间件".equals(lang_context)){
                	String ss = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
                    floor += " <li style='position: relative;'>"+ss+"<img class='imag1' src='plug-in/login/images/msg.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/msg_up.png' style='display: none;' /></li> ";
                }else if("系统管理".equals(lang_context)){

                    floor += " <li><img class='imag1' src='plug-in/login/images/xtgl.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/xtgl_up.png' style='display: none;' />" + " </li> ";
                }else if("常用示例".equals(lang_context)){

                    floor += " <li><img class='imag1' src='plug-in/login/images/cysl.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/cysl_up.png' style='display: none;' />" + " </li> ";
                }else if(lang_context.contains("消息推送")){
                	
                	String s = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'>消息推送</div>";
                    floor += " <li style='position: relative;'>"+s+"<img class='imag1' src='plug-in/login/images/msg.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/msg_up.png' style='display: none;' /></li> ";
                }else{
                    //其他的为默认通用的图片模式
                	String s="";
                    if(lang_context.length()>=5 && lang_context.length()<7){
                        s = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
                    }else if(lang_context.length()<5){
                        s = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'>"+ lang_context +"</div>";
                    }else if(lang_context.length()>=7){
                        s = "<div style='width:67px;position: absolute;top:39px;text-align:center;color:#909090;font-size:13px;'><span style='letter-spacing:-1px;'>"+ lang_context.substring(0, 6) +"</span></div>";
                    }
                    floor += " <li style='position: relative;'>"+s+"<img class='imag1' src='plug-in/login/images/default.png' /> "
                            + " <img class='imag2' src='plug-in/login/images/default_up.png' style='display: none;' />"
                            +"</li> ";
                }

            }
        }

		return floor;
	}

	/**
	 * @Title: top
	 * @author:wangkun
	 * @Description: shortcut头部菜单二级菜单列表，并将其用ajax传到页面，实现动态控制二级菜单列表
	 * @return AjaxJson
	 * @throws
	 */
	@RequestMapping(params = "primaryMenuDiy")
	@ResponseBody
	public String getPrimaryMenuDiy() {
		//取二级菜单
		List<TSFunction> primaryMenu = getFunctionMap(ResourceUtil.getSessionUser()).get(1);
		String floor = "";
		if (primaryMenu == null) {
			return floor;
		}
		String menuString = "user.manage role.manage department.manage menu.manage";
		for (TSFunction function : primaryMenu) {
			if(menuString.contains(function.getFunctionName())){
				if(function.getFunctionLevel() == 1) {

					String lang_key = function.getFunctionName();
					String lang_context = mutiLangService.getLang(lang_key);
					if("申请".equals(lang_key)){
						lang_context = "申请";
						String s = "";
						s = "<div style='width:67px;position: absolute;top:47px;text-align:center;color:#000000;font-size:12px;'>"+ lang_context +"</div>";
						floor += " <li><img class='imag1' src='plug-in/login/images/head_icon1.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/head_icon1.png' style='display: none;' />" + s + " </li> ";
					} else if("Online 开发".equals(lang_context)){

						floor += " <li><img class='imag1' src='plug-in/login/images/online.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/online_up.png' style='display: none;' />" + " </li> ";
					}else if("统计查询".equals(lang_context)){

						floor += " <li><img class='imag1' src='plug-in/login/images/guanli.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/guanli_up.png' style='display: none;' />" + " </li> ";
					}else if("系统管理".equals(lang_context)){

						floor += " <li><img class='imag1' src='plug-in/login/images/xtgl.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/xtgl_up.png' style='display: none;' />" + " </li> ";
					}else if("常用示例".equals(lang_context)){

						floor += " <li><img class='imag1' src='plug-in/login/images/cysl.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/cysl_up.png' style='display: none;' />" + " </li> ";
					}else if("系统监控".equals(lang_context)){

						floor += " <li><img class='imag1' src='plug-in/login/images/xtjk.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/xtjk_up.png' style='display: none;' />" + " </li> ";
					}else if(lang_context.contains("消息推送")){
						String s = "<div style='width:67px;position: absolute;top:40px;text-align:center;color:#909090;font-size:12px;'>消息推送</div>";
						floor += " <li style='position: relative;'><img class='imag1' src='plug-in/login/images/msg.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/msg_up.png' style='display: none;' />"
								+ s +"</li> ";
					}else{
						//其他的为默认通用的图片模式
						String s = "";
						if(lang_context.length()>=5 && lang_context.length()<7){
							s = "<div style='width:67px;position: absolute;top:40px;text-align:center;color:#000000;font-size:12px;'><span style='letter-spacing:-1px;'>"+ lang_context +"</span></div>";
						}else if(lang_context.length()<5){
							s = "<div style='width:67px;position: absolute;top:40px;text-align:center;color:#000000;font-size:12px;'>"+ lang_context +"</div>";
						}else if(lang_context.length()>=7){
							s = "<div style='width:67px;position: absolute;top:40px;text-align:center;color:#000000;font-size:12px;'><span style='letter-spacing:-1px;'>"+ lang_context.substring(0, 6) +"</span></div>";
						}
						floor += " <li style='position: relative;'><img class='imag1' src='plug-in/login/images/head_icon2.png' /> "
								+ " <img class='imag2' src='plug-in/login/images/default_up.png' style='display: none;' />"
								+ s +"</li> ";
					}
				}
			}
		}

		return floor;
	}
	/**
	 * 云桌面返回：用户权限菜单
	 */
	@RequestMapping(params = "getPrimaryMenuForWebos")
	@ResponseBody
	public AjaxJson getPrimaryMenuForWebos() {
		AjaxJson j = new AjaxJson();
		//将菜单加载到Session，用户只在登录的时候加载一次
		Object getPrimaryMenuForWebos =  ContextHolderUtils.getSession().getAttribute("getPrimaryMenuForWebos");
		if(oConvertUtils.isNotEmpty(getPrimaryMenuForWebos)){
			j.setMsg(getPrimaryMenuForWebos.toString());
		}else{
			String PMenu = ListtoMenu.getWebosMenu(getFunctionMap(ResourceUtil.getSessionUser()));
			ContextHolderUtils.getSession().setAttribute("getPrimaryMenuForWebos", PMenu);
			j.setMsg(PMenu);
		}
		return j;
	}

    /**
     * 另一套登录界面
     * @return
     */
    @RequestMapping(params = "login2")
    public String login2(){
        return "login/login2";
    }
	/**
	 * ACE登录界面
	 * @return
	 */
	@RequestMapping(params = "login3")
	public String login3(){
		return "login/login3";
	}
}