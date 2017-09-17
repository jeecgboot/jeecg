package org.jeecgframework.tag.core.easyui;

import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 
 * @Title:HasPermissionTag
 * @description:新权限JSP标签，通过标签的 “权限标示” 控制代码片段是否显示
 * @author chenj
 * @date 2016-08-19
 * @version V1.0
 */
public class HasPermissionTag extends TagSupport{
	private static final long serialVersionUID = 1L;
	/**按钮code*/
	private  String code;
	@Autowired
	private SystemService systemService;
	
	public int doStartTag() throws JspException {
        boolean show = showTagBody(code);
        if (show) {
            return TagSupport.SKIP_BODY;
        } else {
            return TagSupport.EVAL_BODY_INCLUDE;
        }
	}
	
	public boolean showTagBody(String code) {
		if(ResourceUtil.getSessionUser().getUserName().equals("admin")|| !Globals.BUTTON_AUTHORITY_CHECK){
			return false;
		}else{
			//权限判断；
			Set<String> operationCodeIds = (Set<String>) super.pageContext.getRequest().getAttribute(Globals.OPERATIONCODES);
			systemService = ApplicationContextUtil.getContext().getBean(SystemService.class);
			if (null!=operationCodeIds) {
				for (String operationCodeId : operationCodeIds) {
					if (oConvertUtils.isEmpty(operationCodeId))
						break;
					TSOperation operation = systemService.getEntity(TSOperation.class, operationCodeId);
					if (operation!=null && operation.getOperationcode().equals(code)){
						return true;
					}
				}
			}
		}
        return false;
    }
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}
