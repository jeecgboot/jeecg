package org.jeecgframework.core.common.exception;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.JSONHelper;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 * spring mvc 全局处理异常捕获 根据请求区分ajax和普通请求，分别进行响应.
 * 第一、异常信息输出到日志中。
 * 第二、截取异常详细信息的前50个字符，写入日志表中t_s_log。
 */
@Component
public class GlobalExceptionResolver implements HandlerExceptionResolver {
	@Autowired
	private SystemService systemService;
	//记录日志信息
	private static final Logger log = Logger
			.getLogger(GlobalExceptionResolver.class);
	//记录数据库最大字符长度
	private static final int WIRTE_DB_MAX_LENGTH = 1500;
	//记录数据库最大字符长度
	private static final short LOG_LEVEL = 6;
	//记录数据库最大字符长度
	private static final short LOG_OPT = 3;
	/**
	 * 对异常信息进行统一处理，区分异步和同步请求，分别处理
	 */
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
        boolean isajax = isAjax(request,response);
        Throwable deepestException = deepestException(ex);
        return processException(request, response, handler, deepestException, isajax);
	}
	/**
	 * 判断当前请求是否为异步请求.
	 */
	private boolean isAjax(HttpServletRequest request, HttpServletResponse response){
		return oConvertUtils.isNotEmpty(request.getHeader("X-Requested-With"));
	}
	/**
	 * 获取最原始的异常出处，即最初抛出异常的地方
	 */
    private Throwable deepestException(Throwable e){
        Throwable tmp = e;
        int breakPoint = 0;
        while(tmp.getCause()!=null){
            if(tmp.equals(tmp.getCause())){
                break;
            }
            tmp=tmp.getCause();
            breakPoint++;
            if(breakPoint>1000){
                break;
            }
        } 
        return tmp;
    }
	/**
	 * 处理异常.
	 * @param request
	 * @param response
	 * @param handler
	 * @param deepestException
	 * @param isajax
	 * @return
	 */
	private ModelAndView processException(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			Throwable ex, boolean isajax) {
		//步骤一、异常信息记录到日志文件中.
		log.error("全局处理异常捕获:", ex);
		//步骤二、异常信息记录截取前50字符写入数据库中.
		logDb(ex);
		//步骤三、分普通请求和ajax请求分别处理.
		if(isajax){
			return processAjax(request,response,handler,ex);
		}else{
			return processNotAjax(request,response,handler,ex);
		}
	}
	/**
	 * 异常信息记录截取前50字符写入数据库中
	 * @param ex
	 */
	private void logDb(Throwable ex) {
		//String exceptionMessage = getThrowableMessage(ex);
		String exceptionMessage = "错误异常: "+ex.getClass().getSimpleName()+",错误描述："+ex.getMessage();
		if(oConvertUtils.isNotEmpty(exceptionMessage)){
			if(exceptionMessage.length() > WIRTE_DB_MAX_LENGTH){
				exceptionMessage = exceptionMessage.substring(0,WIRTE_DB_MAX_LENGTH);
			}
		}
		systemService.addLog(exceptionMessage, LOG_OPT,LOG_LEVEL);
	}
	/**
	 * ajax异常处理并返回.
	 * @param request
	 * @param response
	 * @param handler
	 * @param deepestException
	 * @return
	 */
	private ModelAndView processAjax(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			Throwable deepestException){
		ModelAndView empty = new ModelAndView();
		//response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		AjaxJson json = new AjaxJson();
		json.setSuccess(true);
		json.setMsg(deepestException.getMessage());
		PrintWriter pw = null;
		try {
			pw=response.getWriter();
			pw.write(JSONHelper.bean2json(json));
			pw.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				pw.close();
			} catch (Exception e2) {
			}
		}
		empty.clear();
		return empty;
	}
	/**
	 * 普通页面异常处理并返回.
	 * @param request
	 * @param response
	 * @param handler
	 * @param deepestException
	 * @return
	 */
	private ModelAndView processNotAjax(HttpServletRequest request,
			HttpServletResponse response, Object handler, Throwable ex) {
		String exceptionMessage = getThrowableMessage(ex);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("exceptionMessage", exceptionMessage);
		model.put("ex", ex);
		return new ModelAndView("common/error", model);
	}
	/**
	 * 返回错误信息字符串
	 * 
	 * @param ex
	 *            Exception
	 * @return 错误信息字符串
	 */
	public String getThrowableMessage(Throwable ex) {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		ex.printStackTrace(pw);
		return sw.toString();
	}
}
